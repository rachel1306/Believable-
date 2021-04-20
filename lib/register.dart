import 'package:flutter/material.dart';
import 'package:believable/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:believable/homePage.dart';
class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _name, _password, _confirmpass, _mobile;

  checkAuthentication() async{
    _auth.onAuthStateChanged.listen((user) async {
    if(user!=null && (_password==_confirmpass)) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => homePage()));
    }
    });
  }
  register() async{
    if(_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        FirebaseUser user = await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password);
        if (user != null) {
           UserUpdateInfo updateuser = UserUpdateInfo();
           updateuser.displayName = _name;
            user.updateProfile(updateuser);
          // await Navigator.pushReplacementNamed(context,"/") ;

        }
      }
      catch (e) {
        showError(e.message);
        print(e);
      }
    }
  }
  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text(errormessage),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }
  @override
  void initState(){
    super.initState();
    this.checkAuthentication();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                new Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      new Padding(
                        padding: EdgeInsets.only(left: 20,top: 80),
                        child:  Text('Register in to get started',style: new TextStyle(fontSize: 20),),
                      ),
                      new Padding(
                        padding: EdgeInsets.only(left: 3,top: 20),
                        child:  Text('Experience the all new App!',style: new TextStyle(fontSize: 16),),
                      ),
                    ],
                  ),
                ),

                Container(
                  width: 360,
                  height: 450,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Container(
                          height: 40,
                          child: Padding(
                            padding: EdgeInsets.only(left: 15),
                              child: TextField(
                                decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Name',
                                hintStyle: TextStyle(
                                  color: Color(0xFF555555),
                                ),
                                prefixIcon: Icon(Icons.person_outline,color: Color(0xFF555555),)
                            ),
                          ),
                        ),
                    ),
                      ),
                    Expanded(child: Divider(
                      height: 1,
                      color: Colors.black,
                      indent: 20,
                      endIndent: 20,)),
                    Container(
                      height: 30,
                      child: Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: TextField(
                          decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'E-mail ID',
                          hintStyle: TextStyle(
                          color: Color(0xFF555555),
                          ),
                          prefixIcon: Icon(Icons.email_outlined,color: Color(0xFF555555),)
                        ),
                      ),
                    ),
                  ),
                    Expanded(child: Divider(
                      color: Colors.black,
                      indent: 20,
                      endIndent: 20,)),
                    Container(
                  //margin: EdgeInsets.fromLTRB(13, 13, 13, 7),
                  //width: 342,
                      height: 30,
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,),
                          child: TextField(
                            decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Mobile Number',
                            hintStyle: TextStyle(
                            color: Color(0xFF555555),
                          ),
                          prefixIcon: Icon(Icons.phone,color: Color(0xFF555555),)
                          ),
                        ),
                      ),
                    ),
                    Expanded(child: Divider(
                color: Colors.black,
                indent: 20,
                endIndent: 20,)),
                    Container(
                      margin: EdgeInsets.only(right: 20),
                      height: 30,
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,),
                        child: TextField(
                          decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                          hintStyle: TextStyle(
                          color: Color(0xFF555555),
                          ),
                              prefixIcon: Icon(Icons.lock,color: Color(0xFF555555),),
                          suffixIcon: Icon(Icons.remove_red_eye_outlined)
                        ),
                      ),
                    ),
                  ),
                    Expanded(child: Divider(
                      color: Colors.black,
                      indent: 20,
                      endIndent: 20,)),
                    Container(
                      margin: EdgeInsets.only(right: 20),
                      height: 30,
                      child: Padding(
                        padding: EdgeInsets.only(left: 15),
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Confirm Password',
                                hintStyle: TextStyle(
                                  color: Color(0xFF555555),
                                ),
                                prefixIcon: Icon(Icons.lock,color: Color(0xFF555555),),
                                suffixIcon: Icon(Icons.remove_red_eye_outlined)
                            ),
                          ),
                      ),
                    ),
                    Expanded(child: Divider(
                      color: Colors.black,
                      indent: 20,
                      endIndent: 20,)),
                    ],
                  ),
                ),

                ButtonTheme(
                  minWidth: 300,
                  height: 50,
                  child: RaisedButton(
                    color: Colors.orange,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    onPressed: register,
                    child: Text('REGISTER',style: TextStyle(color: Colors.white),),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account?',
                          style: TextStyle(
                            fontSize: 15,
                          ),),
                        new GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Login()));
                            },
                          child: new Text("  Login",style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15),),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
  }
}
