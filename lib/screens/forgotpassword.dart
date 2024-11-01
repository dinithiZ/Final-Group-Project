import 'package:cassava_healthy_finder/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService =
        Provider.of<AuthService>(context); // Use AuthService with Provider

    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        backgroundColor: const Color.fromARGB(255, 218, 227, 219),
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 17, 17, 17)),
      ),
      backgroundColor: const Color.fromARGB(255, 11, 32, 11),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Enter your email to reset your password",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18, color: Color.fromARGB(255, 224, 237, 224)),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: "Enter Email",
                labelText: "Email",
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String email = _emailController.text.trim();
                if (email.isEmpty) {
                  _showSnackBar(context, "Email is required.");
                } else if (!_isValidEmail(email)) {
                  _showSnackBar(context, "Please enter a valid email address.");
                } else {
                  await _checkAndSendResetEmail(authService, email, context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 17, 83, 20),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text(
                "Send Reset Email",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isValidEmail(String email) {
    final emailRegEx = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegEx.hasMatch(email);
  }

  Future<void> _checkAndSendResetEmail(
      AuthService authService, String email, BuildContext context) async {
    try {
      bool isRegistered = await authService.isEmailRegistered(email);
      if (!isRegistered) {
        _showSnackBar(context, "This email is not registered with us.");
      } else {
        await authService.sendPasswordResetEmail(email);
        _showSuccessDialog(context);
      }
    } catch (error) {
      _showSnackBar(context, "An error occurred. Please try again.");
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color.fromARGB(255, 224, 237, 224),
        title: const Text(
          'Password Reset Email Sent',
          style: TextStyle(color: Color.fromARGB(255, 11, 32, 11)),
        ),
        content: const Text(
          'A password reset link has been sent to your email address.',
          style: TextStyle(color: Color.fromARGB(255, 11, 32, 11)),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pop(); // Go back to previous screen
            },
            child: const Text(
              'OK',
              style: TextStyle(color: Color.fromARGB(255, 17, 83, 20)),
            ),
          ),
        ],
      ),
    );
  }
}
