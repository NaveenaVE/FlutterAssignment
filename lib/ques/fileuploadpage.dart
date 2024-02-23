import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:techquest/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:video_player/video_player.dart';

class FileUploadScreen extends StatefulWidget {
  const FileUploadScreen({Key? key}) : super(key: key);

  @override
  State<FileUploadScreen> createState() => _FileUploadScreenState();
}

class _FileUploadScreenState extends State<FileUploadScreen> {
  bool isLoading = false;
  File? file;
  dynamic urlDownload;
  UploadTask? task;
  SizedBox spacer = const SizedBox(height: 15);

  PlatformFile? pickedFile;
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset(''); // Initialize with empty asset
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? path.basename(file!.path) : '';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: const Text('Upload file to firebase'),
          backgroundColor: Colors.green,
        centerTitle: true,
        elevation: 0,

      ),
      body: SingleChildScrollView(
        child:
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(50),
              child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Upload your favorite image or video file up to 10MB',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),

                    file != null
                        ? Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              file!.path.endsWith('.mp4') || file!.path.endsWith('.mov')
                                  ? _videoController.value.isInitialized
                                  ? SizedBox(
                                height: 300,
                                width: 400,
                                child: VideoPlayer(_videoController),
                              )
                                  : const Center(child: CircularProgressIndicator(color: Colors.green,))
                                  :
                              Image.file(
                                file!,
                                fit: BoxFit.cover, width: 400, height: 300
                              ),
                              spacer,
                              Text(fileName,style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),maxLines: 3,),

                            ],
                          )
                        : Container(),
                    //const SizedBox(height: 8,),
                    const SizedBox(height: 20,),
                    Center(
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              selectFile();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              alignment: Alignment.centerLeft,
                              height: 50,
                              width: 250,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "Select file",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Icon(
                                    Icons.attach_file,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                          spacer,
                          file != null
                              ?
                          InkWell(
                            onTap: () {
                              uploadFile();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              alignment: Alignment.centerLeft,
                              height: 50,
                              width: 250,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "Upload file",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Icon(
                                    Icons.upload,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ) : Container(),
                        ],
                      ),
                    ),

                  ],
                ),
            ),
            task != null ? buildUploadStatus(task!): Container(),
          ],
        ),
          //
      ),
    );
  }

  showAlertDialogforSize(BuildContext context,String content) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Alert"),
      content: Text(content),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) {
      setState(() {
        pickedFile = null;
        file = null;
      });
      return;
    }
    final path = result.files.single.path!;
    final List<String> allowedExtensions = ['jpg', 'jpeg', 'png', 'gif', 'mp4', 'mov']; // Add more extensions if needed

    final String extension = path.split('.').last.toLowerCase();
    if (!allowedExtensions.contains(extension)) {
      showAlertDialogforSize(context,"Select Image or Video files");
      setState(() {
        pickedFile = null;
        file = null;
      });
      return false;
    }
    final f = File(path);
    int sizeInBytes = f.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    if (sizeInMb > 10) {
      setState(() {
        pickedFile = null;
        file = null;
      });
      showAlertDialogforSize(context,"Select file less than 10 MB");
    } else {
      setState(() {
        pickedFile = result.files.first;
        file = File(path);
        if (path.endsWith('.mp4') || path.endsWith('.mov')) {
          isLoading = true;
          _videoController.dispose(); //
          _videoController = VideoPlayerController.file(file!)
            ..initialize().then((_) {
              setState(() {
                isLoading = false;
              });
            });
        }
      });
    }
  }

  Future uploadFile() async {
    if (file == null) return;

    final fileName = path.basename(file!.path);
    final destination = 'documents/$fileName';
    task = FirebaseServices.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("File uploaded Successfully"),
        ),
      );
      setState(() {
        pickedFile = null;
        file = null;
      });
    });
    setState(() {
      task = null;
    });
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            return
              Container(
                height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  //padding: const EdgeInsets.all(7),
                  color: Colors.black.withOpacity(0.8),
                child: CircularPercentIndicator(
                  radius: 100.0,
                  lineWidth: 4.0,
                  percent: progress,
                  //backgroundColor:Colors.white ,
                  center: Text(
                    '$percentage%',
                    style: const TextStyle(color: Colors.white,fontSize: 28, fontWeight: FontWeight.bold),textAlign: TextAlign.end,
                  ),
                  progressColor: Colors.green,
                ),
          );

          } else {
            return Container();
          }
        },
      );
}
