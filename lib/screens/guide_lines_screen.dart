import 'package:flutter/material.dart';

class GuideLinesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color.fromARGB(255, 11, 32, 11),
      // backgroundColor:Color.fromARGB(255, 79, 80, 79), // Set the background color here
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Cassava Healthy Finder',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            const Text(
              'Guide Lines',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(242, 248, 242, 1)),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 60),
            Container(
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.brightness_1, size: 8, color: Colors.black),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'The leaf must be captured in white background.',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.brightness_1, size: 8, color: Colors.black),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'You should use a high quality camera.',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  const Text(
                    'Ex:',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Image.asset(
                      'assets/assets/leaf_example.jpg',
                      height: 100,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            const Text(
              "Powered By JACP Solutions Lanka (pvt) LTD",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Color(0xEE898686),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
