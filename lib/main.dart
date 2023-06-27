import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:moviedatabase/screens/chat.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAnalytics.instance.logEvent(
    name: 'screen_view',
    parameters: {
      'firebase_screen': "Home",
      'firebase_screen_class': "Chat screen",
    },
  );


  runApp(MaterialApp(home: Home(),theme: ThemeData.light(useMaterial3: true),));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  }



  @override
  Widget build(BuildContext context) {
    return
      AnimatedSplashScreen(
        splash: 'assets/icon.png',
        nextScreen: Basic(),
        splashTransition: SplashTransition.rotationTransition,
        backgroundColor: ThemeData.dark().primaryColor,

      );
  }
}
