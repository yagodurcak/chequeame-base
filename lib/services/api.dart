//import 'dart:convert';

//import 'package:chequeame/core/models/comment.dart';
//import 'package:chequeame/core/models/info.dart';
//import 'package:chequeame/core/models/post.dart';
import 'dart:convert';

import 'package:chequeamefirestore2/models/info.dart';

import 'package:http/http.dart' as http;
//import 'package:device_id/device_id.dart';

/// The service responsible for networking requests
class Api {
  static const endpoint = 'https://www.chequeame.app';

  var client = new http.Client();

  Future<Info> getInfo(String cuit) async {
    Map<String, String> headers = {"Content-type": "application/json"};
    String body = '{"cuit":"$cuit"}';

    var response =
        await client.post('$endpoint/v1/score', headers: headers, body: body);

    if (response.statusCode != 200) {
      return null;
    }

    // Convert and return
    return Info.fromJson(json.decode(response.body));
  }
}
