import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  final String email;
  final String password;

  const AuthEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class AuthLoginEvent extends AuthEvent {
  const AuthLoginEvent(super.email, super.password);
}

class AuthSignUpEvent extends AuthEvent {
  const AuthSignUpEvent(super.email, super.password);
}
