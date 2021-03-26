import 'dart:ui';
import 'package:final_app/pallete.dart';
import 'package:final_app/screen/screens.dart';
import 'package:final_app/widget/background-image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateNewAccount extends StatefulWidget {
  @override
  _CreateNewAccountState createState() => _CreateNewAccountState();
}

class _CreateNewAccountState extends State<CreateNewAccount> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  DatabaseReference dbRef = FirebaseDatabase.instance.reference().child("Users");
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController comfirmpassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Stack(
      children: [
        BackgroundImage(images: 'assets/images/tardis.jpg'),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: size.width * 0.1,),
                Stack(
                  children: [
                    Center(
                      child: ClipOval(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                          child: CircleAvatar(
                            radius: size.width * 0.15,
                            backgroundColor: Colors.blueGrey[400].withOpacity(
                                0.4),
                            child: Icon(FontAwesomeIcons.user,
                              color: kWhite,
                              size: size.width * 0.1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: size.height * 0.8,
                      left: size.height * 0.56,
                      child: Container(
                        height: size.height * 0.1,
                        width: size.width * 0.1,
                        decoration: BoxDecoration(
                          color: kBlue,
                          shape: BoxShape.circle,
                          border: Border.all(color: kWhite, width: 2),
                        ),
                        child: Icon(FontAwesomeIcons.arrowUp,
                          color: kWhite,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: size.width * 0.1,),
                Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Container(height: size.height * 0.08,
                          width: size.width * 0.8,
                          decoration: BoxDecoration(color: Colors.grey[500].withOpacity(0.5),
                          borderRadius: BorderRadius.circular(16),
                          ),
                          child: TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                              labelText: "Enter User Name",
                              enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                              // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter User Name';
                          }
                          return null;
                          },
                          ),
                        ),
                      ),
                      SizedBox(height: 25,),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Container(height: size.height * 0.08,
                            width: size.width * 0.8,
                            decoration: BoxDecoration(color: Colors.grey[500].withOpacity(0.5),
                            borderRadius: BorderRadius.circular(16),
                            ),
                            child: TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                labelText: "Enter Email",
                                enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),),
                              ),
                              // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter an Email Address';
                              }
                              else if (!value.contains('@')) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                              },),
                          ),
                        ),
                      SizedBox(height: 25,),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Container(height: size.height * 0.08,
                          width: size.width * 0.8,
                          decoration: BoxDecoration(color: Colors.grey[500].withOpacity(0.5),
                            borderRadius: BorderRadius.circular(16),),
                          child: TextFormField(
                            obscureText: true,
                            controller: passwordController,
                            decoration: InputDecoration(
                              labelText: "Enter Password",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),),
                            ),
                          // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter Password';
                              }
                              else if (value.length < 6) {
                                return 'Password must be atleast 6 characters!';
                              }
                              return null;
                              },),
                        ),
                      ),
                      SizedBox(height: 25,),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Container(height: size.height * 0.08,
                          width: size.width * 0.8,
                          decoration: BoxDecoration(color: Colors.grey[500].withOpacity(0.5),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: TextFormField(
                            obscureText: true,
                            controller: comfirmpassController,
                            decoration: InputDecoration(
                              labelText: "Confirm Password",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter Password';
                              }
                              else if (value.length < 6) {
                                return 'Password must be atleast 6 characters!';
                              }
                              else if (value !=passwordController.text) {
                                return 'Password not match!';
                              }
                              return null;
                              },),
                        ),
                      ),
                      SizedBox(height: 25,),
                      GestureDetector(
                        onTap: () =>Navigator.pushNamed(context, 'Home'),
                        child: ElevatedButton(
                          child: Text('Register'),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                isLoading =! true;
                              });
                              registerToFb();
                              Navigator.push(context, MaterialPageRoute(builder: (context) {return Home();}));
                              }
                            },
                          style: ElevatedButton.styleFrom(primary: Colors.lightBlue,),
                        ),
                      ),
                      SizedBox(height: 30,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          Text('Already have an account?', style: kBodyText,),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/');
                            },
                            child: Text
                              ('Login', style: kBodyText.copyWith(color: kBlue,
                                fontWeight: FontWeight.bold),)
                        ),
                      ],
                    ),
                      SizedBox(
                      height: 20,
                      ),
                    ]
                    )
                  )
                )
              ]
            )
          )
        )
      ]
    );
  }


  void registerToFb() {
    firebaseAuth
        .createUserWithEmailAndPassword(
        email: emailController.text, password: passwordController.text)
        .then((result) {
      dbRef.child(result.user.uid).set({
        "email": emailController.text,
        "name": nameController.text
      }).then((res) {
        isLoading = false;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home(uid: result.user.uid)),
        );
      });
    }).catchError((err) {
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
  
  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    comfirmpassController.dispose();
  }
}

