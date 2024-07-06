import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nbp/shimmerpage.dart';
import 'package:nbp/utility/colors.dart';
import 'package:nbp/utility/textview/custom_textview.dart';
import 'package:shimmer/shimmer.dart';

class StatssDetailsScreen extends StatefulWidget {
  @override
  _StatssDetailsScreenState createState() => _StatssDetailsScreenState();
}

class _StatssDetailsScreenState extends State<StatssDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  bool isLoading = true;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Initialise Tab Controller
    tabController = TabController(length: 3, vsync: this, initialIndex: 1);
    tabController.addListener(() {
      tabController.index = 1;
    });
    Loading();
  }

  Future<void> Loading() async {
    _timer = Timer(const Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  bool _switchValue = false;

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 80,
          ),
          DataTable(
            columns: [
              DataColumn(label: Text('TEAM')),
              DataColumn(label: Text('GP')),
              DataColumn(label: Text('W')),
              DataColumn(label: Text('L')),
              DataColumn(label: Text('WIN%')),
              DataColumn(label: Text('MIN')),
              DataColumn(label: Text('PTS')),
              DataColumn(label: Text('FGM')),
              DataColumn(label: Text('FGA')),
              DataColumn(label: Text('FG%')),
              DataColumn(label: Text('3PM')),
              DataColumn(label: Text('3PA')),
              DataColumn(label: Text('3P%')),
              DataColumn(label: Text('FTM')),
              DataColumn(label: Text('FTA')),
              DataColumn(label: Text('FT%')),
              DataColumn(label: Text('OREB')),
              DataColumn(label: Text('DREB')),
              DataColumn(label: Text('REB')),
              DataColumn(label: Text('AST')),
              DataColumn(label: Text('TOV')),
              DataColumn(label: Text('STL')),
              DataColumn(label: Text('BLK')),
              DataColumn(label: Text('BLKA')),
              DataColumn(label: Text('PF')),
              DataColumn(label: Text('PFD')),
              DataColumn(label: Text('+/-')),
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text('Boston Celtics')),
                DataCell(Text('82')),
                DataCell(Text('64')),
                DataCell(Text('18')),
                DataCell(Text('.780')),
                DataCell(Text('48.4')),
                DataCell(Text('120.6')),
                DataCell(Text('43.9')),
                DataCell(Text('90.2')),
                DataCell(Text('.487')),
                DataCell(Text('16.5')),
                DataCell(Text('42.5')),
                DataCell(Text('.388')),
                DataCell(Text('16.3')),
                DataCell(Text('20.2')),
                DataCell(Text('.802')),
                DataCell(Text('10.7')),
                DataCell(Text('35.6')),
                DataCell(Text('46.3')),
                DataCell(Text('26.9')),
                DataCell(Text('11.9')),
                DataCell(Text('6.8')),
                DataCell(Text('6.6')),
                DataCell(Text('3.7')),
                DataCell(Text('16.2')),
                DataCell(Text('17.3')),
                DataCell(Text('11.3')),
              ]),
              // Add more DataRow for each team
            ],
          ),
        ],
      ),
    ));
  }
}
