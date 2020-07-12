import 'dart:convert';
import 'package:bidphar/models/ApiModel.dart';
import 'package:bidphar/models/Products.dart';
import 'package:http/http.dart' show Client;

class ApiProductServices{ 
  final String baseUrl = ApiModel.baseUrl+"product";
  Client client = Client();

  Future<Products> getProductById(String id) async{
    final response = await client.get(
      "$baseUrl?id=$id",
    );
    if(response.statusCode==200){
      if(productFromJson(response.body)==null){
        Products products = null;
        return products;
      }
      else{
        return productFromJson(response.body);
      }
    }else{
      return null;
    }
  }

  Future<bool> createProduct(Products data) async {
    final response = await client.post(
      "$baseUrl/add",
      headers: {"content-type": "application/json"},
      body:productToJsonAdd(data)
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateProduct(Products data)async{
    final response = await client.put(
      "$baseUrl/update",
      headers: {"content-type": "application/json"},
      body:productToJsonUpdate(data)
    );
    if (response.statusCode == 200) {
      
      return true;
    } else {
      print("$baseUrl/update");
      print(productToJsonUpdate(data));
      print(response.statusCode);
      return false;
    }
  }
  
  Future<List<Products>> getListProductFromApi(String url)async{
    final response = await client.get(url);
    if(response.statusCode==200){
      return productListFromJson(response.body);
    }
    return null;
  }

  List<Products> productListFromJson(String jsonData) {
    final data = json.decode(jsonData);
    return List<Products>.from(data.map((item) => Products.fromJson(item)));
  }

  Future<bool> addListProduct(List<Products> model)async {
    final response = await client.post(
      "$baseUrl/addlist",
      headers: {"content-type": "application/json"},
      body:productListToJsonAdd(model)
    );
    if(response.statusCode==200){
      return true;
    }
    print(productListToJsonAdd(model));
    print("$baseUrl/addlist");
    print(response.statusCode);
    return false;
  }

  String productListToJsonAdd(List<Products> model){
    final jsonData = jsonEncode(model);
    return jsonData;
  }

  Products productFromJson(String jsonData) {
    Map data = jsonDecode(jsonData);
    if(data.values.elementAt(0)==null){
      return null;
    }
    else{
      var product = Products.fromJson(data.values.elementAt(0));
      return product;
    }
    
  }

  String productToJsonAdd(Products data) {
    final jsonData = data.toJson();
    return json.encode(jsonData);
  }

  String productToJsonUpdate(Products data) {
    final jsonData = data.toJson();
    return json.encode(jsonData);
  }
} 