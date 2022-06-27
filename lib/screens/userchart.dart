import 'package:dagnosis_and_prediction/db/db_helper.dart';
import 'package:dagnosis_and_prediction/model/User_Health_model.dart';
import 'package:dagnosis_and_prediction/screens/admin_screen.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

@override
late TooltipBehavior _tooltipBehavior;

// @override
// void initState() {
//   _tooltipBehavior = TooltipBehavior(enable: true);
// }

class UserChart extends StatefulWidget {
  final String? userEmail;
  const UserChart({Key? key, this.userEmail}) : super(key: key);

  @override
  _UserChartState createState() => _UserChartState();
}

class _UserChartState extends State<UserChart> {
  late List<PatientData> chartData;
  // late ChartSeriesController _chartSeriesController;
  List<UserHealth> usershealth = [];
  List<PatientData> data = [];

  getuserhealth() async {
    print('rrrrr${widget.userEmail}');
    usershealth = await DBHelper.userHeathList('${widget.userEmail}');
    addglucoserateRate();
    return usershealth;
  }

  @override
  void initState() {
    chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
    getuserhealth();
  }

  addglucoserateRate() {
    for (var i in usershealth) {
      data.add(PatientData(i.date.toString(), i.glucoserate!.toInt()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.red),
            onPressed: () {
              // Navigator.of(context).pop();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => AdminScreen()));
            },
          ),
        ),
        body: FutureBuilder(
          future: getuserhealth(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SfCartesianChart(
                title: ChartTitle(text: 'Glucose Rate Reading analysis'),
                legend: Legend(isVisible: true),
                tooltipBehavior: _tooltipBehavior,
                // Initialize category axis
                // primaryXAxis: CategoryAxis(),
                primaryXAxis: CategoryAxis(
                    majorGridLines: const MajorGridLines(width: 2),
                    edgeLabelPlacement: EdgeLabelPlacement.shift,
                    interval: 3,
                    title: AxisTitle(text: 'Day')),
                primaryYAxis: NumericAxis(
                    axisLine: const AxisLine(width: 2),
                    associatedAxisName: 'jjjj',
                    majorTickLines: const MajorTickLines(size: 20),
                    title: AxisTitle(text: 'Glucose Rate')),
                series: <ChartSeries>[
                  // Initialize line series

                  LineSeries<PatientData, String>(
                    dataSource: data,
                    xValueMapper: (PatientData data, _) => data.day,
                    yValueMapper: (PatientData data, _) => data.glucose,

                    // Render the data label
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                  ),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  List<PatientData> getChartData() {
    return <PatientData>[
      PatientData('10/10/2020', 222),
      PatientData('15/10/2020', 232),
      PatientData('20/10/2020', 210),
      PatientData('30/10/2020', 207),
      PatientData('05/11/2020', 257),
      PatientData('10/11/2020', 217),
      PatientData('15/11/2020', 251),
      PatientData('20/11/2020', 280),
    ];
  }
}

class PatientData {
  PatientData(this.day, this.glucose);
  final String day;
  final int glucose;
}
