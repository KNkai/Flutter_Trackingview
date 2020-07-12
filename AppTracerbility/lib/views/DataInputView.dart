import 'package:bidphar/models/Locations.dart';
import 'package:bidphar/models/ProductTransactions.dart';
import 'package:bidphar/models/Products.dart';
import 'package:bidphar/services/ApiLocationServices.dart';
import 'package:bidphar/services/ApiProductServices.dart';
import 'package:bidphar/services/ApiProductTransactionsServices.dart';
import 'package:bidphar/widgets/AppBarCustom.dart';
import 'package:bidphar/widgets/DoubleButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';



class DataInputView extends StatefulWidget {
  @override
  _DataInputViewState createState() => _DataInputViewState();
}

class _DataInputViewState extends State<DataInputView> {

  bool isLoading = false;
  ApiLocationServices apiLocationServices;
  ApiProductServices apiProductServices;
  ApiProdTransServices apiProdTransServices;

  SharedPreferences _sharedPreferences;

  final _formKey = GlobalKey<FormState>();
  var _idController = TextEditingController();
  var _nameProductController = TextEditingController();
  var _nameManufacController = TextEditingController();
  var _detailController = TextEditingController();
  var _mgfDateController = "Mgf. Date";
  var _expDateController = "Exp Date";
  int _idLocationController =0 ;
  String _idUser;
  List<String> _nameCity2;
  String _currentNameCity;
  String _selectedLocation ;
  String _scanBarcode;
  var isUpdate=false;
  int _typeEmploy;
  bool _checkemp;
  
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
      _scanBarcode = barcodeScanRes;
      _idController.text = barcodeScanRes;
    });
  }

  @override
  void initState(){
    apiLocationServices = ApiLocationServices();
    apiProductServices = ApiProductServices();
    apiProdTransServices = ApiProdTransServices();
    
    super.initState();
    _checkShared();
  }

  _checkShared()async{
    _sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      _idUser = _sharedPreferences.getString('iduser');
      _typeEmploy = _sharedPreferences.getInt('role');
      _typeEmploy==1?_checkemp=true:_checkemp=false;    
    });
    print(_sharedPreferences.getInt('role'));
    print("======================");
  }

  List<String> _listNameLocation(List<Locations> list){
    List<String> tempNameLocation = new List<String>();
    for(var name in list){
      tempNameLocation.add(name.nameLocation);
    }
    return tempNameLocation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        appBar: AppBar(),
      ),
      body: Center(
        child: SingleChildScrollView(
            key: _formKey,
            child: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
                    child: Center(
                      child: Text(
                        "DATA ENTRY",
                        style: TextStyle(
                          color: Colors.blue[900],
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 40, 8),
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
                                  print("----------------000");
                                  apiProductServices.getProductById(_scanBarcode).then((value){
                                    setState(() {
                                      if(value != null){
                                        isUpdate = true;
                                        print(isUpdate);
                                        _nameProductController.text = value.nameProduct;
                                        _mgfDateController = value.manufacturedDate.substring(0,10);
                                        _expDateController = value.expiredDate.substring(0,10);
                                        _nameManufacController.text = value.manufactured;
                                        _detailController.text = value.details;

                                        apiProdTransServices.getProductTransactionsByProduct(_scanBarcode).then((value) {
                                          print("================");
                                          setState(() {
                                            if(value!=null){
                                              // print(value.elementAt(value.length-1).idLocation);
                                              apiLocationServices.nameLocation(value.elementAt(value.length-1).idLocation).then((value){
                                                setState(() {
                                                  if(value!=null){
                                                    _selectedLocation = value;
                                                  }
                                                });
                                              });
                                            }
                                          });
                                          print(_idLocationController);
                                        });

                                      }else{
                                        isUpdate = false;
                                      }
                                    });
                                  });
                                });
                              },
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            flex: 4,
                            child: TextField(
                              enabled: _checkemp,
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

                  SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: TextField(
                      controller: _nameProductController,
                      enabled: _checkemp,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueAccent,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: "Name Product",
                      )
                    ),
                  ),

                  SizedBox(height: 15,),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
                    child: Center(
                      child: FlatButton(
                        
                        onPressed: (){
                          switch(_typeEmploy){
                            case 1: {
                              DatePicker.showDatePicker(
                                context,
                                showTitleActions: true,
                                minTime: DateTime(1900, 1, 1),
                                maxTime: DateTime(2030, 12, 31),
                                onConfirm: (date) {
                                  print('=====>confirm $date'.toString());
                                  _mgfDateController = date.toString().split(' ')[0];
                                  setState(() {});
                                },
                                    currentTime: DateTime.now(), locale: LocaleType.vi
                              );
                              break;
                            }
                            case 2:{
                              Text(_mgfDateController);
                              break;
                            }
                          }
                          
                        },
                        child: Text(
                          '$_mgfDateController',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.blue[900]
                          ),
                        ),
                        color: Colors.lightBlue[50],
                      )
                    ),
                  ),

                   SizedBox(height: 5,),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
                    child: Center(
                      child: FlatButton(
                        onPressed: (){
                          switch(_typeEmploy){
                            case 1: {
                              DatePicker.showDatePicker(context,
                                showTitleActions: true,
                                minTime: DateTime(1900, 1, 1),
                                maxTime: DateTime(2030, 12, 31),
                                onConfirm: (date) {
                                  print('confirm $date');
                                  _expDateController = date.toString().split(' ')[0];
                                  setState(() {});
                              },
                                currentTime: DateTime.now(), locale: LocaleType.vi);
                              break;
                            }
                            case 2:{
                              Text(_expDateController);
                              break;
                            }
                          }
                          
                        },
                        child: Text(
                          '$_expDateController',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.blue[900]
                          ),
                        ),
                        color: Colors.lightBlue[50],
                      )
                    ),
                  ),

                  SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: TextField(
                      enabled: _checkemp,
                      controller: _nameManufacController,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueAccent,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: "Manufactured Name",
                      )
                    ),
                  ),
                  SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: TextField(
                      enabled: _checkemp,
                      controller: _detailController,
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueAccent,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: "Detail",
                      )
                    ),
                  ),
                  SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: FutureBuilder(
                          future: apiLocationServices.getAllLocation(),
                          builder: (context, snapshot) {
                            List<Locations> loc = snapshot.data;
                            _nameCity2 = _listNameLocation(loc);
                            if(_typeEmploy==1 || _typeEmploy ==2){
                              return DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedLocation,
                                onChanged: (newValue){
                                  setState(() {
                                    _selectedLocation = newValue;
                                  });
                                },
                                hint: Text("Please choose a location!"),
                                items: _nameCity2.map((location){
                                  return DropdownMenuItem(
                                    child: Text(location),
                                    value: location,
                                    onTap: () {
                                      setState(() {
                                        _idLocationController = _nameCity2.indexOf(location);
                                      });
                                    },
                                  );
                                }
                              ).toList());
                            }else{
                              return Text('null');
                            }
                          },
                        ),
                      )
                    ),
                  ),

                  SizedBox(height: 30,),
                  
                  DoubleButton(
                    funcButton1: (){
                      if(_typeEmploy==1 || _typeEmploy==2){
                          print("vao dau");
                          String dateNow = DateTime.now().toString().substring(0,19);
                          var listDateTime = dateNow.split(' ');
                          dateNow = listDateTime[0]+"T"+listDateTime[1];
                          ProductTransactions productTransactions = new ProductTransactions(
                            idProduct: this._idController.text,
                            dateChecked: dateNow,
                            idLocation: (_idLocationController+1),
                            idUser: _idUser,
                            // idLocation: 
                          );

                          // addDataEntry("11","01-01-2020","04-05-2022",1,http.Client());
                          Products data = new Products();

                          data.id = this._idController.text;
                          data.manufacturedDate = this._mgfDateController.toString();
                          data.expiredDate = this._expDateController.toString();
                          data.manufactured = this._nameManufacController.text;
                          data.nameProduct = this._nameProductController.text;
                          data.details = this._detailController.text;
                          if(!isUpdate){
                            data.idUser = _idUser;
                          }
                          //add 
                          print(isUpdate);
                          if(isUpdate==false){
                            print("vao do");
                            apiProductServices.createProduct(data).then((isSuccess) {
                              setState(() {
                                if(isSuccess){
                                  apiProdTransServices.createProductTransactions(productTransactions).then((isSuccess2) {
                                    if(isSuccess2){
                                      Navigator.pop(context);
                                    }
                                    else{
                                      print("--------------------------------fail2!");
                                    }
                                  });
                                }else{
                                  print("--------------------------------fail1!");
                                  
                                }
                              });
                            });
                          //update
                          }else{
                            print("vao day");
                            apiProductServices.updateProduct(data).then((value) {
                              setState(() {
                                if(value){
                                  apiProdTransServices.createProductTransactions(productTransactions).then((isSuccess2) {
                                    if(isSuccess2){
                                      Navigator.pop(context);
                                    }
                                    else{
                                      print("--------------------------------fail2!");
                                    }
                                  });
                                }else{
                                  print("--------------------------------fail3!");
                                }
                              });
                            });
                          }
                        }
                        else{
                          showGeneralDialog(
                            barrierColor: Colors.black.withOpacity(0.5),
                            transitionBuilder: (context, a1, a2, widget) {
                              final curvedValue = Curves.easeInOutBack.transform(a1.value) -   1.0;
                              return Transform(
                                transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
                                child: Opacity(
                                  opacity: a1.value,
                                  child: Container(
                                    child: Center(
                                      child: Container(
                                        width: 250,
                                        height: 150,
                                        color: Colors.transparent,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20)
                                          ),
                                          child: Center(child: Text("You don't have permission!", style: TextStyle(color: Colors.red),),),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              );
                            },
                            context: context, 
                            transitionDuration: Duration(milliseconds: 200),
                            barrierDismissible: true,
                            barrierLabel: '',
                            pageBuilder: (context, animation1, animation2) {}
                          );
                        }
                      }
                    ,
                    funcButton2: (){
                      Navigator.pop(context);
                    },
                    iconButton1: Icon(Icons.cloud_upload, color: Colors.white, size: 18,),
                    iconButton2: Icon(Icons.exit_to_app, color: Colors.white, size: 18,),
                    titleButton1: "Submit",
                    titleButton2: "Back",
                  ),
                  SizedBox(height: 20,)
                ],
              ),
            ),
          ),
        ),
      );
  }
}