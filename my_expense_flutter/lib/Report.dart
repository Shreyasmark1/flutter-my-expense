import 'network_api.dart';
import 'package:flutter/material.dart';
import 'package:my_expense_flutter/ReportModal.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'Drawer.dart';

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  ReportState createState() => ReportState();
}

class ReportState extends State<Report> {
  late List<ReportModal> data;
  Future<Map<String, int>>? future;
  late TooltipBehavior _tooltipBehavior;
  String myMonth = '11';
  String myYear = '2022';

  @override
  void initState() {
    future = NetworkApi.getReport(myMonth, myYear);
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  String dateDisplayed = 'Show older Report';

  myShowDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((value) {
      setState(() {
        var data = value!;
        dateDisplayed = "${data.month}/${data.year}";
        myMonth = data.month.toString();
        myYear = data.year.toString();
        future = NetworkApi.getReport(myMonth, myYear);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        return false;
      },
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(104, 178, 252, 0.95),
          title: const Text(
            'Report',
            style: TextStyle(fontFamily: 'Georgia'),
          ),
          centerTitle: true,
        ),
        drawer: const CustomDrawer(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                child:
                    (future == null) ? const Text('Loading Data....') : report()),
            ElevatedButton(
              onPressed: () {
                myShowDatePicker();
              },
              child: Text(dateDisplayed),
            )
          ],
        ),
      )),
    );
  }

  FutureBuilder<Map<String, int>> report() {
    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map<String, int>? res = snapshot.data;

            List<ReportModal> c = [];
            for (MapEntry<String, int> i in res!.entries) {
              c.add(ReportModal(i.key, i.value));
            }

            data = c;

            //              data.add(ReportModal(category: key, amount: value));
            return SfCircularChart(
              title: ChartTitle(
                  text:
                      'Your Expense Report For This Month             (Units in Currency)'),
              legend: Legend(
                  isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
              tooltipBehavior: _tooltipBehavior,
              series: <CircularSeries>[
                PieSeries<ReportModal, String>(
                    dataSource: data,
                    xValueMapper: (ReportModal data, _) => data.category,
                    yValueMapper: (ReportModal data, _) => data.amount,
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                    enableTooltip: true,
                    explode: true,
                    explodeIndex: 1)
              ],
            );
          } else if (snapshot.hasError) {
            return const Text("Error Retrieving Data");
          }
          return const CircularProgressIndicator();
        });
  }
}
