import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {

  final String title;  
  final Widget child;  
  final Color backgroundColor;
  final Function onPressed;  
  final Function onTitleTapped;  
  final Widget leading;
  final AppBar appBar;



  const AppBarCustom({Key key, this.title, this.appBar, this.backgroundColor, this.onPressed, this.onTitleTapped, this.child, this.leading}) : super(key: key);   

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(padding: const EdgeInsets.all(8.0), child: Image.asset("images/logo.jpg"),),
      backgroundColor: Colors.white,
      title: Text("I4S TRACKING SYSTEM", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.lightBlue),),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(30),
        child: Container(color: Colors.blue, height: 4.0,),
      ),
    );
  }
  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}