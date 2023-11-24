import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthNotAuthenticatedState extends AuthState {}

class AuthAuthenticatedState extends AuthState {}

class AuthFailureState extends AuthState {
  final String message;

  AuthFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthLoadingState extends AuthState {}
