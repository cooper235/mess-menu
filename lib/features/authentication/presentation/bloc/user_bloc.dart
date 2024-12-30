import 'dart:convert';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uhl_link/features/authentication/data/data_sources/user_data_sources.dart';
import 'package:uhl_link/features/authentication/domain/entities/user_entity.dart';
import 'package:uhl_link/features/authentication/domain/usecases/signin_user.dart';
import 'package:uhl_link/features/authentication/domain/usecases/update_password.dart';

part 'user_event.dart';
part 'user_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final SignInUser loginUser;
  final UpdatePassword updatePassword;

  AuthenticationBloc({required this.loginUser, required this.updatePassword})
      : super(AuthenticationInitial()) {
    on<SignInEvent>(onSignInEvent);
    on<PasswordUpdateEvent>(onPasswordUpdateEvent);
  }

  void onSignInEvent(
      SignInEvent event, Emitter<AuthenticationState> emit) async {
    emit(UserLoading());
    try {
      final user = await loginUser.execute(event.email, event.password);
      if (user != null) {
        const flutterSecureStorage = FlutterSecureStorage();
        flutterSecureStorage.write(
            key: 'user', value: jsonEncode(user.toMap()));
        flutterSecureStorage.write(key: 'savedBarbers', value: jsonEncode([]));
        emit(UserLoaded(user: user));
      } else {
        emit(const UserError(message: "Login Failed"));
      }
    } catch (e) {
      emit(UserError(message: "Error during login : $e"));
    }
  }

  Future<bool> _updatePassword(String id, String newPassword) async {
    bool? isSuccess = await updatePassword.execute(id, newPassword);
    if (isSuccess == true) {
      return true;
    } else {
      return false;
    }
  }

  void onPasswordUpdateEvent(
      PasswordUpdateEvent event, Emitter<AuthenticationState> emit) async {
    emit(PasswordUpdating());
    try {
      bool isPasswordUpdated =
          await _updatePassword(event.id, event.newPassword);
      if (isPasswordUpdated) {
        const flutterSecureStorage = FlutterSecureStorage();
        var currentUser = await flutterSecureStorage.read(key: 'user');
        Map<String, dynamic> currentUserMap = jsonDecode(currentUser!);
        currentUserMap['password'] = event.newPassword;
        flutterSecureStorage.write(key: 'user', value: jsonEncode(currentUser));
        emit(PasswordUpdatedSuccessfully(
            user: UserEntity.fromJson(currentUserMap)));
      } else {
        emit(const PasswordNotUpdated(
            message: "Password is not updated. Please try again."));
      }
    } catch (e) {
      emit(PasswordUpdateError(message: "Error during password update : $e"));
    }
  }
}
