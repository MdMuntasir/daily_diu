import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DeveloperInfo extends StatelessWidget {
  final String name;
  final String linkedinURL;
  final String githubURL;
  final String portfolioURL;
  final String telegramURL;
  final String imagePath;
  const DeveloperInfo({
    super.key,
    required this.name,
    required this.linkedinURL,
    required this.githubURL,
    required this.portfolioURL,
    required this.telegramURL,
    required this.imagePath});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    bool horizontal = h>w;
    double mainHeight = horizontal? h*.25 : w*.25, mainWidth = horizontal ? w*.7: h*.7;


    return Container(
      width: mainWidth,
      height: mainHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: mainHeight*.35,
              width: mainHeight*.35,
              decoration: BoxDecoration(
                shape: BoxShape.circle
              ),
              child: ClipOval(
                child: Image.asset(imagePath,fit: BoxFit.cover,),
              ),
            ),

            Text(
                name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "Madimi"
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: (){
                      launchUrl(
                        Uri.parse(portfolioURL),
                        mode: LaunchMode.externalApplication
                      );
                    },
                    icon: Icon(FontAwesomeIcons.globe, size: 20,)),

                IconButton(
                    onPressed: (){
                      launchUrl(
                          Uri.parse(githubURL),
                          mode: LaunchMode.externalApplication
                      );
                    },
                    icon: Icon(FontAwesomeIcons.github, size: 20)),

                IconButton(
                    onPressed: (){
                      launchUrl(
                          Uri.parse(linkedinURL),
                          mode: LaunchMode.externalApplication
                      );
                    },
                    icon: Icon(FontAwesomeIcons.linkedinIn, size: 20)),


                IconButton(
                    onPressed: (){
                      launchUrl(
                          Uri.parse(telegramURL),
                          mode: LaunchMode.externalApplication
                      );
                    },
                    icon: Icon(FontAwesomeIcons.telegram, size: 20)),
              ],
            )
          ],
        ),
      )
    );
  }
}
