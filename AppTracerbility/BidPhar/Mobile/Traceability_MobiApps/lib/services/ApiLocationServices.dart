import 'dart:convert';
import 'package:bidphar/models/ApiModel.dart';
import 'package:bidphar/models/Locations.dart';
import 'package:http/http.dart' show Client;

class ApiLocationServices{
  final String baseUrl = ApiModel.baseUrl+'location';
  Client client = Client();

  Future<String> nameLocation(int id) async {
    final response = await client.get("$baseUrl?id=$id");
    if(response.statusCode==200){
      return nameLocationEncode(response.body);
    }else{
      return null;
    }
  }

  Future<List<Locations>> getAllLocation() async {
    final response = await client.get("$baseUrl/getall");
    if(response.statusCode==200){
      return locationsFromJson(response.body);
    }else{
      return null;
    }
  }

  List<Locations> locationsFromJson(String jsonData) {
    final data = json.decode(jsonData);
    return List<Locations>.from(data.map((item) => Locations.fromJson(item)));
  }

  String nameLocationEncode(String json){
    Map model = jsonDecode(json);
    var location = Locations.fromJson(model);
    return location.nameLocation;
  }
}