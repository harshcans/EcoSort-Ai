import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState(themeMode: ThemeMode.light));

  void toggleTheme() {
    if (state.themeMode == ThemeMode.light) {
      emit(const ThemeState(themeMode: ThemeMode.dark));
    } else {
      emit(const ThemeState(themeMode: ThemeMode.light));
    }
  }

  void setTheme(ThemeMode mode) {
    emit(ThemeState(themeMode: mode));
  }
}