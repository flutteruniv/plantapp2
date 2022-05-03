// import 'dart:collection';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'package:intl/intl.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:table_calendar/table_calendar.dart';
//
// class CalenderModel extends ChangeNotifier {
//   final DateTime _focusedDay = DateTime.now();
//   late DateTime selectedDay;
//   Map<DateTime, List> _eventsList = {};
//   int getHashCode(DateTime key) {
//     return key.day * 1000000 + key.month * 10000 + key.year;
//   }
//
//   final _events = LinkedHashMap<DateTime, List>(
//     equals: isSameDay,
//     hashCode: getHashCode,
//   )..addAll(_eventsList);
//
//   List getEventForDay(DateTime day) {
//     return _events[day] ?? [];
//   }
//
//   Future<void> fetchEventCalender() async {
//     selectedDay = _focusedDay;
//     _eventsList = {
//       DateTime.now().subtract(Duration(days: 2)): ['Event A6', 'Event B6'],
//       DateTime.now(): ['Event A7', 'Event B7', 'Event C7', 'Event D7'],
//       DateTime.now().add(Duration(days: 1)): [
//         'Event A8',
//         'Event B8',
//         'Event C8',
//         'Event D8'
//       ],
//       DateTime.now().add(Duration(days: 3)):
//           Set.from(['Event A9', 'Event A9', 'Event B9']).toList(),
//       DateTime.now().add(Duration(days: 7)): [
//         'Event A10',
//         'Event B10',
//         'Event C10'
//       ],
//       DateTime.now().add(Duration(days: 11)): ['Event A11', 'Event B11'],
//       DateTime.now().add(Duration(days: 17)): [
//         'Event A12',
//         'Event B12',
//         'Event C12',
//         'Event D12'
//       ],
//       DateTime.now().add(Duration(days: 22)): ['Event A13', 'Event B13'],
//       DateTime.now().add(Duration(days: 26)): [
//         'Event A14',
//         'Event B14',
//         'Event C14'
//       ],
//     };
//     notifyListeners();
//   }
// }
