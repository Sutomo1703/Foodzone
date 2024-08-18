class UserModel {
  String? uid;
  String? email;
  String? firstname;
  String? secondname;
  String? password;
  String? telephone;



  UserModel({this.uid, this.email, this.firstname, this.secondname, this.password, this.telephone});


  // receiving data from server
  factory UserModel.fromMap(map)
  {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstname: map['firstName'],
      secondname: map['secondName'],
      password: map['password'],
      telephone: map['telephone'],
    );
  }

  //sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstname,
      'secondName': secondname,
      'password': password,
      'telephone': telephone,
    };
  }
}