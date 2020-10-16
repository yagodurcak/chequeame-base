import 'package:chequeamefirestore2/constants/route_names.dart';
import 'package:chequeamefirestore2/locator.dart';
import 'package:chequeamefirestore2/services/authentication_service.dart';
import 'package:chequeamefirestore2/services/navigation_service.dart';
import 'package:chequeamefirestore2/viewmodels/base_model.dart';

class StartUpViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future handleStartUpLogic() async {
    var hasLoggedInUser = await _authenticationService.isUserLoggedIn();

    if (hasLoggedInUser) {
      _navigationService.navigateTo(HomeViewRoute);
    } else {
      _navigationService.navigateTo(LoginViewRoute);
    }
  }
}
