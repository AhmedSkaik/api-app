import 'package:api_training/Cotrollers/images_Api_Controller.dart';
import 'package:api_training/Models/Student_images.dart';
import 'package:api_training/Models/api_response.dart';
import 'package:api_training/get/image_get_controller.dart';
import 'package:api_training/utitls/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageScrean extends StatefulWidget {
  const ImageScrean({Key? key}) : super(key: key);

  @override
  State<ImageScrean> createState() => _ImageScreanState();
}

class _ImageScreanState extends State<ImageScrean> with Helpers {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Images'),
          actions: [
            IconButton(onPressed: (){
              Navigator.pushNamed(context, '/uploadimage_Screan');
            }, icon: Icon(Icons.image_outlined))
          ],
        ),
        body: GetX<ImageGetxController>(
            init: ImageGetxController(),
            global: true,
            builder: (controller) {
              if (controller.loading.isTrue) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (controller.images.isNotEmpty) {
                return GridView.builder(
                    itemCount: controller.images.length,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.white,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Stack(
                          children: [
                            Image.network(
                              controller.images[index].imageUrl,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                height: 50,
                                color: Colors.black54,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        controller.images[index].image,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () async => _deleteimage(index: index),
                                      icon: const Icon(Icons.delete),
                                      color: Colors.red,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              } else {
                return const Center(
                  child: Text('NO IMAGES'),
                );
              }
            }));
  }

  Future<void> _deleteimage({required int index}) async {
    ApiResponse apiResponse =
        await ImageGetxController.to.deleteimage(index: index);
    // ignore: use_build_context_synchronously
    showSnackBar(context,
        massage: apiResponse.massage, error: !apiResponse.success);
  }
}
