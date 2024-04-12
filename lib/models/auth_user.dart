class User {
  String id = "";
  String name = "";
  String email = "";
  String status = "";
  String role = "";
  String accessToken = "";
  String subscriptionId = "";
  bool isPremium = false;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.status,
    required this.role,
    required this.accessToken,
    required this.isPremium,
    required this.subscriptionId,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    status = json['status'];
    role = json['role'];
    accessToken = json['access_token'];
    isPremium = json['is_premium'];
    subscriptionId = json['subscription_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
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
