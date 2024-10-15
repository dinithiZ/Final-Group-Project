import 'package:cassava_healthy_finder/screens/CommunityScreen.dart';
import 'package:cassava_healthy_finder/screens/notifications.dart';
import 'package:cassava_healthy_finder/screens/profile_screen.dart';
import 'package:cassava_healthy_finder/screens/sign_in_screen.dart';
import 'package:cassava_healthy_finder/screens/feedback_screen.dart';
import 'package:cassava_healthy_finder/screens/detection_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_services.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 11, 32, 11),
      appBar: AppBar(
        title: Text(
          'Cassava Healthy Finder',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 10, 49, 12),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              await authService.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignInScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/assets/onboarding4.png', height: 200),
            SizedBox(height: 50),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildButton(context, Icons.person, 'Your Profile'),
                    buildButton(context, Icons.new_releases, 'New Prediction'),
                    buildButton(context, Icons.feedback, 'Feedback'),
                    buildButton(context, Icons.notifications, 'Notifications'),
                    buildButton(context, Icons.group, 'Community'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method for building buttons similar to the image
  Widget buildButton(BuildContext context, IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: InkWell(
        onTap: () {
          // Navigate based on the text label
          if (text == 'Feedback') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FeedbackScreen()),
            );
          } else if (text == 'New Prediction') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetectionScreen()),
            );
          } else if (text == 'Your Profile') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
          } else if (text == 'Notifications') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotificationsScreen()),
            );
          } else if (text == 'Community') {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>CommunityScreen()), // Navigate to CommunityScreen
            );
          }
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.green.shade100,  // Light green background
            borderRadius: BorderRadius.circular(30),  // Rounded corners
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),  // Shadow color
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 3),  // Shadow position
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 40,
                color: Colors.green.shade900,  // Dark green icon color
              ),
              SizedBox(width: 20),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade900,  // Dark green text color
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
