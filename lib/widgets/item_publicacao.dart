import 'package:flutter/material.dart';
import 'package:trainee/repository/dataRepository.dart';

import '../models/publicacao.dart';

class ItemPublicacao extends StatelessWidget {
  final DataRepository repository = DataRepository();
  Publicacao publicacao;
  ItemPublicacao(this.publicacao);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding:
              const EdgeInsets.only(top: 14.0, bottom: 8, left: 8, right: 8),
          child: Text(
            publicacao.titulo,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          height: 500,
          width: double.infinity,
          child: FittedBox(
            child: Image.network(publicacao.url),
            fit: BoxFit.cover,
          ),
        ),
        Row(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
              child: IconButton(
                onPressed: () {
                  publicacao.likes = publicacao.likes + 1;
                  repository.updatePublicacao(publicacao);
                },
                icon: Icon(
                  Icons.favorite,
                  color: Colors.pink,
                ),
              ),
            ),
            Text(publicacao.likes.toString())
          ],
        )
      ],
    );
  }
}
