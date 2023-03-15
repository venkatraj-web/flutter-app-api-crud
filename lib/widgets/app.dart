import 'package:flutter/material.dart';
import 'package:qikcasual/ui/splash_screen.dart';

import '../ui/home_screen.dart';


class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
