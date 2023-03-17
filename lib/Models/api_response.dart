class ApiResponse<T> {
  late String massage;
  late bool success;
   T? object;
  ApiResponse({required this.massage, this.success= true});
}