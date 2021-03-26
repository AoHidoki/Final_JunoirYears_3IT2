import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    Key key,
    @required this.images,
  }) : super(key: key);

  final String images;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) => LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.center,
        colors: [Colors.white12,Colors.transparent],
      ).createShader(rect),
      blendMode: BlendMode.colorDodge,
      child: Container(
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage(images),
          fit: BoxFit.cover,colorFilter: ColorFilter.mode(Colors.black87, BlendMode.darken),
        )),
      ),
    );
  }
}