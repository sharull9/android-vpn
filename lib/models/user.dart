class User {
  String name = "";
  String email = "";
  String status = "";
  String role = "";
  String accessToken = "";
  bool isPremium = false;
  String subscriptionId = "";

  User({
    required this.name,
    required this.email,
    required this.status,
    required this.role,
    required this.accessToken,
    required this.isPremium,
    required this.subscriptionId,
  });

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "";
    email = json['email'] ?? "";
    status = json['status'] ?? "";
    role = json['role'] ?? "";
    accessToken = json['access_token'] ?? "";
    isPremium = json['is_premium'] ?? false;
    subscriptionId = json['subscription_id'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['status'] = this.status;
    data['role'] = this.role;
    data['access_token'] = this.accessToken;
    data['is_premium'] = this.isPremium;
    data['subscription_id'] = this.subscriptionId;
    return data;
  }
}
