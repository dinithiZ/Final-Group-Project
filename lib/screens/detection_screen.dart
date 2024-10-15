import 'package:cassava_healthy_finder/screens/guide_lines_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DetectionScreen extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();

  DetectionScreen({super.key});

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // Handle the picked image
      print('Image picked from gallery: ${pickedFile.path}');
    } else {
      print('No image selected.');
    }
  }

  Future<void> _pickImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      // Handle the picked image
      print('Image picked from camera: ${pickedFile.path}');
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Cassava Healthy Finder',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              child: Text('Guide Lines'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GuideLinesScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              child: Text('Open Gallery'),
              onPressed: _pickImageFromGallery,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              child: Text('Start Camera'),
              onPressed: _pickImageFromCamera,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/assets/upload_icon.png',
                        height: 300),
                    Text('UPLOAD IMAGE',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('TO DETECT DISEASE',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              child: Text('Upload'),
              onPressed: () {
                // Implement upload functionality
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(10, 49, 12, 1),
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}