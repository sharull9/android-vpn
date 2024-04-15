class VpnStatus {
  VpnStatus({
    this.duration,
    this.lastPacketReceive,
    this.byteIn,
    this.byteOut,
  });

  String? duration;
  String? lastPacketReceive;
  String? byteIn;
  String? byteOut;

  VpnStatus.fromJson(Map<String, dynamic> json) {
    duration = json['duration'];
    lastPacketReceive = json['last_packet_receive'];
    byteIn = json['byte_in'];
    byteOut = json['byte_out'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['duration'] = this.duration;
    data['last_packet_receive'] = this.lastPacketReceive;
    data['byte_in'] = this.byteIn;
    data['byte_out'] = this.byteOut;
    return data;
  }
}
