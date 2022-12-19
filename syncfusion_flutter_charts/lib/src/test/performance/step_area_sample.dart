import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_test/flutter_test.dart';
import '../../../charts.dart';
import 'step_area_series.dart';

/// Test method of the step area series performance.
void stepareaPerformance() {
  SfCartesianChart? chart;
  // _SfCartesianChartState _chartState;
  group('Steparea - default performance', () {
    testWidgets('Steparea - Default - 10K', (WidgetTester tester) async {
      final _StepareaPerformance chartContainer =
          _stepareaPerformance('default_steparea', 10000)
              as _StepareaPerformance;
      await tester.pumpWidget(chartContainer);
      chart = chartContainer.chart;
      // final GlobalKey key = chart.key;
      // _chartState = key.currentState;
    });
    // to test series data count
    test('to test series data length', () {
      expect(chart!.series[0].dataSource!.length, 10000);
    });
    //Commented the below test case, since removed _renderDuration property from
    // chart_base.dart file. Need to check for another possibilities.
    // // to test series render duration
    // test('to test render duration', () {
    //   expect(_chartState._renderDuration.inMilliseconds < 1500, true);
    // });

    testWidgets('Steparea - Default - 10K', (WidgetTester tester) async {
      final _StepareaPerformance chartContainer =
          _stepareaPerformance('default_steparea', 50000)
              as _StepareaPerformance;
      await tester.pumpWidget(chartContainer);
      chart = chartContainer.chart;
      // final GlobalKey key = chart.key;
      // _chartState = key.currentState;
    });
    // to test series data count
    test('to test series data length', () {
      expect(chart!.series[0].dataSource!.length, 50000);
    });
    //Commented the below test case, since removed _renderDuration property from
    // chart_base.dart file. Need to check for another possibilities.
    // //to test series render duration
    // test('to test render duration', () {
    //   expect(_chartState._renderDuration.inMilliseconds < 1900, true);
    // });

    testWidgets('Steparea - Default - 1L', (WidgetTester tester) async {
      final _StepareaPerformance chartContainer =
          _stepareaPerformance('default_steparea', 100000)
              as _StepareaPerformance;
      await tester.pumpWidget(chartContainer);
      chart = chartContainer.chart;
      // final GlobalKey key = chart.key;
      // _chartState = key.currentState;
    });
    // // to test series data count
    test('to test series data length', () {
      expect(chart!.series[0].dataSource!.length, 100000);
    });
    //Commented the below test case, since removed _renderDuration property from
    // chart_base.dart file. Need to check for another possibilities.
    // // to test series render duration
    // test('to test render duration', () {
    //   expect(_chartState._renderDuration.inMilliseconds < 2800, true);
    // });

    testWidgets('Steparea - Default - 2L', (WidgetTester tester) async {
      final _StepareaPerformance chartContainer =
          _stepareaPerformance('default_steparea', 200000)
              as _StepareaPerformance;
      await tester.pumpWidget(chartContainer);
      chart = chartContainer.chart;
      // final GlobalKey key = chart.key;
      // _chartState = key.currentState;
    });
    // to test series data count
    test('to test series data length', () {
      expect(chart!.series[0].dataSource!.length, 200000);
    });
    //Commented the below test case, since removed _renderDuration property from
    // chart_base.dart file. Need to check for another possibilities.
    // // to test series render duration
    // test('to test render duration', () {
    //   expect(_chartState._renderDuration.inMilliseconds < 4900, true);
    // });
  });

  group('Steparea- with marker performance', () {
    testWidgets('Line - with marker - 10K', (WidgetTester tester) async {
      final _StepareaPerformance chartContainer =
          _stepareaPerformance('Steparea_with_marker', 10000)
              as _StepareaPerformance;
      await tester.pumpWidget(chartContainer);
      chart = chartContainer.chart;
      // final GlobalKey key = chart.key;
      // _chartState = key.currentState;
    });
    //   // to test series data count
    test('to test series data length', () {
      expect(chart!.series[0].dataSource!.length, 10000);
    });
    //Commented the below test case, since removed _renderDuration property from
    // chart_base.dart file. Need to check for another possibilities.
    // //   // to test series render duration
    // test('to test render duration', () {
    //   expect(_chartState._renderDuration.inMilliseconds < 1500, true);
    // });

    testWidgets('Steparea - with marker - 50K', (WidgetTester tester) async {
      final _StepareaPerformance chartContainer =
          _stepareaPerformance('Steparea_with_marker', 50000)
              as _StepareaPerformance;
      await tester.pumpWidget(chartContainer);
      chart = chartContainer.chart;
      // final GlobalKey key = chart.key;
      // _chartState = key.currentState;
    });
    //   // to test series data count
    test('to test series data length', () {
      expect(chart!.series[0].dataSource!.length, 50000);
    });
    //Commented the below test case, since removed _renderDuration property from
    // chart_base.dart file. Need to check for another possibilities.
    // //   // to test series render duration
    // test('to test render duration', () {
    //   expect(_chartState._renderDuration.inMilliseconds < 1900, true);
    // });

    testWidgets('Steparea - with marker - 1L', (WidgetTester tester) async {
      final _StepareaPerformance chartContainer =
          _stepareaPerformance('Steparea_with_marker', 100000)
              as _StepareaPerformance;
      await tester.pumpWidget(chartContainer);
      chart = chartContainer.chart;
      // final GlobalKey key = chart.key;
      // _chartState = key.currentState;
    });
    //   // to test series data count
    test('to test series data length', () {
      expect(chart!.series[0].dataSource!.length, 100000);
    });
    //Commented the below test case, since removed _renderDuration property from
    // chart_base.dart file. Need to check for another possibilities.
    // //   // to test series render duration
    // test('to test render duration', () {
    //   expect(_chartState._renderDuration.inMilliseconds < 2800, true);
    // });

    testWidgets('Steparea - with marker - 2L', (WidgetTester tester) async {
      final _StepareaPerformance chartContainer =
          _stepareaPerformance('Steparea_with_marker', 200000)
              as _StepareaPerformance;
      await tester.pumpWidget(chartContainer);
      chart = chartContainer.chart;
      // final GlobalKey key = chart.key;
      // _chartState = key.currentState;
    });
    //   // to test series data count
    test('to test series data length', () {
      expect(chart!.series[0].dataSource!.length, 200000);
    });
    //Commented the below test case, since removed _renderDuration property from
    // chart_base.dart file. Need to check for another possibilities.
    // //   // to test series render duration
    // test('to test render duration', () {
    //   expect(_chartState._renderDuration.inMilliseconds < 4900, true);
    // });
  });

  //   group('Steparea - with datalabel performance',(){
  //   testWidgets('Line - with datalabel - 10K', (WidgetTester tester) async {
  //     final _StepareaPerformance  chartContainer = _stepareaPerformance('Steparea_with_datalabel', 10000);
  //     await tester.pumpWidget(chartContainer);
  //     chart = chartContainer.chart;
  //     final GlobalKey key = chart.key;
  //     _chartState = key.currentState;
  //   });
  // //   // to test series data count
  //   test('to test series data length', () {
  //     expect(chart.series[0].dataSource.length, 10000);
  //   });
  // //   // to test series render duration
  //   test('to test render duration', () {
  //     expect(_chartState._renderDuration.inMilliseconds < 1500, true);
  //   });

  //   testWidgets('Steparea - with datalabel - 50K', (WidgetTester tester) async {
  //     final _StepareaPerformance  chartContainer = _stepareaPerformance('Steparea_with_datalabel', 50000);
  //     await tester.pumpWidget(chartContainer);
  //     chart = chartContainer.chart;
  //     final GlobalKey key = chart.key;
  //     _chartState = key.currentState;
  //   });
  // //   // to test series data count
  //   test('to test series data length', () {
  //     expect(chart.series[0].dataSource.length, 50000);
  //   });
  // //   // to test series render duration
  //   test('to test render duration', () {
  //     expect(_chartState._renderDuration.inMilliseconds < 1900, true);
  //   });

  //   testWidgets('Steparea - with datalabel - 1L', (WidgetTester tester) async {
  //     final _StepareaPerformance  chartContainer = _stepareaPerformance('Steparea_with_datalabel', 100000);
  //     await tester.pumpWidget(chartContainer);
  //     chart = chartContainer.chart;
  //     final GlobalKey key = chart.key;
  //     _chartState = key.currentState;
  //   });
  // //   // to test series data count
  //   test('to test series data length', () {
  //     expect(chart.series[0].dataSource.length, 100000);
  //   });
  // //   // to test series render duration
  //   test('to test render duration', () {
  //     expect(_chartState._renderDuration.inMilliseconds < 2800, true);
  //   });

  //   testWidgets('Steparea - with datalabel - 2L', (WidgetTester tester) async {
  //     final _StepareaPerformance  chartContainer = _stepareaPerformance('Steparea_with_datalabel', 200000);
  //     await tester.pumpWidget(chartContainer);
  //     chart = chartContainer.chart;
  //     final GlobalKey key = chart.key;
  //     _chartState = key.currentState;
  //   });
  // //   // to test series data count
  //   test('to test series data length', () {
  //     expect(chart.series[0].dataSource.length, 200000);
  //   });
  // //   // to test series render duration
  //   test('to test render duration', () {
  //     expect(_chartState._renderDuration.inMilliseconds < 4900, true);
  //   });
  //  });
}

StatelessWidget _stepareaPerformance(String sampleName, int noOfSamples) {
  return _StepareaPerformance(sampleName, noOfSamples);
}

// ignore: must_be_immutable
class _StepareaPerformance extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  _StepareaPerformance(String sampleName, int noOfSamples) {
    chart = getStepareaPerformanceChart(sampleName, noOfSamples);
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
