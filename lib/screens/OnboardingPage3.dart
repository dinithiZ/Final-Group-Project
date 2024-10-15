import 'package:flutter/material.dart';

class OnboardingPage3 extends StatelessWidget {
  final VoidCallback onPressed;
  final VoidCallback onBackPressed;

  // Constructor with required onPressed callback
  const OnboardingPage3(
      {required this.onPressed,
      required this.onBackPressed,
      required Null Function() backPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold provides the structure for the page
      // backgroundColor: Color.fromARGB(255, 79, 80, 79), // Uncomment to set a specific background color

      appBar: AppBar(
        backgroundColor:
            Colors.transparent, // Transparent background for the AppBar
        elevation: 0, // No shadow under the AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 24.0), // Horizontal padding for the body content
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Center the contents vertically
          children: [
            // Image displaying the third onboarding illustration
            Image.asset('assets/assets/onboarding3.png', height: 300),
            SizedBox(
                height: 20), // Space between the image and the next element
            const Text(
              "Community", // Heading text for this onboarding page
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center, // Center align the text
            ),
            const SizedBox(
                height: 16), // Space between the heading and the description
            Text(
              "Ask a question about your crop to receive help from the community.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700], // Text color for the description
              ),
              textAlign: TextAlign.center, // Center align the text
            ),
            const SizedBox(
                height: 40), // Space between the description and the button
            ElevatedButton(
              onPressed: onPressed, // Trigger the callback when pressed
              child: const Text('Next'), // Label for the button
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0A310C), // Button background color
                foregroundColor: Colors.white, // Button text color
                padding: const EdgeInsets.symmetric(
                    horizontal: 50, vertical: 15), // Button padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      25), // Rounded corners for the button
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
