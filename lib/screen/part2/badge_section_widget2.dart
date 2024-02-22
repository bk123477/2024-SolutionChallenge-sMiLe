import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BadgeSectionWidget extends StatefulWidget {
  const BadgeSectionWidget({Key? key}) : super(key: key);

  @override
  _BadgeSectionWidgetState createState() => _BadgeSectionWidgetState();
}

class _BadgeSectionWidgetState extends State<BadgeSectionWidget> {
  List<String> _badges = [
    'asset/img/badge/sky_watch.png',
    'asset/img/badge/count10.png',
    'asset/img/badge/early_bird.png',
    'asset/img/badge/stretching.png',
    'asset/img/badge/music_listen.png',
    'asset/img/badge/no_phone.png',
  ];
  final List<String> _description = [
    "Looking at the sky",
    "Counting slowly  from 1 to 10",
    "Waking up early",
    "Stretching for a minute",
    "Listening to your favorite songs",
    "Not looking at my cell phone for an hour"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: _badges.length,
        itemBuilder: (context, index) {
          return _BadgeButton(context: context, index: index);
        },
      ),
    );
  }

  Widget _BadgeButton({required BuildContext context, required int index}) {
    return InkWell(
      onTap: () async {
        SharedPreferences _prefs = await SharedPreferences.getInstance();
        String key = 'mission${index + 1}';
        int mission = _prefs.getInt(key) ?? 0;
        showDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), // Rounded corners for the dialog
              child: Column(
                mainAxisSize: MainAxisSize.min, // Makes the dialog height fit the content
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)), // Rounded corners at the top
                    child: Image.asset(_badges[index], fit: BoxFit.cover),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          _description[index],
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), // Emphasize the title
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Achieved ${mission} times in total',
                          style: TextStyle(fontSize: 16), // Slightly de-emphasized but still readable
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset(_badges[index], fit: BoxFit.cover),
        ),
      ),
    );
  }
}
