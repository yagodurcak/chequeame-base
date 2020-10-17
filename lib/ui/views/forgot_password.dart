//import 'package:chequeame/constantes.dart';
//import 'package:chequeame/src/pages/chequeame.dart';

import 'package:chequeamefirestore2/constants/route_names.dart';
import 'package:chequeamefirestore2/services/navigation_service.dart';
import 'package:chequeamefirestore2/ui/shared/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../../locator.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final NavigationService _navigationService = locator<NavigationService>();

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(children: <Widget>[
        Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/images/bg_bottom.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          color: Colors.transparent,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  height: 200,
                  width: 200.0,
                  child: Image.asset("assets/images/logo2.png")),
              SizedBox(
                height: 20,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(labelText: "Email"),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Por favor ingresar el texto';
                          }
                          return null;
                        },
                      ),
                    ],
                  )),
              Text(
                "Luego de esciribir su mail, verifique su casilla de correo",
                style: TextStyle(color: Colors.blue),
              ),
            ],
          ),
        ),
      ]),
      floatingActionButton: Container(
        height: 100,
        width: 70,
        child: FloatingActionButton(
          backgroundColor: AppColors.kceleste,
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              _auth.sendPasswordResetEmail(email: _emailController.text).then(
                  (value) => _navigationService.navigateTo(LoginViewRoute));
            }
          },
          child: Icon(
            Icons.send,
            size: 30,
          ),
        ),
      ),
    );
  }

  @override //para eliminar los datos una vez cerrada la app asi no lo roban
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
