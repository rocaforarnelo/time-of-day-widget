import 'package:example/image_asset_names.dart';
import 'package:flutter/material.dart';
import 'package:time_of_day_widget/models/time_of_day_range.dart';
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
        body: Column(
          children: [
            Text('Time Of Day Widget'),
            _buildTimeOfDayWidget(),
            Text('Time Of Day Range Widget'),
            _buildTimeOfDayRangesWidget()
          ],
        ));
  }

  Widget _buildTimeOfDayRangesWidget() {
    return TimeOfDayRangedWidget(
      timeOfDayRanges: [
        TimeOfDayRange(
            from: TimeOfDay(hour: 1, minute: 0),
            to: TimeOfDay(hour: 5, minute: 0),
            builder: (context, timeOfDay, child) {
              return _TimeOfDaySampleWidget(
                imageAssetPath: ImageAssetNames.twilight,
                timeOfDay: timeOfDay,
              );
            }),
        TimeOfDayRange(
            from: TimeOfDay(hour: 5, minute: 0),
            to: TimeOfDay(hour: 9, minute: 0),
            builder: (context, timeOfDay, child) {
              return _TimeOfDaySampleWidget(
                imageAssetPath: ImageAssetNames.sunrise,
                timeOfDay: timeOfDay,
              );
            }),
        TimeOfDayRange(
            from: TimeOfDay(hour: 9, minute: 0),
            to: TimeOfDay(hour: 15, minute: 0),
            builder: (context, timeOfDay, child) {
              return _TimeOfDaySampleWidget(
                imageAssetPath: ImageAssetNames.midday,
                timeOfDay: timeOfDay,
              );
            }),
        TimeOfDayRange(
            from: TimeOfDay(hour: 15, minute: 0),
            to: TimeOfDay(hour: 19, minute: 0),
            builder: (context, timeOfDay, child) {
              return _TimeOfDaySampleWidget(
                imageAssetPath: ImageAssetNames.sunglow,
                timeOfDay: timeOfDay,
              );
            }),
        TimeOfDayRange(
            from: TimeOfDay(hour: 19, minute: 0),
            to: TimeOfDay(hour: 24, minute: 0),
            builder: (context, timeOfDay, child) {
              return _TimeOfDaySampleWidget(
                imageAssetPath: ImageAssetNames.nightfall,
                timeOfDay: timeOfDay,
              );
            })
      ],
    );
  }

  TimeOfDayWidget _buildTimeOfDayWidget() {
    return TimeOfDayWidget(
      timeOfDayWidgetBuilders: [
        (context, timeOfDay, child) {
          return _TimeOfDaySampleWidget(
            imageAssetPath: ImageAssetNames.twilight,
            timeOfDay: timeOfDay,
          );
        },
        (context, timeOfDay, child) {
          return _TimeOfDaySampleWidget(
            imageAssetPath: ImageAssetNames.sunrise,
            timeOfDay: timeOfDay,
          );
        },
        (context, timeOfDay, child) {
          return _TimeOfDaySampleWidget(
            imageAssetPath: ImageAssetNames.midday,
            timeOfDay: timeOfDay,
          );
        },
        (context, timeOfDay, child) {
          return _TimeOfDaySampleWidget(
            imageAssetPath: ImageAssetNames.sunglow,
            timeOfDay: timeOfDay,
          );
        },
        (context, timeOfDay, child) {
          return _TimeOfDaySampleWidget(
            imageAssetPath: ImageAssetNames.nightfall,
            timeOfDay: timeOfDay,
          );
        }
      ],
    );
  }
}

class _TimeOfDaySampleWidget extends StatelessWidget {
  final TimeOfDay timeOfDay;
  final String imageAssetPath;

  const _TimeOfDaySampleWidget(
      {Key? key, required this.timeOfDay, required this.imageAssetPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 200,
        width: 300,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(imageAssetPath), fit: BoxFit.cover)),
        child: Text(timeOfDay.format(context),
            style:
                Theme.of(context).textTheme.headline1!.copyWith(fontSize: 12)),
      ),
    );
  }
}
