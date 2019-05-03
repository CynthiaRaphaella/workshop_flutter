import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'screens/home.dart';
import 'data/item_repository.dart';

Future<void> main() async {
//  final FirebaseApp app = await FirebaseApp.configure(
//    name: 'test',
//    options: const FirebaseOptions(
//      googleAppID: '1:79601577497:ios:5f2bcc6ba8cecddd',
//      gcmSenderID: '79601577497',
//      apiKey: 'AIzaSyArgmRGfB5kiQT6CunAOmKRVKEsxKmy6YI-G72PVU',
//      projectID: 'flutter-firestore',
//    ),
//  );
  final FirebaseApp app = FirebaseApp.instance;
  final Firestore firestore = Firestore(app: app);
  await firestore.settings(timestampsInSnapshotsEnabled: true);

  final ItemRepository itemRepository = ItemRepository(firestore: firestore);

  runApp(MyApp(itemRepository: itemRepository));
}

class MyApp extends StatelessWidget {
  final ItemRepository itemRepository;

  MyApp({this.itemRepository});

  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'To do app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(itemRepository: itemRepository));
}
