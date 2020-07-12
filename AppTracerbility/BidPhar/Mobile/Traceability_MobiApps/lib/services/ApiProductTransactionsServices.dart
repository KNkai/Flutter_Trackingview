import 'dart:convert';
import 'package:bidphar/models/ApiModel.dart';
import 'package:bidphar/models/ProductTransactions.dart';
import 'package:http/http.dart' show Client;

class ApiProdTransServices{
  final String baseUrl =ApiModel.baseUrl+"producttransactions";

  Client client = Client();

  Future<List<ProductTransactions>> getProductTransactionsByProduct(String id) async{
    final response = await client.get(
      "$baseUrl/gettrans?id=$id"
    );
    if(response.statusCode==200){
      return productTransFromJson(response.body);
    }else{
      return null;
    }
  }

  Future<bool> createProductTransactions(ProductTransactions data) async {
    final response = await client.post(
      "$baseUrl/add",
      headers: {"content-type": "application/json"},
      body:productTransToJson(data)
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  List<ProductTransactions> productTransFromJson(String jsonData) {
    final data = json.decode(jsonData);
    return List<ProductTransactions>.from(data.map((item) => ProductTransactions.fromJson(item)));
  }

  String productTransToJson(ProductTransactions data) {
    final jsonData = data.toJson();
    print(json.encode(jsonData));
    return json.encode(jsonData);
  }
}