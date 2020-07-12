class Users{
  String userName;
  String passWord;
  String idUser;
  String nameUser;
  int role;
  String email;
  String avatar;
  

  Users({this.nameUser, this.role, this.email, this.userName, this.passWord, this.idUser, this.avatar});

  factory Users.fromJson(Map<String, dynamic> map){
    return Users(
      idUser: map["idUser"],
      email: map["email"],
      nameUser: map["nameUser"],
      passWord: map["password"],
      userName: map["username"],
      role: map["idRole"],
      avatar: map["avatar"]
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'idUser':idUser,
      'email':email,
      'nameUser':nameUser,
      'password':passWord,
      'username':userName,
      'idRole':role,
      'avatar':avatar
    };
  }
}