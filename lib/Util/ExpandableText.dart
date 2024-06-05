import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shortplex/table/StringTable.dart';

class ExpandableText extends StatefulWidget
{
  ExpandableText({required this.text});

  final String text;


  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText>
{
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context)
  {
    return
    Column
    (
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>
      [
        LayoutBuilder
        (
          builder: (BuildContext context, BoxConstraints constraints)
          {
            final span = TextSpan(text: widget.text);
            final tp = TextPainter(text: span, maxLines: 4, textDirection: TextDirection.ltr);
            tp.layout(maxWidth: constraints.maxWidth);

            if (tp.didExceedMaxLines)
            { // Check if the text will overflow
              return
              Column
              (
                children: <Widget>
                [
                  _isExpanded ?
                  Padding
                  (
                    padding: const EdgeInsets.only(left: 8, top: 8, right: 8),
                    child:
                    Text
                    (
                      widget.text,
                      style:
                      TextStyle(fontSize: 12, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                    ),
                  ) :
                Padding
                (
                  padding: const EdgeInsets.only(left: 8, top: 8, right: 8),
                  child:
                  Text
                  (
                      widget.text, maxLines: 4, overflow: TextOverflow.ellipsis,
                    style:
                    TextStyle(fontSize: 12, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                  ),
                ),
                Align
                (
                  alignment: Alignment.centerRight,
                  child:
                  SizedBox
                  (
                    height: 20,
                    child:
                    TextButton
                    (
                      child:
                      Text
                      (
                        _isExpanded ? '간략히' : StringTable().Table![100007]!,
                        style:
                        TextStyle(fontSize: 11, color: Color(0xFF00FFBF), fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                      ) ,
                      onPressed: () => setState(() => _isExpanded = !_isExpanded),
                    ),
                  ),
                ),
                ],
              );
            }
            else
            {
              return
              Padding
              (
                padding: const EdgeInsets.all(8),
                child:
                Text
                (
                  widget.text,
                  style:
                  TextStyle(fontSize: 12, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
