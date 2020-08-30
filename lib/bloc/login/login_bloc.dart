import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../repository/dataRepository.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final DataRepository repository;
  LoginBloc(this.repository) : super(LoginInitial());

  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is Login) {
      yield LoginLoading();
      try {

        FirebaseUser user = (await event.auth.signInWithEmailAndPassword(
                email: event.email, password: event.senha))
            .user;
        yield LoginLoaded(user: user);
      } catch (e) {
        yield LoginError(e: e);
      }
    } else if (event is Registrar) {
      yield LoginLoading();
      try {

        final FirebaseUser user =
            (await event.auth.createUserWithEmailAndPassword(
          email: event.email,
          password: event.senha,
        ))
                .user;
        yield LoginLoaded(user: user);
      } catch (e) {
        yield LoginError(e: e);
      }
    }
  }
}
