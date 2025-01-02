import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uhl_link/config/routes/routes_consts.dart';
import 'package:uhl_link/features/authentication/presentation/pages/choose_auth.dart';
import 'package:uhl_link/features/authentication/presentation/pages/login.dart';
import 'package:uhl_link/widgets/test.dart';

class UhlLinkRouter {
  GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
          name: UhlLinkRoutesNames.chooseAuth,
          path: '/',
          pageBuilder: (context, state) {
            return MaterialPage(
                key: state.pageKey, child: const ChooseAuthPage());
          }),
      GoRoute(
          name: UhlLinkRoutesNames.login,
          path: '/login',
          pageBuilder: (context, state) {
            return MaterialPage(key: state.pageKey, child: const LoginPage());
          }),
      GoRoute(
          name: UhlLinkRoutesNames.updatePassword,
          path: '/updatePassword',
          pageBuilder: (context, state) {
            return MaterialPage(key: state.pageKey, child: const TestScreen());
          }),
    ],
  );
}
