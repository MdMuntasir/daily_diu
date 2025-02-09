import 'package:diu_student/config/theme/Themes.dart';
import 'package:diu_student/core/common/app%20user/userCubit/app_user_state.dart';
import 'package:diu_student/features/authentication/presentation/pages/login.dart';
import 'package:diu_student/features/home/presentation/pages/homePage.dart';
import 'package:diu_student/features/home/presentation/state/home_bloc.dart';
import 'package:diu_student/features/routine/presentation/state/routine_bloc.dart';
import 'package:diu_student/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lottie/lottie.dart';
import 'core/common/app user/userCubit/app_user_cubit.dart';
import 'features/authentication/presentation/widgets/textStyle.dart';
import 'features/home/presentation/state/home_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await initializeDependency();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
        BlocProvider(create: (_) => serviceLocator<HomeBloc>()),
        BlocProvider(create: (_) => serviceLocator<RoutineBloc>())
      ],
      child: const MyApp(),
    ));
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AppUserCubit>().updateUser();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: BlocSelector<AppUserCubit, AppUserState, AppUserState>(
          selector: (state) {
            return state;
          },
          builder: (context, state) {
            switch (state.runtimeType) {
              case LoggedAppUser:
                context.read<HomeBloc>().add(HomeInitialEvent());
                return const homePage();
              case LoggedOutAppUser:
                return const loginScreen();
              default:
                return Scaffold(
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: h * .02,
                    children: [
                      Lottie.asset("assets/lottie/Loading1.json",
                          height: h * .3),
                      SizedBox(
                        width: w,
                      ),
                      Text(
                        "DAILY DIU",
                        style: TextTittleStyle,
                      )
                    ],
                  ),
                );
            }
          },
        ));
  }
}
