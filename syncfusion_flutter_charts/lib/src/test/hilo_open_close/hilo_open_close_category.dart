import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_test/flutter_test.dart';
import '../../../charts.dart';
import 'hilo_open_close_sample.dart';

/// Test method of category axis of the Hilo open-close series.
void hiloOpenCloseCategoryAxis() {
  // Define a test. The TestWidgets function will also provide a WidgetTester
  // for us to work with. The WidgetTester will allow us to build and interact
  // with Widgets in the test environment.

  // chart instance will get once pumpWidget is called
  SfCartesianChart? chart;

  group('HiloOpenClose Category - Defualt Properties', () {
    testWidgets('Category axis - Default', (WidgetTester tester) async {
      final _HiloOpenCloseCategory chartContainer =
          _hiloOpenCloseCategory('customization_default')
              as _HiloOpenCloseCategory;
      await tester.pumpWidget(chartContainer);
      chart = chartContainer.chart;
    });

// to test series count
    test('test series count', () {
      expect(chart!.series.length, 1);
    });

    testWidgets('Category axis - Default', (WidgetTester tester) async {
      final _HiloOpenCloseCategory chartContainer =
          _hiloOpenCloseCategory('category_axis') as _HiloOpenCloseCategory;
      await tester.pumpWidget(chartContainer);
      chart = chartContainer.chart;
    });

    test('test series count', () {
      expect(chart!.series.length, 1);
    });

    testWidgets('Category axis - Default', (WidgetTester tester) async {
      final _HiloOpenCloseCategory chartContainer =
          _hiloOpenCloseCategory('category_axis_fillcolor')
              as _HiloOpenCloseCategory;
      await tester.pumpWidget(chartContainer);
      chart = chartContainer.chart;
    });

    test('test series count', () {
      expect(chart!.series.length, 1);
    });

    testWidgets('Category axis - Default', (WidgetTester tester) async {
      final _HiloOpenCloseCategory chartContainer =
          _hiloOpenCloseCategory('category_axis_border')
              as _HiloOpenCloseCategory;
      await tester.pumpWidget(chartContainer);
      chart = chartContainer.chart;
    });

    test('test series count', () {
      expect(chart!.series.length, 1);
    });

    testWidgets('Category axis - Default', (WidgetTester tester) async {
      final _HiloOpenCloseCategory chartContainer =
          _hiloOpenCloseCategory('category_axis_datalabel')
              as _HiloOpenCloseCategory;
      await tester.pumpWidget(chartContainer);
      chart = chartContainer.chart;
    });

    test('test series count', () {
      expect(chart!.series.length, 1);
    });

    testWidgets('Category axis - Default', (WidgetTester tester) async {
      final _HiloOpenCloseCategory chartContainer =
          _hiloOpenCloseCategory('category_axis_negative_animation')
              as _HiloOpenCloseCategory;
      await tester.pumpWidget(chartContainer);
      chart = chartContainer.chart;
    });

    test('test series count', () {
      expect(chart!.series.length, 1);
    });

    testWidgets('Category axis - Default', (WidgetTester tester) async {
      final _HiloOpenCloseCategory chartContainer =
          _hiloOpenCloseCategory('category_axis_high_and_close_null_value')
              as _HiloOpenCloseCategory;
      await tester.pumpWidget(chartContainer);
      chart = chartContainer.chart;
    });

    test('test series count', () {
      expect(chart!.series.length, 1);
    });
    testWidgets('Category axis - Default', (WidgetTester tester) async {
      final _HiloOpenCloseCategory chartContainer =
          _hiloOpenCloseCategory('category_axis_transposed')
              as _HiloOpenCloseCategory;
      await tester.pumpWidget(chartContainer);
      chart = chartContainer.chart;
    });

    test('test series count', () {
      expect(chart!.series.length, 1);
    });
    testWidgets('Category axis - Default', (WidgetTester tester) async {
      final _HiloOpenCloseCategory chartContainer = _hiloOpenCloseCategory(
              'category_axis_negative_animation_with_transposed')
          as _HiloOpenCloseCategory;
      await tester.pumpWidget(chartContainer);
      chart = chartContainer.chart;
    });

    test('test series count', () {
      expect(chart!.series.length, 1);
    });
  });
}

StatelessWidget _hiloOpenCloseCategory(String sampleName) {
  return _HiloOpenCloseCategory(sampleName);
}

// ignore: must_be_immutable
class _HiloOpenCloseCategory extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  _HiloOpenCloseCategory(String sampleName) {
    chart = getHiloOpenCloseChart(sampleName);
  }
  SfCartesianChart? chart;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Test Chart Widget'),
          ),
          body: Center(
              child: Container(
            margin: EdgeInsets.zero,
            child: chart,
          ))),
    );
  }
}
