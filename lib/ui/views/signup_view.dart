import 'package:chequeamefirestore2/ui/shared/ui_helpers.dart';
import 'package:chequeamefirestore2/ui/widgets/busy_button.dart';
import 'package:chequeamefirestore2/ui/widgets/expansion_list.dart';
import 'package:chequeamefirestore2/ui/widgets/input_field.dart';
import 'package:chequeamefirestore2/viewmodels/signup_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SignUpView extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fullNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      viewModelBuilder: () => SignUpViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("assets/images/bg_bottom.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Container(
                        height: 150,
                        width: 150.0,
                        child: Image.asset("assets/images/logo2.png")),
                  ),
                  verticalSpaceLarge,
                  InputField(
                    placeholder: 'Nombre Completo',
                    controller: fullNameController,
                  ),
                  verticalSpaceSmall,
                  InputField(
                    placeholder: 'Email',
                    controller: emailController,
                  ),
                  verticalSpaceSmall,
                  InputField(
                    placeholder: 'Contraseña',
                    password: true,
                    controller: passwordController,
                    additionalNote:
                        'La contraseña debe contener 6 digitos como mínimo',
                  ),
                  verticalSpaceSmall,
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BusyButton(
                        title: 'Registrarse',
                        busy: model.busy,
                        onPressed: () {
                          model.signUp(
                              email: emailController.text,
                              password: passwordController.text,
                              fullName: fullNameController.text);
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
