import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:baseflow_plugin_template/baseflow_plugin_template.dart';
// import 'package:example/plugin_example/download_page.dart';
// import 'package:example/plugin_example/floating_action_button.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

// void main() {
//   runApp(
//     BaseflowPluginExample(
//       pluginName: 'Flutter Cache Manager',
//       githubURL: 'https://github.com/Baseflow/flutter_cache_manager',
//       pubDevURL: 'https://pub.dev/packages/flutter_cache_manager',
//       pages: [CacheManagerPage.createPage()],
//     ),
//   );
//   CacheManager.logLevel = CacheManagerLogLevel.verbose;
// }

const url = 'https://picsum.photos/200/300';

/// Example [Widget] showing the functionalities of flutter_cache_manager
class CacheManagerPage extends StatefulWidget {
  const CacheManagerPage({super.key});

  // static ExamplePage createPage()
  // {
  //   return ExamplePage(Icons.save_alt, (context) => const CacheManagerPage());
  // }

  @override
  CacheManagerPageState createState() => CacheManagerPageState();

  //   SafeArea
  //     (
  //     child:
  //     CupertinoApp
  //       (
  //       home:
  //       CupertinoPageScaffold
  //         (
  //         backgroundColor: Colors.black,
  //         navigationBar:
  //         CupertinoNavigationBar
  //           (
  //           backgroundColor: Colors.transparent,
  //           leading:
  //           Row
  //             (
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             children:
  //             [
  //               Container
  //                 (
  //                 width: MediaQuery.of(context).size.width * 0.3,
  //                 height: 50,
  //                 //color: Colors.blue,
  //                 padding: EdgeInsets.zero,
  //                 alignment: Alignment.centerLeft,
  //                 child:
  //                 CupertinoNavigationBarBackButton
  //                   (
  //                   color: Colors.white,
  //                   onPressed: ()
  //                   {
  //                     Get.back();
  //                   },
  //                 ),
  //
  //               ),
  //               Container
  //                 (
  //                 width: MediaQuery.of(context).size.width * 0.3,
  //                 height: 50,
  //                 //color: Colors.green,
  //                 alignment: Alignment.center,
  //                 child:
  //                 Text(StringTable().Table![400052]!,
  //                   style:
  //                   TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),),
  //
  //               ),
  //               Container(width: MediaQuery.of(context).size.width * 0.3, height: 50,)
  //             ],
  //           ),
  //         ),
  //         child:
  //         Container
  //           (
  //           alignment: Alignment.topCenter,
  //           height: MediaQuery.of(context).size.height,
  //           width: MediaQuery.of(context).size.width,
  //           //color: Colors.yellow,
  //           child:
  //           Padding
  //             (
  //             padding: const EdgeInsets.only(top: 80),
  //             child:
  //             Column
  //               (
  //               children:
  //               [
  //
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
}

class CacheManagerPageState extends State<CacheManagerPage> {
  Stream<FileResponse>? fileStream;

  void _downloadFile() {
    setState(() {
      fileStream = DefaultCacheManager().getFileStream(url, withProgress: true);
    });
  }

  @override
  Widget build(BuildContext context)
  {
    return Placeholder();
    // if (fileStream == null) {
    //   return Scaffold(
    //     body: const ListTile(
    //       title: Text('Tap the floating action button to download.'),
    //     ),
    //     floatingActionButton: Fab(
    //       downloadFile: _downloadFile,
    //     ),
    //   );
    // }
    // return DownloadPage(
    //   fileStream: fileStream!,
    //   downloadFile: _downloadFile,
    //   clearCache: _clearCache,
    //   removeFile: _removeFile,
    // );
  }

  void _clearCache() {
    DefaultCacheManager().emptyCache();
    setState(() {
      fileStream = null;
    });
  }

  void _removeFile() {
    DefaultCacheManager().removeFile(url).then((value) {
      if (kDebugMode) {
        print('File removed');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error);
      }
    });
    setState(() {
      fileStream = null;
    });
  }
}

Future<int> getTemporaryDirectorySize() async
{
  Directory tempDir = await getTemporaryDirectory();
  int sizeInBytes = await _getDirectorySize(tempDir);
  return sizeInBytes;
}

Future<int> _getDirectorySize(Directory dir) async
{
  int size = 0;
  await for (FileSystemEntity entity in dir.list(recursive: true)) {
    if (entity is File) {
      size += await entity.length();
    }
  }
  return size;
}

// Widget mainWidget(BuildContext context)=>
//     SafeArea
//       (
//       child:
//       CupertinoApp
//         (
//         home:
//         CupertinoPageScaffold
//           (
//           backgroundColor: Colors.black,
//           navigationBar:
//           CupertinoNavigationBar
//           (
//             backgroundColor: Colors.transparent,
//             leading:
//             Row
//               (
//               mainAxisAlignment: MainAxisAlignment.start,
//               children:
//               [
//                 Container
//                   (
//                   width: MediaQuery.of(context).size.width * 0.3,
//                   height: 50,
//                   //color: Colors.blue,
//                   padding: EdgeInsets.zero,
//                   alignment: Alignment.centerLeft,
//                   child:
//                   CupertinoNavigationBarBackButton
//                     (
//                     color: Colors.white,
//                     onPressed: ()
//                     {
//                       Get.back();
//                     },
//                   ),
//                 ),
//                 Container
//                   (
//                   width: MediaQuery.of(context).size.width * 0.3,
//                   height: 50,
//                   //color: Colors.green,
//                   alignment: Alignment.center,
//                   child:
//                   Text
//                     (
//                     StringTable().Table![400021]!,
//                     style:
//                     TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
//                   ),
//                 ),
//                 Container(width: MediaQuery.of(context).size.width * 0.3, height: 50,)
//               ],
//             ),
//           ),
//           child:
//           Container
//             (
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height,
//             //color: Colors.blue,
//
//           ),
//         ),
//       ),
//     );


//List<bool> _selections = List.generate(3, (_) => false);
// ToggleButtons
// (
// children: <Widget>
// [
// Icon(Icons.add_comment),
// Icon(Icons.airline_seat_individual_suite),
// Icon(Icons.add_location),
// ],
// isSelected: _selections,
// onPressed: (int index)
// {
// setState(() {
// _selections[index] = !_selections[index];
// });
// },
// )

// void main() async
// {
//   WidgetsFlutterBinding.ensureInitialized();
//   await StringTable().InitTable();
//   runApp( FeaturedPage());
// }
