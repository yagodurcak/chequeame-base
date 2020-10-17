import 'package:flutter/material.dart';

class MoreCredits extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/bg_bottom.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Center(
        child: Container(
            height: 150,
            width: 150.0,
            child: Image.asset("assets/images/logo2.png")),
      ),
      Center(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
        margin: EdgeInsets.only(top: 300),
        child: new Text(
            "Por favor comuniquese con su proveedor para que le habiliten mas consultas al 358-510 88 88  o a mauriciodurcak@chequeameonline.com"),
      )),
    ]));
  }
}
