import 'dart:async';
import 'package:after_layout/after_layout.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SecondscreenState createState() => _SecondscreenState();
}

class _SecondscreenState extends State<SplashScreen>
    with AfterLayoutMixin<SplashScreen> {
  int initScreen=1;

  @override
  void afterFirstLayout(BuildContext context) => navigate();

  void initState() {
    super.initState();
    _mockCheckForSession().then((status) {
      if (status) {
        _navigateToHome();
      }
    });

  }
  Future<bool> _mockCheckForSession() async {
    await Future.delayed(Duration(milliseconds: 5000), () {});

    return true;
  }
  //one time screen
  Future<void> navigate() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    initScreen = prefs.getInt("initScreen");
  }

  void _navigateToHome() async {
    if (initScreen == 1) {
      Timer(Duration(seconds: 10),moveToLogin() );
    } else {
      loadData();
    }
  }

  Future<Timer> loadData() async {
    return Timer(Duration(seconds: 10), moveToHome());
  }
  moveToLogin() {
    Get.offAndToNamed('/Login');
  }

  moveToHome() {
    Get.offAndToNamed('/Home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Welcome to Todo App',style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 26,
                fontWeight:FontWeight.bold
              ),),
              Image.asset(
                "assets/splash_log.png",
                width: 217.5,
                height: 263.5,
              ),
            ],
          ),
        ));
  }
}
