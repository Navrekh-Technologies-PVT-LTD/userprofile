// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:yoursportz/utils/google_map_api.dart';

import '../../gen/locale_keys.g.dart';
import 'add_players.dart';

class CreateTeam extends StatefulWidget {
  const CreateTeam(
      {super.key,
      required this.phone,
      required this.ground,
      required this.source});

  final Map ground;
  final String phone;
  final String source;

  @override
  State<CreateTeam> createState() => _CreateTeamState();
}

class _CreateTeamState extends State<CreateTeam> {
  var imageUrl = "null";
  final teamName = TextEditingController();
  final city = TextEditingController();
  bool isChecked = false;
  var validTeamName = true;
  var validCity = true;
  var isLoading = false;
  late File imageFile;
  var imagePath = "null";

  final MapController _mapController = MapController();

  void getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final croppedImage = await cropImageFile(pickedFile);
      setState(() {
        imageFile = File(croppedImage.path);
        imagePath = croppedImage.path;
      });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 245),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(LocaleKeys.create_your_team.tr()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Stack(children: [
                CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.transparent,
                    child: ClipOval(
                        child: imagePath == "null"
                            ? Image.asset(
                                'assets/images/team_logo.png',
                                height: 100,
                                width: 100,
                              )
                            : Image.file(imageFile, height: 100, width: 100))),
                Padding(
                  padding: const EdgeInsets.fromLTRB(60, 65, 0, 0),
                  child: GestureDetector(
                    onTap: () {
                      getImage();
                    },
                    child: const CircleAvatar(
                        backgroundColor: Colors.white,
                        child: ClipOval(
                            child: Icon(
                          Icons.edit_outlined,
                          color: Colors.grey,
                        ))),
                  ),
                )
              ]),
              // const SizedBox(height: 8),
              // Text(LocaleKeys.team_logo.tr(),
              //     style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(LocaleKeys.team_name.tr(),
                      style: const TextStyle(fontSize: 17)),
                  const SizedBox(height: 8),
                  TextField(
                    onChanged: (value) {
                      if (value.length >= 3) {
                        setState(() {
                          validTeamName = true;
                        });
                      }
                    },
                    controller: teamName,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(8)),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: LocaleKeys.enter_team_name.tr(),
                        hintStyle:
                            const TextStyle(fontWeight: FontWeight.normal),
                        contentPadding: const EdgeInsets.all(16),
                        errorText: validTeamName
                            ? null
                            : LocaleKeys.cant_be_less_than_3_characters.tr()),
                  ),
                  const SizedBox(height: 16),
                  Text(LocaleKeys.city_town.tr(),
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  TextField(
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          validCity = true;
                        });
                      }
                    },
                    controller: city,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(8)),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: LocaleKeys.enter_city_town.tr(),
                        hintStyle:
                            const TextStyle(fontWeight: FontWeight.normal),
                        contentPadding: const EdgeInsets.all(16),
                        suffixIcon: IconButton(
                          icon: _mapController.isLoading.value
                              ? SizedBox(
                                  height: 50,
                                  child: Lottie.asset(
                                      "assets/videos/location_loading.json"),
                                )
                              : const Icon(Icons.location_on),
                          onPressed: () async {
                            if (_mapController.isLoading.value)
                              return; // Prevent multiple requests
                            setState(() {
                              _mapController.isLoading.value =
                                  true; // Set loading to true
                            });
                            await _mapController.fetchCurrentLocationAndCity();
                            print(_mapController.currentCity);
                            setState(() {
                              city.text =
                                  _mapController.currentCity.value ?? '';
                              _mapController.isLoading.value =
                                  false; // Set loading to false after data is fetched
                            });
                          },
                        ),
                        suffixIconColor: const Color(0xff554585),
                        errorText: validCity
                            ? null
                            : LocaleKeys.please_enter_valid_city_town.tr()),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                      Text(LocaleKeys.add_myself_team.tr(),
                          style: const TextStyle(color: Colors.grey))
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () async {
                      final teamNameString = teamName.text.trim();
                      city.text = city.text.trim();
                      if (teamNameString.length < 3) {
                        setState(() {
                          validTeamName = false;
                        });
                      } else if (city.text.isEmpty) {
                        setState(() {
                          validCity = false;
                        });
                      } else {
                        setState(() {
                          isLoading = true;
                        });
                        final body = jsonEncode(<String, dynamic>{
                          'name': teamNameString.toLowerCase()
                        });
                        final initialResponse = await http.post(
                            Uri.parse(
                                "https://yoursportzbackend.azurewebsites.net/api/team/check/"),
                            headers: <String, String>{
                              'Content-Type': 'application/json; charset=UTF-8',
                            },
                            body: body);
                        final Map<String, dynamic> responseData =
                            jsonDecode(initialResponse.body);
                        if (responseData['message'] == "success") {
                          String cleanedImageUrl = "null";
                          if (imagePath != "null") {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(LocaleKeys.uploading_logo.tr(),
                                  style: const TextStyle(color: Colors.white)),
                              backgroundColor: Colors.green,
                              duration: const Duration(seconds: 3),
                            ));
                            var request = http.MultipartRequest(
                                'POST',
                                Uri.parse(
                                    'https://yoursportzbackend.azurewebsites.net/api/upload/'));
                            request.files.add(await http.MultipartFile.fromPath(
                                'file', imagePath));
                            var response = await request.send();
                            imageUrl = await response.stream.bytesToString();
                            cleanedImageUrl = imageUrl.replaceAll('"', '');
                          }
                          if (cleanedImageUrl != "error") {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(LocaleKeys.creating_team.tr(),
                                  style: const TextStyle(color: Colors.white)),
                              backgroundColor: Colors.cyan,
                              duration: const Duration(seconds: 1),
                            ));
                            final body = jsonEncode(<String, dynamic>{
                              'phone': widget.phone,
                              'name': teamNameString,
                              'city': city.text,
                              'logo': cleanedImageUrl,
                            });
                            final response = await http.post(
                                Uri.parse(
                                    "https://yoursportzbackend.azurewebsites.net/api/team/create_team/"),
                                headers: <String, String>{
                                  'Content-Type':
                                      'application/json; charset=UTF-8',
                                },
                                body: body);
                            final Map<String, dynamic> responseData =
                                jsonDecode(response.body);
                            if (responseData['message'] == "success") {
                              if (isChecked) {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddPlayers(
                                            ground: widget.ground,
                                            teamName: teamNameString,
                                            city: city.text,
                                            phone: widget.phone,
                                            imageUrl: cleanedImageUrl,
                                            source: widget.source,
                                            token: responseData['link'],
                                            selfAdd: true)));
                              } else {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddPlayers(
                                            ground: widget.ground,
                                            teamName: teamNameString,
                                            city: city.text,
                                            phone: widget.phone,
                                            imageUrl: cleanedImageUrl,
                                            source: widget.source,
                                            token: responseData['link'],
                                            selfAdd: false)));
                              }
                              setState(() {
                                isLoading = false;
                              });
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                    LocaleKeys
                                        .server_error_failed_to_create_team
                                        .tr(),
                                    style:
                                        const TextStyle(color: Colors.white)),
                                backgroundColor: Colors.red,
                                duration: const Duration(seconds: 3),
                              ));
                              setState(() {
                                isLoading = false;
                              });
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  LocaleKeys.server_error_failed_to_upload_image
                                      .tr(),
                                  style: const TextStyle(color: Colors.white)),
                              backgroundColor: Colors.red,
                              duration: const Duration(seconds: 3),
                            ));
                            setState(() {
                              isLoading = false;
                            });
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Row(
                              children: [
                                Text("\"$teamNameString\"",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                Text(LocaleKeys.already_exist.tr(),
                                    style:
                                        const TextStyle(color: Colors.white)),
                              ],
                            ),
                            backgroundColor: Colors.orange,
                            duration: const Duration(seconds: 3),
                          ));
                          setState(() {
                            isLoading = false;
                          });
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: const Color(0xff554585)),
                    child: isLoading
                        ? Padding(
                            padding: const EdgeInsets.all(4),
                            child: Transform.scale(
                              scale: 0.5,
                              child: const CircularProgressIndicator(
                                  color: Colors.white),
                            ))
                        : Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(LocaleKeys.creat_e.tr(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Position extends StatelessWidget {
  const Position(
      {super.key,
      required this.selected,
      required this.avatar,
      required this.label,
      required this.updatePosition});

  final String selected;
  final String avatar;
  final String label;
  final Function(String) updatePosition;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        updatePosition(avatar);
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: selected == avatar
                ? BorderRadius.circular(4)
                : BorderRadius.zero,
            border: selected == avatar
                ? Border.all(width: 1, color: Colors.cyan)
                : null),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey[300],
                  child: ClipOval(
                      child: Text(
                    avatar,
                    style: const TextStyle(color: Colors.brown),
                  ))),
              const SizedBox(height: 4),
              Text(label,
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: selected == avatar
                          ? FontWeight.bold
                          : FontWeight.normal))
            ],
          ),
        ),
      ),
    );
  }
}

class YourPosition extends StatelessWidget {
  const YourPosition(
      {super.key,
      required this.selected,
      required this.avatar,
      required this.label,
      required this.updatePosition});

  final String selected;
  final String avatar;
  final String label;
  final Function(String) updatePosition;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        updatePosition(avatar);
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: selected == avatar
                ? BorderRadius.circular(4)
                : BorderRadius.zero,
            border: selected == avatar
                ? Border.all(width: 1, color: Colors.cyan)
                : null),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey[300],
                  child: ClipOval(
                      child: Text(
                    avatar,
                    style: const TextStyle(color: Colors.brown),
                  ))),
              const SizedBox(height: 4),
              Text(label,
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: selected == avatar
                          ? FontWeight.bold
                          : FontWeight.normal))
            ],
          ),
        ),
      ),
    );
  }
}
