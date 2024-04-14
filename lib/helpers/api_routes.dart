class ApiRoutes {
  static const host = "https://mojhavpn.com";
  static const token =
      "V9dCO66ynnBdg/Lv86KL/BEqq8QAn+PL78vfCHBj7pOsOsebXAuT5yAhunlyutpg2i9kPx9iBiFNWL+LbThUNKRUvsFH4LeG8yAiNL1KooqOxfIGlCnu6B7ZWoxQC4CyI7nSu2vzuAJJ5SgJQnWMpA=";
  static const createUser = "$host/create-user";
  static const login = "$host/login";
  static const user = "$host/user";
  static google(String googleId) => "$host/user/google/$googleId";
  static const location = "$host/location";
  static bestServer(String location) => "$host/location/$location/best";
}
