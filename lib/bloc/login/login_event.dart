import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Login extends LoginEvent {
  final String email;
  final String senha;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Login({@required this.email, @required this.senha});
}

class Registrar extends LoginEvent {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final String email;
  final String senha;

  Registrar({@required this.email, @required this.senha});
}
