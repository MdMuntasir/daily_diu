import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../navbar/presentation/pages/NavBar.dart';

class notePage extends StatefulWidget {
  const notePage({super.key});

  @override
  State<notePage> createState() => _notePageState();
}

class _notePageState extends State<notePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: (){
                    PersistentNavBarNavigator.pushNewScreen(
                        context,
                        withNavBar: false,
                        screen: NavBar());
                  },
                  color: Colors.black87,
                  icon: Icon(FontAwesomeIcons.barsStaggered)),
            ],
          ),
        ),
      ),
      body: Center(
        child: Text(
          "Coming Soon...",
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
            color: Colors.green.shade700
          ),
        ),
      ),
    );
  }
}
