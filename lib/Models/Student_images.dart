class Studentimage {
  late int id;
  late String image;
  late String studentId;
  late String imageUrl;


  Studentimage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    studentId = json['student_id'];
    imageUrl = json['image_url'];
  }
}
