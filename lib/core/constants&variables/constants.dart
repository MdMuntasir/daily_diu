import 'package:flutter_dotenv/flutter_dotenv.dart';

String link1 = dotenv.env["Routine_Scrapper_API"]!;
const link2 = "";

String result_api = dotenv.env["Result_API"]!;

String routine_api = "https://" + link1;

String routine_api_base = link1;

