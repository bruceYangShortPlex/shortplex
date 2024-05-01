import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import '../firebase_options.dart';

class FirebaseSetting
{
  FirebaseSetting._privateConstructor();

  static final FirebaseSetting _instance = FirebaseSetting._privateConstructor();

  factory FirebaseSetting()
  {
    return _instance;
  }

  Setup() async
  {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    final fcmToken = await FirebaseMessaging.instance.getToken();
    print(fcmToken);

    var messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    messaging.onTokenRefresh.listen((fcmToken1)
    {
      // TODO: If necessary send token to application server.
      print(fcmToken1);
      // Note: This callback is fired at each app startup and whenever a new
      // token is generated.
    })
        .onError((err) {
      // Error getting token.
    });

    print('User granted permission: ${settings.authorizationStatus}');

    // FirebaseMessaging.onMessage.listen((RemoteMessage message)
    // {
    //   print('Got a message whilst in the foreground!');
    //   print('Message data: ${message.data}');
    //
    //   if (message.notification != null) {
    //     print('Message also contained a notification: ${message.notification}');
    //   }
    // });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    setupInteractedMessage();
  }

  void _handleMessage(RemoteMessage message)
  {
    print("알람 이름 1: ${message.data}");
    print("알람 이름 2: ${message.senderId}");
    print("알람 이름 3: ${message.category}");
    print("알람 이름 4: ${message.collapseKey}");
    print("알람 이름 5: ${message.messageType}");
    print("알람 이름 6: ${message.from}");

    if (message.data['type'] == 'chat')
    {
      print('Todo : !!!!!!!!!!!');
      // Navigator.pushNamed(context, '/chat',
      //   arguments: ChatArguments(message),
      // );
    }
  }

  Future<void> setupInteractedMessage() async
  {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(
    //options: DefaultFirebaseOptions.currentPlatform,
  );

  print("Handling a background message: ${message.messageId}");
  print("알람 이름 1: ${message.data}");
  print("알람 이름 2: ${message.senderId}");
  print("알람 이름 3: ${message.category}");
  print("알람 이름 4: ${message.collapseKey}");
  print("알람 이름 5: ${message.messageType}");
  print("알람 이름 6: ${message.from}");

}

//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

class Application extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Application();
}

class _Application extends State<Application>
{
  // It is assumed that all messages contain a data field with the key 'type'
  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message)
  {
    print("알람 이름 1: ${message.data}");
    print("알람 이름 2: ${message.senderId}");
    print("알람 이름 3: ${message.category}");
    print("알람 이름 4: ${message.collapseKey}");
    print("알람 이름 5: ${message.messageType}");
    print("알람 이름 6: ${message.from}");

    if (message.data['type'] == 'chat')
    {
      print('Todo : !!!!!!!!!!!');
      // Navigator.pushNamed(context, '/chat',
      //   arguments: ChatArguments(message),
      // );
    }
  }

  @override
  void initState() {
    super.initState();

    // Run code required to handle interacted messages in an async function
    // as initState() must not be async
    setupInteractedMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Text("...");
  }
}
