import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trainee/widgets/gradient_button.dart';

import '../bloc/login/login.dart';
import '../repository/dataRepository.dart';
import './home_screen.dart';
import './register_screen.dart';

class LoginScreen extends StatefulWidget {
  static final String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final DataRepository repository = DataRepository();

  final _formKey = GlobalKey<FormState>();
  String _email;
  String _senha;

  LoginBloc _loginBloc;

  _submit() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _loginBloc.add(Login(email: _email, senha: _senha));
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
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'Foodgram',
          style: TextStyle(fontFamily: 'SIMPLIFICA Typeface', fontSize: 50),
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
                  validator: (input) => (input.length > 5 &&
                          input.trim().length > 0 &&
                          input.contains('@'))
                      ? null
                      : 'Por favor insira um email válido',
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
                listener: (context, state) {
                  if (state is LoginLoaded) {
                    Navigator.of(context).pushReplacementNamed(HomeScreen.id);
                  } else if (state is LoginError) {
                    
                    print('Usuario ou senha invalidos');
                  }
                },
                child: BlocBuilder<LoginBloc, LoginState>(
                    bloc: _loginBloc,
                    builder: (context, state) {
                      if (state is LoginLoading) {
                        return Center(
                          child: LinearProgressIndicator(),
                        );
                      }
                      return GradientButton(label: 'Entrar', onPressed: _submit);
                    }),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Ainda não possui uma conta?'),
                  _buildRegisterButton(),
                ],
              ),
            ],
            mainAxisSize: MainAxisSize.min,
          ),
        )
      ],
    )));
  }

  _buildRegisterButton() {
    return Builder(builder: (context) {
      return FlatButton(
        onPressed: () async {
          var response =
              await Navigator.of(context).pushNamed(RegisterScreen.id);
          if (response) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
                'Conta criada com Sucesso',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              backgroundColor: Colors.green,
            ));
          }
        },
        child: Text(
          'Registre-se',
          style: TextStyle(
            color: Colors.pink,
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _loginBloc.close();
    super.dispose();
  }
}
