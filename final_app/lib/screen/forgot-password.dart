import 'package:final_app/pallete.dart';
import 'package:final_app/widget/background-image.dart';
import 'package:final_app/widget/rounded-button.dart';
import 'package:final_app/widget/text-input-field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        BackgroundImage(images: 'assets/images/tardis.jpg'),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);

              },
              icon: Icon(Icons.arrow_back_ios,color: kWhite,),),
          title: Text('Forgot Password',style: kBodyText,
          ),
            centerTitle: true,
        ),
          body: Column(children: [
            Center(
              child: Column(
                children: [
                  SizedBox(height: size.height *0.1,),
                  Container(
                    width: size.width *0.8,
                    child: Text('Enter your e-mail we send instruction to reset your password',style: kBodyText,),
                  ),
                  SizedBox(height: 20,),
                  TextInputFleid(icon: FontAwesomeIcons.envelope, hint: 'E-mail',inputType: TextInputType.emailAddress,inputAction: TextInputAction.done
                    ,),
                  SizedBox(height: 20,),
                  RoundedButton(buttonName: 'Send')
                ],
              ),
            )
          ],),
        )
      ],
    );
  }
}
