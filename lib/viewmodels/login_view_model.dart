import 'package:chequeamefirestore2/constants/route_names.dart';
import 'package:chequeamefirestore2/locator.dart';
import 'package:chequeamefirestore2/services/authentication_service.dart';
import 'package:chequeamefirestore2/services/dialog_service.dart';
import 'package:chequeamefirestore2/services/navigation_service.dart';
import 'package:flutter/foundation.dart';

import 'base_model.dart';

class LoginViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future login({
    @required String email,
    @required String password,
  }) async {
    setBusy(true);

    var result = await _authenticationService.loginWithEmail(
      email: email,
      password: password,
    );

    setBusy(false);

    if (result is bool) {
      if (result) {
        _navigationService.navigateTo(HomeViewRoute);
      } else {
        await _dialogService.showDialog(
          title: 'El Inicio de Sesíon falló',
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'El Inicio de Sesíon falló',
        description: result,
      );
    }
  }

  void navigateToSignUp() {
    _navigationService.navigateTo(SignUpViewRoute);
  }
}
