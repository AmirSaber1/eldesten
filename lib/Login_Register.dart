import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eldesten/Home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

//import 'package:http/http.dart' as http;
import 'package:http/http.dart' as http;
import 'package:eldesten/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login_Register extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login_Register>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  int index = 0;
  var _email = TextEditingController();
  var _password = TextEditingController();
  var _name = TextEditingController();
  var _emailr = TextEditingController();
  var _phone = TextEditingController();
  var _passwordr = TextEditingController();
  static Firestore fireStore = Firestore.instance;

//  var _emailController = TextEditingController();
//  var _PasswordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Image.asset(
                        "assets/logo.png",
                        width: 100,
                        height: 100,
                      ),
                    ),
                    Container(margin: EdgeInsets.only(top: 40),
                      child: Text("Eldesten",style: TextStyle(fontSize: 20),),)
                  ],
                ),
              ),
              SizedBox(height: 20,)
              ,Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: DefaultTabController(
                  length: 2,
                  initialIndex: index,
                  child: Column(
                    children: <Widget>[
                      TabBar(
                        tabs: <Widget>[
                          Tab(
                            child: Text(
                              "Sign in",
                              style:
                                  TextStyle(fontSize: 25, color: Colors.black),
                            ),
                          ),
                          Tab(
                            child: Text(
                              "Sign Up",
                              style:
                                  TextStyle(fontSize: 25, color: Colors.black),
                            ),
                          )
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: <Widget>[
                            //Log in Design
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 35),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 40),
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    child: InkWell(
                                      onTap: (){
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) => Home("test@g.g", "123456")));
                                      },
                                      child: Text(
                                        "User name",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: TextField(
                                      controller: _email,
                                      decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            // width: 0.0 produces a thin "hairline" border
                                            borderSide: const BorderSide(
                                                color: Colors.black,
                                                width: 1.5),
                                          ),
                                          contentPadding: EdgeInsets.all(17),
                                          hintText: "Email",
                                          prefixIcon: Icon(Icons.people),
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 30),
                                    child: Text(
                                      "Password",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: TextField(
                                      obscureText:true,
                                      controller: _password,
                                      decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            // width: 0.0 produces a thin "hairline" border
                                            borderSide: const BorderSide(
                                                color: Colors.black,
                                                width: 1.5),
                                          ),
                                          labelStyle: TextStyle(
                                            color: Colors.black,
                                          ),
                                          contentPadding: EdgeInsets.all(17),
                                          hintText: "Password",
                                          prefixIcon: Icon(Icons.lock_outline),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black,
                                                width: 15.0),
                                          )),
                                    ),
                                  ),
                                  Center(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        color: Colors.yellowAccent,
                                        border: Border.all(
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                5.0) //         <--- border radius here
                                            ),
                                      ),
                                      child: RaisedButton(
                                        color: Colors.orangeAccent,
                                        onPressed: () {
                                          //startLogin();
//                                          Navigator.of(context).push(
//                                              MaterialPageRoute(
//                                                  builder: (context) => Home(
//                                                      _email.text,
//                                                      _password.text)));
                                          Login();
                                        },
                                        elevation: 0,
                                        padding: EdgeInsets.symmetric(
                                          vertical: 14.0,
                                        ),
                                        child: Text(
                                          "SIGN IN",
                                          style: TextStyle(
                                              fontSize: 19,
                                              color: Colors.white),
                                        ),
                                      ),
                                      margin: EdgeInsets.only(top: 50),
                                    ),
                                  ),
                                  SizedBox(height: 40),
                                  //Row Divider
                                  Row(
                                    children: <Widget>[
                                      Container(
                                          width: 120,
                                          child: Divider(
                                            thickness: 0.7,
                                            height: 2,
                                            color: Colors.black,
                                          )),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        "OR USE",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Container(
                                          width: 120,
                                          child: Divider(
                                            thickness: 0.7,
                                            height: 2,
                                            color: Colors.black,
                                          ))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  //Row icon
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      InkWell(
                                        onTap: (){
                                          startFBLogin();
                                        },
                                        child: Center(
                                          child: Container(
                                            margin: EdgeInsets.only(left: 30),
                                            child: Icon(
                                              FontAwesomeIcons.facebook,
                                              size: 35,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),

                                    ],
                                  ),

                                ],
                              ),
                            ),

                            //Sign up Design
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 25),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[


                                    Container(
                                      margin: EdgeInsets.only(top: 40),
                                      child: Text(
                                        "Email",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      child: TextField(
                                        controller: _emailr,
                                        decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              // width: 0.0 produces a thin "hairline" border
                                              borderSide: const BorderSide(
                                                  color: Colors.black,
                                                  width: 1.5),
                                            ),
                                            contentPadding: EdgeInsets.all(17),
                                            hintText: "Email",
                                            prefixIcon: Icon(Icons.email),
                                            border: OutlineInputBorder()),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),


                                    Text(
                                      "Password",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      child: TextField(
                                        controller: _passwordr,
                                        decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              // width: 0.0 produces a thin "hairline" border
                                              borderSide: const BorderSide(
                                                  color: Colors.black,
                                                  width: 1.5),
                                            ),
                                            contentPadding: EdgeInsets.all(17),
                                            hintText: "Password",
                                            prefixIcon:
                                                Icon(Icons.lock_outline),
                                            border: OutlineInputBorder()),
                                      ),
                                    ),
                                    Center(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          color: Colors.orangeAccent,
                                          border: Border.all(
                                            color: Colors.orangeAccent,
                                            width: 1.0,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  5.0) //         <--- border radius here
                                              ),
                                        ),
                                        child: RaisedButton(
                                          color: Colors.orangeAccent,
                                          onPressed: () {
                                            Resgister();
                                          },
                                          elevation: 0,
                                          padding: EdgeInsets.symmetric(
                                            vertical: 10.0,
                                          ),
                                          child: Text(
                                            "SIGN UP",
                                            style: TextStyle(
                                                fontSize: 19,
                                                color: Colors.white),
                                          ),
                                        ),
                                        margin: EdgeInsets.only(top: 50),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 35),
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            "ALREADY HAVE AN ACCOUNT?",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text("SIGN IN",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.deepPurple))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ]),
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void Login() async {
    try {
      AuthResult result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: "${_email.text}", password: "${_password.text}");
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("userID", result.user.uid);

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Home(_email.text, _password.text)));
    } catch (e) {
      _scaffoldKey.currentState.showSnackBar(new SnackBar(
          content: new Text(e.message)));
    }
  }

  Future Resgister() async {
    try {
      AuthResult result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: "${_emailr.text}", password: "${_passwordr.text}");

      DocumentReference documentReference =
      fireStore.collection("users").document(result.user.uid);

      documentReference.setData(
        {
          'email': '${_emailr.text}',
          'userPhone': '${_passwordr.text}',
          'id':result.user.uid,


        },
      );

      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("userID", result.user.uid);

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Home(_emailr.text, _passwordr.text)));
    } catch (e) {
      print(e.message);

      _scaffoldKey.currentState.showSnackBar(new SnackBar(
          content: new Text(e.message)));
    }
  }

  void startFBLogin()async {

    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Home(_emailr.text, _passwordr.text)));
        //_sendTokenToServer(result.accessToken.token);
       // _showLoggedInUI();
        break;
      case FacebookLoginStatus.cancelledByUser:
       // _showCancelledMessage();
        break;
      case FacebookLoginStatus.error:
      //  _showErrorOnUI(result.errorMessage);
        break;
    }
  }

/* void startLogin() async {
    http.Response request = await http.post(
        "http://www.skyline-store.com/ABI/login.php",
        body: {"email": _emailController.text, "password": _PasswordController.text});
    print(request.body);
  }

  */
  void showInSnackBar(String value) {
    Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text(value)
    ));
  }
}
