
import 'package:bidphar/views/InfoTracking.dart';
import 'package:bidphar/widgets/AppBarCustom.dart';
import 'package:bidphar/widgets/DoubleButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class TrackingView extends StatefulWidget {
  @override
  _TrackingViewState createState() => _TrackingViewState();
}

class _TrackingViewState extends State<TrackingView> {

  String _scanBarcode = 'Click Scan to scan barcode';

  // startBarcodeScanStream() async {
  //   FlutterBarcodeScanner.getBarcodeStreamReceiver(
  //           "#ff6666", "Cancel", true, ScanMode.BARCODE)
  //       .listen((barcode) => print(barcode));
  // }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      print("------------------>"+barcodeScanRes);
      if(barcodeScanRes!="-1"){
        Navigator.push(context, MaterialPageRoute(builder: (context) => InfoTrackingView(barCode: _scanBarcode,)));
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        appBar: AppBar(),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                Text(
                  _scanBarcode,
                  style: TextStyle(
                    fontSize: 20.0, 
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 50,),

                Container(
                  height: 200,
                  child: DoubleButton(
                    funcButton1: scanBarcodeNormal,
                    funcButton2: (){
                      Navigator.pop(context);
                    },
                    iconButton1:Icon(Icons.camera_alt, color: Colors.white, size: 30,),
                    iconButton2: Icon(Icons.exit_to_app, color: Colors.white, size: 30,),
                    titleButton1: "Scan",
                    titleButton2: "Back",
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}