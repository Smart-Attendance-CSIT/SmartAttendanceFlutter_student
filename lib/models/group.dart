class Group {
  String? id;
  String? name;
  String? qrToken;
  int? radius;

  Group({this.id, this.name, this.qrToken, this.radius});

  Group.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    qrToken = json['qrToken'];
    radius = json['radius'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['qrToken'] = qrToken;
    data['radius'] = radius;
    return data;
  }
}
