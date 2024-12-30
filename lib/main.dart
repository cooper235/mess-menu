import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:uhl_link/config/routes/routes.dart';
import 'package:uhl_link/features/authentication/data/data_sources/user_data_sources.dart';
import 'package:uhl_link/features/authentication/domain/usecases/update_password.dart';
import 'package:uhl_link/utils/theme.dart';

import 'features/authentication/data/repository_implementations/user_repository_impl.dart';
import 'features/authentication/domain/usecases/signin_user.dart';
import 'features/authentication/presentation/bloc/user_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  const storage = FlutterSecureStorage();
  final GoRouter router = UhlLinkRouter().router;
  runApp(BlocProvider<ThemeBloc>(
    create: (context) => ThemeBloc(storage: storage)..loadSavedTheme(),
    child: UhlLink(router: router),
  ));
}

class UhlLink extends StatelessWidget {
  final GoRouter router;

  const UhlLink({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<SignInUser>(
            create: (_) => SignInUser(UserRepositoryImpl(UhlUsersDB()))),
        RepositoryProvider<UpdatePassword>(
            create: (_) => UpdatePassword(UserRepositoryImpl(UhlUsersDB()))),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
              create: (context) => AuthenticationBloc(
                  loginUser: SignInUser(UserRepositoryImpl(UhlUsersDB())),
                  updatePassword:
                      UpdatePassword(UserRepositoryImpl(UhlUsersDB())))),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return MaterialApp.router(
              title: 'UhlLink',
              themeMode: state.isDark ? ThemeMode.dark : ThemeMode.light,
              theme: UhlLinkTheme.lightTheme,
              darkTheme: UhlLinkTheme.darkTheme,
              routerConfig: router,
            );
          },
        ),
      ),
    );
  }
}
