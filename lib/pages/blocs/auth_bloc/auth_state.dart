part of 'auth_bloc.dart';

@immutable
sealed class AuthStates {}

final class AuthInitial extends AuthStates {}


class LoginInitialState extends AuthStates {}

class LoginLoadingState extends AuthStates {}

class LoginSuccessState extends AuthStates {}

class LoginFailureState extends AuthStates
{
  String? errorMessage;
  LoginFailureState({this.errorMessage});
}


class RegisterInitialState extends AuthStates {}

class RegisterLoadingState extends AuthStates {}

class RegisterSuccessState extends AuthStates {}

class RegisterFailureState extends AuthStates
{
  String? errorMessage;
  RegisterFailureState({this.errorMessage});
}
