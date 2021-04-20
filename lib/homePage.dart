import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:believable/login.dart';
class homePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;
  bool isLoggedin=false;

  checkAuthentication() async{
    _auth.onAuthStateChanged.listen((user) async {
      if(user!=null && (user==null)) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
      }
    });
  }

  getUser() async{
    FirebaseUser _user = await _auth.currentUser();
    await _user?.reload();
    _user=await _auth.currentUser();
    if (_user != null) {
      setState(() {
        this.user = _user;
        this.isLoggedin = true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Home'),
    );
  }
}
