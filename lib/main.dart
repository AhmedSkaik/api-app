import 'package:api_training/Screans/image_Screan.dart';
import 'package:api_training/Screans/launch_Screan.dart';
import 'package:api_training/Screans/login_Screan.dart';
import 'package:api_training/Screans/register_Screan.dart';
import 'package:api_training/Screans/upload_image.dart';
import 'package:api_training/Screans/user_screan.dart';
import 'package:api_training/SharedPrefencess/shared_pref_controller.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefController().initPrefancess();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/launch_Screan",
      routes: {
        '/launch_Screan': (context) => const LaunchScrean(),
        '/user_screan': (context) => const UserScrean(),
        '/login_screan': (context) => const LoginScrean(),
        '/register_screan': (context) => const RegisterScrean(),
        "/image_Screan": (context) => const ImageScrean(),
        "/uploadimage_Screan": (context) => const UploadImageScrean(),
      },
    );
  }
}
