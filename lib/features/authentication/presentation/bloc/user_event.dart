part of 'user_bloc.dart';


abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class SignInEvent extends AuthenticationEvent {
  final String email;
  final String password;

  SignInEvent(
      {required this.email,
        required this.password});
}

class PasswordUpdateEvent extends AuthenticationEvent {
  final String id;
  final String newPassword;

  PasswordUpdateEvent({required this.id, required this.newPassword});
}
