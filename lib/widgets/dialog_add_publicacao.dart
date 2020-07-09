import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trainee/models/publicacao.dart';

import '../repository/dataRepository.dart';

class AddPublicacaoDialog extends StatefulWidget {
  @override
  _AddPublicacaoDialogState createState() => _AddPublicacaoDialogState();
}

class _AddPublicacaoDialogState extends State<AddPublicacaoDialog> {
  var _formKey = GlobalKey<FormState>();
  String _titulo;
  String _url;
  final DataRepository repository = DataRepository();

  _submit() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        var _publicacao = Publicacao(url: _url, titulo: _titulo, likes: 0);
        repository.addPublicacao(_publicacao);
        Navigator.of(context).pop(true);
      } catch (e) {
        print(e.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Form(
        key: _formKey,
        child: Container(
          height: 320,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  top: 30.0,
                ),
                child: Center(
                  child: Text(
                    'Adicionar Publicação',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 10,
                ),
                child: TextFormField(
                  validator: (input) =>
                      (input.length > 1 && input.trim().length > 1)
                          ? null
                          : 'Por favor insira um titulo válido',
                  decoration: InputDecoration(labelText: 'Título'),
                  onSaved: (input) => _titulo = input,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 10,
                ),
                child: TextFormField(
                  cursorColor: Colors.pink,
                  validator: (input) =>
                      input.length <= 0 ? 'Url inválida' : null,
                  decoration: InputDecoration(labelText: 'Url'),
                  onSaved: (input) => _url = input,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: 250,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.pink, Colors.pink[300], Colors.amber]),
                ),
                child: FlatButton(
                  //color: Colors.pink,
                  onPressed: _submit,
                  child: Text(
                    'Publicar',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
