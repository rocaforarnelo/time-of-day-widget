import 'package:flutter/material.dart';
import 'package:time_of_day_widget/time_of_day_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Time Of Day Widget Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: TimeOfDayWidget(
          timeOfDayWidgetBuilders: [
            (context, timeOfDay, child) {
              return _TimeOfDaySampleWidget(
                imageAssetUrl:
                    'https://c.tadst.com/gfx/750w/nautical-twilight-lake.jpg?1',
                timeOfDay: timeOfDay,
              );
            },
            (context, timeOfDay, child) {
              return _TimeOfDaySampleWidget(
                imageAssetUrl:
                    'https://media.istockphoto.com/photos/sunrise-picture-id531253600?k=6&m=531253600&s=612x612&w=0&h=5TlTeuDKczLxsZno-y28J1r9OTHH0KqoEn4XG0LyZDw=',
                timeOfDay: timeOfDay,
              );
            },
            (context, timeOfDay, child) {
              return _TimeOfDaySampleWidget(
                imageAssetUrl:
                    'https://media.istockphoto.com/photos/miraculous-heavenly-light-panorama-banner-picture-id932252868?k=6&m=932252868&s=612x612&w=0&h=0NfalAxcXZ7HQVYJgkMgejyvqPnk1kJcYKVvtA9o3AA=',
                timeOfDay: timeOfDay,
              );
            },
            (context, timeOfDay, child) {
              return _TimeOfDaySampleWidget(
                imageAssetUrl:
                    'https://i.pinimg.com/originals/81/a7/b7/81a7b7a3f0b50f5b36a2a345b73614d1.jpg',
                timeOfDay: timeOfDay,
              );
            },
            (context, timeOfDay, child) {
              return _TimeOfDaySampleWidget(
                imageAssetUrl:
                    'https://www.maxpixel.net/static/photo/1x/Light-Sunset-Sky-Nightfall-In-The-Evening-777111.jpg',
                timeOfDay: timeOfDay,
              );
            }
          ],
        ));
  }
}

class _TimeOfDaySampleWidget extends StatelessWidget {
  final TimeOfDay timeOfDay;
  final String imageAssetUrl;

  const _TimeOfDaySampleWidget(
      {Key? key, required this.timeOfDay, required this.imageAssetUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 300,
        width: 300,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(imageAssetUrl), fit: BoxFit.cover)),
        child: Text(timeOfDay.format(context),
            style:
                Theme.of(context).textTheme.headline1!.copyWith(fontSize: 12)),
      ),
    );
  }
}
