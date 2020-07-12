import 'dart:convert';

import 'package:bidphar/models/ApiModel.dart';
import 'package:bidphar/models/DataEntries.dart';
import 'package:http/http.dart' show Client;

class ApiDataEntryServices{
  final String baseUrl = ApiModel.baseUrl+"dataentry";

  Client client = Client();


  Future<List<DataEntries>> getDataEntry() async {
    final response = await client.get("$baseUrl/getall");
    if (response.statusCode == 200) {
      return dataEntriesFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<bool> createDataEntry(DataEntries data) async {
    final response = await client.post(
      "$baseUrl/add",
      headers: {"content-type": "application/json"},
      body:dataEntriesToJson(data)
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> delDataEntry(String id) async{
    final response = await client.delete(
      "$baseUrl/del?id=$id",
      headers: {"content-type": "application/json"},
    );
    if(response.statusCode == 404){
      return true;
    }else{
      return false;
    }
  }

  List<DataEntries> dataEntriesFromJson(String jsonData) {
    final data = json.decode(jsonData);
    return List<DataEntries>.from(data.map((item) => DataEntries.fromJson(item)));
  }

  String dataEntriesToJson(DataEntries data) {
    final jsonData = data.toJson();
    return json.encode(jsonData);
  }
}