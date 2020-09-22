import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class PieOutsideLabelChart extends StatefulWidget {
  @override
  _PieOutsideLabelChartState createState() => _PieOutsideLabelChartState();
}

class _PieOutsideLabelChartState extends State<PieOutsideLabelChart> {

  getData() async{
    await Firestore.instance
        .collection('data')
        .where('type', isEqualTo: 'Перевод').where('visible', isEqualTo: true)
        .getDocuments()
        .then((value) {

      dataMap2['Перевод'] = value.documents.length.toDouble() ?? 0;
    });

    await Firestore.instance
        .collection('data').where('visible', isEqualTo: true)
        .where('type', isEqualTo: 'Снятие')
        .getDocuments()
        .then((value) {

      dataMap2['Снятие'] = value.documents.length.toDouble() ?? 0;

    });

   await Firestore.instance
        .collection('data').where('visible', isEqualTo: true)
        .where('type', isEqualTo: 'Пополнение')
        .getDocuments()
        .then((value) {

      dataMap2['Пополнение'] = value.documents.length.toDouble() ?? 0;
    });
  }


  Map<String, double> dataMap2 = {};

  List<Color> colorList = [
    Colors.yellow,
    Colors.green,
    Colors.red,
  ];



  @override
  Widget build(BuildContext context) {
    print(dataMap2.toString() + '     kek22222222');
    return Scaffold(
        body: Center(
      child: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Center(
                child: CircularProgressIndicator(),
              );
            default:

              return PieChart(
                dataMap: dataMap2,
                animationDuration: Duration(milliseconds: 1200),
                chartLegendSpacing: 40,
                chartRadius: MediaQuery.of(context).size.width / 1.4,
                colorList: colorList,
                initialAngleInDegree: 0,
                chartType: ChartType.ring,
                ringStrokeWidth: 32,
                legendOptions: LegendOptions(
                  showLegendsInRow: false,
                  legendPosition: LegendPosition.bottom,
                  showLegends: true,
                  legendShape: BoxShape.circle,
                  legendTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                chartValuesOptions: ChartValuesOptions(
                  showChartValueBackground: true,
                  showChartValues: true,
                  showChartValuesInPercentage: false,
                  showChartValuesOutside: true,
                ),
              );
          }
        },
      ),
    ));
  }
}
