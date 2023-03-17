import 'dart:convert';

import 'package:api_training/Models/main_response.dart';
import 'package:api_training/Models/users.dart';
import 'package:api_training/api/api_Settings.dart';
import 'package:http/http.dart' as http;
class UserApiController {

  Future<List<User>> indexUser() async {
    var uri = Uri.parse(ApiSettings.users);
    var response = await http.get(uri);

    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body);
      MainResponse mainResponse = MainResponse.fromJson(jsonData);
      return mainResponse.data;
    }
return [];
  }
}