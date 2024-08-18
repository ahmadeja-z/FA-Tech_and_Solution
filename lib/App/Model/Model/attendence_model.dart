class AttendanceModel {
  String? uid;
  String? totalClasses;
  String? present;
  String? absent;
  String? leaves;
  String? leavesLeft;

  AttendanceModel(
      this.uid,
      this.totalClasses,
      this.present,
      this.absent,
      this.leaves,
      this.leavesLeft,
      );

  AttendanceModel.fromMap(Map<String, dynamic> map) {
    uid = map['uid']??'';
    totalClasses = map['totalClasses'];
    present = map['present'];
    absent = map['absent'];
    leaves = map['leaves'];
    leavesLeft = map['leavesLeft'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'totalClasses': totalClasses,
      'present': present,
      'absent': absent,
      'leaves': leaves,
      'leavesLeft': leavesLeft
    };
  }
}
