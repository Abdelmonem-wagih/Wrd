import 'package:flutter/material.dart';
import 'package:wrd/core/services/screen_size_helper.dart';

import '../features/quran_db/presention/controller/db_helper.dart';
import '../frosted_glass.dart';

class AyaOfDay extends StatelessWidget {
  const AyaOfDay({Key? key, required this.ayaNumber}) : super(key: key);
  final int ayaNumber;
  @override
  Widget build(BuildContext context) {
    DatabaseHelper dbHelper = DatabaseHelper();
    return Padding(
      padding: EdgeInsets.only(
        left: 10.0.width,
        right: 10.0.width,
        top: 10.0.height,
        bottom: 30.height,
      ),
      child: FrostedGlassBox(
        theWidth: 340.width,
        theHeight: 170.height,
        theBoraderRight: 10,
        theBoraderLeft: 10,
        theChild: FutureBuilder<String>(
          future: dbHelper.getStringById(ayaNumber),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // Show a loading indicator while waiting
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              // The data is available here as snapshot.data
              String resultString = snapshot.data ?? 'Default Value';
              return Padding(
                padding: EdgeInsets.all(10.0.size),
                child: Text(
                  textScaleFactor: 0.8,
                  resultString,
                  style: TextStyle(
                    height: 1.5.height,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontFamily: "UthmanicHafs",
                    fontStyle: FontStyle.normal,
                    fontSize: 20.0.fontSize,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }
          }, // Asynchronous operation
        ),
      ),
    );
  }
}
