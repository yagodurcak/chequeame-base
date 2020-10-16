import 'package:chequeamefirestore2/constants/route_names.dart';
import 'package:chequeamefirestore2/core/enums/viewstate.dart';
import 'package:chequeamefirestore2/locator.dart';
import 'package:chequeamefirestore2/services/firestore_service.dart';
import 'package:chequeamefirestore2/services/navigation_service.dart';
import 'package:chequeamefirestore2/ui/shared/app_colors.dart';
import 'package:chequeamefirestore2/ui/shared/ui_helpers.dart';
import 'package:chequeamefirestore2/ui/views/login_view.dart';
import 'package:chequeamefirestore2/ui/views/more_credits.dart';
import 'package:chequeamefirestore2/ui/views/post_view.dart';
import 'package:chequeamefirestore2/ui/views/signup_view.dart';
import 'package:chequeamefirestore2/ui/widgets/home_header.dart';
import 'package:chequeamefirestore2/viewmodels/home_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'base_view.dart';

final TextEditingController _inputCuit = TextEditingController();

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirestoreService _authstore = FirestoreService.instance;
final NavigationService _navigationService = locator<NavigationService>();

Stream<QuerySnapshot> firebaseStream;

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BaseView<HomeModel>(
        builder: (context, model, child) => Scaffold(
              body: Stack(children: [
                Container(
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: new AssetImage("assets/images/fondo1.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Scaffold(
                    appBar: AppBar(
                      automaticallyImplyLeading: false,
                      backgroundColor: AppColors.kceleste,
                      actions: <Widget>[
                        Builder(builder: (BuildContext context) {
                          return SafeArea(
                            child: FlatButton(
                              child: const Text(
                                'Cerrar Sesión',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              textColor: Theme.of(context).buttonColor,
                              onPressed: () async {
                                final FirebaseUser user =
                                    await _auth.currentUser();
                                if (user == null) {
                                  Scaffold.of(context)
                                      .showSnackBar(const SnackBar(
                                    content:
                                        Text('No posee una sesión abierta.'),
                                  ));
                                  return;
                                }
                                await _auth.signOut();
                                final String uid = user.email;
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text(uid +
                                      ' Se cerro su sesión correctamente'),
                                ));
                                return _navigationService
                                    .navigateTo(LoginViewRoute);
                              },
                            ),
                          );
                        })
                      ],
                    ),
                    backgroundColor: Colors.transparent,
                    body: new SingleChildScrollView(
                        child: new Form(
                            child: new Column(
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.50),
                          HomeHeader(
                            validationMessage: model.errorMessage,
                            cuitController: _inputCuit,
                          ),
                          UIHelper.verticalSpaceMedium(),
                          model.state == ViewState.Busy
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                      CircularProgressIndicator(),
                                      UIHelper.verticalSpaceMedium(),
                                    ])
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    FutureBuilder(
                                      future: getUserInfo2(),
                                      builder: (context,
                                          AsyncSnapshot<DocumentSnapshot>
                                              snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          if (snapshot.data.data["queries"] !=
                                              -1)
                                            return Container();
                                          else
                                            _auth.signOut();
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MoreCredits()),
                                          );
                                        } else if (snapshot.connectionState ==
                                            ConnectionState.none) {
                                          return Text("No data");
                                        }
                                        return CircularProgressIndicator();
                                      },
                                    ),
                                    Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 50.0, vertical: 0),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.07,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.75,
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 2.0,
                                                color: Colors.black
                                                    .withOpacity(.5),
                                                offset: Offset(0, 1.0),
                                              ),
                                            ],
                                            color: AppColors.kceleste,
                                            borderRadius:
                                                BorderRadius.circular(8.0)),
                                        child: FlatButton(
                                          color: Colors.transparent,
                                          child: Text(
                                            'Procesar',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () async {
                                            var firebaseUser =
                                                await FirebaseAuth.instance
                                                    .currentUser();
                                            DocumentReference queri = Firestore
                                                .instance
                                                .collection("users")
                                                .document(firebaseUser.uid);
                                            var loginSuccess = await model
                                                .getdata(_inputCuit.text);
                                            if (loginSuccess) {
                                              queri.updateData({
                                                "queries":
                                                    FieldValue.increment(-1)
                                              });
                                              Navigator.pushNamed(
                                                  context, 'post',
                                                  arguments: model.info);
                                            } else {
                                              if (model.connectionFail) {
                                                void _showDialog() {
                                                  // flutter defined function
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      // return object of type Dialog
                                                      return AlertDialog(
                                                        title: new Text(
                                                            "Error de conexión"),
                                                        content: new Text(
                                                            "Verifique su conexión a internet"),
                                                        actions: <Widget>[
                                                          // usually buttons at the bottom of the dialog
                                                          new FlatButton(
                                                            child: new Text(
                                                                "Aceptar"),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                }

                                                _showDialog();
                                              }
                                            }
                                          },
                                        )),
                                    FutureBuilder(
                                      future: getUserInfo2(),
                                      builder: (context,
                                          AsyncSnapshot<DocumentSnapshot>
                                              snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          if (snapshot.data.data["queries"] >=
                                              10)
                                            return ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: 1,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return ListTile(
                                                    title: Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 70.0,
                                                              vertical: 0),
                                                      child: Text(
                                                          "Dispone de " +
                                                              snapshot
                                                                  .data
                                                                  .data[
                                                                      "queries"]
                                                                  .toString() +
                                                              " informes restantes",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.blue),
                                                          textAlign:
                                                              TextAlign.center),
                                                    ),
                                                  );
                                                });
                                          else
                                            return ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: 1,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return ListTile(
                                                    title: Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 70.0,
                                                              vertical: 0),
                                                      child: Text(
                                                          "Dispone de " +
                                                              snapshot
                                                                  .data
                                                                  .data[
                                                                      "queries"]
                                                                  .toString() +
                                                              " informes restantes. Por favor solicite más cantidad de informes al 358-510 88 88  o a mauriciodurcak@chequeameonline.com",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.red),
                                                          textAlign:
                                                              TextAlign.center),
                                                    ),
                                                  );
                                                });
                                        } else if (snapshot.connectionState ==
                                            ConnectionState.none) {
                                          return Text("No data");
                                        }
                                        return CircularProgressIndicator();
                                      },
                                    ),
                                    UIHelper.verticalSpaceLarge(),

                                    //UIHelper.verticalSpaceLarge(),
                                  ],
                                )
                        ])))),
              ]),
            ));
  }

  Future<DocumentSnapshot> getUserInfo2() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();

    return await Firestore.instance
        .collection("users")
        .document(firebaseUser.uid)
        .get();
  }

  Future<void> getqueries() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();

    return Firestore.instance
        .collection("users")
        .document(firebaseUser.uid)
        .collection("queries")
        .snapshots();

// ignore: unrelated_type_equality_checks
  }
}
