import 'package:chequeamefirestore2/constants/route_names.dart';
import 'package:chequeamefirestore2/models/info.dart';
import 'package:chequeamefirestore2/ui/views/home_view.dart';
import 'package:chequeamefirestore2/ui/views/login_view.dart';
import 'package:chequeamefirestore2/ui/views/more_credits.dart';
import 'package:chequeamefirestore2/ui/views/policy_view.dart';
import 'package:chequeamefirestore2/ui/views/post_view.dart';
import 'package:chequeamefirestore2/ui/views/signup_view.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: LoginView(),
      );
    case SignUpViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: SignUpView(),
      );
    case HomeViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: HomeView(),
      );
    case PostViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: PostView(),
      );
    case PolicyViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: PolicyView(),
      );
    case MoreCreditsRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: MoreCredits(),
      );
    case 'post':
      var info = settings.arguments as Info;
      return MaterialPageRoute(builder: (_) => PostView(info: info));
    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}')),
              ));
  }
}

PageRoute _getPageRoute({String routeName, Widget viewToShow}) {
  return MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (_) => viewToShow);
}
