class UpdateModel {
  String? uid;
  String? firstname;
  String? secondname;
  String? telephone;

  UpdateModel({this.uid, this.firstname, this.secondname, this.telephone});

  // receiving data from server
  factory UpdateModel.fromMap(map) {
    return UpdateModel(
      uid: map['uid'],
      firstname: map['firstName'],
      secondname: map['secondName'],
      telephone: map['telephone'],
    );
  }

  //sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'firstName': firstname,
      'secondName': secondname,
      'telephone': telephone,
    };
  }
}
