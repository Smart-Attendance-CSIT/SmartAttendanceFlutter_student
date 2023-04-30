class StudentSummary {
  int? uNKNOWN;
  int? pRESENT;
  int? aBSENT;
  int? lATE;

  StudentSummary({this.uNKNOWN, this.pRESENT, this.aBSENT, this.lATE});

  StudentSummary.fromJson(Map<String, dynamic> json) {
    uNKNOWN = json['UNKNOWN'];
    pRESENT = json['PRESENT'];
    aBSENT = json['ABSENT'];
    lATE = json['LATE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UNKNOWN'] = this.uNKNOWN;
    data['PRESENT'] = this.pRESENT;
    data['ABSENT'] = this.aBSENT;
    data['LATE'] = this.lATE;
    return data;
  }
}
