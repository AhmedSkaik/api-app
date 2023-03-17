import 'package:api_training/Cotrollers/auth_Api_Controler.dart';
import 'package:api_training/Models/Student.dart';
import 'package:api_training/Models/api_response.dart';
import 'package:api_training/utitls/helpers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScrean extends StatefulWidget {
  const RegisterScrean({Key? key}) : super(key: key);

  @override
  State<RegisterScrean> createState() => _RegisterScreanState();
}

class _RegisterScreanState extends State<RegisterScrean> with Helpers {
  late TextEditingController _emailTextController;
  late TextEditingController _passTextController;
  late TextEditingController _fullnameTextController;
  String _gender = 'M';


  @override
  void initState() {
    super.initState();
    _emailTextController = TextEditingController();
    _passTextController = TextEditingController();
    _fullnameTextController = TextEditingController();
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passTextController.dispose();
    _fullnameTextController.dispose();
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
              height: 10,
            ),
            TextField(
              obscureText: false,
              keyboardType: TextInputType.emailAddress,
              controller: _fullnameTextController,
              decoration: InputDecoration(
                  hintText: 'Full Name',
                  prefixIcon: Icon(Icons.person),
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
              height: 10,
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
            const SizedBox(
              height: 10,
            ),
            TextField(
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              controller: _passTextController,
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
            SizedBox(height: 10,)
,
            Row(
              children: [
                Expanded(
                  child: RadioListTile(
                      title: Text('Male',
                        style: GoogleFonts.actor(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),),value: 'M', groupValue: _gender,
                      onChanged: (String ? value) {
                        if (value != null) {
                          setState(() {
                            _gender = value;
                          });
                        }
                      }),
                ) ,
                Expanded(
                  child: RadioListTile(
                      title: Text('Female',
                        style: GoogleFonts.actor(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),),value: "F", groupValue: _gender, onChanged: (String ? value){
                    if(value != null){
                      setState(() {
                        _gender = value;
                      });
                    }
                  }),
                )
              ],
            ),
            const SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () async => await _performedLogin(),
              style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _performedLogin() async {
    if (checkData()) {
      await _register();
    }
  }

  bool checkData() {
    if (_emailTextController.text.isNotEmpty &&
        _passTextController.text.isNotEmpty && _fullnameTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context, massage: "Enter Requierd data!!", error: true);
    return false;
  }

  Future<void> _register() async {
       ApiResponse apiResponse = await AuthApiController().register(student: student);
     if(apiResponse.success){
        Navigator.pushReplacementNamed(context, '/login_screan');
     }
     showSnackBar(context, massage: apiResponse.massage , error: !apiResponse.success );
  }

  Student get student  {
    Student student = Student();
    student.fullName = _fullnameTextController.text;
    student.email= _emailTextController.text;
    student.password = _passTextController.text;
    student.gender=_gender;
  return student;
  }
}