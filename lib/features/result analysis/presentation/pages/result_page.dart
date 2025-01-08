import 'package:diu_student/features/result%20analysis/data/data%20sources/remote/api_data_source.dart';
import 'package:diu_student/features/result%20analysis/data/repository/resultRepositoryImp.dart';
import 'package:diu_student/features/result%20analysis/domain/usecase/result_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../navbar/presentation/pages/NavBar.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Hero(
          tag: "Result",
          child: Text(
            "Result",
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * .05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => NavBar()));
                    },
                    color: Colors.teal.shade900,
                    icon: Icon(FontAwesomeIcons.barsStaggered)),
              ],
            ),
          )
        ],
      ),
      body: Column(),
    );
  }
}
