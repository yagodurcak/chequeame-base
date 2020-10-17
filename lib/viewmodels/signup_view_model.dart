import 'package:chequeamefirestore2/constants/route_names.dart';
import 'package:chequeamefirestore2/locator.dart';
import 'package:chequeamefirestore2/services/authentication_service.dart';
import 'package:chequeamefirestore2/services/dialog_service.dart';
import 'package:chequeamefirestore2/services/navigation_service.dart';
import 'package:flutter/foundation.dart';

import 'base_model.dart';

class SignUpViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future signUp({
    @required String email,
    @required String password,
    @required String fullName,
  }) async {
    setBusy(true);

    var result = await _authenticationService.signUpWithEmail(
      email: email,
      password: password,
      fullName: fullName,
    );

    setBusy(false);

    if (result is bool) {
      if (result) {
        _navigationService.navigateTo(PolicyViewRoute);
      } else {
        await _dialogService.showDialog(
          title: 'Sign Up Failure',
          description: 'General sign up failure. Please try again later',
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Sign Up Failure',
        description: result,
      );
    }
  }
}
