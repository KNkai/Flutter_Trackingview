import 'dart:convert';

import 'package:bidphar/models/ApiModel.dart';
import 'package:bidphar/models/DataEntries.dart';
import 'package:bidphar/services/ApiDataEntryServices.dart';
import 'package:bidphar/widgets/AppBarCustom.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


Future<List<DataEntries>> fetchDataEntries(http.Client client) async{
  final response = await client.get(ApiModel.baseUrl+"dataentry/getall");
  print(response);
  return compute(parseDataEntries, response.body);
}

List<DataEntries> parseDataEntries(String responseBody){
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<DataEntries>((json) => DataEntries.fromJson(json)).toList();
}

class ShowDataEntries extends StatefulWidget {
  @override
  _ShowDataEntriesState createState() => _ShowDataEntriesState();
}

class _ShowDataEntriesState extends State<ShowDataEntries> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        appBar: AppBar(),
      ),
      body: FutureBuilder<List<DataEntries>>(
        future: fetchDataEntries(http.Client()),
        builder: (context, snapshot){
          if(snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
            ? DataEntriesList(data: snapshot.data) : CircularIndicatorProgressDemo();
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.replay),
        onPressed: (){
          CircularIndicatorProgressDemo();
        },
      ),
    );
  }
}

class DataEntriesList extends StatefulWidget {
  final List<DataEntries> data;
  const DataEntriesList({Key key, this.data}) : super(key: key);
  @override
  _DataEntriesListState createState() => _DataEntriesListState();
}

class _DataEntriesListState extends State<DataEntriesList> {
  
  ApiDataEntryServices apiServices;

  @override
  void initState(){
    super.initState();
    apiServices = ApiDataEntryServices();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2
      ),
      itemCount: widget.data.length,
      itemBuilder: (context, index){
        return Card(
          color: Colors.lightBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          ),
          elevation: 10,
          child: Column(
            children: <Widget>[
              Text(widget.data[index].id),
              Text(widget.data[index].startDate),
              Text(widget.data[index].endDate),
              Text(widget.data[index].idLocation.toString()),
              SizedBox(height: 10,),
              FlatButton(
                child: Icon(Icons.delete, color: Colors.red, size: 20,),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)
                ),
                onPressed: (){
                  String idTemp = widget.data[index].id.trim();
                  apiServices.delDataEntry(idTemp).then((isSuccess) {
                    if(isSuccess){
                      setState(() {
                        
                      });
                    }
                  });
                  print("Delete");
                },
              )
            ],
          ),
        );
      },
    );
  }
}

class CircularIndicatorProgressDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}