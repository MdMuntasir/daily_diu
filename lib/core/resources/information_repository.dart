import 'package:device_info_plus/device_info_plus.dart';
import 'package:diu_student/core/constants&variables/variables.dart';
import 'package:diu_student/features/routine/data/models/slot.dart';

import '../../features/routine/data/models/empty_slot_model.dart';
import '../../features/routine/data/repository/empty slots/empty_slot_repo_impl.dart';
import '../../features/routine/data/repository/manual/manual.dart';
import '../../features/routine/data/repository/time_repository_implement.dart';
import '../../features/routine/domain/entities/empty_slot.dart';



late var android_info;




class Information {
  static Map departments
  = {
  'SWE': ['Software Engineering', ()async{
      try{
          allSlots = await getAllSlotsRemotely().getAllSlots();
          emptySlots = await getEmptySlotRemotely().getEmptySlots();
          Times = await getTimesRemotely().getTime();
        }
        catch(e){
          print(e);
        }
        if(allSlots.isNotEmpty && emptySlots.isNotEmpty && Times.isNotEmpty) {
          hasFunction = true;
        }
      }],
  'CSE': ['Computer Science & Engineering', (){
    hasFunction = false;
  }],
  'ITM': ['Information Technology & Management', (){hasFunction = false;}],
  'CIS': ['Computing and Information System', (){hasFunction = false;}],
  'ARCH': ['Architecture', (){hasFunction = false;}],
  'EEE': ['Electrical and Electronic Engineering', (){hasFunction = false;}],
  'TE': ['Textile Engineering', (){hasFunction = false;}],
  'ICE': ['Information and Communication Engineering', (){hasFunction = false;}],
  'THM': ['Tourism & Hospitality Management', (){hasFunction = false;}],
  'ACC': ['Accounting', (){hasFunction = false;}],
  'RE': ['Real Estate', (){hasFunction = false;}],
  'DE': ['Innovation & Entrepreneurship', (){hasFunction = false;}],
  'AGRI': ['Agricultural Science', (){hasFunction = false;}],
  'PHARM': ['Pharmacy', (){hasFunction = false;}],
  'NFE': ['Nutrition and Food Engineering', (){hasFunction = false;}],
  'BPH': ['Public Health', (){hasFunction = false;}],
  'ESDM': ['Environmental Science and Disaster Management', (){hasFunction = false;}],
  'PESS': ['Physical Education & Sports Science', (){hasFunction = false;}],
  'ENG': ['English', (){hasFunction = false;}],
  'LAW': ['Law', (){hasFunction = false;}]
  };
}

List Times = [];

List<EmptySlotModel> emptySlots = [];


List Days = [
  "Saturday",
  "Sunday",
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday"
];

List<SlotModel> test_body = [
  SlotModel.fromJson(const {
    "id": "1",
    "day": "Saturday",
    "room": "704",
    "time": "09:45-11:00",
    "batch": "41",
    "section": "N",
    "course": "SE212",
    "ti": "FRR"
  }),
  SlotModel.fromJson(const {
    "id": "2",
    "day": "Saturday",
    "room": "712B",
    "time": "01:30 - 02:45",
    "batch": "41",
    "section": "N",
    "course": "MAT102",
    "ti": "MSH"
  }),
  SlotModel.fromJson(const {
    "id": "3",
    "day": "Saturday",
    "room": "703",
    "time": "04:00-05:15",
    "batch": "41",
    "section": "N",
    "course": "SE121",
    "ti": "SUP"
  }),
  SlotModel.fromJson(const {
    "id": "4",
    "day": "Sunday",
    "room": "704",
    "time": "09:45-11:00",
    "batch": "41",
    "section": "N",
    "course": "SE213",
    "ti": "MT"
  }),
  SlotModel.fromJson(const {
    "id": "5",
    "day": "Sunday",
    "room": "814B",
    "time": "01:30 - 02:45",
    "batch": "41",
    "section": "N",
    "course": "PHY101",
    "ti": "AAM"
  }),
  SlotModel.fromJson(const {
    "id": "6",
    "day": "Sunday",
    "room": "703",
    "time": "02:45 - 04:00",
    "batch": "41",
    "section": "N",
    "course": "SE212",
    "ti": "FRR"
  }),
SlotModel.fromJson(const {
    "id": "7",
    "day": "Sunday",
    "room": "701A",
    "time": "04:00-05:15",
    "batch": "41",
    "section": "N",
    "course": "SE123",
    "ti": "RHH"
  }),
SlotModel.fromJson(const {
    "id": "8",
    "day": "Monday",
    "room": "710",
    "time": "11:00-12:15",
    "batch": "41",
    "section": "N",
    "course": "SE123",
    "ti": "RHH"
  }),
SlotModel.fromJson(const {
    "id": "9",
    "day": "Monday",
    "room": "914",
    "time": "02:45 - 04:00",
    "batch": "41",
    "section": "N",
    "course": "SE121",
    "ti": "SUP"
  }),
SlotModel.fromJson(const {
    "id": "10",
    "day": "Tuesday",
    "room": "913",
    "time": "01:30 - 02:45",
    "batch": "41",
    "section": "N",
    "course": "MAT102",
    "ti": "MSH"
  }),
SlotModel.fromJson(const {
    "id": "11",
    "day": "Tuesday",
    "room": "812",
    "time": "02:45 - 04:00",
    "batch": "41",
    "section": "N",
    "course": "SE213",
    "ti": "MT"
  }),
SlotModel.fromJson(const {
    "id": "12",
    "day": "Wednesday",
    "room": "616",
    "time": "11:00-12:15",
    "batch": "41",
    "section": "N1",
    "course": "SE122",
    "ti": "SUP"
  }),
  SlotModel.fromJson(const {
    "id": "13",
    "day": "Wednesday",
    "room": "616",
    "time": "12:15-01:30",
    "batch": "41",
    "section": "N2",
    "course": "SE122",
    "ti": "SUP"
  }),
SlotModel.fromJson(const {
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

List test_time = [
  {
    "Time": [
      "08:30-09:45",
      "09:45-11:00",
      "11:00-12:15",
      "12:15-01:30",
      "01:30 - 02:45",
      "02:45 - 04:00",
      "04:00-05:15"
    ]
  }
];

List<SlotModel> allSlots = [];