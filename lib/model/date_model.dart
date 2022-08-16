// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

const String TimeStamp = 'timestamp';
const String Day = 'day';
const String Month = 'month';
const String Year = 'year';

class DateModel {
  Timestamp timestamp;
  int day;
  int month;
  int year;

  DateModel({
    required this.timestamp,
    required this.day,
    required this.month,
    required this.year,
  });

  Map<String, dynamic> toMap(DateModel dateModel) {
    return <String, dynamic>{
      TimeStamp: timestamp,
      Day: day,
      Month: month,
      Year: year,
    };
  }

  factory DateModel.fromMap(Map<String, dynamic> map) => DateModel(
        timestamp: map[TimeStamp],
        day: map[Day],
        month: map[Month],
        year: map[Year],
      );
}
