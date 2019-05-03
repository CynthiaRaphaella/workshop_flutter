// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:workshop_flutter/main.dart';
import 'package:workshop_flutter/data/item.dart';
import 'package:workshop_flutter/data/item_repository.dart';
import 'mocks.dart';

void main() {
  _createTodoItem(WidgetTester tester) async {
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'New item to be done');
    await tester.tap(find.byKey(Key('Add')));
    await tester.pumpAndSettle();
  }

  testWidgets('Todo is shown', (WidgetTester tester) async {
    // Given
    Item item = Item(description: 'Item description');
    final firestore = MockFirestore();
    final collection = MockCollectionReference();
    final existingDocument = MockDocumentSnapshot(item.toJson());
    final itemRepository = ItemRepository(firestore: firestore);
    final snapshot = MockQuerySnapshot();
    final snapshots = Stream.fromIterable([snapshot]);

    when(firestore.collection(ItemRepository.path)).thenReturn(collection);
    when(collection.snapshots()).thenAnswer((_) => snapshots);
    when(snapshot.documents).thenReturn([existingDocument]);
    when(existingDocument.documentID).thenReturn('qXmZomiaCQPR3cOLS67J');

    // When
    await tester.pumpWidget(MyApp(itemRepository: itemRepository));
    await tester.pumpAndSettle();

    // Verify that the TodoItem is shown
    expect(find.text('Item description'), findsWidgets);
    verify(collection.snapshots());
    verify(snapshot.documents);
    verify(existingDocument.documentID);
  });

  testWidgets('Todo is only added when has a confirmation',
      (WidgetTester tester) async {
    // Given
    final firestore = MockFirestore();
    final collection = MockCollectionReference();
    final newDocument = MockDocumentReference();
    final itemRepository = ItemRepository(firestore: firestore);
    final snapshot = MockQuerySnapshot();
    final snapshots = Stream.fromIterable([snapshot]);
    when(firestore.collection(ItemRepository.path)).thenReturn(collection);
    when(collection.document()).thenReturn(newDocument);
    when(collection.snapshots()).thenAnswer((_) => snapshots);
    when(snapshot.documents).thenReturn([]);
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(itemRepository: itemRepository));

    // When
    await _createTodoItem(tester);

    // Verify that the TodoItem was created
    verify(collection.document());
    verify(newDocument
        .setData({'description': 'New item to be done', 'state': false}));
  });
}
