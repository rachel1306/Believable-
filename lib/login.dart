import 'package:flutter/material.dart';
import 'package:believable/homePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _email=TextEditingController(), _password=TextEditingController();
  checkAuthentication() async{
  _auth.authStateChanges().listen((user) {
    if(user!=null){
      Navigator.push(context, MaterialPageRoute(builder: (context) => homePage()));
    }
  });
  }

  @override
  void initState(){
    super.initState();
    this.checkAuthentication();
  }
  login() async{
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      try{
        await _auth.signInWithEmailAndPassword(
            email: _email.text, password: _password.text);
      }
      catch(e){

      }
    }
  }
  /*showError(String errormessage){
    showDialog(context: context,
      builder: (BuildContext context){
      return AlertDialog(
        title: Text('Error'),
        actions: <widgets>[
          Flat
        ],
      );
      }
    );
  }*/
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
                    padding: EdgeInsets.only(left: 10,top: 80),
                    child:  Text('Log in to get started',style: new TextStyle(fontSize: 20),),
                  ),
                  new Padding(
                    padding: EdgeInsets.only(left: 25,top: 20),
                    child:  Text('Experience the all new App!',style: new TextStyle(fontSize: 16),),
                  ),
                ],
              ),
            ),
            Container(
              width: 360,
              height: 200,
              child: Column(
                children: [
                  Container(
                    height: 150,
                    child: Padding(
                      padding: EdgeInsets.only(left: 15,top: 100),
                      child: TextField(
                        controller: _email,
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
                    margin: EdgeInsets.only(right: 20),
                    height: 50,
                    child: Padding(
                      padding: EdgeInsets.only(left: 15,),
                      child: TextField(
                        controller: _password,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Password',
                            hintStyle: TextStyle(
                              color: Color(0xFF555555),
                            ),
                            prefixIcon: Icon(Icons.lock,color: Color(0xFF555555),),
                            suffixIcon: Icon(Icons.remove_red_eye_outlined),
                        ),
                        obscureText: true,
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
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(top: 40,right: 30),
                child: Text('Use Mobile Number',
                  style: TextStyle(
                    color: Colors.orange,
                  ),),
              ),
            ),
            SizedBox(
              height: 230,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Spacer(),
                  Divider(
                    color: Colors.black,
                  ),
                  FlatButton(
                    onPressed: login,
                    minWidth: 350,
                    color: Colors.orange,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Text('Login'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
