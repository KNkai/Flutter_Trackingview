import 'package:bidphar/models/ProductTransactions.dart';
import 'package:bidphar/models/Products.dart';
import 'package:bidphar/services/ApiLocationServices.dart';
import 'package:bidphar/services/ApiProductServices.dart';
import 'package:bidphar/services/ApiProductTransactionsServices.dart';
import 'package:bidphar/widgets/AppBarCustom.dart';
import 'package:flutter/material.dart';

class InfoTrackingView extends StatefulWidget {
  final String barCode;

  const InfoTrackingView({Key key, this.barCode}) : super(key: key);
  @override
  _InfoTrackingViewState createState() => _InfoTrackingViewState();
}

class _InfoTrackingViewState extends State<InfoTrackingView> {
  //Biến barcode
  
  ApiProdTransServices apiProdTransServices;
  ApiProductServices apiProductServices;
  ApiLocationServices apiLocationServices;

  @override
  void initState(){
    super.initState();
    apiProdTransServices = ApiProdTransServices();
    apiProductServices = ApiProductServices();
    apiLocationServices = ApiLocationServices();
    
  }

  _showPopup(ProductTransactions productTransactions, String nameLocation){
    return showGeneralDialog(
    barrierColor: Colors.black.withOpacity(0.5),
    transitionBuilder: (context, a1, a2, widget) {
      final curvedValue = Curves.easeInOutBack.transform(a1.value) -   1.0;
      return Transform(
        transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
        child: Opacity(
          opacity: a1.value,
          child: Container(
            child: Center(
              child: Card(
                elevation: 30,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Container(
                  height: 250,
                  width: MediaQuery.of(context).orientation==Orientation.portrait ? (MediaQuery.of(context).size.width - 50) : (MediaQuery.of(context).size.width - 150) ,
                  child: ListView(
                    children: <Widget>[
                      SizedBox(height: 30,),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Container(
                          child: Row(
                            children: [
                              Expanded(flex:1, child: Center(child: Text("User Created: ", style: TextStyle(
                                color: Colors.blue,
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                              ),))),
                              Expanded(flex:1, child: Text(productTransactions.idUser==null?"null":productTransactions.idUser)),
                            ],
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                        child: Container(
                          child: Row(
                            children: [
                              Expanded(flex:1, child: Center(child: Text("Date Created: ", style: TextStyle(
                                color: Colors.blue,
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                              )))),
                              Expanded(flex:1, child: Text(productTransactions.dateChecked)),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                        child: Container(
                          child: Row(
                            children: [
                              Expanded(flex:1, child: Center(child: Text("Location Check: ", style: TextStyle(
                                color: Colors.blue,
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                              )))),
                              Expanded(flex:1, child: Text(nameLocation)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ),
              ),
            ),
          )
        ),
      );
    },
    transitionDuration: Duration(milliseconds: 200),
    barrierDismissible: true,
    barrierLabel: '',
    context: context,
    pageBuilder: (context, animation1, animation2) {});
  }

  // List<ProductTransactions> listModel = apiProdTransServices.getProductTransactionsByProduct(this.barCode);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        appBar: AppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //biến barcode
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 50, 0, 20),
              child: Text(
                "Product Code: "+widget.barCode,
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 18
                ),
              ),
            ),
            Divider(
              color: Colors.blue,
              thickness: 1.5,
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Info:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: FutureBuilder(
                future: apiProductServices.getProductById(widget.barCode),
                builder: (context, snapshot){
                    // print(jsonEncode(snapshot.data));
                    if(snapshot.hasData){
                      Products productTemp = snapshot.data ;
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "-Manufactured date: "+ productTemp.manufacturedDate.substring(0,10),
                              style: TextStyle(
                                color:Colors.lightBlue,
                              ),
                            ),
                            SizedBox(height: 5,),
                            Text(
                              "-Expired date: "+ productTemp.expiredDate.substring(0,10),
                              style: TextStyle(
                                color:Colors.lightBlue,
                              ),
                            ),
                            SizedBox(height: 5,),
                            Text(
                              "-Product of "+ productTemp.manufactured,
                              style: TextStyle(
                                color:Colors.lightBlue,
                              ),
                            )
                          ],
                        );
                    }else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
              )
            ),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Tracing Data:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              height: 300,
              // child: ListTrackingView(listDataTracking: listDataTracking,)
              child: SafeArea(
                child: FutureBuilder(
                  future: apiProdTransServices.getProductTransactionsByProduct(widget.barCode),
                  builder: (BuildContext context, AsyncSnapshot<List<ProductTransactions>> snapshot){
                    if(snapshot.hasError){
                      return Center( child:  Text("Something wrong with message: ${snapshot.error.toString()}"),);
                    }
                    else if(snapshot.connectionState==ConnectionState.done){
                      List<ProductTransactions> listModel = snapshot.data;
                      return _listTrackingView(listModel,);
                    }else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back, color: Colors.white, size: 30,),
      ),
    );
  }
  _listTrackingView(List<ProductTransactions> listDataTracking){
    return ListView.separated(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(8),
      itemBuilder: (BuildContext context, int index) {
        int idLoc = listDataTracking[index].idLocation;
        String nameLocation;
        var formatDate;
        print(idLoc.toString());
        return Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 5,
                child: FutureBuilder(
                  future: apiLocationServices.nameLocation(idLoc),
                  builder: (context, snapshot){
                    if(snapshot.hasData){
                      nameLocation = snapshot.data;
                      formatDate = listDataTracking[index].dateChecked.substring(0,19).split('T');
                      return Text("${formatDate[0]+" "+formatDate[1]}"+"-"+"$nameLocation"+"-"+"${listDataTracking[index].detail}");
                    }
                  },
                ),
              ),
              
              SizedBox(width: 50,),
              Expanded(
                flex: 3,
                child: FlatButton(
                  onPressed: (){
                    _showPopup(listDataTracking[index], nameLocation);
                  },
                  child: Text("Detail", style: TextStyle(color: Colors.lightBlue),),
                )
              )
            ],
          ),
        );
      }, 
      separatorBuilder: (BuildContext context, int index) => const Divider(), 
      itemCount: listDataTracking.length
    );
  }
}