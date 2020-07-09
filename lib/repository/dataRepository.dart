import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/publicacao.dart';

class DataRepository {
  final CollectionReference collection =
      Firestore.instance.collection('publicacoes');

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Future<DocumentReference> addPublicacao(Publicacao publicacao) {
    return collection.add(publicacao.toJson(publicacao));
  }

  updatePublicacao(Publicacao publicacao) async {
    print(publicacao.id);
    await collection
        .document(publicacao.id)
        .updateData(publicacao.toJson(publicacao));
  }
}
