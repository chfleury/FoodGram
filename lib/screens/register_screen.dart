import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainee/widgets/gradient_button.dart';

import '../bloc/login/login.dart';
import '../repository/dataRepository.dart';

class RegisterScreen extends StatefulWidget {
  static final String id = 'register_screen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DataRepository repository = DataRepository();
  String _email;
  String _senha;
  LoginBloc _loginBloc;
  _submit() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _loginBloc.add(Registrar(email: _email, senha: _senha));
    }
  }

  @override
  void initState() {
    _loginBloc = LoginBloc(repository);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 32),
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.of(context).pop()),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Criar Conta',
                  style: TextStyle(
                      fontFamily: 'SIMPLIFICA Typeface', fontSize: 50),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 10,
                        ),
                        child: TextFormField(
                          validator: (input) =>
                              (input.length <= 2 || input.trim().isEmpty)
                                  ? 'Por favor insira um email válido'
                                  : null,
                          decoration: InputDecoration(labelText: 'E-mail'),
                          onSaved: (input) => _email = input,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 10,
                        ),
                        child: TextFormField(
                          cursorColor: Colors.pink,
                          obscureText: true,
                          validator: (input) => input.length < 6
                              ? 'A senha deve conter pelo menos 6 caracteres'
                              : null,
                          decoration: InputDecoration(labelText: 'Senha'),
                          onSaved: (input) => _senha = input,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      BlocListener<LoginBloc, LoginState>(
                        bloc: _loginBloc,
                        child: BlocBuilder<LoginBloc, LoginState>(
                            bloc: _loginBloc,
                            builder: (context, state) {
                              if (state is LoginLoading) {
                                return Center(
                                  child: LinearProgressIndicator(),
                                );
                              }
                              return GradientButton(
                                  label: 'Registrar', onPressed: _submit);
                              
                            }),
                        listener: (context, state) {
                          if (state is LoginLoaded) {
                            Navigator.of(context).pop(true);
                          } else if (state is LoginError) {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text('Erro'),
                              backgroundColor: Colors.red,
                            ));
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                    mainAxisSize: MainAxisSize.min,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _loginBloc.close();
    super.dispose();
  }
}
