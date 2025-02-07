import 'package:diu_student/config/theme/Themes.dart';
import 'package:diu_student/core/common/app%20user/userCubit/app_user_state.dart';
import 'package:diu_student/features/authentication/presentation/pages/email_varification_page.dart';
import 'package:diu_student/features/authentication/presentation/pages/login.dart';
import 'package:diu_student/features/home/presentation/pages/homePage.dart';
import 'package:diu_student/features/home/presentation/state/home_bloc.dart';
import 'package:diu_student/injection_container.dart';
import 'package:diu_student/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/common/app user/userCubit/app_user_cubit.dart';

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
                return const homePage();
              case LoggedOutAppUser:
                return const loginScreen();
              default:
                return const Center(
                  child: CircularProgressIndicator(),
                );
            }
          },
        ));
  }
}
