import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:workshop_flutter/main.dart';
import 'package:workshop_flutter/data/item.dart';
import 'package:workshop_flutter/data/item_repository.dart';
import '../mocks.dart';

void main() {
  testWidgets('Opacity and Style when checkbox is not checked',
      (WidgetTester tester) async {
    // Given
    final SemanticsHandle handle = tester.ensureSemantics();
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
    await tester
        .pumpWidget(MyApp(itemRepository: itemRepository));
    await tester.pumpAndSettle();

    // Then
    expect(
        tester
            .firstWidget<AnimatedOpacity>(find.byType(AnimatedOpacity))
            .opacity,
        1);
    expect(tester.firstWidget<Text>(find.byType(Text)).style.fontStyle,
        FontStyle.normal);

    expect(
        tester.getSemantics(find.byType(Checkbox).first),
        matchesSemantics(
            hasCheckedState: true,
            hasEnabledState: true,
            isEnabled: true,
            hasTapAction: true,
            isChecked: false));

    handle.dispose();
  });

  testWidgets('Opacity and Style when checkbox is checked',
      (WidgetTester tester) async {
    // Given
    final SemanticsHandle handle = tester.ensureSemantics();
    final Item item = Item(description: 'Item description', state: true);
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
    await tester
        .pumpWidget(MyApp(itemRepository: itemRepository));
    await tester.pumpAndSettle();

    // Then
    expect(
        tester
            .firstWidget<AnimatedOpacity>(find.byType(AnimatedOpacity))
            .opacity,
        0.5);
    expect(tester.firstWidget<Text>(find.byType(Text)).style.fontStyle,
        FontStyle.italic);

    expect(
        tester.getSemantics(find.byType(Checkbox).first),
        matchesSemantics(
            hasCheckedState: true,
            hasEnabledState: true,
            isEnabled: true,
            hasTapAction: true,
            isChecked: true));

    handle.dispose();
  });
}
