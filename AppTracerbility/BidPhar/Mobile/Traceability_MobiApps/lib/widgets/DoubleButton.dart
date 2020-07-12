import 'package:flutter/material.dart';

class DoubleButton extends StatelessWidget {
  final Function funcButton1;
  final Function funcButton2;

  final Icon iconButton1;
  final Icon iconButton2;

  final String titleButton1;
  final String titleButton2;

  const DoubleButton({Key key, this.funcButton1, this.funcButton2, this.iconButton1, this.iconButton2, this.titleButton1, this.titleButton2}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RaisedButton(
          onPressed: (){
            funcButton1();
          },
          child: Container(
            child: Row(
              children: <Widget>[
                // Icon(Icons.camera_alt, color: Colors.white, size: 30,),
                iconButton1,
                SizedBox(width: 10, height: 60,),
                Text(titleButton1, style: TextStyle(color: Colors.white, fontSize: 18),)
              ],
            ),
          ),
          color: Colors.blue[600],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        SizedBox(width: 40,),
        RaisedButton(
          onPressed: (){
            funcButton2();
          },
          child: Container(
            child: Row(
              children: <Widget>[
                // Icon(Icons.exit_to_app, color: Colors.white, size: 30,),
                iconButton2,
                SizedBox(width: 10, height: 60,),
                Text(titleButton2, style: TextStyle(color: Colors.white, fontSize: 18),)
              ],
            ),
          ),
          color: Colors.blue[600],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ],
    );
  }
}