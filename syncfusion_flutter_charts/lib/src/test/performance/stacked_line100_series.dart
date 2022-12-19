import 'dart:math';
import 'package:flutter/material.dart';
import '../../../charts.dart';
import 'performance.dart';

/// Method to get the stacked line100 performance sample
SfCartesianChart getStackedline100PerformanceChart(
    String sampleName, int noOfSamples) {
  SfCartesianChart chart;
  final List<PerformanceData> data = <PerformanceData>[];
  for (int i = 0; i < noOfSamples; i++) {
    data.add(PerformanceData(x: i.toDouble(), sales1: Random().nextInt(100)));
  }
  switch (sampleName) {
    case 'default_stackedline100':
      chart = SfCartesianChart(
          key: GlobalKey<State<SfCartesianChart>>(),
          series: <StackedLine100Series<PerformanceData, num?>>[
            StackedLine100Series<PerformanceData, num?>(
              dataSource: data,
              animationDuration: 0,
              xValueMapper: (PerformanceData dat, _) => dat.x,
              yValueMapper: (PerformanceData dat, _) => dat.sales1,
            )
          ]);
      break;
    case 'stackedline100_with_marker':
      chart = SfCartesianChart(
          key: GlobalKey<State<SfCartesianChart>>(),
          series: <StackedLine100Series<PerformanceData, num?>>[
            StackedLine100Series<PerformanceData, num?>(
                dataSource: data,
                animationDuration: 0,
                xValueMapper: (PerformanceData dat, _) => dat.x,
                yValueMapper: (PerformanceData dat, _) => dat.sales1,
                markerSettings: const MarkerSettings(isVisible: true))
          ]);
      break;
    case 'stackedline100_with_datalabel':
      chart = SfCartesianChart(
          key: GlobalKey<State<SfCartesianChart>>(),
          series: <StackedLine100Series<PerformanceData, num?>>[
            StackedLine100Series<PerformanceData, num?>(
                dataSource: data,
                animationDuration: 0,
                xValueMapper: (PerformanceData dat, _) => dat.x,
                yValueMapper: (PerformanceData dat, _) => dat.sales1,
                dataLabelSettings: const DataLabelSettings(isVisible: true))
          ]);
      break;
    default:
      chart = SfCartesianChart(
        key: GlobalKey<State<SfCartesianChart>>(),
      );
  }
  return chart;
}
