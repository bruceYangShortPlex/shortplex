import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shortplex/Network/Comment_Res.dart';
import 'package:shortplex/Network/HomeData_Res.dart';
import 'package:shortplex/Network/Home_Content_Res.dart';
import 'package:shortplex/Network/OAuthLogin.dart';
import 'package:shortplex/Network/Stat_Req.dart';
import 'package:shortplex/Network/Stat_Res.dart';

import '../Network/Comment_Req.dart';
import '../Network/Content_Res.dart';
import '../Network/EpisodeGroup_Res.dart';
import '../Network/OAuth_Res.dart';
import '../Network/Recommended_Res.dart';
import '../table/UserData.dart';

enum Stat_Type
{
  like,
  favorite,
}

enum Comment_CD_Type
{
  episode,
  title_school,
  content,
}

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

  Future<OAuthRes?> Send_OAuthLogin(OAuthLogin _oauthLogin) async
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

  Future<String> Send_GetUserData() async
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

  Future<bool> Send_Logout() async
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

  Future<HomeContentRes?> Get_SearchData(String _url) async
  {
    try
    {
      var heads = {'apikey':ApiKey,'Authorization': 'Bearer ${UserData.to.id}', 'Content-Type':'application/json'};
      var url = Uri.parse(_url);
      var res = await http.get(url, headers: heads);
      print('Get_SearchData res body : ${res.body}');
      if (res.statusCode == 200)
      {
        var data =  HomeContentRes.fromJson(jsonDecode(utf8.decode(res.bodyBytes)));
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

  Future<HomeDataRes?> Get_HomeData() async
  {
    try
    {
      var heads = {'apikey':ApiKey,'Authorization': 'Bearer ${UserData.to.id}', 'Content-Type':'application/json'};
      var url = Uri.parse('https://www.quadra-system.com/api/v1/home');
      var res = await http.get(url, headers: heads);

      // print('url = $url');
      // print('heads = $heads');
      // print('res.body = ${res.body}');

      if (res.statusCode == 200)
      {
        var data =  HomeDataRes.fromJson(jsonDecode(utf8.decode(res.bodyBytes)));
        return data;
      }
      else
      {
        print('get home data FAILD : ${res.statusCode}');
      }
    }
    catch (e)
    {
      print('get home data error : ${e}');
    }

    return null;
  }

  Future<HomeContentRes?> Get_HomeContentData(HomeDataType _type, int _page, int _itemsPerPage, [String _themesID = '']) async
  {
    try
    {
      var heads = {'apikey':ApiKey,'Authorization': 'Bearer ${UserData.to.id}', 'Content-Type':'application/json'};
      var type = _type.name;
      var url = 'https://www.quadra-system.com/api/v1/home/$type?page=$_page&itemsPerPage=$_itemsPerPage';
      if (_type == HomeDataType.themes)
      {
        url = 'https://www.quadra-system.com/api/v1/home/$type/$_themesID?page=$_page&itemsPerPage=$_itemsPerPage';
      }

      var res = await http.get(Uri.parse(url), headers: heads);

      // print('get_HomeContentData send url = $url');
      // print('heads = $heads');
      //  if (_type == HomeDataType.recent)
      //    print('res.body = ${res.body}');

      if (res.statusCode == 200)
      {
        var data =  HomeContentRes.fromJson(jsonDecode(utf8.decode(res.bodyBytes)));
        return data;
      }
      else
      {
        print('get home data FAILD : ${res.statusCode} send url = $url');
      }
    }
    catch (e)
    {
      print('get home data error : ${e}');
    }

    return null;
  }

  Future<ContentRes?> Get_ContentData(String _contentID) async
  {
    try
    {
      var heads = {'apikey':ApiKey,'Authorization': 'Bearer ${UserData.to.id}', 'Content-Type':'application/json'};
      var url = Uri.parse('https://www.quadra-system.com/api/v1/vod/content/$_contentID');
      var res = await http.get(url, headers: heads);

      // print('get_ContentData url = $url');
      // print('get_ContentData heads = $heads');
      print('get_ContentData res.body = ${res.body}');

      if (res.statusCode == 200)
      {
        var data =  ContentRes.fromJson(jsonDecode(utf8.decode(res.bodyBytes)));
        return data;
      }
      else
      {
        print('get content FAILD : ${res.statusCode}');
      }
    }
    catch (e)
    {
      print('get content data error : ${e}');
    }

    return null;
  }

  Future<EpisodeGroupRes?> Get_EpisodeGroup(String _contentID, int _page) async
  {
    try
    {
      var heads = {'apikey':ApiKey,'Authorization': 'Bearer ${UserData.to.id}', 'Content-Type':'application/json'};
      var url = Uri.parse('https://www.quadra-system.com/api/v1/vod/content/$_contentID/episode?page=$_page');
      var res = await http.get(url, headers: heads);

      // print('get_EpisodeGroup url = $url');
      // print('get_EpisodeGroup heads = $heads');
      // print('get_EpisodeGroup res.body = ${res.body}');

      if (res.statusCode == 200)
      {
        var data =  EpisodeGroupRes.fromJson(jsonDecode(utf8.decode(res.bodyBytes)));
        return data;
      }
      else
      {
        print('get_EpisodeGroup FAILD : ${res.statusCode}');
      }
    }
    catch (e)
    {
      print('get_EpisodeGroup data error : ${e}');
    }

    return null;
  }

  Future<CommentRes?> Get_Comments(String _contentID, int _page) async
  {
    try
    {
      var heads = {'apikey':ApiKey,'Authorization': 'Bearer ${UserData.to.id}', 'Content-Type':'application/json'};
      var url = Uri.parse('https://www.quadra-system.com/api/v1/vod/content/$_contentID/comments?page=$_page&itemsPerPage=20');
      var res = await http.get(url, headers: heads);

       print('get_CommentData url = $url');
      // print('get_CommentData heads = $heads');
       print('get_CommentData res.body = ${res.body}');

      if (res.statusCode == 200)
      {
        var data =  CommentRes.fromJson(jsonDecode(utf8.decode(res.bodyBytes)));
        print('get_CommentData data = ${data}');
        return data;
      }
      else
      {
        print('get_CommentData FAILD : ${res.statusCode}');
      }
    }
    catch (e)
    {
      print('get_CommentData error : ${e}');
    }

    return null;
  }

  Future<CommentRes?> Get_RepliesData(String _contentID, String _commentID, int _page) async
  {
    try
    {
      var heads = {'apikey':ApiKey,'Authorization': 'Bearer ${UserData.to.id}', 'Content-Type':'application/json'};
      var url = Uri.parse('https://www.quadra-system.com/api/v1/addition/comment/$_contentID/replies/$_commentID?page=$_page&itemsPerPage=20');
      var res = await http.get(url, headers: heads);

      print('get_CommentData url = $url');
      // print('get_CommentData heads = $heads');
      print('get_CommentData res.body = ${res.body}');

      if (res.statusCode == 200)
      {
        var data =  CommentRes.fromJson(jsonDecode(utf8.decode(res.bodyBytes)));
        print('get_CommentData data = ${data}');
        return data;
      }
      else
      {
        print('get_CommentData FAILD : ${res.statusCode}');
      }
    }
    catch (e)
    {
      print('get_CommentData error : ${e}');
    }

    return null;
  }

  Future<CommentRes?> Send_Comment(String _episodeID, String _comment, String _replyParentID, Comment_CD_Type _type) async
  {
    try
    {
      var heads = {'apikey':ApiKey, 'Authorization': 'Bearer ${UserData.to.id}','Content-Type':'application/json'};
      var url = 'https://www.quadra-system.com/api/v1/addition/comment/$_episodeID';
      var type_cd = _type.toString().replaceAll('Comment_CD_Type.', '');
      var comment =  CommentReq(content: _comment, parentId: _replyParentID, typeCd: type_cd);
      var bodys = jsonEncode(comment.toJson());
      print('send_Comment heads : ${heads} / send bodys : ${bodys}');
      var res = await http.post(Uri.parse(url), headers: heads, body: bodys);
      print('send_Comment res.body ${res.body}');

      if (res.statusCode == 200)
      {
        var data =  CommentRes.fromJson(jsonDecode(utf8.decode(res.bodyBytes)));
        print('send_Comment data = $data');
        return data;
      }
      else
      {
        //TODO:에러때 팝업 어떻게 할것인지.
        print('send_Comment FAILD : ${res.statusCode}');
      }
    }
    catch (e)
    {
      print('send_Comment error : $e');
    }

    return null;
  }

  Future<CommentRes?> Get_EpisodeComments(String _episodeID, int _page) async
  {
    try
    {
      var heads = {'apikey':ApiKey, 'Authorization': 'Bearer ${UserData.to.id}','Content-Type':'application/json'};
      var url = 'https://www.quadra-system.com/api/v1/addition/comment/$_episodeID?page=$_page&itemsPerPage=20';
      //print('send url : $url');
      var res = await http.get(Uri.parse(url), headers: heads);
      print('get_EpisodeComments res.body ${res.body}');

      if (res.statusCode == 200)
      {
        var data =  CommentRes.fromJson(jsonDecode(utf8.decode(res.bodyBytes)));
        print('get_EpisodeComments data = $data');
        return data;
      }
      else
      {
        //TODO:에러때 팝업 어떻게 할것인지.
        print('get_EpisodeComments FAILD : ${res.statusCode}');
      }
    }
    catch (e)
    {
      print('get_EpisodeComments error : $e');
    }

    return null;
  }

  Future<CommentRes?> Get_Comment(String _episodeID, String _commentID) async
  {
    try
    {
      var heads = {'apikey':ApiKey, 'Authorization': 'Bearer ${UserData.to.id}','Content-Type':'application/json'};
      var url = 'https://www.quadra-system.com/api/v1/addition/comment/$_episodeID/$_commentID';
      if (kDebugMode) {
        print('send url : $url');
      }
      var res = await http.get(Uri.parse(url), headers: heads);
      if (kDebugMode) {
        print('get_Comment res.body ${res.body}');
      }

      if (res.statusCode == 200)
      {
        var data =  CommentRes.fromJson(jsonDecode(utf8.decode(res.bodyBytes)));
        if (kDebugMode) {
          print('get_Comment data = $data');
        }
        return data;
      }
      else
      {
        //TODO:에러때 팝업 어떻게 할것인지.
        print('get_Comment FAILD : ${res.statusCode}');
      }
    }
    catch (e)
    {
      print('get_Comment error : $e');
    }

    return null;
  }

  Future<CommentRes?> Send_Reply(String _episodeID, String _comment, String _replyParentID, Comment_CD_Type _type) async
  {
    try
    {
      var heads = {'apikey':ApiKey, 'Authorization': 'Bearer ${UserData.to.id}','Content-Type':'application/json'};
      var url = 'https://www.quadra-system.com/api/v1/addition/comment/$_episodeID/replies/$_replyParentID';
      var type_cd = _type.toString().replaceAll('Comment_CD_Type.', '');
      var comment =  CommentReq(content: _comment, parentId: _replyParentID, typeCd: type_cd);
      var bodys = jsonEncode(comment.toJson());
      print('send_Reply url : ${url} / heads : ${heads} / bodys : ${bodys}');
      var res = await http.post(Uri.parse(url), headers: heads, body: bodys);
      print('send_Reply res.body ${res.body}');

      if (res.statusCode == 200)
      {
        var data =  CommentRes.fromJson(jsonDecode(utf8.decode(res.bodyBytes)));
        print('send_Reply data = $data');
        return data;
      }
      else
      {
        //TODO:에러때 팝업 어떻게 할것인지.
        print('send_Reply FAILD : ${res.statusCode}');
      }
    }
    catch (e)
    {
      print('send_Reply error : $e');
    }

    return null;
  }

  Future<CommentRes?> Get_Reply(String _episodeID, String _commentID, String _replyID) async
  {
    try
    {
      var heads = {'apikey':ApiKey, 'Authorization': 'Bearer ${UserData.to.id}','Content-Type':'application/json'};
      var url = 'https://www.quadra-system.com/api/v1/addition/comment/$_episodeID/replies/$_commentID/$_replyID';
      print('get_Reply send url : $url');
      var res = await http.get(Uri.parse(url), headers: heads);
      print('get_Reply res.body ${res.body}');

      if (res.statusCode == 200)
      {
        var data =  CommentRes.fromJson(jsonDecode(utf8.decode(res.bodyBytes)));
        print('get_Reply data = $data');
        return data;
      }
      else
      {
        //TODO:에러때 팝업 어떻게 할것인지.
        print('get_Reply FAILD : ${res.statusCode}');
      }
    }
    catch (e)
    {
      print('get_Reply error : $e');
    }

    return null;
  }

  Future<CommentRes?> Send_edit_comment(String _episodeID, String _comment, String _comment_id, Comment_CD_Type _type) async
  {
    try
    {
      var heads = {'apikey':ApiKey, 'Authorization': 'Bearer ${UserData.to.id}','Content-Type':'application/json'};
      var url = 'https://www.quadra-system.com/api/v1/addition/comment/$_episodeID/$_comment_id';
      var type_cd = _type.toString().replaceAll('Comment_CD_Type.', '');
      var comment =  CommentReq(content: _comment, parentId: null, typeCd: type_cd);
      var bodys = jsonEncode(comment.toJson());
      print('send_edit_comment url : ${url} / heads : ${heads} / bodys : ${bodys}');
      var res = await http.patch(Uri.parse(url), headers: heads, body: bodys);
      print('send_edit_comment res.body ${res.body}');

      if (res.statusCode == 200)
      {
        var data =  CommentRes.fromJson(jsonDecode(utf8.decode(res.bodyBytes)));
        print('send_edit_comment data = ${data}');
        return data;
      }
      else
      {
        //TODO:에러때 팝업 어떻게 할것인지.
        print('send_edit_comment FAILD : ${res.statusCode}');
      }
    }
    catch (e)
    {
      print('send_edit_comment error : $e');
    }

    print('send_edit_comment return null!!!');
    return null;
  }

  Future<CommentRes?> Send_edit_reply(String _episodeID, String _comment, String _commentID, String _replyID, Comment_CD_Type _type) async
  {
    try
    {
      var heads = {'apikey':ApiKey, 'Authorization': 'Bearer ${UserData.to.id}','Content-Type':'application/json'};
      var url = 'https://www.quadra-system.com/api/v1/addition/comment/$_episodeID/replies/$_commentID/$_replyID';
      var type_cd = _type.toString().replaceAll('Comment_CD_Type.', '');
      var comment =  CommentReq(content: _comment, parentId: _commentID, typeCd: type_cd);
      var bodys = jsonEncode(comment.toJson());
      print('send_edit_reply url : ${url} / heads : ${heads} / bodys : ${bodys}');
      var res = await http.patch(Uri.parse(url), headers: heads, body: bodys);
      print('send_edit_reply res.body ${res.body}');

      if (res.statusCode == 200)
      {
        var data =  CommentRes.fromJson(jsonDecode(utf8.decode(res.bodyBytes)));
        print('send_edit_reply data = ${data}');
        return data;
      }
      else
      {
        //TODO:에러때 팝업 어떻게 할것인지.
        print('send_edit_reply FAILD : ${res.statusCode}');
      }
    }
    catch (e)
    {
      print('send_edit_reply error : $e');
    }

    print('send_edit_reply return null!!!!');
    return null;
  }

  Future<CommentRes?> Send_delete_comment(String _episodeID, String _comment_id) async
  {
    try
    {
      var heads = {'apikey':ApiKey, 'Authorization': 'Bearer ${UserData.to.id}','Content-Type':'application/json'};
      var url = 'https://www.quadra-system.com/api/v1/addition/comment/$_episodeID/$_comment_id';

      print('send_delete_comment url : ${url} / heads : ${heads}');
      var res = await http.delete(Uri.parse(url), headers: heads);
      print('send_delete_comment res.body ${res.body}');

      if (res.statusCode == 200)
      {
        var data =  CommentRes.fromJson(jsonDecode(utf8.decode(res.bodyBytes)));
        print('send_edit_comment data = ${data}');
        return data;
      }
      else
      {
        //TODO:에러때 팝업 어떻게 할것인지.
        print('send_delete_comment FAILD : ${res.statusCode}');
      }
    }
    catch (e)
    {
      print('send_delete_comment error : $e');
    }

    print('send_delete_comment return null!!!');
    return null;
  }

  Future<CommentRes?> Send_delete_reply(String _episodeID, String _comment_id, String _replyID) async
  {
    try
    {
      var heads = {'apikey':ApiKey, 'Authorization': 'Bearer ${UserData.to.id}','Content-Type':'application/json'};
      var url = 'https://www.quadra-system.com/api/v1/addition/comment/$_episodeID/replies/$_comment_id/$_replyID';

      print('send_delete_comment url : ${url} / heads : ${heads}');
      var res = await http.delete(Uri.parse(url), headers: heads);
      print('send_delete_comment res.body ${res.body}');

      if (res.statusCode == 200)
      {
        var data =  CommentRes.fromJson(jsonDecode(utf8.decode(res.bodyBytes)));
        print('send_edit_comment data = ${data}');
        return data;
      }
      else
      {
        //TODO:에러때 팝업 어떻게 할것인지.
        print('send_delete_comment FAILD : ${res.statusCode}');
      }
    }
    catch (e)
    {
      print('send_delete_comment error : $e');
    }

    print('send_delete_comment return null!!!');
    return null;
  }

  Future<String> Get_streamUrl(String _fileName) async
  {
    try
    {
      var heads = {'apikey':ApiKey, 'Authorization': 'Bearer ${UserData.to.id}','Content-Type':'application/json'};
      var url = 'https://www.quadra-system.com/api/v1/vod/stream/direct/$_fileName';
      var res = await http.get(Uri.parse(url), headers: heads);
      print('get_streamUrl res.body ${res.body}');

      if (res.statusCode == 200)
      {
        var data = res.body;
        return data;
      }
      else
      {
        //TODO:에러때 팝업 어떻게 할것인지.
        print('get_streamUrl FAILD : ${res.statusCode}');
      }
    }
    catch (e)
    {
      print('get_streamUrl error : $e');
    }

    return '';
  }

  Future<StatRes?> Send_Stat(String _contentID, int _active, Stat_Type _type ) async
  {
    try
    {
      var heads = {'apikey':ApiKey, 'Authorization': 'Bearer ${UserData.to.id}','Content-Type':'application/json'};
      var url = 'https://www.quadra-system.com/api/v1/action/stat/$_contentID';
      var type_cd = Comment_CD_Type.content.name;
      var stat =  StatReq(action: _type.name, value: _active, typeCd: type_cd);
      print('stat : ${stat.value}');
      var bodys = jsonEncode(stat.toJson());
      print('send_Stat heads : ${heads} / send bodys : ${bodys}');
      var res = await http.post(Uri.parse(url), headers: heads, body: bodys);
      print('send_Stat res.body ${res.body}');

      if (res.statusCode == 200)
      {
        var data =  StatRes.fromJson(jsonDecode(utf8.decode(res.bodyBytes)));
        //print('send_Comment data = $data');
        return data;
      }
      else
      {
        //TODO:에러때 팝업 어떻게 할것인지.
        print('send_Comment FAILD : ${res.statusCode}');
      }
    }
    catch (e)
    {
      print('send_Comment error : $e');
    }

    return null;
  }

  Future<StatRes?> Get_Stat(String _parentID) async
  {
    try
    {
      var heads = {'apikey':ApiKey, 'Authorization': 'Bearer ${UserData.to.id}','Content-Type':'application/json'};
      var url = 'https://www.quadra-system.com/api/v1/action/personal/stat/$_parentID';
      print('get_Stat send url : $url');
      var res = await http.get(Uri.parse(url), headers: heads);
      print('get_Stat res.body ${res.body}');

      if (res.statusCode == 200)
      {
        var data =  StatRes.fromJson(jsonDecode(utf8.decode(res.bodyBytes)));
        print('get_Stat data = $data');
        return data;
      }
      else
      {
        //TODO:에러때 팝업 어떻게 할것인지.
        print('get_Stat FAILD : ${res.statusCode}');
      }
    }
    catch (e)
    {
      print('get_Stat error : $e');
    }

    return null;
  }

  Future<StatRes?> GetUserStat() async
  {
    if (UserData.to.isLogin.value == false) {
      return null;
    }

    try
    {
      var heads = {'apikey':ApiKey, 'Authorization': 'Bearer ${UserData.to.id}','Content-Type':'application/json'};
      var url = 'https://www.quadra-system.com/api/v1/action/personal/stat/${UserData.to.userId}';
      print('get_Stat send url : $url');
      var res = await http.get(Uri.parse(url), headers: heads);
      print('get_Stat res.body ${res.body}');

      if (res.statusCode == 200)
      {
        var data =  StatRes.fromJson(jsonDecode(utf8.decode(res.bodyBytes)));
        print('get_Stat data = $data');
        return data;
      }
      else
      {
        //TODO:에러때 팝업 어떻게 할것인지.
        print('get_Stat FAILD : ${res.statusCode}');
      }
    }
    catch (e)
    {
      print('get_Stat error : $e');
    }

    return null;
  }

  Future<RecommendedRes?> Get_Recommended() async
  {
    try
    {
      var heads = {'apikey':ApiKey, 'Authorization': 'Bearer ${UserData.to.id}','Content-Type':'application/json'};
      var url = 'https://www.quadra-system.com/api/v1/recommended';
      print('Get_Recommended send url : $url');
      var res = await http.get(Uri.parse(url), headers: heads);
      print('Get_Recommended res.body ${res.body}');

      if (res.statusCode == 200)
      {
        var data =  RecommendedRes.fromJson(jsonDecode(utf8.decode(res.bodyBytes)));
        print('get_Stat data = $data');
        return data;
      }
      else
      {
        //TODO:에러때 팝업 어떻게 할것인지.
        print('Get_Recommended FAILD : ${res.statusCode}');
      }
    }
    catch (e)
    {
      print('Get_Recommended error : $e');
    }

    return null;
  }
}
