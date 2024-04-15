class ApiRoutes {
  static const host = "https://mojhavpn.com";
  static const createUser = "$host/create-user";
  static const refreshToken = "$host/login/refresh-token";
  static const login = "$host/login";
  static const user = "$host/user";
  static const google = "$host/user/google";
  static const location = "$host/location";
  static bestServer(String location) => "$host/location/$location/best";
}
