import 'package:bidphar/models/Users.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveLoginUser{
  String userName = "username";
  String passWord = "password";
  String idUser = "iduser";
  String nameUser = "nameuser";
  String role = "role";
  String email = "email";
  String status = "isLogin";
  SharedPreferences _prep;

  SaveLoginUser({this.userName, this.passWord, this.idUser, this.nameUser, this.role, this.email, this.status});

  Future<Users> getUserSave() async{
    Users _users;
    _prep = await SharedPreferences.getInstance();
    print(_prep.getBool('isLogin'));
    if(_prep.getBool(status)){
     _users = new Users(
       idUser: _prep.getString(idUser),
       userName: _prep.getString(userName),
       passWord: _prep.getString(passWord),
       nameUser: _prep.getString(nameUser),
       role: _prep.getInt(role),
       email: _prep.getString(email),
     );
    }
    return _users;
  }
}