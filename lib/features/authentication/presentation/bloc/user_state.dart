part of 'user_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class UserLoading extends AuthenticationState {}

class UserLoaded extends AuthenticationState {
  final UserEntity user;

  const UserLoaded({required this.user});
}

class UserLoggedIn extends AuthenticationState {
  final UserEntity user;

  const UserLoggedIn({required this.user});
}

class UserError extends AuthenticationState {
  final String message;

  const UserError({required this.message});
}

class PasswordUpdating extends AuthenticationState {}

class PasswordUpdatedSuccessfully extends AuthenticationState {
  final UserEntity user;

  const PasswordUpdatedSuccessfully({required this.user});
}

class PasswordNotUpdated extends AuthenticationState {
  final String message;

  const PasswordNotUpdated({required this.message});
}

class PasswordUpdateError extends AuthenticationState {
  final String message;

  const PasswordUpdateError({required this.message});
}
