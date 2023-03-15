import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qikcasual/ui/auth/login_screen.dart';
import 'package:qikcasual/ui/bottom_bar.dart';
import 'package:qikcasual/ui/home_screen.dart';
import 'package:qikcasual/ui/select_city_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? _token;

  @override
  void initState() {
    _checkAuth();
    super.initState();
  }

  Future<void> _checkAuth() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _token = _prefs.getString("token");
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return (_token != null) ? SelectCityScreen() : LoginScreen();
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Qikcasual"),
        ),
      ),
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.red,
        ),
      ),
    );
  }
}
