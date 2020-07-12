import 'dart:convert';

import 'package:bidphar/models/ApiModel.dart';
import 'package:bidphar/models/Roles.dart';
import 'package:http/http.dart';

class ApiRoleServices{
  final String baseUrl = ApiModel.baseUrl+'role';
  Client client = Client();

  Future<String> nameRole(int id) async {
    final response = await client.get(
      "$baseUrl/getid?id=$id",
      headers: {"content-type": "application/json"},
    );
    if(response.statusCode==200){

      return nameRoleEncode(response.body);
    }else{
      print("$baseUrl/getid?id=$id");
      print(response.statusCode);
      return null;
    }
  }

  Future<Roles> getRoleById(int id) async{
    final response = await client.get(
      "$baseUrl/getid?id=$id",
    );
    if(response.statusCode==200){
      return rolesFromJson(response.body);
    }else{
      return null;
    }
  }

  Roles rolesFromJson(String jsonData) {
    Map data = jsonDecode(jsonData);
    var role = Roles.fromJson(data);
    return role;
    
  }

  String nameRoleEncode(String json){
    Map model = jsonDecode(json);
    var role = Roles.fromJson(model);
    return role.roleName;
  }
}