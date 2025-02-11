import 'package:diu_student/core/common/app%20user/userCubit/app_user_cubit.dart';
import 'package:diu_student/core/util/widgets/error_screen.dart';
import 'package:diu_student/features/navbar/presentation/pages/profileEdit.dart';
import 'package:diu_student/features/navbar/presentation/state/nav_bloc.dart';
import 'package:diu_student/features/navbar/presentation/state/nav_event.dart';
import 'package:diu_student/features/navbar/presentation/state/nav_state.dart';
import 'package:diu_student/features/navbar/presentation/widgets/developer_info.dart';
import 'package:diu_student/features/navbar/presentation/widgets/user_info_show.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/util/widgets/custom_alert_box.dart';
import '../../../authentication/presentation/pages/login.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  void initState() {
    super.initState();
    context.read<NavBloc>().add(NavInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    bool horizontal = h > w;

    return BlocConsumer(
        bloc: context.read<NavBloc>(),
        listenWhen: (previous, current) => current is NavBarActionState,
        buildWhen: (previous, current) =>
            current is! NavBarActionState && current is NavBarState,
        listener: (context, state) {
          if (state is SignOutFromNav) {
            showDialog(
                context: context,
                builder: (context) => CustomAlertBox(
                    text: "Want to log out?",
                    function: () async {
                      context.read<NavBloc>().add(SignOutConfirmEvent());
                    }));
          } else if (state is SignOutConfirm) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Logged Out'),
              ));
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const loginScreen()));
            }
          } else if (state is SignOutFailed) {
            final String errorMessage = state.message == "No Internet"
                ? "No Internet Connection"
                : "Logout failed. An error occurred while signing out.";
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(errorMessage),
            ));
          }
        },
        builder: (context, state) {
          if (state is NavInitialState) {
            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: h * .05,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(FontAwesomeIcons.xmark))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: h * .02,
                    ),
                    UserInfoShow(
                      user: AppUserCubit()
                          .currentUser(context.read<AppUserCubit>()),
                    ),
                    SizedBox(
                      height: h * .008,
                    ),
                    SizedBox(
                      width: horizontal ? w * .9 : h * .9,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ProfileEdit()));
                        },
                        style: ButtonStyle(
                            elevation: const WidgetStatePropertyAll(8),
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.teal.shade50)),
                        child: const Text(
                          "Edit Profile",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Madimi",
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: h * .02,
                    ),
                    const Divider(
                      thickness: 2,
                    ),
                    SizedBox(
                      height: h * .02,
                    ),
                    Container(
                      width: w * .9,
                      height: h * .65,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          color: Colors.teal.shade50,
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 20,
                                spreadRadius: -10,
                                offset: Offset(2, 5))
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        child: SingleChildScrollView(
                          child: horizontal
                              ? Column(
                                  children: [
                                    const Text(
                                      "Developers",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Madimi",
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                    SizedBox(
                                      height: h * .02,
                                    ),
                                    const DeveloperInfo(
                                        name: "Md. Muntasir Hossain",
                                        linkedinURL:
                                            "https://www.linkedin.com/in/muntasir27/",
                                        githubURL:
                                            "https://github.com/MdMuntasir",
                                        portfolioURL:
                                            "https://muntasir.infinityfreeapp.com/",
                                        telegramURL: "https://t.me/muntasir27",
                                        imagePath:
                                            "assets/images/Muntasir1.jpg"),
                                    SizedBox(
                                      height: h * .02,
                                    ),
                                    const DeveloperInfo(
                                        name: "Imranul Islam Shihab",
                                        linkedinURL:
                                            "https://www.linkedin.com/in/imransihab0/",
                                        githubURL:
                                            "https://github.com/imransihab0",
                                        portfolioURL:
                                            "https://imransihab.wordpress.com",
                                        telegramURL: "https://t.me/imransihab0",
                                        imagePath: "assets/images/Shihab.jpeg"),
                                  ],
                                )
                              : Column(
                                  children: [
                                    const Text(
                                      "Developers",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Madimi",
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                    SizedBox(
                                      height: h * .02,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const DeveloperInfo(
                                            name: "Md. Muntasir Hossain",
                                            linkedinURL:
                                                "https://www.linkedin.com/in/muntasir27/",
                                            githubURL:
                                                "https://github.com/MdMuntasir",
                                            portfolioURL:
                                                "https://live-mdmuntasir.pantheonsite.io",
                                            telegramURL:
                                                "https://t.me/muntasir27",
                                            imagePath:
                                                "assets/images/muntasir.jpg"),
                                        SizedBox(
                                          width: w * .08,
                                        ),
                                        const DeveloperInfo(
                                            name: "Imranul Islam Shihab",
                                            linkedinURL:
                                                "https://www.linkedin.com/in/imransihab0/",
                                            githubURL:
                                                "https://github.com/imransihab0",
                                            portfolioURL:
                                                "https://imransihab.wordpress.com",
                                            telegramURL:
                                                "https://t.me/imransihab0",
                                            imagePath:
                                                "assets/images/Shihab.jpeg"),
                                      ],
                                    ),
                                    SizedBox(
                                      height: h * .02,
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: h * .02,
                    ),
                    const Divider(
                      thickness: 2,
                    ),
                    SizedBox(
                      height: h * .02,
                    ),
                    SizedBox(
                      width: horizontal ? w * .9 : h * .9,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<NavBloc>().add(SignOutFromNavEvent());
                        },
                        style: ButtonStyle(
                            elevation: const WidgetStatePropertyAll(8),
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.teal.shade50)),
                        child: const Text(
                          "Logout",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Madimi",
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: h * .05,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Scaffold(body: ErrorScreen());
          }
        });
  }
}
