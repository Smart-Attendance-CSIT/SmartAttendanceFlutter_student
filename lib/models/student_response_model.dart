class StudentResponsemodel {
  bool? success;
  User? user;
  String? token;
  String? expiresIn;

  StudentResponsemodel({this.success, this.user, this.token, this.expiresIn});

  StudentResponsemodel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
    expiresIn = json['expiresIn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['token'] = this.token;
    data['expiresIn'] = this.expiresIn;
    return data;
  }
}

class User {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? role;
  Null? contactId;
  Null? sessionId;

  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.role,
      this.contactId,
      this.sessionId});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    role = json['role'];
    contactId = json['contactId'];
    sessionId = json['sessionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['role'] = this.role;
    data['contactId'] = this.contactId;
    data['sessionId'] = this.sessionId;
    return data;
  }
}