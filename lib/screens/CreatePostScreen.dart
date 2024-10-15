import 'package:cassava_healthy_finder/services/auth_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CreatePostScreen extends StatefulWidget {
  final String? postId; // For editing post
  final Map<String, dynamic>? postData;

  const CreatePostScreen({Key? key, this.postId, this.postData}) : super(key: key);

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isLoading = false;
  bool _isEditing = false;

  final AuthService _authService = AuthService(); // Instance of AuthService

  @override
  void initState() {
    super.initState();
    if (widget.postData != null) {
      _titleController.text = widget.postData?['title'] ?? '';
      _descriptionController.text = widget.postData?['description'] ?? '';
      _isEditing = true;
    }
  }

  // Fetch the user's name from Firestore using their UID
  Future<String?> _getUserName(String uid) async {
    try {
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userDoc.exists && userDoc.data() != null) {
        return (userDoc.data() as Map<String, dynamic>)['name'];
      }
    } catch (e) {
      print("Error fetching user name: $e");
    }
    return null;
  }

  Future<void> _createOrUpdatePost() async {
    final user = _authService.getCurrentUser();
    print("Current User: ${user?.uid}"); // This will print null if the user is not logged in

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please log in to create or update a post")),
      );
      return;
    }

    // Fetch the display name from Firestore
    final String? displayName = await _getUserName(user.uid) ?? 'Anonymous';

    if (_titleController.text.isEmpty || _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Prepare the post data with the user's display name and user ID
    final postData = {
      'title': _titleController.text,
      'description': _descriptionController.text,
      'timestamp': FieldValue.serverTimestamp(),
      'username': displayName, // Save the username fetched from Firestore
      'user_id': user.uid,     // Save the user ID
    };

    if (_isEditing && widget.postId != null) {
      await FirebaseFirestore.instance
          .collection('community_posts')
          .doc(widget.postId)
          .update(postData);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Post updated successfully!")),
      );
    } else {
      await FirebaseFirestore.instance.collection('community_posts').add(postData);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Post created successfully!")),
      );
    }

    setState(() {
      _isLoading = false;
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 11, 32, 11),
      appBar: AppBar(
        title: Text(_isEditing ? "Edit Post" : "Create Post"),
        backgroundColor: Color.fromARGB(255, 243, 245, 243), // Professional green tone
        elevation: 0, // Flat app bar for a modern look
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Title",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        hintText: "Enter the title...",
                      ),
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _descriptionController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        hintText: "Enter the description...",
                      ),
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _createOrUpdatePost,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          backgroundColor:  Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 5, // Slight elevation for depth
                        ),
                        child: Text(
                          _isEditing ? "Update Post" : "Create Post",
                          style: const TextStyle(fontSize: 18,
                          color: Color.fromARGB(255, 6, 27, 6)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
