import '../../features/routine/data/models/empty_slot_model.dart';

late var androidInfo;

String selectedDepartment = "";

bool Online = false;

class Information {
  static Map departments = {
    'SWE': 'Software Engineering',
    'CSE': 'Computer Science & Engineering',
  };
}

Map Faculty_Info = {
  "FSIT": {
    'SWE': 'Software Engineering',
    'CSE': 'Computer Science & Engineering',
    'ITM': 'Information Technology & Management',
    'CIS': 'Computing and Information System',
  },
  "FBE": {
    "DBA": "Business Administration",
    "BS": "Business Studies",
    'THM': 'Tourism & Hospitality Management',
    'ACC': 'Accounting',
    'RE': 'Real Estate',
    'DE': 'Innovation & Entrepreneurship',
  },
  "FHSS": {
    'ENG': 'English',
    'LAW': 'Law',
    'JMC': "Journalism, Media and Communication",
    'DS': "Development Studies",
  },
  "FHLS": {
    'AGRI': 'Agricultural Science',
    'PHARM': 'Pharmacy',
    'NFE': 'Nutrition and Food Engineering',
    'BPH': 'Public Health',
    'ESDM': 'Environmental Science and Disaster Management',
    'PESS': 'Physical Education & Sports Science',
  },
  "Engineering": {
    'ARCH': 'Architecture',
    'EEE': 'Electrical and Electronic Engineering',
    'CE': 'Civil Engineering',
    'TE': 'Textile Engineering',
    'ICE': 'Information and Communication Engineering',
  },
};

List Times = [];

List<EmptySlotModel> emptySlots = [];
