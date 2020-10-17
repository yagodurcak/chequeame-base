import 'dart:ui';

import 'package:chequeamefirestore2/ui/shared/ui_helpers.dart';
import 'package:chequeamefirestore2/viewmodels/startup_view_model.dart';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class StartUpView extends StatelessWidget {
  const StartUpView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartUpViewModel>.reactive(
      viewModelBuilder: () => StartUpViewModel(),
      onModelReady: (model) => model.handleStartUpLogic(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage('assets/images/bg_bottom.png'),
                fit: BoxFit.cover),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                    margin: EdgeInsets.symmetric(horizontal: 70.0, vertical: 0),
                    child: Image(image: AssetImage('assets/images/logo.png'))),
                UIHelper.verticalSpaceLarge(),
                new Container(child: CircularProgressIndicator()),
              ]),
        ),
      ),
    );
  }
}
