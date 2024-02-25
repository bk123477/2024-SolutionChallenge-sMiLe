import 'package:flutter/material.dart';
import '../../chat/message_send.dart';
import '../../chat/message_show.dart';

class DailydialogueChatbotWidget extends StatefulWidget {
  final VoidCallback onToggleScreen;
  const DailydialogueChatbotWidget({Key? key, required this.onToggleScreen}) : super(key: key);

  @override
  State<DailydialogueChatbotWidget> createState() => _DailydialogueChatbotWidgetState();
}

class _DailydialogueChatbotWidgetState extends State<DailydialogueChatbotWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Container(
              width: constraints.maxWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: widget.onToggleScreen,
                    style: TextButton.styleFrom(
                      primary: Colors.black,
                    ),
                    child: Text(
                      'Daily Life',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Image.asset(
                    'asset/img/smileimoge.png',
                    height: 40,
                  ),
                  Opacity(
                    opacity: 0.0,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Daily Life',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
