import 'package:bidphar/models/Products.dart';
import 'package:bidphar/services/ApiProductServices.dart';
import 'package:bidphar/widgets/AppBarCustom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class AddListDataView extends StatefulWidget {
  @override
  _AddListDataViewState createState() => _AddListDataViewState();
}

class _AddListDataViewState extends State<AddListDataView> {

  var _idController = TextEditingController();
  var _urlController = TextEditingController();
  ApiProductServices apiProductServices;
  List<Products> listProducts;
  bool isLoading = true;

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      print("------------------>"+barcodeScanRes);
      if(barcodeScanRes!="-1"){
        
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _idController.text = barcodeScanRes;
      _urlController.text = "http://192.168.0.5:8888/api/product?id=$barcodeScanRes";
      apiProductServices.getListProductFromApi(_urlController.text).then((value){
        if(value!=null){
          listProducts = value;
          isLoading = false;
          setState(() {
            
          });
        }
      });
    });
  }

  @override
  void initState() {
    apiProductServices = ApiProductServices();
    _urlController.text = "http://192.168.0.5:8888/api/product?id=0";
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        appBar: AppBar(),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Center(child: Text("URL"))
                ),
                SizedBox(width: 10,),
                Expanded(
                  flex: 4,
                  child: TextField(
                    controller: _urlController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blueAccent,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: "URL",
                    )
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 100,
            color: Colors.transparent,
            child: Column(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 8),
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: FlatButton(
                              child: SizedBox(
                                child: Icon(Icons.camera_alt, size: 30, color: Colors.lightBlue,),
                                height: 65,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                  color: Colors.blueAccent
                                )
                              ),
                              onPressed: () {
                                scanBarcodeNormal().then((value){
                                });
                              },
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            flex: 4,
                            child: TextField(
                              controller: _idController,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blueAccent,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                hintText: "ID",
                              )
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          
          SizedBox(height: 30,),
          Container(
            height: MediaQuery.of(context).size.height-200,
            color: Colors.transparent,
            child: isLoading == true ? Center(child: Text("Empty data"),) : ListView.builder(
              padding: EdgeInsets.all(6),
              itemCount: listProducts.length,
              itemBuilder: (BuildContext context, int index){
                Products products = listProducts[index];
                return Card(
                  elevation: 3,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 100,
                          color: Colors.blue,
                          child: Center(
                            child: Text(products.id, textAlign: TextAlign.center,),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(child: Text("Name Product:")),
                                      Expanded(child: Text(products.nameProduct))
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(child: Text("Mgf Date :")),
                                      Expanded(child: products.manufacturedDate==null ? Text("null") : Text(products.manufacturedDate.substring(0,10)))
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(child: Text("Exp Date:")),
                                      Expanded(child: products.expiredDate==null ? Text("null")  : Text(products.expiredDate.substring(0,10)))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 20, 10),
        child: FloatingActionButton(
          backgroundColor: Colors.lightBlue,
          child: Icon(Icons.check_circle_outline, size: 35,),
          onPressed: (){
            if(listProducts.length!=0){
              apiProductServices.addListProduct(listProducts).then((value){
                if(!value){
                  print(value);
                }
                else{
                  Navigator.pop(context);
                }
              });
            }
            
          },
        ),
      ),
    );
  }
}