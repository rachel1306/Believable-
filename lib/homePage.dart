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
    User _user = _auth.currentUser;
    await _user?.reload();
    _user = _auth.currentUser;
    if (_user != null) {
      setState(() {
        this.user = _user;
        this.isLoggedin = true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Image(
                    image: new AssetImage('assets/71IHR8nsZhL._UX679_.jpg'),
                    fit: BoxFit.cover,
                    height: 200,
                    width: 200,
                    alignment: Alignment.center,
                    colorBlendMode: BlendMode.darken
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      child: Column(
                        children: [
                          ButtonTheme(
                            minWidth: 50,
                            child: RaisedButton(
                                onPressed: null,
                                shape: CircleBorder(),
                                elevation: 5,
                                disabledColor: Colors.white54,
                                child: Icon(Icons.favorite,size: 50,)
                            ),
                          ),
                          ButtonTheme(
                            minWidth: 50,
                            child: RaisedButton(
                                elevation: 2,
                                onPressed: null,
                                shape: CircleBorder(),
                                child: Icon(Icons.share,size: 50,)
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]
            ),
            Row(
              children: [
                RaisedButton(
                  onPressed: null,
                  child: Text('ADD TO CART'),
                ),
                RaisedButton(
                  onPressed: null,
                  child: null,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
