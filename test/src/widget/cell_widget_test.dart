import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../helper/pluto_widget_test_helper.dart';
import '../../matcher/pluto_object_matcher.dart';
import '../../mock/mock_pluto_event_manager.dart';
import '../../mock/mock_pluto_state_manager.dart';

void main() {
  PlutoStateManager stateManager;
  PlutoEventManager eventManager;

  setUp(() {
    stateManager = MockPlutoStateManager();
    eventManager = MockPlutoEventManager();
    when(stateManager.eventManager).thenReturn(eventManager);
    when(stateManager.configuration).thenReturn(PlutoConfiguration());
    when(stateManager.localeText).thenReturn(const PlutoGridLocaleText());
    when(stateManager.gridFocusNode).thenReturn(FocusNode());
    when(stateManager.keepFocus).thenReturn(true);
    when(stateManager.hasFocus).thenReturn(true);
  });

  testWidgets(
      'WHEN If it is not CurrentCell or not in Editing state'
      'THEN Text widget should be rendered', (WidgetTester tester) async {
    // given
    final PlutoCell cell = PlutoCell(value: 'cell value');

    final PlutoColumn column = PlutoColumn(
      title: 'header',
      field: 'header',
      type: PlutoColumnType.text(),
    );

    final rowIdx = 0;

    // when
    when(stateManager.isCurrentCell(any)).thenReturn(false);
    when(stateManager.isSelectedCell(any, any, any)).thenReturn(false);
    when(stateManager.isEditing).thenReturn(false);

    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: CellWidget(
            stateManager: stateManager,
            cell: cell,
            column: column,
            rowIdx: rowIdx,
          ),
        ),
      ),
    );

    // then
    expect(find.text('cell value'), findsOneWidget);
    expect(find.byType(SelectCellWidget), findsNothing);
    expect(find.byType(NumberCellWidget), findsNothing);
    expect(find.byType(DateCellWidget), findsNothing);
    expect(find.byType(TimeCellWidget), findsNothing);
    expect(find.byType(TextCellWidget), findsNothing);
  });

  testWidgets(
      'WHEN If it is CurrentCell and not in Editing state'
      'THEN Text widget should be rendered', (WidgetTester tester) async {
    // given
    final PlutoCell cell = PlutoCell(value: 'cell value');

    final PlutoColumn column = PlutoColumn(
      title: 'header',
      field: 'header',
      type: PlutoColumnType.text(),
    );

    final rowIdx = 0;

    // when
    when(stateManager.isCurrentCell(any)).thenReturn(true);
    when(stateManager.isEditing).thenReturn(false);

    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: CellWidget(
            stateManager: stateManager,
            cell: cell,
            column: column,
            rowIdx: rowIdx,
          ),
        ),
      ),
    );

    // then
    expect(find.text('cell value'), findsOneWidget);
    expect(find.byType(SelectCellWidget), findsNothing);
    expect(find.byType(NumberCellWidget), findsNothing);
    expect(find.byType(DateCellWidget), findsNothing);
    expect(find.byType(TimeCellWidget), findsNothing);
    expect(find.byType(TextCellWidget), findsNothing);
  });

  testWidgets(
      'WHEN If it is CurrentCell and in Editing state'
      'THEN [TextCellWidget] should be rendered', (WidgetTester tester) async {
    // given
    final PlutoCell cell = PlutoCell(value: 'cell value');

    final PlutoColumn column = PlutoColumn(
      title: 'header',
      field: 'header',
      type: PlutoColumnType.text(),
    );

    final rowIdx = 0;

    // when
    when(stateManager.isCurrentCell(any)).thenReturn(true);
    when(stateManager.isEditing).thenReturn(true);

    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: CellWidget(
            stateManager: stateManager,
            cell: cell,
            column: column,
            rowIdx: rowIdx,
          ),
        ),
      ),
    );

    // then
    expect(find.text('cell value'), findsOneWidget);
    expect(find.byType(SelectCellWidget), findsNothing);
    expect(find.byType(NumberCellWidget), findsNothing);
    expect(find.byType(DateCellWidget), findsNothing);
    expect(find.byType(TimeCellWidget), findsNothing);
    expect(find.byType(TextCellWidget), findsOneWidget);
  });

  testWidgets(
      'WHEN If it is CurrentCell and in Editing state'
      'THEN [TimeCellWidget] should be rendered', (WidgetTester tester) async {
    // given
    final PlutoCell cell = PlutoCell(value: '00:00');

    final PlutoColumn column = PlutoColumn(
      title: 'header',
      field: 'header',
      type: PlutoColumnType.time(),
    );

    final rowIdx = 0;

    // when
    when(stateManager.isCurrentCell(any)).thenReturn(true);
    when(stateManager.isEditing).thenReturn(true);

    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: CellWidget(
            stateManager: stateManager,
            cell: cell,
            column: column,
            rowIdx: rowIdx,
          ),
        ),
      ),
    );

    // then
    expect(find.text('00:00'), findsOneWidget);
    expect(find.byType(SelectCellWidget), findsNothing);
    expect(find.byType(NumberCellWidget), findsNothing);
    expect(find.byType(DateCellWidget), findsNothing);
    expect(find.byType(TimeCellWidget), findsOneWidget);
    expect(find.byType(TextCellWidget), findsNothing);
  });

  testWidgets(
      'WHEN If it is CurrentCell and in Editing state'
      'THEN [DateCellWidget] should be rendered', (WidgetTester tester) async {
    // given
    final PlutoCell cell = PlutoCell(value: '2020-01-01');

    final PlutoColumn column = PlutoColumn(
      title: 'header',
      field: 'header',
      type: PlutoColumnType.date(),
    );

    final rowIdx = 0;

    // when
    when(stateManager.isCurrentCell(any)).thenReturn(true);
    when(stateManager.isEditing).thenReturn(true);

    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: CellWidget(
            stateManager: stateManager,
            cell: cell,
            column: column,
            rowIdx: rowIdx,
          ),
        ),
      ),
    );

    // then
    expect(find.text('2020-01-01'), findsOneWidget);
    expect(find.byType(SelectCellWidget), findsNothing);
    expect(find.byType(NumberCellWidget), findsNothing);
    expect(find.byType(DateCellWidget), findsOneWidget);
    expect(find.byType(TimeCellWidget), findsNothing);
    expect(find.byType(TextCellWidget), findsNothing);
  });

  testWidgets(
      'WHEN If it is CurrentCell and in Editing state'
      'THEN [NumberCellWidget] should be rendered',
      (WidgetTester tester) async {
    // given
    final PlutoCell cell = PlutoCell(value: 1234);

    final PlutoColumn column = PlutoColumn(
      title: 'header',
      field: 'header',
      type: PlutoColumnType.number(),
    );

    final rowIdx = 0;

    // when
    when(stateManager.isCurrentCell(any)).thenReturn(true);
    when(stateManager.isEditing).thenReturn(true);

    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: CellWidget(
            stateManager: stateManager,
            cell: cell,
            column: column,
            rowIdx: rowIdx,
          ),
        ),
      ),
    );

    // then
    expect(find.text('1234'), findsOneWidget);
    expect(find.byType(SelectCellWidget), findsNothing);
    expect(find.byType(NumberCellWidget), findsOneWidget);
    expect(find.byType(DateCellWidget), findsNothing);
    expect(find.byType(TimeCellWidget), findsNothing);
    expect(find.byType(TextCellWidget), findsNothing);
  });

  testWidgets(
      'WHEN If it is CurrentCell and in Editing state'
      'THEN [SelectCellWidget] should be rendered',
      (WidgetTester tester) async {
    // given
    final PlutoCell cell = PlutoCell(value: 'one');

    final PlutoColumn column = PlutoColumn(
      title: 'header',
      field: 'header',
      type: PlutoColumnType.select(['one', 'two', 'three']),
    );

    final rowIdx = 0;

    // when
    when(stateManager.isCurrentCell(any)).thenReturn(true);
    when(stateManager.isEditing).thenReturn(true);

    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: CellWidget(
            stateManager: stateManager,
            cell: cell,
            column: column,
            rowIdx: rowIdx,
          ),
        ),
      ),
    );

    // then
    expect(find.text('one'), findsOneWidget);
    expect(find.byType(SelectCellWidget), findsOneWidget);
    expect(find.byType(NumberCellWidget), findsNothing);
    expect(find.byType(DateCellWidget), findsNothing);
    expect(find.byType(TimeCellWidget), findsNothing);
    expect(find.byType(TextCellWidget), findsNothing);
  });

  testWidgets(
      'WHEN If there is no type'
      'THEN An exception should be thrown.', (WidgetTester tester) async {
    // given
    final PlutoCell cell = PlutoCell(value: 'one');

    final PlutoColumn column = PlutoColumn(
      title: 'header',
      field: 'header',
      type: null,
    );

    final rowIdx = 0;

    // when
    when(stateManager.isCurrentCell(any)).thenReturn(true);
    when(stateManager.isEditing).thenReturn(true);

    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: CellWidget(
            stateManager: stateManager,
            cell: cell,
            column: column,
            rowIdx: rowIdx,
          ),
        ),
      ),
    );

    // then
    expect(tester.takeException(), isInstanceOf<Error>());
  });

  testWidgets(
    '셀을 탭하면 PlutoCellGestureEvent 이벤트가 OnTapUp 으로 호출 되어야 한다.',
    (WidgetTester tester) async {
      // given
      final PlutoCell cell = PlutoCell(value: 'one');

      final PlutoColumn column = PlutoColumn(
        title: 'header',
        field: 'header',
        type: PlutoColumnType.text(),
      );

      final rowIdx = 0;

      // when
      when(stateManager.isCurrentCell(any)).thenReturn(false);
      when(stateManager.isEditing).thenReturn(false);
      when(stateManager.isSelectedCell(any, any, any)).thenReturn(false);

      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: CellWidget(
              stateManager: stateManager,
              cell: cell,
              column: column,
              rowIdx: rowIdx,
            ),
          ),
        ),
      );

      Finder gesture = find.byType(GestureDetector);

      await tester.tap(gesture);

      verify(eventManager.addEvent(
        argThat(PlutoObjectMatcher<PlutoCellGestureEvent>(rule: (object) {
          return object.gestureType.isOnTapUp &&
              object.cell.key == cell.key &&
              object.column.key == column.key &&
              object.rowIdx == rowIdx;
        })),
      )).called(1);
    },
  );

  testWidgets(
    '셀을 길게 탭하면 PlutoCellGestureEvent 이벤트가 OnLongPressStart 으로 호출 되어야 한다.',
    (WidgetTester tester) async {
      // given
      final PlutoCell cell = PlutoCell(value: 'one');

      final PlutoColumn column = PlutoColumn(
        title: 'header',
        field: 'header',
        type: PlutoColumnType.text(),
      );

      final rowIdx = 0;

      // when
      when(stateManager.isCurrentCell(any)).thenReturn(false);
      when(stateManager.isEditing).thenReturn(false);
      when(stateManager.isSelectedCell(any, any, any)).thenReturn(false);

      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: CellWidget(
              stateManager: stateManager,
              cell: cell,
              column: column,
              rowIdx: rowIdx,
            ),
          ),
        ),
      );

      Finder gesture = find.byType(GestureDetector);

      await tester.longPress(gesture);

      verify(eventManager.addEvent(
        argThat(PlutoObjectMatcher<PlutoCellGestureEvent>(rule: (object) {
          return object.gestureType.isOnLongPressStart &&
              object.cell.key == cell.key &&
              object.column.key == column.key &&
              object.rowIdx == rowIdx;
        })),
      )).called(1);
    },
  );

  testWidgets(
    '셀을 길게 탭하고 이동하면 PlutoCellGestureEvent 이벤트가 '
    'onLongPressMoveUpdate 으로 호출 되어야 한다.',
    (WidgetTester tester) async {
      // given
      final PlutoCell cell = PlutoCell(value: 'one');

      final PlutoColumn column = PlutoColumn(
        title: 'header',
        field: 'header',
        type: PlutoColumnType.text(),
      );

      final rowIdx = 0;

      when(stateManager.isCurrentCell(any)).thenReturn(true);
      when(stateManager.isEditing).thenReturn(false);
      when(stateManager.selectingMode).thenReturn(PlutoSelectingMode.row);

      when(stateManager.isSelectingInteraction()).thenReturn(false);
      when(stateManager.needMovingScroll(any, any)).thenReturn(false);

      // when
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: CellWidget(
              stateManager: stateManager,
              cell: cell,
              column: column,
              rowIdx: rowIdx,
            ),
          ),
        ),
      );

      // then
      final TestGesture gesture =
          await tester.startGesture(const Offset(100, 18));

      await tester.pump(const Duration(milliseconds: 500));

      await gesture.moveBy(const Offset(50, 0));

      await gesture.up();

      await tester.pump();

      await tester.pumpAndSettle(const Duration(milliseconds: 800));

      verify(eventManager.addEvent(
        argThat(PlutoObjectMatcher<PlutoCellGestureEvent>(rule: (object) {
          return object.gestureType.isOnLongPressMoveUpdate &&
              object.cell.key == cell.key &&
              object.column.key == column.key &&
              object.rowIdx == rowIdx;
        })),
      )).called(1);
    },
  );

  group('configuration', () {
    PlutoCell cell;

    PlutoColumn column;

    int rowIdx;

    final aCellWithConfiguration = (
      PlutoConfiguration configuration, {
      bool isCurrentCell = true,
      bool isSelectedCell = false,
      bool readOnly = false,
    }) {
      return PlutoWidgetTestHelper('a cell.', (tester) async {
        when(stateManager.isCurrentCell(any)).thenReturn(isCurrentCell);
        when(stateManager.isSelectedCell(any, any, any))
            .thenReturn(isSelectedCell);
        when(stateManager.hasFocus).thenReturn(true);
        when(stateManager.isEditing).thenReturn(true);

        cell = PlutoCell(value: 'one');

        column = PlutoColumn(
          title: 'header',
          field: 'header',
          type: PlutoColumnType.text(
            readOnly: readOnly,
          ),
        );

        rowIdx = 0;

        when(stateManager.configuration).thenReturn(configuration);

        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: CellWidget(
                stateManager: stateManager,
                cell: cell,
                column: column,
                rowIdx: rowIdx,
              ),
            ),
          ),
        );

        await tester.pumpAndSettle(const Duration(seconds: 1));
      });
    };

    aCellWithConfiguration(
      PlutoConfiguration(
        enableColumnBorder: false,
        borderColor: Colors.deepOrange,
      ),
      readOnly: true,
    ).test(
      'if readOnly is true, should be set the color to cellColorInReadOnlyState.',
      (tester) async {
        expect(column.type.readOnly, true);

        final target = find.descendant(
          of: find.byType(GestureDetector),
          matching: find.byType(Container),
        );

        final container = target.evaluate().first.widget as Container;

        final BoxDecoration decoration = container.decoration;

        final Color color = decoration.color;

        expect(color, stateManager.configuration.cellColorInReadOnlyState);
      },
    );

    aCellWithConfiguration(
      PlutoConfiguration(
        enableColumnBorder: true,
        borderColor: Colors.deepOrange,
      ),
      isCurrentCell: false,
      isSelectedCell: false,
    ).test(
      'if isCurrentCell, isSelectedCell are false '
      'and enableColumnBorder is true, '
      'should be set the border.',
      (tester) async {
        final target = find.descendant(
          of: find.byType(GestureDetector),
          matching: find.byType(Container),
        );

        final container = target.evaluate().first.widget as Container;

        final BoxDecoration decoration = container.decoration;

        final Border border = decoration.border;

        expect(border.right.color, stateManager.configuration.borderColor);
      },
    );

    aCellWithConfiguration(
      PlutoConfiguration(
        enableColumnBorder: false,
        borderColor: Colors.deepOrange,
      ),
      isCurrentCell: false,
      isSelectedCell: false,
    ).test(
      'if isCurrentCell, isSelectedCell are false '
      'and enableColumnBorder is false, '
      'should not be set the border.',
      (tester) async {
        final target = find.descendant(
          of: find.byType(GestureDetector),
          matching: find.byType(Container),
        );

        final container = target.evaluate().first.widget as Container;

        final BoxDecoration decoration = container.decoration;

        final Border border = decoration.border;

        expect(border, isNull);
      },
    );
  });
}
