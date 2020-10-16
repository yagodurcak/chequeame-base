import 'package:chequeamefirestore2/ui/shared/app_colors.dart';
import 'package:chequeamefirestore2/ui/shared/ui_helpers.dart';
import 'package:chequeamefirestore2/ui/views/forgot_password.dart';
import 'package:chequeamefirestore2/ui/widgets/busy_button.dart';
import 'package:chequeamefirestore2/ui/widgets/input_field.dart';
import 'package:chequeamefirestore2/ui/widgets/text_link.dart';
import 'package:chequeamefirestore2/viewmodels/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("assets/images/bg_bottom.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 150,
                    child: Image.asset('assets/images/letrasylogo.png'),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  InputField(
                    textInputType: TextInputType.emailAddress,
                    placeholder: 'Email',
                    controller: emailController,
                  ),
                  verticalSpaceSmall,
                  InputField(
                    placeholder: 'Password',
                    password: true,
                    controller: passwordController,
                  ),
                  verticalSpaceMedium,
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BusyButton(
                        title: 'Login',
                        busy: model.busy,
                        onPressed: () {
                          model.login(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                        },
                      )
                    ],
                  ),
                  verticalSpaceMedium,
                  TextLink(
                    'Presiona aquí \ para registrarte.',
                    onPressed: () {
                      model.navigateToSignUp();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        persistentFooterButtons: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ForgotPassword()),
                    );
                  },
                  child: Text(
                    "Olvide mi contraseña",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
