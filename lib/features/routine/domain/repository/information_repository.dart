import 'package:diu_student/features/routine/data/models/slot.dart';

import '../../data/models/empty_slot_model.dart';
import '../entities/empty_slot.dart';

class Information {
  static Map departments
  = {
  'SWE': ['Software Engineering', (){}],
  'CSE': ['Computer Science & Engineering', (){}],
  'ITM': ['Information Technology & Management', (){}],
  'CIS': ['Computing and Information System', (){}],
  'ARCH': ['Architecture', (){}],
  'EEE': ['Electrical and Electronic Engineering', (){}],
  'TE': ['Textile Engineering', (){}],
  'ICE': ['Information and Communication Engineering', (){}],
  'THM': ['Tourism & Hospitality Management', (){}],
  'ACC': ['Accounting', (){}],
  'RE': ['Real Estate', (){}],
  'DBA': ['Business Administration', (){}],
  'DE': ['Innovation & Entrepreneurship', (){}],
  'AGRI': ['Agricultural Science', (){}],
  'PHARM': ['Pharmacy', (){}],
  'NFE': ['Nutrition and Food Engineering', (){}],
  'BPH': ['Public Health', (){}],
  'ESDM': ['Environmental Science and Disaster Management', (){}],
  'PESS': ['Physical Education & Sports Science', (){}],
  'ENG': ['English', (){}],
  'LAW': ['Law', (){}]
  };
}

var Times = [];

List<EmptySlotModel> emptySlots = [];

List<SlotModel> test_body = [
  SlotModel.fromJson({
    "id": "1",
    "day": "Saturday",
    "room": "704",
    "time": "09:45-11:00",
    "batch": "41",
    "section": "N",
    "course": "SE212",
    "ti": "FRR"
  }),
  SlotModel.fromJson({
    "id": "2",
    "day": "Saturday",
    "room": "712B",
    "time": "01:30 - 02:45",
    "batch": "41",
    "section": "N",
    "course": "MAT102",
    "ti": "MSH"
  }),
  SlotModel.fromJson({
    "id": "3",
    "day": "Saturday",
    "room": "703",
    "time": "04:00-05:15",
    "batch": "41",
    "section": "N",
    "course": "SE121",
    "ti": "SUP"
  }),
  SlotModel.fromJson({
    "id": "4",
    "day": "Sunday",
    "room": "704",
    "time": "09:45-11:00",
    "batch": "41",
    "section": "N",
    "course": "SE213",
    "ti": "MT"
  }),
  SlotModel.fromJson({
    "id": "5",
    "day": "Sunday",
    "room": "814B",
    "time": "01:30 - 02:45",
    "batch": "41",
    "section": "N",
    "course": "PHY101",
    "ti": "AAM"
  }),
  SlotModel.fromJson({
    "id": "6",
    "day": "Sunday",
    "room": "703",
    "time": "02:45 - 04:00",
    "batch": "41",
    "section": "N",
    "course": "SE212",
    "ti": "FRR"
  }),
SlotModel.fromJson({
    "id": "7",
    "day": "Sunday",
    "room": "701A",
    "time": "04:00-05:15",
    "batch": "41",
    "section": "N",
    "course": "SE123",
    "ti": "RHH"
  }),
SlotModel.fromJson({
    "id": "8",
    "day": "Monday",
    "room": "710",
    "time": "11:00-12:15",
    "batch": "41",
    "section": "N",
    "course": "SE123",
    "ti": "RHH"
  }),
SlotModel.fromJson({
    "id": "9",
    "day": "Monday",
    "room": "914",
    "time": "02:45 - 04:00",
    "batch": "41",
    "section": "N",
    "course": "SE121",
    "ti": "SUP"
  }),
SlotModel.fromJson({
    "id": "10",
    "day": "Tuesday",
    "room": "913",
    "time": "01:30 - 02:45",
    "batch": "41",
    "section": "N",
    "course": "MAT102",
    "ti": "MSH"
  }),
SlotModel.fromJson({
    "id": "11",
    "day": "Tuesday",
    "room": "812",
    "time": "02:45 - 04:00",
    "batch": "41",
    "section": "N",
    "course": "SE213",
    "ti": "MT"
  }),
SlotModel.fromJson({
    "id": "12",
    "day": "Wednesday",
    "room": "616",
    "time": "11:00-12:15",
    "batch": "41",
    "section": "N1",
    "course": "SE122",
    "ti": "SUP"
  }),
  SlotModel.fromJson({
    "id": "13",
    "day": "Wednesday",
    "room": "616",
    "time": "12:15-01:30",
    "batch": "41",
    "section": "N2",
    "course": "SE122",
    "ti": "SUP"
  }),
SlotModel.fromJson({
    "id": "14",
    "day": "Wednesday",
    "room": "814B",
    "time": "02:45 - 04:00",
    "batch": "41",
    "section": "N",
    "course": "PHY101",
    "ti": "AAM"
  })
];

Map<String, dynamic> test =   {
  "id": "1",
  "day": "Saturday",
  "room": "704",
  "time": "09:45-11:00",
  "batch": "41",
  "section": "N",
  "course": "SE212",
  "ti": "FRR"
};


List<SlotModel> allSlots = [];