import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';

class Streaming extends StatefulWidget {
  const Streaming({super.key, required this.camera, required this.streamData});

  final Map<String, dynamic> streamData;
  final CameraDescription camera;

  @override
  State<Streaming> createState() => _StreamingState();
}

class _StreamingState extends State<Streaming> {
  late CameraController controller;
  late Future<void> initializeControllerFuture;
  bool isRecording = false;
  bool isStreaming = false;
  bool isStreamed = false;
  final FlutterFFmpeg flutterFFmpeg = FlutterFFmpeg();
  late String videoPath;

  @override
  void initState() {
    super.initState();
    controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
    );
    initializeControllerFuture = controller.initialize();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> startRecording() async {
    final directory = await getApplicationDocumentsDirectory();
    videoPath = '${directory.path}/${DateTime.now()}.mp4';
    await controller.startVideoRecording();
    setState(() {
      isRecording = true;
      isStreamed = false;
    });
  }

  Future<void> stopRecording() async {
    await controller.stopVideoRecording();
    setState(() {
      isRecording = false;
    });
  }

  Future<void> startStreaming() async {
    String streamUrl =
        '${widget.streamData['cdn']['ingestionInfo']['ingestionAddress']}/${widget.streamData['cdn']['ingestionInfo']['streamName']}';
    await flutterFFmpeg
        .execute('-re -i $videoPath -c:v libx264 -c:a aac -f flv $streamUrl');
    setState(() {
      isStreaming = true;
    });
  }

  Future<void> stopStreaming() async {
    await flutterFFmpeg.cancel();
    setState(() {
      isStreaming = false;
      isStreamed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: CameraPreview(controller),
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isRecording && !isStreamed
                          ? ElevatedButton(
                              onPressed:
                                  isStreaming ? stopStreaming : startStreaming,
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        isStreaming ? 8 : 32),
                                  ),
                                  backgroundColor: Colors.red),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  children: [
                                    Icon(
                                        isStreaming
                                            ? Icons.stop
                                            : Icons.play_arrow,
                                        color: Colors.white),
                                    const SizedBox(width: 8),
                                    Text(
                                        isStreaming
                                            ? 'Stop Streaming'
                                            : 'Start Streaming',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            )
                          : ElevatedButton(
                              onPressed:
                                  isRecording ? stopRecording : startRecording,
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  backgroundColor: const Color(0xff554585)),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Text(
                                    isRecording
                                        ? 'Stop Recording'
                                        : 'Start Recording',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ),
                            )
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
