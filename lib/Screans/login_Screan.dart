import 'package:api_training/Cotrollers/auth_Api_Controler.dart';
import 'package:api_training/Models/api_response.dart';
import 'package:api_training/utitls/helpers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScrean extends StatefulWidget {
  const LoginScrean({Key? key}) : super(key: key);

  @override
  State<LoginScrean> createState() => _LoginScreanState();
}

class _LoginScreanState extends State<LoginScrean> with Helpers {
  late TextEditingController _emailTextController;
  late TextEditingController _passTextController;

  @override
  void initState() {
    super.initState();
    _emailTextController = TextEditingController();
    _passTextController = TextEditingController();
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'LOGIN :)',
          style: GoogleFonts.abel(
              fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome back...',
                style: GoogleFonts.actor(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    letterSpacing: 1)),
            Text(
              'Enter email and password',
              style: GoogleFonts.actor(
                  color: Colors.black38,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              // controller: _emailTextController,
              keyboardType: TextInputType.emailAddress,
              controller: _emailTextController,
              decoration: InputDecoration(
                  hintText: 'email',
                  prefixIcon: Icon(Icons.email),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      const BorderSide(width: 1, color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      const BorderSide(width: 1, color: Colors.blue))),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              controller:  _passTextController,
              decoration: InputDecoration(
                  hintText: 'password',
                  prefixIcon: Icon(Icons.lock),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      const BorderSide(width: 1, color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      const BorderSide(width: 1, color: Colors.blue))),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async => await _performedLogin(),
              style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: const Text('Login'),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Don\'t have an  acount',
                  style: GoogleFonts.actor(
                      fontSize: 9),),
                TextButton(onPressed: (){
                  Navigator.pushReplacementNamed(context, '/register_screan');
                }, child: Text('Create now!!',
                  style: GoogleFonts.actor(
                      fontSize: 9),)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _performedLogin() async {
    if (checkData()) {
      await _Login();
    }
  }

  bool checkData() {
    if (_emailTextController.text.isNotEmpty &&
        _passTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context, massage: "Enter Requierd data!!",error:  true);
    return false;
  }

  Future<void> _Login() async {
    ApiResponse apiResponse = await AuthApiController().Login(
        email: _emailTextController.text, password: _passTextController.text);
  if(apiResponse.success){
    Navigator.pushReplacementNamed(context, '/user_screan');
  }
  showSnackBar(context, massage: apiResponse.massage , error: !apiResponse.success );
  }
}