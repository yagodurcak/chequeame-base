import 'dart:async';

import 'package:chequeamefirestore2/locator.dart';
import 'package:chequeamefirestore2/models/info.dart';

import 'api.dart';

class InfoService {
  Api _api = locator<Api>();

  StreamController<Info> infoController = StreamController<Info>();

  Future<Info> getInfo(String cuit) async {
    var fetchedInfo = await _api.getInfo(cuit);

    return fetchedInfo;
  }
}
