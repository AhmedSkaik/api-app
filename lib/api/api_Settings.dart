class ApiSettings {
  static const String _apiBaseUrl = "http://demo-api.mr-dev.tech/api/";
  static const String users = "${_apiBaseUrl}users";
  static const String login   = "${_apiBaseUrl}students/auth/login";
  static const String logout   = "${_apiBaseUrl}students/auth/logout";
  static const String register   = "${_apiBaseUrl}students/auth/register";
  static const String image   = "${_apiBaseUrl}student/images/{id}";


}
