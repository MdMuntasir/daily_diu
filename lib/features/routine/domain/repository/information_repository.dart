import 'package:diu_student/core/constants&variables/variables.dart';
import 'package:diu_student/features/routine/data/models/slot.dart';

import '../../data/models/empty_slot_model.dart';
import '../../data/repository/empty slots/empty_slot_repo_impl.dart';
import '../../data/repository/manual/manual.dart';
import '../../data/repository/time_repository_implement.dart';
import '../entities/empty_slot.dart';



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