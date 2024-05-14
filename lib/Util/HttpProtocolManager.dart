import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shortplex/Network/OAuthLogin.dart';
import 'package:shortplex/sub/UserInfoPage.dart';

import '../Network/OAuth_Res.dart';

// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
//
// void main() async
// {
//   WidgetsFlutterBinding.ensureInitialized();
//   Get.put(HttpProtocolManager());
//   var manager = Get.find<HttpProtocolManager>();
//   manager.getData();
//   manager.postData();
//   manager.sendOAuthLogin(OAuthLogin(email: 'email', displayname: 'displayname', providerid: 'providerid', provideruserid: 'provideruserid', privacypolicies: 'privacypolicies', photourl: 'photourl'));
//   runApp(const HttpTest());
// }
//
// class HttpTest extends StatelessWidget {
//   const HttpTest({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context)
//   {
//     return Placeholder();
//   }
// }

class HttpProtocolManager
{
  static String ApiKey = 'cbj1PqcA1NKlJEzQa0BGKwJulkfBqQcb';

  getData() async
  {
    //var heads = {'apikey' : ApiKey};
    //var heads = {'Authorization' : 'KakaoAK 7223322857794c79fd6f7467272f8f9c'};
    try
    {
      var uri = 'https://quadra-server.web.app/api/v1/oping';
      //var uri = 'www.google.com';
      //var uri = 'https://dapi.kakao.com/v3/search/book?target=title&query=doit';

      var res = await http.get(Uri.parse(uri));
      print('resutl : ${res.body}');
    }
    catch (e)
    {
      print('get error ${e}');
    }
  }

  postData() async
  {
    try
    {
      var uri = 'https://quadra-server.web.app/api/v1/status';
      var heads = {'apikey':ApiKey, 'Content-Type':'application/json'};
      var response = await http.post(Uri.parse(uri), headers: heads, body: null);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
    catch (e)
    {
      print('post error ${e}');
    }
   // print(await http.read(Uri.https('https://quadra-server.web.app/api/v1/status', 'foobar.txt')));
  }

  Future<OAuthRes?> send_OAuthLogin(OAuthLogin _oauthLogin) async
  {
    try
    {
      var heads = {'apikey':ApiKey, 'Content-Type':'application/json'};
      var url = Uri.parse('https://quadra-server.web.app/api/v1/account/oauth_login');
      var bodys = jsonEncode(_oauthLogin.toJson());
      print('send bodys : ${bodys}');
      var res = await http.post(url, headers: heads, body: bodys);
      print('res.body ${res.body}');

      if (res.statusCode == 200)
      {
        var data =  OAuthRes.fromJson(jsonDecode(res.body));
        return data;
      }
    }
    catch (e)
    {
      print('sendOAuthLogin error : ${e}');
    }

    return null;
  }

  Future<String> send_GetUserData() async
  {
    var uri = 'https://quadra-server.web.app/api/v1/account/user';
    var userData = Get.find<UserData>();
    var heads = {'apikey':ApiKey, 'Authorization': 'Bearer ${userData.id}','Content-Type':'application/json'};
    try
    {
      var res = await http.get(Uri.parse(uri), headers: heads);
      print('send_GetUserData resutl : ${res.body} / res.statusCode : ${res.statusCode}');
      return res.body;
    }
    catch (e)
    {
      print('send_GetUserData error ${e}');
    }

    return '';
  }
}
