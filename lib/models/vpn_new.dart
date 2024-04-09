class VpnNew {
  late final String hostname;
  late final String ip;
  late final String ping;
  late final String speed;
  late final String countryLong;
  late final String countryShort;
  late final String configdataBase64;

  VpnNew({
    required this.hostname,
    required this.ip,
    required this.ping,
    required this.speed,
    required this.countryLong,
    required this.countryShort,
    required this.configdataBase64,
  });

  VpnNew.fromJson(Map<String, dynamic> json) {
    hostname = json['hostname'] ?? '';
    ip = json['ip'] ?? '';
    ping = json['ping'].toString();
    speed = json['speed'] ?? 0;
    countryLong = json['country_long'] ?? '';
    countryShort = json['country_short'] ?? '';
    configdataBase64 = json['configdata_base64'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['hostname'] = hostname;
    data['ip'] = ip;
    data['ping'] = ping;
    data['speed'] = speed;
    data['country_long'] = countryLong;
    data['country_short'] = countryShort;
    data['configdata_base64'] = configdataBase64;
    return data;
  }
}
