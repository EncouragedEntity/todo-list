import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthLoggingEvent extends AuthEvent {
  final String email;
  final String password;

  const AuthLoggingEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class AuthLoginEvent extends AuthLoggingEvent {
  const AuthLoginEvent(super.email, super.password);
}

class AuthSignUpEvent extends AuthLoggingEvent {
  const AuthSignUpEvent(super.email, super.password);
}

class AuthLogoutEvent extends AuthEvent {}
