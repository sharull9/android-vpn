class LoggedInUser {
  late final int? id;
  late final String? googleId;
  late final String? name;
  late final String? email;
  late final String? accessToken;
  late final bool? isPremium;
  late final bool isLoggedIn;

  LoggedInUser({
    this.id,
    this.googleId,
    this.name,
    this.email,
    this.accessToken,
    this.isPremium = false,
    this.isLoggedIn = false,
  });

  LoggedInUser.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    googleId = json['googleId'] ?? '';
    name = json['name'] ?? '';
    email = json['email'] ?? '';
    accessToken = json['accessToken'] ?? '';
    isPremium = json['isPremium'];
    isLoggedIn = json['isLoggedIn'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['googleId'] = googleId;
    data['name'] = name;
    data['email'] = email;
    data['accessToken'] = accessToken;
    data['isPremium'] = isPremium;
    data['isLoggedIn'] = isLoggedIn;
    return data;
  }
}

class UserApi {
  late final int? id;
  late final String? googleId;
  late final String? name;
  late final String? email;
  late final String? accessToken;
  late final bool? isPremium;

  UserApi({
    this.id,
    this.googleId,
    this.name,
    this.email,
    this.accessToken,
    this.isPremium = false,
  });

  UserApi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    googleId = json['google_id'];
    name = json['name'];
    email = json['email'];
    accessToken = json['access_token'];
    isPremium = json['isPremium'];
  }
}
