import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Util/ShortplexTools.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: KeyboardOverlayExample(),
    );
  }
}

class KeyboardOverlayExample extends StatefulWidget {
  @override
  _KeyboardOverlayExampleState createState() => _KeyboardOverlayExampleState();
}

class _KeyboardOverlayExampleState extends State<KeyboardOverlayExample> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold
      (
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Cupertino TextField Example'),
      ),
      body: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              _focusNode.unfocus();
            },
            child: Center(
              child: Text('Tap the input field below'),
            ),
          ),
          VirtualKeybord('테스트용',_controller,_focusNode,MediaQuery.of(context).viewInsets.bottom, () {

          }),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Container(
          //     color: Colors.white,
          //     child: Row(
          //       children: <Widget>[
          //         Expanded(
          //           child: CupertinoTextField(
          //             controller: _controller,
          //             focusNode: _focusNode,
          //             placeholder: 'Enter text',
          //             padding: EdgeInsets.all(16),
          //           ),
          //         ),
          //         CupertinoButton(
          //           child: Icon(CupertinoIcons.arrow_up_circle),
          //           onPressed: () {
          //             // Handle send button press
          //             print('Text entered: ${_controller.text}');
          //             _controller.clear();
          //             _focusNode.unfocus();
          //           },
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
