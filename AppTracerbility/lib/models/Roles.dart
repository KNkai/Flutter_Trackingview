class Roles{
  int id;
  String roleName;

  Roles({this.id, this.roleName});

  factory Roles.fromJson(Map<String, dynamic> map){
    return Roles(
      id: map['idRole'],
      roleName: map['nameRole']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'idRole': id,
      'nameRole':roleName
    };
  }

}