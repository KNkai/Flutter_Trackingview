import 'dart:convert';
import 'package:bidphar/models/ApiModel.dart';
import 'package:bidphar/models/Users.dart';
import 'package:http/http.dart' show Client;

class ApiUserServices{
  final String baseUrl = ApiModel.baseUrl+"user";
  Client client = Client();

  Future<Users> loginUser(String username, String password)async{
    String code = convertTo64Base(username, password);
    final response = await client.get(
      "$baseUrl/login",
      headers: {"Authorization":"Basic $code"},
    );
    if(response.statusCode==200){
      return userFromJson(response.body);
    }else{
      return null;
    }
  }

  Future<List<Users>> getAllUser(String username, String password) async {
    String code = convertTo64Base(username, password);
    final response = await client.get(
      "$baseUrl/getall",
      headers: {"Authorization":"Basic $code"},
    );
    if(response.statusCode==200){
      return listUsersFromJson(response.body);
    }else{
      print(response.statusCode);
      print("$baseUrl/getall");
      print("Basic $code");
      print("$username////////$password");
      return null;
    }
  }

  String convertTo64Base(String username, String password){
    String loginInfo = "$username:$password";
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String enCode = stringToBase64.encode(loginInfo);

    return enCode;
  }

  Users userFromJson(String jsonData) {
    Map data = jsonDecode(jsonData);
    var product = Users.fromJson(data);
    return product;
  }

  String userToJson(Users data) {
    final jsonData = data.toJson();
    return json.encode(jsonData);
  }

  List<Users> listUsersFromJson(String jsonData) {
    final data = json.decode(jsonData);
    return List<Users>.from(data.map((item) => Users.fromJson(item)));
  }
}