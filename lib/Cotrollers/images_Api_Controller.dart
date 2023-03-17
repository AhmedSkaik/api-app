import 'dart:convert';
import 'dart:io';
import 'package:api_training/Models/api_response.dart';
import 'package:http/http.dart' as http;

import 'package:api_training/Models/Student.dart';
import 'package:api_training/Models/Student_images.dart';
import 'package:api_training/SharedPrefencess/shared_pref_controller.dart';
import 'package:api_training/api/api_Settings.dart';
import 'package:http/http.dart' as http;

typedef UploadCallback = void Function(ApiResponse<Studentimage> apiResponse);

class ImageApiController {
  Future<List<Studentimage>> getimage() async {
    var uri = Uri.parse(ApiSettings.image.replaceFirst('/{id}', ''));
    var response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: SharedPrefController().token,
    });

    if (response.statusCode == 200) {
      var jsonResponse = await jsonDecode(response.body);
      var jsonArray = jsonResponse['data'] as List;
      return jsonArray.map((e) => Studentimage.fromJson(e)).toList();
    }
    return [];
  }

  Future<ApiResponse> deleteimage({required int id}) async {
    var uri = Uri.parse(ApiSettings.image.replaceFirst('{id}', id.toString()));
    var response = await http.delete(uri, headers: {
      HttpHeaders.authorizationHeader: SharedPrefController().token
    });
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return ApiResponse(
          massage: jsonResponse['message'], success: jsonResponse['status']);
    }
    return ApiResponse(massage: 'Somthing wrongg!!', success: false);
  }

  Future<void> uploadImage({required String path , required UploadCallback uploadCallback}) async {
    var url = Uri.parse(ApiSettings.image.replaceFirst('{/id}', ''));
    var request = http.MultipartRequest('POST', url );
    var imageFile = await http.MultipartFile.fromPath('image', path );
    request.files.add(imageFile);
    request.headers[HttpHeaders.authorizationHeader] = SharedPrefController().token;
    request.headers[HttpHeaders.acceptHeader] = 'application/json';


    var response = await request.send();
    response.stream.transform(utf8.decoder).listen((String body) {
      if (response.statusCode == 201 || response.statusCode == 400) {
        var jsonResponse = jsonDecode(body);
       ApiResponse<Studentimage> apiResponse = ApiResponse<Studentimage>(massage: jsonResponse['message'],success:jsonResponse['status'] );
        if(response.statusCode==201){
          Studentimage studentimage = Studentimage.fromJson(jsonResponse['object']);
          apiResponse.object =studentimage;
        }
        uploadCallback(apiResponse);
      }
      else{
        uploadCallback(ApiResponse(massage: 'somthing wrong!!', success: false ));
      }
    });
  }
}
