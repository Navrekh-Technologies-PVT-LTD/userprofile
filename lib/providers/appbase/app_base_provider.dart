import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:yoursportz/core/prefs.dart';
import 'package:yoursportz/gen/locale_keys.g.dart';
import 'package:yoursportz/injection/injection.dart';
import 'package:yoursportz/presentation/chat/player%20chat/player_to_player_chat.dart';
import 'package:yoursportz/presentation/streaming/streaming.dart';

enum AppBaseBottomNavState { home, search, reels, indiaLearning, profile }

@injectable
class AppBaseProvider extends ChangeNotifier {
  TextEditingController searchcontroller = TextEditingController();
  late IO.Socket socket;
  var streamStatus = false;
  Map<String, dynamic> streamData = {};
  Map<String, dynamic> userDetails = {'followers': [], 'profileViews': 0};
  var age = "-";

  late File imageFile;
  var imagePath = "null";
  var imageUrl = "null";
  Map ground = {};

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> storeUserCredentials(String phone) async {
    var currentUser = await Hive.openBox('CurrentUser');
    if (phone != "guest") {
      await currentUser.put('userId', phone);
    } else {
      await currentUser.put('userId', 'null');
    }
  }

  void updateSearchControllerValue(String value) {
    searchcontroller.text = value;
    notifyListeners();
  }

  void socketConnection(BuildContext context, dynamic data) async {
    streamStatus = data['streamCreated'];
    streamData = data['stream'];
    notifyListeners();
    if (streamStatus) {
      final cameras = await availableCameras();
      final firstCamera = cameras.first;
      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                Streaming(camera: firstCamera, streamData: streamData),
          ),
        );
      }
    }
  }

  int calculateAge(String dob) {
    DateFormat dateFormat = DateFormat('dd-MMM-yyyy');
    DateTime birthDate = dateFormat.parse(dob);
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month &&
            currentDate.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  Future<void> getUserDetails(String phone) async {
    final body = jsonEncode(
        <String, dynamic>{'phone': getIt<AppPrefs>().phoneNumber.getValue()});
    final response = await http.post(
        Uri.parse(
            "https://yoursportzbackend.azurewebsites.net/api/auth/get-user/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);

    userDetails = jsonDecode(response.body);
    age = "${calculateAge(userDetails['dob'])} Years";
    username = userDetails['name'];
    userDp = userDetails['dp'];
    notifyListeners();
  }

  void getImage(BuildContext context, String phone) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final croppedImage = await cropImageFile(pickedFile);
      imageFile = File(croppedImage.path);
      imagePath = croppedImage.path;
      notifyListeners();
      var request = http.MultipartRequest('POST',
          Uri.parse('https://yoursportzbackend.azurewebsites.net/api/upload/'));
      request.files.add(await http.MultipartFile.fromPath('file', imagePath));
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(LocaleKeys.updating_display_picture.tr(),
              style: const TextStyle(color: Colors.white)),
          backgroundColor: Colors.cyan,
          duration: const Duration(seconds: 3),
        ));
      }

      var response = await request.send();
      imageUrl = await response.stream.bytesToString();
      String cleanedImageUrl = imageUrl.replaceAll('"', '');
      final body = jsonEncode(<String, dynamic>{
        'phone': phone,
        'url': cleanedImageUrl,
      });
      final finalResponse = await http.put(
          Uri.parse(
              "https://yoursportzbackend.azurewebsites.net/api/auth/update-dp/"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: body);
      final Map<String, dynamic> responseData = jsonDecode(finalResponse.body);
      if (responseData['message'] == "success") {
        userDetails['dp'] = cleanedImageUrl;
        notifyListeners();
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Row(
              children: [
                Text(LocaleKeys.display_picture_updated.tr(),
                    style: const TextStyle(color: Colors.white)),
                const SizedBox(width: 8),
                const Icon(Icons.done, color: Colors.white)
              ],
            ),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ));
        }
      }
    }
  }

  Future<CroppedFile> cropImageFile(XFile image) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [CropAspectRatioPreset.square],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Image Cropper',
            toolbarColor: const Color(0xff554585),
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true),
      ],
    );
    return croppedFile!;
  }

  Future<Map<String, dynamic>> getMyProfileStats(String phone) async {
    final response = await http.post(
        Uri.parse(
            'https://yoursportzbackend-achrgzenhhcqg0f9.centralindia-01.azurewebsites.net/api/user/get-player-stats'),
        body: {"phone": phone});
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData as Map<String, dynamic>;
    } else {
      return {"status": "error"};
    }
  }

  Future<Map<String, dynamic>> followUser(String phone) async {
    final response = await http.post(
        Uri.parse(
            'https://yoursportzbackend.azurewebsites.net/api/user/follow'),
        body: {
          "phone": phone,
          "follower": getIt<AppPrefs>().phoneNumber.getValue()
        });
    debugPrint(response.body);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData as Map<String, dynamic>;
    } else {
      return {"status": "error"};
    }
  }
}
