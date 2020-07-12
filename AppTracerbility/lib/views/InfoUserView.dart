import 'dart:async';

import 'package:bidphar/SharedPreferences/SaveLoginUser.dart';
import 'package:bidphar/models/Users.dart';
import 'package:bidphar/services/ApiRoleServices.dart';
import 'package:bidphar/services/ApiUserServices.dart';
import 'package:bidphar/views/LoginView.dart';
import 'package:bidphar/widgets/AppBarCustom.dart';
import 'package:bidphar/widgets/DoubleButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InfoUserView extends StatefulWidget {
  @override
  _InfoUserViewState createState() => _InfoUserViewState();
}

class _InfoUserViewState extends State<InfoUserView> {
  SaveLoginUser saveLoginUser;
  Users userTemp =new Users();
  SharedPreferences _prep;
  String roleName;
  double page;
  getUser()async{
    _prep = await SharedPreferences.getInstance();
    setState(() {
      userTemp.email = _prep.getString("email");
      userTemp.userName = _prep.getString("username");
      userTemp.idUser = _prep.getString("iduser");
      userTemp.nameUser = _prep.getString("nameuser");
      userTemp.passWord = _prep.getString("password");
      userTemp.role = _prep.getInt("role");
      roleName = _prep.getString("rolename");
    });
    
  }

  void dispose() {
    indexcontroller.close();
    super.dispose();
  }

  @override
  void initState() {
    
    super.initState();
    getUser();
    // page = pageController.page;
  }

  PageController pageController = PageController(initialPage: 0);
  StreamController<int> indexcontroller = StreamController<int>.broadcast();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBarCustom(
          appBar: AppBar(),
        ),
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (index){
            indexcontroller.add(index);
          },
          controller: pageController,
          children: <Widget>[
            InfoPage(
              email: userTemp.email,
              idUser: userTemp.idUser,
              nameUser: "${userTemp.nameUser}",
              role: "$roleName",
              userName: userTemp.userName,
            ),
            ListInfo(
              username: "${userTemp.userName}",
              password: "${userTemp.passWord}",
            ),
          ],
        ),
        bottomNavigationBar: StreamBuilder<Object>(
          initialData: 0,
          stream: indexcontroller.stream,
          builder: (context, snapshot) {
            print(pageController.page);
            int cIndex = snapshot.data;
            return FancyBottomNavigation(
              currentIndex: cIndex,
              items: <FancyBottomNavigationItem>[
                FancyBottomNavigationItem(
                    icon: Icon(Icons.person_outline), title: Text('Info')),
                FancyBottomNavigationItem(
                    icon: Icon(Icons.view_list), title: Text('List User')),
              ],
              onItemSelected: (int value) {
                indexcontroller.add(value);
                pageController.jumpToPage(value);
              },
            );
          }
        ),
        floatingActionButton: Visibility(
          visible: page == 0.0?false:true,
          child: FloatingActionButton(
            onPressed: (){},
            elevation: 3,
            child: Icon(Icons.add, size: 30,),
          ),
        ),
    );
  }
}
//start stl support info page
class UserInfo extends StatelessWidget {
  final String idUser;
  final String email;
  final String userName;

  const UserInfo({Key key, this.idUser, this.email, this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
            alignment: Alignment.topLeft,
            child: Text(
              "User Information",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Card(
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      ...ListTile.divideTiles(
                        color: Colors.grey,
                        tiles: [
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            leading: Icon(Icons.assignment_ind),
                            title: Text("ID"),
                            subtitle: Text(idUser==null ? "empty" : idUser),
                          ),
                          ListTile(
                            leading: Icon(Icons.email),
                            title: Text("Email"),
                            subtitle: Text(email==null ? "empty" : email),
                          ),
                          ListTile(
                            leading: Icon(Icons.person),
                            title: Text("Username"),
                            subtitle: Text(userName==null ? "empty" : userName),
                          ),
                          ListTile(
                            leading: Icon(Icons.person),
                            title: Text("About Me"),
                            subtitle: Text(
                                "This is a about me link and you can khow about me in this section."),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  final ExactAssetImage coverImage;
  final ExactAssetImage avatar;
  final String title;
  final String subtitle;
  final List<Widget> actions;

  const ProfileHeader(
      {Key key,
      @required this.coverImage,
      @required this.avatar,
      @required this.title,
      this.subtitle,
      this.actions})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Ink(
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(image: coverImage, fit: BoxFit.cover),
          ),
        ),
        Ink(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.black38,
          ),
        ),
        if (actions != null)
          Container(
            width: double.infinity,
            height: 200,
            padding: const EdgeInsets.only(bottom: 0.0, right: 0.0),
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: actions,
            ),
          ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 160),
          child: Column(
            children: <Widget>[
              Avatar(
                image: avatar,
                radius: 40,
                backgroundColor: Colors.white,
                borderColor: Colors.grey.shade300,
                borderWidth: 4.0,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.title,
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 5.0),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.subtitle,
                ),
              ]
            ],
          ),
        )
      ],
    );
  }
}

class Avatar extends StatelessWidget {
  final ImageProvider<dynamic> image;
  final Color borderColor;
  final Color backgroundColor;
  final double radius;
  final double borderWidth;

  const Avatar(
      {Key key,
      @required this.image,
      this.borderColor = Colors.grey,
      this.backgroundColor,
      this.radius = 30,
      this.borderWidth = 5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius + borderWidth,
      backgroundColor: borderColor,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor != null
            ? backgroundColor
            : Theme.of(context).primaryColor,
        child: CircleAvatar(
          radius: radius - borderWidth,
          backgroundImage: image,
        ),
      ),
    );
  }
}
//end stl support info page

//start stf support navigationbar
class FancyBottomNavigation extends StatefulWidget {
  final int currentIndex;
  final double iconSize;
  final Color activeColor;
  final Color inactiveColor;
  final Color backgroundColor;
  final List<FancyBottomNavigationItem> items;
  final ValueChanged<int> onItemSelected;

  FancyBottomNavigation(
      {Key key,
      this.currentIndex = 0,
      this.iconSize = 30,
      this.activeColor,
      this.inactiveColor,
      this.backgroundColor,
      @required this.items,
      @required this.onItemSelected}) {
    assert(items != null);
    assert(onItemSelected != null);
  }

  @override
  _FancyBottomNavigationState createState() {
    return _FancyBottomNavigationState(
        items: items,
        backgroundColor: backgroundColor,
        currentIndex: currentIndex,
        iconSize: iconSize,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        onItemSelected: onItemSelected);
  }
}

class _FancyBottomNavigationState extends State<FancyBottomNavigation> {
  final int currentIndex;
  final double iconSize;
  Color activeColor;
  Color inactiveColor;
  Color backgroundColor;
  List<FancyBottomNavigationItem> items;
  int _selectedIndex;
  ValueChanged<int> onItemSelected;

  _FancyBottomNavigationState(
      {@required this.items,
      this.currentIndex,
      this.activeColor,
      this.inactiveColor = Colors.blue,
      this.backgroundColor,
      this.iconSize,
      @required this.onItemSelected}) {
    _selectedIndex = currentIndex;
  }

  Widget _buildItem(FancyBottomNavigationItem item, bool isSelected) {
    return AnimatedContainer(
      width: isSelected ? 124 : 50,
      height: double.maxFinite,
      duration: Duration(milliseconds: 250),
      padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              color: activeColor,
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(0),
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: IconTheme(
                  data: IconThemeData(
                      size: iconSize,
                      color: isSelected ? backgroundColor : inactiveColor),
                  child: item.icon,
                ),
              ),
              isSelected
                  ? DefaultTextStyle.merge(
                      style: TextStyle(color: backgroundColor),
                      child: item.title,
                    )
                  : SizedBox.shrink()
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    activeColor =
        (activeColor == null) ? Theme.of(context).accentColor : activeColor;

    backgroundColor = (backgroundColor == null)
        ? Theme.of(context).bottomAppBarColor
        : backgroundColor;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      padding: EdgeInsets.only(left: 50, right: 50, top: 6, bottom: 6),
      decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2)]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items.map((item) {
          var index = items.indexOf(item);
          return GestureDetector(
            onTap: () {
              onItemSelected(index);

              setState(() {
                _selectedIndex = index;
              });
            },
            child: _buildItem(item, _selectedIndex == index),
          );
        }).toList(),
      ),
    );
  }
}

class FancyBottomNavigationItem {
  final Icon icon;
  final Text title;

  FancyBottomNavigationItem({
    @required this.icon,
    @required this.title,
  }) {
    assert(icon != null);
    assert(title != null);
  }
}
//end stf support navigationbar

class InfoPage extends StatelessWidget {
  String nameUser;
  String role;
  String email;
  String idUser;
  String userName;

  InfoPage({Key key, this.nameUser, this.role, this.email, this.idUser, this.userName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          ProfileHeader(
            avatar: ExactAssetImage("images/logo.png"),
            coverImage: ExactAssetImage("images/bg.jpg", scale: 1.0),
            title: nameUser,
            subtitle: role,
            actions: <Widget>[
              MaterialButton(
                color: Colors.white,
                shape: CircleBorder(),
                elevation: 0,
                child: Icon(Icons.edit),
                onPressed: (){},
              )
            ],
          ),
          SizedBox(height: 10,),
          UserInfo(
            email: email,
            idUser: idUser,
            userName: userName,
          ),
          DoubleButton(
            iconButton1: Icon(Icons.exit_to_app, color: Colors.white),
            titleButton1: "Logout",
            funcButton1: (){
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(height: 30,),
                                  Text("Do you wanna logout?"),
                                  SizedBox(height: 20,),
                                  FlatButton(
                                    child: Text("OK", style: TextStyle(color: Colors.white),),
                                    onPressed: ()async{
                                      SharedPreferences _share = await SharedPreferences.getInstance();
                                      await _share.clear();

                                      Navigator.pushAndRemoveUntil(
                                        context, 
                                        MaterialPageRoute(builder: (BuildContext context)=>LoginView()),
                                        (Route<dynamic> route) => false,
                                      );
                                    },
                                    color: Colors.lightGreen,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  )
                                ],
                              ),
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
            },

            iconButton2: Icon(Icons.arrow_back, color: Colors.white),
            titleButton2: "Back",
            funcButton2: (){
              Navigator.pop(context);
            },
          ),
          SizedBox(height: 20,)
        ],
      ),
    );
  }
}

class ListInfo extends StatefulWidget {
  final String username;
  final String password;

  const ListInfo({Key key, this.username, this.password}) : super(key: key);
  @override
  _ListInfoState createState() => _ListInfoState();
}

class _ListInfoState extends State<ListInfo> {
  ApiUserServices apiUserServices;
  ApiRoleServices apiRoleServices;
  String nameRoles;

  final TextStyle dropdownMenuItem =
      TextStyle(color: Colors.black, fontSize: 18);

  final primary = Color(0xff696b9e);
  final secondary = Color(0xfff29a94);

  

  @override
  void initState() {
    apiUserServices = ApiUserServices();
    apiRoleServices = ApiRoleServices();
    super.initState();
  }

  _listTrackingView(List<Users> list){
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return buildList(context, index, list);
      }, 
      itemCount: list.length
    );
  }
  buildList(BuildContext context, int index, List<Users> list) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
      ),
      width: double.infinity,
      height: 110,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 50,
            height: 50,
            // color: Colors.lightBlue,
            margin: EdgeInsets.only(right: 15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Hero(tag: list[index].avatar, child: Image.asset(list[index].avatar),),
              // child: Image.asset(list[index].avatar),
            ),
            foregroundDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(width: 3, color: secondary),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  list[index].nameUser,
                  style: TextStyle(
                      color: primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.perm_identity,
                      color: secondary,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(list[index].idUser,
                        style: TextStyle(
                            color: primary, fontSize: 13, letterSpacing: .3)),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.mail,
                      color: secondary,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(list[index].email == null ? "empty" : list[index].email,
                        style: TextStyle(
                            color: primary, fontSize: 13, letterSpacing: .3)),
                  ],
                ),
              ],
            ),
          ),
          Container(
            child: Center(
              child: IconButton(
                iconSize: 30,
                icon: Icon(Icons.info, color: primary),
                onPressed: (){
                  apiRoleServices.nameRole(list[index].role).then((value){
                    if(value!=null){
                      setState(() {
                        nameRoles=value;
                      });
                      
                    }
                  });
                  _showPopup(list[index],nameRoles);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  _showPopup(Users users, String roleName){
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
                  height: 600,
                  width: MediaQuery.of(context).orientation==Orientation.portrait ? (MediaQuery.of(context).size.width - 50) : (MediaQuery.of(context).size.width - 150) ,
                  child: ListView(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(flex:1,child: SizedBox(width: 30,)),
                          Expanded(
                            flex: 1,
                            child: Container(
                              width: 80,
                              height: 80,
                              child: Image.asset(users.avatar, scale: 3,),
                            ),
                          ),
                          Expanded(flex:1,child: SizedBox(width: 30,)),
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(users.nameUser),
                                SizedBox(height: 10,),
                                Text(nameRoles==null?"null": nameRoles)
                              ],
                            ),
                          )
                        ],
                      ),
                      UserInfo(
                        email: users.email,
                        idUser: users.idUser,
                        userName: users.userName,
                      ),
                      SizedBox(height: 10,),
                      IconButton(
                        icon: Icon(Icons.delete),
                        iconSize: 30,
                        color: Colors.red,
                        onPressed: (){},
                      ),
                      SizedBox(height: 20,),
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: FutureBuilder(
          future: apiUserServices.getAllUser(widget.username, widget.password),
          builder: (BuildContext context, AsyncSnapshot<List<Users>> snapshot){
            if(snapshot.hasError){
              return Center( child:  Text("Something wrong with message: ${snapshot.error.toString()}"),);
            }
            else if(snapshot.connectionState==ConnectionState.done){
              List<Users> listModel = snapshot.data;
              print(listModel.length);
              return _listTrackingView(listModel,);
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
}
