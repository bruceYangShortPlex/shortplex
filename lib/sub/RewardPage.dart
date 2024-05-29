import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  //await StringTable().InitTable();
  runApp(RewardPage());
}

class RewardPage extends StatefulWidget
{
  const RewardPage({super.key});

  @override
  State<RewardPage> createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage>
{
  var contentList = <int>[];
  var selectedIndex = 0;

  @override
  void initState() {

    super.initState();

    for(int i = 0; i < 10 ; ++i)
      contentList.add(i);
  }

  @override
  Widget build(BuildContext context) {
    return
      MaterialApp
      (
        home:
        Container
        (
          color: Colors.black,
          child:
          ListView
          (
            scrollDirection: Axis.vertical,
            children:
            [
              for(int i = 0; i < contentList.length ; ++i)
                  testItem(i),
            ],
          ),

          // Column
          // (
          //   children:
          //   [
          //     testItem(1),
          //     SizedBox(height: 10,),
          //     testItem(2),
          //     SizedBox(height: 10,),
          //     testItem(3),
          //   ],
          // ),
        ),
      );
  }

  Widget testItem(int _index)
  {
    return
    GestureDetector
    (
      onTap: ()
      {
        setState(() {
          selectedIndex = _index;
        });

        print(selectedIndex);
      },
      child: Container
      (
        width: 100,
        height: 100,
        color: selectedIndex == _index ? Colors.red : Colors.grey,
      ),
    );
  }
}
