import 'package:flutter/material.dart';
import 'package:lms/backend/bookcatalog.dart';
import 'package:lms/const/custom-button.dart';
import 'package:lms/const/theme.dart';

import 'package:pie_chart/pie_chart.dart';
import 'dart:math' as math;

// ignore: must_be_immutable
class PiChart extends StatefulWidget {
  double issueBook;
  double noissuebook;
  PiChart({super.key, required this.issueBook, required this.noissuebook});

  @override
  State<PiChart> createState() => _PiChartState(issueBook, noissuebook);
}

class _PiChartState extends State<PiChart> {
  double issueBook;
  double notissuedbook;
  _PiChartState(this.issueBook, this.notissuedbook);

  dynamic dataMap;
  @override
  void initState() {
    super.initState();
    dataMap = {
      "Issued Book": issueBook,
      "Not Issued Book": notissuedbook,
    };
  }

  final legendLabels = <String, String>{
    "Issued Book": "Issued Book legend",
    "Not Issued Book": "Not Issued Book legend",
  };
  void updateDataMap(double issueBook, double notissuedbook) {
    dataMap = {
      "Issued Book": issueBook,
      "Not Issued Book": notissuedbook,
    };
  }

  final colorList = <Color>[
    const Color(0xfffdcb6e),
    const Color(0xff0984e3),
  ];

  final gradientList = <List<Color>>[
    [
      const Color.fromRGBO(223, 250, 92, 1),
      const Color.fromRGBO(129, 250, 112, 1),
    ],
    [
      const Color.fromRGBO(129, 182, 205, 1),
      const Color.fromRGBO(91, 253, 199, 1),
    ],
  ];
  final ChartType _chartType = ChartType.disc;

  final double _ringStrokeWidth = 32;
  final double _chartLegendSpacing = 32;

  final bool _showLegendsInRow = false;
  final bool _showLegends = true;
  final bool _showLegendLabel = false;

  final bool _showChartValueBackground = true;
  final bool _showChartValues = true;
  final bool _showChartValuesInPercentage = false;
  final bool _showChartValuesOutside = false;

  final bool _showGradientColors = false;

  // LegendShape? _legendShape = LegendShape.circle;
  final LegendPosition _legendPosition = LegendPosition.right;

  int key = 0;
  @override
  Widget build(BuildContext context) {
    final chart = PieChart(
      key: ValueKey(key),
      dataMap: dataMap,
      animationDuration: const Duration(milliseconds: 800),
      chartLegendSpacing: _chartLegendSpacing,
      chartRadius: math.min(MediaQuery.of(context).size.width / 3.2, 300),
      colorList: colorList,
      initialAngleInDegree: 0,
      chartType: _chartType,
      legendLabels: _showLegendLabel ? legendLabels : {},
      legendOptions: LegendOptions(
        showLegendsInRow: _showLegendsInRow,
        legendPosition: _legendPosition,
        showLegends: _showLegends,
        legendTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      chartValuesOptions: ChartValuesOptions(
        showChartValueBackground: _showChartValueBackground,
        showChartValues: _showChartValues,
        showChartValuesInPercentage: _showChartValuesInPercentage,
        showChartValuesOutside: _showChartValuesOutside,
      ),
      ringStrokeWidth: _ringStrokeWidth,
      emptyColor: Colors.grey,
      gradientList: _showGradientColors ? gradientList : null,
      emptyColorGradient: const [
        Color(0xff6c5ce7),
        Colors.blue,
      ],
      baseChartColor: Colors.transparent,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pie Chart"),
        actions: [
          // ElevatedButton(
          //   onPressed: () async {
              // List<int> Data = await BookCatalog().getCatalogData();
              // issueBook = Data[0] + 0.0;
              // notissuedbook = Data[1] + 0.0;
              // updateDataMap(issueBook, notissuedbook);

              // setState(() {
              //   key = key + 1;
              // });
          //   },
          //   child: Text("Reload".toUpperCase()),
          // ),
          Padding(
            padding: const EdgeInsets.only(right:10),
            child: SizedBox(
              height:30,
              width:100,
              child: CustomButton(onPressed:()async{
                 List<int> Data = await BookCatalog().getCatalogData();
                  issueBook = Data[0] + 0.0;
                  notissuedbook = Data[1] + 0.0;
                  updateDataMap(issueBook, notissuedbook);
              
                  setState(() {
                    key = key + 1;
                  });
              }, text: Text('Reload',style:buttonTextStyle,)),
            ),
          )
        ],
      ),
      body: Container(
          alignment: Alignment.center,
          height: 200,
          width: double.maxFinite,
          child: Center(child: chart)),
    );
  }
}
