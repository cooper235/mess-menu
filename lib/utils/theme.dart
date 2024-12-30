import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// enum CurrentTheme { dark, light }

class UhlLinkTheme {
  UhlLinkTheme._();

  static final ThemeData darkTheme = ThemeData();

  static final ThemeData lightTheme = ThemeData();
}

// Events
abstract class ThemeEvent {}

class ToggleTheme extends ThemeEvent {}

// States
class ThemeState {
  final bool isDark;
  ThemeState({required this.isDark});
}

// BLoC
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final FlutterSecureStorage storage;

  ThemeBloc({required this.storage}) : super(ThemeState(isDark: false)) {
    on<ToggleTheme>((event, emit) async {
      final newIsDark = !state.isDark;
      await storage.write(key: 'isDark', value: newIsDark.toString());
      emit(ThemeState(isDark: newIsDark));
    });
  }

  // Load saved theme preference
  Future<void> loadSavedTheme() async {
    final isDark = (await storage.read(key: 'isDark')) == "true" ? true : false;
    emit(ThemeState(isDark: isDark));
  }
}
