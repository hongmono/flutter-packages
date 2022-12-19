import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_test/flutter_test.dart';
import '../../../charts.dart';
import 'stacked_line_sample.dart';

/// Testing method for customization of the stacked line series.
void stackedLineCustomization() {
  // Define a test. The TestWidgets function will also provide a WidgetTester
  // for us to work with. The WidgetTester will allow us to build and interact
  // with Widgets in the test environment.

  // chart instance will get once pumpWidget is called
  SfCartesianChart? chart;

  group('Stacked Line - Fill, Point Color Mapping', () {
    // Line series
    testWidgets(
        'Chart Widget - Testing Stacked Line series with point color mapping and fill',
        (WidgetTester tester) async {
      final _StackedLineCustomization chartContainer =
          _stackedLineCustomization('line_customization_default')
              as _StackedLineCustomization;
      await tester.pumpWidget(chartContainer);
      chart = chartContainer.chart;
    });

    // to test series count
    test('test series count', () {
      expect(chart!.series.length, 2);
    });

    // final List<_ChartColorDataValues> _chartColorDataValues =
    //     _getColorValues(const Color(0xff4b87b9), const Color(0xffc06c84));

    // // to test segment stroke paint
    // test('test segment stroke paint', () {
    //   for (int i = 0; i < chart!.series.length; i++) {
    //     final CartesianSeriesRenderer cartesianSeriesRenderer =
    //         _chartState!._chartSeries.visibleSeriesRenderers[i];
    //     for (int j = 0; j < cartesianSeriesRenderer._segments.length; j++) {
    //       final Color strokeColor =
    //           cartesianSeriesRenderer._segments[j].getStrokePaint().color;
    //       expect(_chartColorDataValues[i].rectValues, strokeColor);
    //     }
    //   }
    // });

    // // to test segment fill paint
    // test('test segment fill paint', () {
    //   for (int i = 0; i < chart!.series.length; i++) {
    //     final CartesianSeriesRenderer cartesianSeriesRenderer =
    //         _chartState!._chartSeries.visibleSeriesRenderers[i];
    //     for (int j = 0; j < cartesianSeriesRenderer._segments.length; j++) {
    //       final Color fillColor =
    //           cartesianSeriesRenderer._segments[j].getFillPaint().color;
    //       expect(_chartColorDataValues[i].rectValues, fillColor);
    //     }
    //   }
    // });

    // //Testing Line series with fill
    // testWidgets('Chart Widget - Testing Line series with fill',
    //     (WidgetTester tester) async {
    //   final _StackedLineCustomization chartContainer =
    //       _stackedLineCustomization('line_customization_fill')
    //           as _StackedLineCustomization;
    //   await tester.pumpWidget(chartContainer);
    //   chart = chartContainer.chart;
    //   final GlobalKey key = chart!.key as GlobalKey<State<StatefulWidget>>;
    //   _chartState = key.currentState as SfCartesianChartState?;
    // });

    // // to test segment stroke paint
    // test('test segment stroke paint', () {
    //   for (int i = 0; i < chart!.series.length; i++) {
    //     final CartesianSeriesRenderer cartesianSeriesRenderer =
    //         _chartState!._chartSeries.visibleSeriesRenderers[0];
    //     for (int j = 0; j < cartesianSeriesRenderer._segments.length; j++) {
    //       final Color strokeColor =
    //           cartesianSeriesRenderer._segments[j].getStrokePaint().color;
    //       expect(strokeColor, const Color(0xff2196f3));
    //     }
    //   }
    // });

    // // to test segment point color mapping paint
    // test('test segment fill paint', () {
    //   for (int i = 0; i < chart!.series.length; i++) {
    //     final CartesianSeriesRenderer cartesianSeriesRenderer =
    //         _chartState!._chartSeries.visibleSeriesRenderers[0];
    //     for (int j = 0; j < cartesianSeriesRenderer._segments.length; j++) {
    //       final Color fillColor =
    //           cartesianSeriesRenderer._segments[j].getFillPaint().color;
    //       expect(fillColor, const Color(0xff2196f3));
    //     }
    //   }
    // });

// //Testing Stacked Line series with point color mapping
//     testWidgets('Chart Widget - Stacked Line series with multicolored line',
//         (WidgetTester tester) async {
//       final _StackedLineCustomization chartContainer =
//           _stackedLineCustomization('customization_pointColor')
//               as _StackedLineCustomization;
//       await tester.pumpWidget(chartContainer);
//       chart = chartContainer.chart;
//       final GlobalKey key = chart!.key as GlobalKey<State<StatefulWidget>>;
//       _chartState = key.currentState as SfCartesianChartState?;
//     });
//     final List<Color> color = <Color>[
//       const Color(0xffff5722),
//       const Color(0xff673ab7),
//       const Color(0xff8bc34a),
//       const Color(0xfff44336)
//     ];
//     // to test segment stroke paint
//     test('test segment stroke paint', () {
//       for (int i = 0;
//           i < _chartState!._chartSeries.visibleSeriesRenderers.length;
//           i++) {
//         final CartesianSeriesRenderer cartesianSeriesRenderer =
//             _chartState!._chartSeries.visibleSeriesRenderers[0];
//         for (int j = 0; j < cartesianSeriesRenderer._segments.length; j++) {
//           final Color strokeColor =
//               cartesianSeriesRenderer._segments[j].getStrokePaint().color;
//           expect(strokeColor.value, color[j].value);
//         }
//       }
//     });

//     // to test segment fill paint
//     test('test segment fill paint', () {
//       for (int i = 0;
//           i < _chartState!._chartSeries.visibleSeriesRenderers.length;
//           i++) {
//         final CartesianSeriesRenderer cartesianSeriesRenderer =
//             _chartState!._chartSeries.visibleSeriesRenderers[0];
//         for (int j = 0; j < cartesianSeriesRenderer._segments.length; j++) {
//           final Color fillColor =
//               cartesianSeriesRenderer._segments[j].getFillPaint().color;
//           expect(fillColor, color[j]);
//         }
//       }
//     });

// //Testing Stacked Line series with point color mapping
//     testWidgets('Chart Widget - Stacked Line series with multicolored line',
//         (WidgetTester tester) async {
//       final _StackedLineCustomization chartContainer =
//           _stackedLineCustomization('customization_fill_pointcolor')
//               as _StackedLineCustomization;
//       await tester.pumpWidget(chartContainer);
//       chart = chartContainer.chart;
//       final GlobalKey key = chart!.key as GlobalKey<State<StatefulWidget>>;
//       _chartState = key.currentState as SfCartesianChartState?;
//     });
//     // to test segment stroke paint
//     test('test segment stroke paint', () {
//       for (int i = 0; i < chart!.series.length; i++) {
//         final CartesianSeriesRenderer cartesianSeriesRenderer =
//             _chartState!._chartSeries.visibleSeriesRenderers[0];
//         for (int j = 0; j < cartesianSeriesRenderer._segments.length; j++) {
//           final Color strokeColor =
//               cartesianSeriesRenderer._segments[j].getStrokePaint().color;
//           expect(strokeColor.value, const Color(0xfff44336).value);
//         }
//       }
//     });

//     // to test segment fill paint
//     test('test segment fill paint', () {
//       for (int i = 0; i < chart!.series.length; i++) {
//         final CartesianSeriesRenderer cartesianSeriesRenderer =
//             _chartState!._chartSeries.visibleSeriesRenderers[0];
//         for (int j = 0; j < cartesianSeriesRenderer._segments.length; j++) {
//           final Color fillColor =
//               cartesianSeriesRenderer._segments[j].getFillPaint().color;
//           expect(fillColor.value, const Color(0xfff44336).value);
//         }
//       }
//     });

//     testWidgets(
//         'Chart Widget - Testing stacked Line series with point color mapping',
//         (WidgetTester tester) async {
//       final _StackedLineMarker chartContainer =
//           _stackedLineMarker('marker_PointColormapping') as _StackedLineMarker;
//       await tester.pumpWidget(chartContainer);
//       chart = chartContainer.chart;
//       final GlobalKey key = chart!.key as GlobalKey<State<StatefulWidget>>;
//       _chartState = key.currentState as SfCartesianChartState?;
//     });

//     test('to test point color mapping properties', () {
//       final List<CartesianSeriesRenderer?> cartesianSeriesRenderers =
//           _chartState!._chartSeries.visibleSeriesRenderers;
//       cartesianSeriesRenderers[0]!
//           ._regionalData!
//           .forEach((dynamic k, dynamic v) => expect(k[2], Colors.blue));
//       cartesianSeriesRenderers[1]!
//           ._regionalData!
//           .forEach((dynamic k, dynamic v) => expect(k[2], Colors.blue));
//     });
    //    testWidgets('Line series with selction in intial rendering',
    //       (WidgetTester tester) async {
    //     final _StackedLineCustomization chartContainer =
    //         _stackedLineCustomization('customization_selection_initial_render');
    //     await tester.pumpWidget(chartContainer);
    //     chart = chartContainer.chart;
    //     final GlobalKey key = chart.key;
    //     _chartState = key.currentState;
    //   });

    //   test('test segment stroke paint', () {
    //     for (int i = 0; i < chart.series.length; i++) {
    //       final CartesianSeriesRenderer cartesianSeriesRenderer =
    //           _chartState._chartSeries.visibleSeriesRenderers[i];
    //       for (int j = 0; j < cartesianSeriesRenderer.segments.length; j++) {
    //         final Color strokeColor =
    //             cartesianSeriesRenderer.segments[j].getStrokePaint().color;
    //         if (j == 0) {
    //           expect(strokeColor, const Color(0xffff5722));
    //         } else if (j == 1) {
    //           expect(strokeColor, const Color(0xff673ab7));
    //         } else if (j == 2) {
    //           expect(strokeColor, const Color(0xff8bc34a));
    //         } else if (j == 3) {
    //           expect(strokeColor, const Color(0xfff44336));
    //         }
    //       }
    //     }
    //   });

    //   //Testing Line series with point color mapping
    //   testWidgets('Chart Widget - Line series with multicolored line',
    //       (WidgetTester tester) async {
    //     final _StackedLineCustomization chartContainer =
    //         _stackedLineCustomization('line_customization_pointColor');
    //     await tester.pumpWidget(chartContainer);
    //     chart = chartContainer.chart;
    //     final GlobalKey key = chart.key;
    //     _chartState = key.currentState;
    //   });

    //   // to test segment stroke paint
    //   test('test segment stroke paint', () {
    //     for (int i = 0; i < chart.series.length; i++) {
    //       final CartesianSeriesRenderer cartesianSeriesRenderer =
    //           _chartState._chartSeries.visibleSeriesRenderers[i];
    //       for (int j = 0; j < cartesianSeriesRenderer.segments.length; j++) {
    //         final Color strokeColor =
    //             cartesianSeriesRenderer.segments[j].getStrokePaint().color;
    //         if (j == 0) {
    //           expect(strokeColor, const Color(0xffff5722));
    //         } else if (j == 1) {
    //           expect(strokeColor, const Color(0xff673ab7));
    //         } else if (j == 2) {
    //           expect(strokeColor, const Color(0xff8bc34a));
    //         } else if (j == 3) {
    //           expect(strokeColor, const Color(0xfff44336));
    //         }
    //       }
    //     }
    //   });

    //   // to test segment fill paint
    //   test('test segment fill paint', () {
    //     for (int i = 0; i < chart.series.length; i++) {
    //       final CartesianSeriesRenderer cartesianSeriesRenderer =
    //           _chartState._chartSeries.visibleSeriesRenderers[i];
    //       for (int j = 0; j < cartesianSeriesRenderer.segments.length; j++) {
    //         final Color fillColor =
    //             cartesianSeriesRenderer.segments[j].getFillPaint().color;
    //         if (j == 0) {
    //           expect(fillColor, const Color(0xffff5722));
    //         } else if (j == 1) {
    //           expect(fillColor, const Color(0xff673ab7));
    //         } else if (j == 2) {
    //           expect(fillColor, const Color(0xff8bc34a));
    //         } else if (j == 3) {
    //           expect(fillColor, const Color(0xfff44336));
    //         }
    //       }
    //     }
    //   });
  });

  // group('Line - Sorting', () {
  //   testWidgets('Chart Widget - Testing Line Series Sorting Descending',
  //       (WidgetTester tester) async {
  //     final _StackedLineCustomization chartContainer =
  //         _stackedLineCustomization('sortingX') as _StackedLineCustomization;
  //     await tester.pumpWidget(chartContainer);
  //     chart = chartContainer.chart;
  //     final GlobalKey key = chart!.key as GlobalKey<State<StatefulWidget>>;
  //     _chartState = key.currentState as SfCartesianChartState?;
  //   });

  //   test('to test primaryXAxis labels', () {
  //     expect(
  //         _chartState!._chartAxis._primaryXAxisRenderer._visibleLabels[0].text,
  //         'USA');
  //     expect(
  //         _chartState!
  //             ._chartAxis._primaryXAxisRenderer._visibleLabels.last.text,
  //         'Africa');
  //   });

  //   test('to test primaryYAxis labels', () {
  //     expect(
  //         _chartState!._chartAxis._primaryYAxisRenderer._visibleLabels[0].text,
  //         '0');
  //     expect(
  //         _chartState!._chartAxis._primaryYAxisRenderer._visibleLabels[4].text,
  //         '40');
  //   });

  //   testWidgets(
  //       'Testing line series sorting with first point null in ascending order',
  //       (WidgetTester tester) async {
  //     final _StackedLineCustomization chartContainer =
  //         _stackedLineCustomization('sortingX_ascending_null')
  //             as _StackedLineCustomization;
  //     await tester.pumpWidget(chartContainer);
  //     chart = chartContainer.chart;
  //     final GlobalKey key = chart!.key as GlobalKey<State<StatefulWidget>>;
  //     _chartState = key.currentState as SfCartesianChartState?;
  //   });

  //   test('to test primaryXAxis labels', () {
  //     expect(
  //         _chartState!._chartAxis._primaryXAxisRenderer._visibleLabels[0].text,
  //         'China');
  //     expect(
  //         _chartState!
  //             ._chartAxis._primaryXAxisRenderer._visibleLabels.last.text,
  //         'Swiss');
  //   });
  //   testWidgets(
  //       'Testing line series sorting with first point null in descending order',
  //       (WidgetTester tester) async {
  //     final _StackedLineCustomization chartContainer =
  //         _stackedLineCustomization('sortingX_descending_null')
  //             as _StackedLineCustomization;
  //     await tester.pumpWidget(chartContainer);
  //     chart = chartContainer.chart;
  //     final GlobalKey key = chart!.key as GlobalKey<State<StatefulWidget>>;
  //     _chartState = key.currentState as SfCartesianChartState?;
  //   });

  //   test('to test primaryXAxis labels', () {
  //     expect(
  //         _chartState!._chartAxis._primaryXAxisRenderer._visibleLabels[0].text,
  //         'USA');
  //     expect(
  //         _chartState!
  //             ._chartAxis._primaryXAxisRenderer._visibleLabels.last.text,
  //         'Africa');
  //   });
  // });
}

StatelessWidget _stackedLineCustomization(String sampleName) {
  return _StackedLineCustomization(sampleName);
}

// ignore: must_be_immutable
class _StackedLineCustomization extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  _StackedLineCustomization(String sampleName) {
    chart = getStackedLineChart(sampleName);
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
