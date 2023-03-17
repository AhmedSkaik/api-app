import 'package:api_training/Cotrollers/images_Api_Controller.dart';
import 'package:api_training/Models/Student_images.dart';
import 'package:api_training/Models/api_response.dart';
import 'package:get/get.dart';

class ImageGetxController extends GetxController {
  RxList<Studentimage> images = <Studentimage>[].obs;
  RxBool loading = false.obs;
  final ImageApiController _apiController = ImageApiController();

  static ImageGetxController get to => Get.find();

  @override
  void onInit() {
    getimages();
    super.onInit();
  }

  void getimages() async {
    loading.value = true;
    images.value = await _apiController.getimage();
    loading.value = false;
  }

  Future<ApiResponse> deleteimage({required int index}) async {
    ApiResponse apiResponse =
        await _apiController.deleteimage(id: images[index].id);
    if (apiResponse.success) {
      images.removeAt(index).image;
    }
    return apiResponse;
  }

  Future<void> uploadImage({required String path , required UploadCallback  imageuploadCallback}) async{
    _apiController.uploadImage(path: path, uploadCallback: (ApiResponse<Studentimage> uploadCallback) {
      if(uploadCallback.success){
        images.add(uploadCallback.object!);
      }
      imageuploadCallback(uploadCallback);
    });
  }
}
