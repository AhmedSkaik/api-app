import 'package:api_training/SharedPrefencess/shared_pref_controller.dart';
import 'package:flutter/material.dart';

class LaunchScrean extends StatefulWidget {
  const LaunchScrean({Key? key}) : super(key: key);

  @override
  State<LaunchScrean> createState() => _LaunchScreanState();
}

class _LaunchScreanState extends State<LaunchScrean> {
  @override
  void initState() {
    super.initState;
    Future.delayed(Duration(seconds: 3), () {
      String route =
          SharedPrefController().loggedIn ? '/user_screan' : '/login_screan';
      Navigator.pushReplacementNamed(context, route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: AlignmentDirectional.topStart,
                end: AlignmentDirectional.bottomEnd,
                colors: [Colors.orange.shade200, Colors.pink.shade200])),
        child: const Text(
          'UI APP',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
