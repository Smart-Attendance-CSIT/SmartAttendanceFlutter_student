class Loginparams {
  String? email;
  String? password;

  Loginparams({this.email, this.password});

  Loginparams.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['email'] = email!;
    data['password'] = password!;
    return data;
  }
}
