import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class PickerScreen extends StatefulWidget {
  const PickerScreen({super.key});

  @override
  State<PickerScreen> createState() => _PickerScreenState();
}

class _PickerScreenState extends State<PickerScreen> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  List<Map<String, String>> uploadedFiles =
      []; // Pastikan ini dideklarasikan sebagai List<Map<String, String>>

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future uploadFile() async {
    final path = 'files/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    setState(() {
      uploadTask = FirebaseStorage.instance.ref().child(path).putFile(file);
    });

    final snapshot = await uploadTask!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download link: $urlDownload');

    setState(() {
      // Tambahkan map yang berisi nama dan URL file ke dalam uploadedFiles
      uploadedFiles.add({
        'name': pickedFile!.name,
        'url': urlDownload,
      });
      pickedFile = null; // Reset picked file setelah upload
      uploadTask = null; // Reset upload task setelah upload
    });
  }

  Widget buildProgress() {
    if (uploadTask == null) {
      return SizedBox(
          height: 50); // Return an empty widget if uploadTask is null
    }

    return StreamBuilder<TaskSnapshot>(
      stream: uploadTask!.snapshotEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;
          double progress = data.bytesTransferred / data.totalBytes;

          return SizedBox(
            height: 50,
            child: Stack(
              fit: StackFit.expand,
              children: [
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey,
                  color: Colors.green,
                ),
                Center(
                  child: Text('${(100 * progress).roundToDouble()} %'),
                ),
              ],
            ),
          );
        } else {
          return SizedBox(
            height: 50,
          );
        }
      },
    );
  }

  Widget buildFileList() {
    return Expanded(
      child: ListView.builder(
        itemCount: uploadedFiles.length,
        itemBuilder: (context, index) {
          final fileData = uploadedFiles[index];
          final fileName = fileData['name']!;
          final fileUrl = fileData['url']!;

          return ListTile(
            leading: Image.network(
              fileUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.image_not_supported);
              },
            ),
            title: Text(fileName),
            subtitle: Text(fileUrl),
            onTap: () {
              // Implementasi aksi saat file diklik, misalnya membuka URL di browser
              print('File URL: $fileUrl');
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Picker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (pickedFile != null)
              Expanded(
                child: Container(
                  color: Colors.deepPurple[100],
                  child: Image.file(
                    File(pickedFile!.path!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                selectFile();
              },
              child: Text('Select File'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                uploadFile();
              },
              child: Text('Upload File'),
            ),
            SizedBox(height: 20),
            buildProgress(),
            SizedBox(height: 20),
            buildFileList(), // Tampilkan list file yang sudah diupload
          ],
        ),
      ),
    );
  }
}
