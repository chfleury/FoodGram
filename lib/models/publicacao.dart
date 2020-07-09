import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Publicacao {
  final String url;
  int likes;
  final String titulo;
  String id = '';

  Publicacao(
      {@required this.url,
      @required this.titulo,
      @required this.likes,
      this.id});

  static Publicacao fromJson(dynamic json) {
    return Publicacao(
      url: json['url'],
      titulo: json['titulo'],
      likes: json['likes'],
    );
  }

  factory Publicacao.fromSnapshot(DocumentSnapshot snapshot) {
    Publicacao novaPublicacao = Publicacao.fromJson(snapshot.data);
    novaPublicacao.id = snapshot.documentID;

    return novaPublicacao;
  }

  toJson(Publicacao publicacao) {
    return {
      'url': publicacao.url,
      'likes': publicacao.likes,
      'titulo': publicacao.titulo,
    };
  }
}
