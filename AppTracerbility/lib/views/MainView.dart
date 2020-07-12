import 'package:bidphar/views/AddListDataView.dart';
import 'package:bidphar/views/DataInputView.dart';
import 'package:bidphar/views/InfoTracking.dart';
import 'package:bidphar/views/InfoUserView.dart';
import 'package:bidphar/views/TrackingView.dart';
import 'package:bidphar/widgets/AppBarCustom.dart';
import 'package:bidphar/widgets/SlidePageRoute.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int userRole;
  SharedPreferences _sharedPreferences;

  _getUserRole() async{
    _sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userRole = _sharedPreferences.getInt('role');
    });
  }

  @override
  void initState() { 
    super.initState();
    _getUserRole();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        appBar: AppBar(),
      ),
      body: MainItem(userRoleMain: userRole),
    );
  }
}

class MainItem extends StatelessWidget {
  final int userRoleMain;

  const MainItem({Key key, this.userRoleMain}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20.0),
        crossAxisSpacing: 30,
        childAspectRatio: 2.5,
        mainAxisSpacing: 20.0,
        crossAxisCount: 2,
        children: <Widget>[
          RaisedButton(
            color: Colors.lightBlue,
            onPressed: (){
              (userRoleMain==1||userRoleMain==2)?
              Navigator.push(context, SlideRightRoute(page: DataInputView())): null;
            },
            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Icon(Icons.add_box, size: 30, color: Colors.white,)
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    child:Center(
                      child: Text(
                        "DATA INPUT",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              ],
            )
          ),
          RaisedButton(
            color: Colors.lightBlue,
            onPressed: (){
              Navigator.push(context, SlideRightRoute(page: TrackingView()));
            },
            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Icon(Icons.code, size: 30, color: Colors.white,)
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    child:Center(
                      child: Text(
                        "TRACKING VIEW",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              ],
            )
          ),
          RaisedButton(
            color: Colors.lightBlue,
            onPressed: (){
              Navigator.push(context, SlideRightRoute(page: InfoUserView()));
            },
            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Icon(Icons.person, size: 30, color: Colors.white,)
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    child:Center(
                      child: Text(
                        "USER",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              ],
            )
          ),
          RaisedButton(
            color: Colors.lightBlue,
            onPressed: (){
              Navigator.push(context, SlideRightRoute(page: AddListDataView()));
            },
            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Icon(Icons.add, size: 30, color: Colors.white,)
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    child:Center(
                      child: Text(
                        "ADD DATA FROM API",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              ],
            )
          ),
        ],
      ),
    );
  }
}

