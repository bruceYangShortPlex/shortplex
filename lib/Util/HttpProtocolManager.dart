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
  //manager.getData();
  manager.postData();
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
    //var heads = {'apikey' : ApiKey, '' : ''};
    var heads = {'Authorization' : 'KakaoAK 7223322857794c79fd6f7467272f8f9c'};
    try
    {
      //var uri = 'https://quadra-server.web.app/docs/tag/api-routes/get/api/v1/oping';
      //var uri = 'www.google.com';
      var uri = 'https://dapi.kakao.com/v3/search/book?target=title&query=doit';

      var res = await http.get(Uri.parse(uri),headers: heads);

      print('resutl : ${res.body}');
      //print('json decode ${jsonDecode(res.body)}');
    }
    catch (e)
    {
      print('get error ${e}');
    }
  }

  postData() async
  {
    try {
      var uri = 'https://quadra-server.web.app/docs/tag/api-routes/post/api/v1/status';

      var data = {
        "id" : "ID0205",
      };
      var body = jsonEncode(data);

      var heads = {'apikey': ApiKey, 'Content-Type': 'application/json'};
      var response = await http.post(Uri.parse(uri), headers: heads, body: body);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
    catch (e)
    {
      print('post error ${e}');
    }
   // print(await http.read(Uri.https('https://quadra-server.web.app/api/v1/status', 'foobar.txt')));
  }

  sendOAuthLogin() async
  {
    var oauthLogin = OAuthLogin(email: '');

    try
    {
      var heads = {'apikey': ApiKey, "Content-Type": "application/json", 'Authorization': ''};
      var url = Uri.parse('https://quadra-server.web.app/docs/tag/api-routes/post/api/v1/account/oauth_login');
      var response = await http.post(url, headers: heads, body: oauthLogin.toJson());
      print(response);
    }
    catch (e)
    {
      print('sendOAuthLogin error : ${e}');
    }
  }
}
