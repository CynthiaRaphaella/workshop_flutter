import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'item.dart';

class ItemRepository {
  static const String path = 'andre';

  final Firestore firestore;

  const ItemRepository({this.firestore});

  Future<void> create(Item item) =>
      firestore.collection(path).document().setData(item.toJson());

  Stream<List<Item>> read() => firestore
      .collection(path)
      .snapshots()
      .map((snapshot) => snapshot.documents
          .map((doc) => Item(
                id: doc.documentID,
                description: doc['description'],
                state: doc['state'],
              ))
          .toList());

  Future<void> update(Item item) =>
      firestore.collection(path).document(item.id).updateData(item.toJson());

  Future<void> delete(Item item) => Future.value(null);
}
