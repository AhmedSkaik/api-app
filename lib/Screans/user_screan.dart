import 'package:api_training/Cotrollers/auth_Api_Controler.dart';
import 'package:api_training/Cotrollers/user_api_controller.dart';
import 'package:api_training/Models/api_response.dart';
import 'package:api_training/Models/users.dart';
import 'package:api_training/SharedPrefencess/shared_pref_controller.dart';
import 'package:flutter/material.dart';

class UserScrean extends StatefulWidget {
  const UserScrean({Key? key}) : super(key: key);

  @override
  State<UserScrean> createState() => _UserScreanState();
}

class _UserScreanState extends State<UserScrean> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          'Users',
        )),
        actions: [
          IconButton(
              onPressed: () async {
                ApiResponse apiResponse = await AuthApiController().Logout();
                if (apiResponse.success) {
                  Navigator.pushReplacementNamed(context, '/login_screan');
                }
              },
              icon: Icon(Icons.logout)),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/image_Screan");
              },
              icon: Icon(Icons.image))
        ],
      ),
      body: FutureBuilder<List<User>>(
        future: UserApiController().indexUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(snapshot.data![index].image),
                    ),
                    title: Text(snapshot.data![index].firstName),
                    subtitle: Text(snapshot.data![index].email),
                  );
                });
          } else {
            return const Center(
              child: Text("No Data"),
            );
          }
        },
      ),
    );
  }
}
