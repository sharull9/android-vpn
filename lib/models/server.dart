class Server {
  late final String hostname;
  late final String ip;
  late final String ping;
  late final String speed;
  late final String configData;
  late final String username;
  late final String password;

  Server({
    required this.hostname,
    required this.ip,
    required this.ping,
    required this.speed,
    required this.configData,
    required this.username,
    required this.password,
  });

  Server.fromJson(Map<String, dynamic> json) {
    hostname = json['hostname'] ?? '';
    ip = json['ip'] ?? '';
    ping = json['ping'] ?? '';
    speed = json['speed'] ?? '';
    configData = json['configdata'] ?? '';
    username = json['username'] ?? '';
    password = json['password'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['hostname'] = hostname;
    data['ip'] = ip;
    data['ping'] = ping;
    data['speed'] = speed;
    data['configdata'] = configData;
    data['username'] = username;
    data['password'] = password;
    return data;
  }
}
