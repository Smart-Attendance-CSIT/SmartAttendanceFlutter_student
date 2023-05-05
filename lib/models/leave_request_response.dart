class LeaveRequestResponse {
  String? msg;
  List<LeaveRequests>? leaveRequests;

  LeaveRequestResponse({this.msg, this.leaveRequests});

  LeaveRequestResponse.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['leaveRequests'] != null) {
      leaveRequests = <LeaveRequests>[];
      json['leaveRequests'].forEach((v) {
        leaveRequests!.add(new LeaveRequests.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.leaveRequests != null) {
      data['leaveRequests'] =
          this.leaveRequests!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeaveRequests {
  String? id;
  String? status;
  String? date;
  String? requestMessage;
  String? responseMessage;
  String? studentid;
  String? reviewedbyid;
  String? groupid;
  Student? student;
  GroupP? group;
  Student? reviewedBy;

  LeaveRequests(
      {this.id,
      this.status,
      this.date,
      this.requestMessage,
      this.responseMessage,
      this.studentid,
      this.reviewedbyid,
      this.groupid,
      this.student,
      this.group,
      this.reviewedBy});

  LeaveRequests.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    date = json['date'];
    requestMessage = json['requestMessage'];
    responseMessage = json['responseMessage'];
    studentid = json['studentid'];
    reviewedbyid = json['reviewedbyid'];
    groupid = json['groupid'];
    student =
        json['student'] != null ? new Student.fromJson(json['student']) : null;
    group = json['group'] != null ? new GroupP.fromJson(json['group']) : null;
    reviewedBy = json['reviewedBy'] != null
        ? new Student.fromJson(json['reviewedBy'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['date'] = this.date;
    data['requestMessage'] = this.requestMessage;
    data['responseMessage'] = this.responseMessage;
    data['studentid'] = this.studentid;
    data['reviewedbyid'] = this.reviewedbyid;
    data['groupid'] = this.groupid;
    if (this.student != null) {
      data['student'] = this.student!.toJson();
    }
    if (this.group != null) {
      data['group'] = this.group!.toJson();
    }
    if (this.reviewedBy != null) {
      data['reviewedBy'] = this.reviewedBy!.toJson();
    }
    return data;
  }
}

class Student {
  String? firstName;
  String? lastName;
  String? id;

  Student({this.firstName, this.lastName, this.id});

  Student.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['id'] = this.id;
    return data;
  }
}

class GroupP {
  String? id;
  String? name;

  GroupP({this.id, this.name});

  GroupP.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
