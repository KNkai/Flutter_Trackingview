import 'package:bidphar/models/ProductTransactions.dart';
import 'package:bidphar/services/ApiProductTransactionsServices.dart';
import 'package:bidphar/widgets/AppBarCustom.dart';
import 'package:flutter/material.dart';

class DemoProd extends StatefulWidget {
  @override
  _DemoProdState createState() => _DemoProdState();
}

class _DemoProdState extends State<DemoProd> {
  BuildContext buildContext;
  ApiProdTransServices apiService;
  String id = "0000001";

  @override
  void initState(){
    super.initState();
    apiService = ApiProdTransServices();
  }

  @override
  Widget build(BuildContext context) {
    this.buildContext = context;
    return Scaffold(
      appBar: AppBarCustom(
        appBar: AppBar(),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: apiService.getProductTransactionsByProduct("0000001"),
          builder: (BuildContext context, AsyncSnapshot<List<ProductTransactions>> snapshot){
            if(snapshot.hasError){
              return Center( child:  Text("Something wrong with message: ${snapshot.error.toString()}"),);
            }
            else if(snapshot.connectionState==ConnectionState.done){
              List<ProductTransactions> listModel = snapshot.data;
              return _buildListview(listModel);
            }else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  _buildListview(List<ProductTransactions> listModel){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListView.builder(
        itemBuilder: (context, index){
          ProductTransactions model = listModel[index];
          return Padding(
            padding: const EdgeInsets.only(top:8),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(model.id.toString()),
                    Text(model.idLocation.toString()),
                    Text(model.idProduct),
                    Text(model.detail),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}