import 'package:bidphar/SharedPreferences/SaveLoginUser.dart';
import 'package:bidphar/models/Users.dart';
import 'package:bidphar/services/ApiRoleServices.dart';
import 'package:bidphar/services/ApiUserServices.dart';
import 'package:bidphar/views/MainView.dart';
import 'package:bidphar/views/SignUpView.dart';
import 'package:bidphar/widgets/RoundedDiagonalClipper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  var _userController = new TextEditingController();
  var _passController = new TextEditingController();
  ApiUserServices apiUserServices;
  SaveLoginUser saveLoginUser;
  ApiRoleServices apiRoleServices;
  bool _passVisible = true;
  SharedPreferences _preferences;

  @override
  void initState(){
    apiUserServices = ApiUserServices();
    saveLoginUser = SaveLoginUser();
    apiRoleServices = ApiRoleServices();
    _passVisible=true;
    super.initState();
    _checkLoginStatus();
  }

  _checkLoginStatus()async{
    _preferences = await SharedPreferences.getInstance();
    if(_preferences.getBool("isLogin")){
      Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) => MainView()
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue.shade100,
        child: ListView(
          children: <Widget>[
            SizedBox(height: 50,),
            CircleAvatar(child: Image.asset("images/logo.png"), maxRadius: 50,backgroundColor: Colors.transparent,),
            SizedBox(height: 50,),
            _buildLoginForm(),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(
                        builder: (BuildContext context) => SignUpView()
                      ));
                    },
                    child: Text("Sign Up", style: TextStyle(color: Colors.blue, fontSize: 18.0)),

                  )
                ],
              ),
            )
          ],
          
        ),
      ),
    );
  }

  _buildLoginForm(){
    return Container(
      padding: const EdgeInsets.all(20),
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: RoundedDiagonalPathClipper(),
            child: Container(
              height: 400,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 90,),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: _userController,
                      style: TextStyle(color: Colors.blue),
                      decoration: InputDecoration(
                        hintText: "Username",
                        hintStyle: TextStyle(color: Colors.blue.shade200),
                        border: InputBorder.none,
                        icon: Icon(Icons.person, color: Colors.blue,)
                      ),
                    )
                  ),
                  Container(child: Divider(color: Colors.blue.shade400,), padding: EdgeInsets.only(left: 20.0,right: 20.0, bottom: 10.0),),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 5,
                          child: TextField(
                            maxLength: 20,
                            controller: _passController,
                            textInputAction: TextInputAction.done,
                            obscureText: _passVisible,
                            style: TextStyle(color: Colors.blue),
                            decoration: InputDecoration(
                              hintText: "Password",
                              hintStyle: TextStyle(color: Colors.blue.shade200),
                              border: InputBorder.none,
                              icon: Icon(Icons.lock, color: Colors.blue,),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            icon: _passVisible ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                            onPressed: (){
                              setState(() {
                                _passVisible = !_passVisible;
                              });
                            },
                          ),
                        ),
                      ],
                    )
                  ),
                  Container(child: Divider(color: Colors.blue.shade400,), padding: EdgeInsets.only(left: 20.0,right: 20.0, bottom: 10.0),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(padding: EdgeInsets.only(right: 20.0),
                        child: Text("Forgot Password",
                          style: TextStyle(color: Colors.black45),
                        )
                      )
                    ],
                  ),
                  SizedBox(height: 10.0,),
                ],
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 40.0,
                backgroundColor: Colors.blue.shade600,
                child: Icon(Icons.person),
              ),
            ],
          ),
          Container(
            height: 420,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: RaisedButton(
                onPressed: (){
                  _loginUsers();
                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
                child: SizedBox(
                  width: 100,
                  height: 50,
                  child: Center(
                    child: Text(
                      "Login", 
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                color: Colors.blue,
              ),
            ),
          )
        ],
      ),
    );
  }

  _loginUsers(){
    apiUserServices.loginUser(_userController.text, _passController.text).then((isSuccess){
      setState(() async {
        if(isSuccess==null){
          print("error");
        }
        else{
          apiRoleServices.nameRole(isSuccess.role).then((value) {
            if(value!=null){
              _saveUser(isSuccess, true, value);
                Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) => MainView()
                ));
            }
          });
        }
      });
    });
  }

  _saveUser(Users users, bool isLogin, String roleName) async {
    if(isLogin){
      _preferences = await SharedPreferences.getInstance();
      _preferences.setBool("isLogin", isLogin);
      _preferences.setString("username", users.userName);
      _preferences.setString("password", users.passWord);
      _preferences.setString("iduser", users.idUser);
      _preferences.setString("nameuser", users.nameUser);
      _preferences.setInt("role", users.role);
      _preferences.setString("email", users.email);
      _preferences.setString("rolename", roleName);
    }else{
      _preferences.clear();
      _preferences.setBool("isLogin", false);
    }
    
  }
}
