import 'package:chequeamefirestore2/core/enums/viewstate.dart';

import 'package:chequeamefirestore2/models/info.dart';

import 'package:chequeamefirestore2/services/info_service.dart';
import 'package:chequeamefirestore2/viewmodels/base_model.dart';

import '../locator.dart';

class HomeModel extends BaseModel1 {
  final InfoService _infoService = locator<InfoService>();
  String errorMessage;
  Info info;
  bool connectionFail;

  onIdle() async {
    await new Future.delayed(const Duration(seconds: 1));
    setState(ViewState.Idle);
  }

  Future<bool> getdata(String cuit) async {
    connectionFail = false;
    errorMessage = '';
    setState(ViewState.Busy);
    if (cuit.length != 11) {
      errorMessage = 'Ingrese un cuit válido';
      setState(ViewState.Idle);
      return false;
    }

    try {
      info = await _infoService.getInfo(cuit);
    } catch (e) {
      print(e);
      connectionFail = true;
      setState(ViewState.Idle);
      return false;
    }
    var success = info != null;

    if (!success) {
      errorMessage = 'El cuit ingresado no se encuentra registradoo';
      setState(ViewState.Idle);
      return false;
    }

    setState(ViewState.Idle);

    // Handle potential error here too.
    return success;
  }
}
