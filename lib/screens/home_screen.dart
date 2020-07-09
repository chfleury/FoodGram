import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../repository/dataRepository.dart';
import '../widgets/dialog_add_publicacao.dart';
import '../widgets/item_publicacao.dart';
import '../models/publicacao.dart';

class HomeScreen extends StatefulWidget {
  static final String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DataRepository repository = DataRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Builder(builder: (context) {
        return FloatingActionButton(
            onPressed: () async {
              var response = await showDialog(
                  context: context, child: AddPublicacaoDialog());
              if (response) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(
                    'Publicação criada com Sucesso',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  backgroundColor: Colors.green,
                ));
              }
            },
            child: Icon(Icons.add, color: Colors.white));
      }),
      appBar: AppBar(
        title: Text(
          'Feed de Publicações',
          style: TextStyle(
              fontFamily: 'SIMPLIFICA Typeface',
              fontSize: 36,
              fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: Colors.pink,
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return StreamBuilder<QuerySnapshot>(
        stream: repository.getStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          return _buildListView(snapshot.data.documents);
        });
  }

  ListView _buildListView(listaPublicacao) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ItemPublicacao(
          Publicacao.fromSnapshot(listaPublicacao[index]),
        );
      },
      itemCount: listaPublicacao.length,
    );
  }
}
