import 'dart:io';

import 'package:api_training/Cotrollers/images_Api_Controller.dart';
import 'package:api_training/Models/Student_images.dart';
import 'package:api_training/Models/api_response.dart';
import 'package:api_training/get/image_get_controller.dart';
import 'package:api_training/utitls/helpers.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageScrean extends StatefulWidget {
  const UploadImageScrean({Key? key}) : super(key: key);

  @override
  State<UploadImageScrean> createState() => _UploadImageScreanState();
}

class _UploadImageScreanState extends State<UploadImageScrean> with Helpers {
  late ImagePicker _imagePicker;
  XFile? _pickedimage;
  double? _progressvalue;

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Images"),
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            minHeight: 10,
            color: Colors.green,
            value: _progressvalue,
          ),
          Expanded(
              child: _pickedimage != null
                  ? Image.file(File(_pickedimage!.path))
                  : IconButton(
                      onPressed: () async => await _pickImage(),
                      icon: const Icon(Icons.camera),
                      iconSize: 48,
                    )),
          ElevatedButton.icon(
            onPressed: () async {
              await performedimage();
            },
            icon: const Icon(Icons.upload),
            label: const Text('Upload'),
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50)),
          )
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _pickedimage = image;
      });
    }
  }

  Future<void> performedimage() async {
    if (_checkdata()) {
      _imagevalue();
    }
  }

  bool _checkdata() {
    if (_pickedimage != null) {
      return true;
    }
    showSnackBar(context, massage: 'pick image to upload', error: true);
    return false;
  }

  Future<void> _imagevalue() async {
    _changeorogressvalue();
    await ImageGetxController.to.uploadImage(
        path: _pickedimage!.path,
        imageuploadCallback: (ApiResponse<Studentimage> callback) {
          _changeorogressvalue(value: callback.success ? 1 : 0);
          showSnackBar(context, massage: callback.massage,error: !callback.success);
        });
  }

  void _changeorogressvalue({double? value}) {
    setState(() => _progressvalue = value);
  }
}
