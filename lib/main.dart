import 'package:cassava_healthy_finder/services/firebase_messaging_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/OnboardingScreen.dart';
import 'services/auth_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDWToPzQdxj4Aq3iB2Sy4_ZG-FGIto6w50",
      authDomain: "YOUR_AUTH_DOMAIN",
      projectId: "cassava-healthy-finder",
      storageBucket: "cassava-healthy-finder.appspot.com",
      messagingSenderId: "451811533078",
      appId: "1:451811533078:android:98b32638e54a5d61287037",
    ),
  );
  await FirebaseMessagingService.initialize();  // Firebase Messaging initialization
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // Disable the DEBUG banner
        title: 'Cassava Healthy Finder',
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: OnboardingScreen(),
      ),
    );
  }
}
