import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shortplex/Network/OAuthLogin.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(HttpProtocolManager());
  var manager = Get.find<HttpProtocolManager>();
  manager.getData();
  runApp(const HttpTest());
}

class HttpTest extends StatelessWidget {
  const HttpTest({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context)
  {
    return Placeholder();
  }
}

class HttpProtocolManager
{
  static String ApiKey = 'cbj1PqcA1NKlJEzQa0BGKwJulkfBqQcb';

  getData() async
  {
    var heads = {'apikey' : ApiKey, '' : ''};
    try
    {
      var res = await http.get(
          Uri.parse('https://quadra-server.web.app/docs/tag/api-routes/get/api/v1/oping'),);
      print('resutl : ${res.body}');
      print('json decode ${jsonDecode(res.body)}');
    }
    catch (e)
    {
      print('error ${e}');
    }
  }

// POST (https://pub.dev/documentation/http/latest/)
  postData() async {
    var url = Uri.https('example.com', 'whatsit/create');
    var response = await http.post(url, body: {'name': 'doodle', 'color': 'blue'});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    print(await http.read(Uri.https('example.com', 'foobar.txt')));
  }

  var oauthLogin = OAuthLogin(email: '');

  sendOAuthLogin() async
  {
    var url = Uri.https('example.com', 'whatsit/create');
    var response = await http.post(url, body: oauthLogin.toJson());
    print(response);
  }
}
