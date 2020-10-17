import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final TextEditingController cuitController;
  final String validationMessage;

  HomeHeader({@required this.cuitController, this.validationMessage});

  @override
  Widget build(BuildContext context) {
    var assetsImage = new AssetImage('images/logo.png');
    var assetsImage2 = new AssetImage('images/logo2.png');
    var image = new Image(image: assetsImage);
    var image2 = new Image(image: assetsImage2);
    return Column(children: <Widget>[
      CuitTextField(cuitController),
      this.validationMessage != null
          ? Text(validationMessage, style: TextStyle(color: Colors.red))
          : Container()
    ]);
  }
}

class CuitTextField extends StatelessWidget {
  final TextEditingController controller;

  CuitTextField(this.controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50),
      child: TextFormField(
        decoration: InputDecoration(
            contentPadding:
                new EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            fillColor: Colors.black,
            hintText: "Ingrese el CUIT",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
        controller: controller,
        keyboardType: TextInputType.number,
      ),
    );
  }
}
