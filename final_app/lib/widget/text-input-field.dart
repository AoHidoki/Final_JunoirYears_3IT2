import 'package:final_app/pallete.dart';
import 'package:flutter/material.dart';

class TextInputFleid extends StatelessWidget {
  const TextInputFleid({
    Key key,
    @required  this.icon,
    @required   this.hint,
    this.inputAction,
    this.inputType,
    this.onSaved,
    this.validator,
  }) : super(key: key);
  final FormFieldSetter<String> onSaved;
  final IconData icon;
  final String hint;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final FormFieldSetter<String> validator;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: size.height * 0.08,
        width: size.width * 0.8,
        decoration: BoxDecoration(color: Colors.grey[500].withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(icon,size: 28,
                  color: kWhite,),
              ),
              hintText: hint,
              hintStyle: kBodyText,
            ),
            style: kBodyText,
            keyboardType: inputType,
            textInputAction: inputAction,
          ),
        ),

      ),
    );
  }
}