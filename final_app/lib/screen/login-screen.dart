import 'package:final_app/pallete.dart';
import 'package:final_app/screen/screens.dart';
import 'package:final_app/widget/widget.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState()
  ;
}


class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  IconData icon;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        BackgroundImage(images: 'assets/images/tardis.jpg',),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Flexible(
                child: Center(
                  child: Text
                  ('Identify yourself',style: TextStyle(color: Colors.white,fontSize: 60,fontWeight: FontWeight.bold),),
                ),
              ),

              Form(
                key: _formKey,
                child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Container(height: size.height * 0.08,
                          width: size.width * 0.8,
                          decoration: BoxDecoration(color: Colors.grey[500].withOpacity(0.5),
                            borderRadius: BorderRadius.circular(16),),
                          child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              labelText: "Enter Email Address",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter Email Address';
                              }
                              else if (!value.contains('@')) {
                                return 'Please enter a valid email address!';
                              }
                              return null;
                              },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Container(height: size.height * 0.08,
                          width: size.width * 0.8,
                          decoration: BoxDecoration(color: Colors.grey[500].withOpacity(0.5),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: TextFormField(
                              obscureText: true,
                              controller: passwordController,
                              decoration: InputDecoration(
                                labelText: "Enter Password",
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Enter Password';
                                }
                                else if (value.length < 6) {
                                  return 'Password must be atleast 6 characters!';
                                }
                                return null;
                                },
                            ),
                          ),
                        ),
                      ),
                      GestureDetector
                        (
                          onTap: ()=> Navigator.pushNamed(context, 'ForgotPassword'),
                          child: Text
                            (
                            'Forgot Password', style: kBodyText,)
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      GestureDetector(
                        onTap: () =>Navigator.pushNamed(context, 'Home'),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.lightBlue,),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              logInToFb();
                            }
                            },
                          child: Text('Login'),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                    ]
                ),
              ),
              GestureDetector(
                onTap: () =>Navigator.pushNamed(context, 'CreateNewAccount'),
                child: Container(
                  child: Text('Create New Account',style: kBodyText,),
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1,color: kWhite))),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          )
        )
      ]
    );
  }


void logInToFb() {
  FirebaseAuth.instance
      .signInWithEmailAndPassword(
      email: emailController.text, password: passwordController.text)
      .then((result) {
    isLoading = false;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Home(uid: result.user.uid)),
    );
  }).catchError((err) {
    print(err.message);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(err.message),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  });
}
}
