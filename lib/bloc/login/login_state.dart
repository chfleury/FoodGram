import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginLoaded extends LoginState {
  final FirebaseUser user;

  LoginLoaded({this.user});
}

class LoginError extends LoginState {
  final Exception e;

  LoginError({@required this.e}) : assert(e != null);
}
