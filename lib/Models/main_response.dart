import 'package:api_training/Models/users.dart';

class MainResponse {
 late bool status;
 late String message;
 late List<User> data;



  MainResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <User>[];
      json['data'].forEach((v) {
        data.add(new User.fromJson(v));
      });
    }
  }


}