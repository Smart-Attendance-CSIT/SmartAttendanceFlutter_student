class Loginparams {
  String? email;
  String? password;
  String? otp;

  Loginparams({this.email, this.password, this.otp});

  Loginparams.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['email'] = email!;
    data['password'] = password!;
    data['otp'] = otp!;
    return data;
  }
}
