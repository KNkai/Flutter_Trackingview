import 'package:bidphar/widgets/RoundedDiagonalClipper.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {

  var _userController = new TextEditingController();
  var _passController = new TextEditingController();
  var _nameController = new TextEditingController();
  var _emailController = new TextEditingController();
  bool _passVisible = true;

  @override
  void initState(){
    _passVisible=true;
    super.initState();
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
            _buildSignUpForm(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                  child: FloatingActionButton(
                    mini: true,
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.arrow_back),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  _buildSignUpForm(){
    return Container(
      padding: const EdgeInsets.all(20),
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: RoundedDiagonalPathClipper(),
            child: Container(
              height: 450,
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
                      controller: _nameController,
                      style: TextStyle(color: Colors.blue),
                      decoration: InputDecoration(
                        hintText: "Full Name",
                        hintStyle: TextStyle(color: Colors.blue.shade200),
                        border: InputBorder.none,
                        icon: Icon(Icons.person_outline, color: Colors.blue,)
                      ),
                    )
                  ),
                  Container(child: Divider(color: Colors.blue.shade400,), padding: EdgeInsets.only(left: 20.0,right: 20.0, bottom: 10.0),),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Colors.blue),
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: TextStyle(color: Colors.blue.shade200),
                        border: InputBorder.none,
                        icon: Icon(Icons.email, color: Colors.blue,)
                      ),
                    )
                  ),
                  Container(child: Divider(color: Colors.blue.shade400,), padding: EdgeInsets.only(left: 20.0,right: 20.0, bottom: 10.0),),
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
            height: 470,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: RaisedButton(
                onPressed: (){},
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
                child: SizedBox(
                  width: 100,
                  height: 50,
                  child: Center(
                    child: Text(
                      "Sign Up", 
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
}