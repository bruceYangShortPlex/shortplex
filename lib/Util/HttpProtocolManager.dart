import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shortplex/Network/OAuthLogin.dart';
import 'package:shortplex/Network/Search_Res.dart';
import 'package:shortplex/sub/Home/SearchPage.dart';

import '../Network/OAuth_Res.dart';
import '../table/UserData.dart';

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

class HttpProtocolManager extends GetxController with GetSingleTickerProviderStateMixin
{
  static HttpProtocolManager get to => Get.find();

  static String ApiKey = 'cbj1PqcA1NKlJEzQa0BGKwJulkfBqQcb';

  static bool waiting = false;

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
      print('res OAuthLogin body ${res.body}');

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
    var uri = 'https://www.quadra-system.com/api/v1/account/user';
    var userData = UserData.to;
    if (userData.isLogin == false)
      return '';

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

  Future<bool> send_Logout() async
  {
    try
    {
      var heads = {'apikey':ApiKey, 'Authorization': 'Bearer ${UserData.to.id}','Content-Type':'application/json'};
      var url = Uri.parse('https://www.quadra-system.com/api/v1/account/logout');

      var logout =  Logout(email: UserData.to.email, password: '', username: UserData.to.name.value);

      var bodys = jsonEncode(logout.toJson());
      print('send Logout heads : ${heads} / bodys : ${bodys}');
      var res = await http.post(url, headers: heads, body: bodys);
      print('res.body ${res.body}');

      if (res.statusCode == 200)
      {
        //var data =  Logout.fromJson(jsonDecode(res.body));
        print('LOGOUT SUCCESS ~');
        return true;
      }
      else
      {
        print('LOGOUT FAILD : ${res.statusCode}');
      }
    }
    catch (e)
    {
      print('send logout error : ${e}');
    }

    return false;
  }

  Future<SearchRes?> send_Search(int _page, int _perPage) async
  {
    try
    {
      //'Authorization': 'Bearer ${UserData.to.id}',
      var heads = {'apikey':ApiKey, 'Content-Type':'application/json'};
      var url = Uri.parse('https://www.quadra-system.com/api/v1/vod/all?page=$_page&itemsPerPage=$_perPage');
      var res = await http.get(url, headers: heads);

      // print('url = $url');
      // print('heads = $heads');
      // print('res.body = ${res.body}');

      if (res.statusCode == 200)
      {
        var data =  SearchRes.fromJson(jsonDecode(res.body));
        return data;
      }
      else
      {
        print('Search FAILD : ${res.statusCode}');
      }
    }
    catch (e)
    {
      print('send Search error : ${e}');
    }

    return null;
  }
}
