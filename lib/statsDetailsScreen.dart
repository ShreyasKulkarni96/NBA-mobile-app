import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nbp/utility/colors.dart';
import 'package:nbp/utility/textview/custom_textview.dart';
import 'package:http/http.dart' as http;
import 'package:nbp/shimmerpage.dart';
import 'package:nbp/utility/HelperClass.dart';
import 'package:nbp/utility/colors.dart';
import 'package:nbp/utility/textview/custom_textview.dart';

import 'CONSTANTS.dart';
class StatssDetailsScreen extends StatefulWidget {
  @override
  _StatssDetailsScreenState createState() => _StatssDetailsScreenState();
}

class _StatssDetailsScreenState extends State<StatssDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  bool isLoading = true;
  late Timer _timer;

var  statsList=[];

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
            height: 60,
          ),
          Container(
            color: grayBgColor,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
                top: 0.0, left: 30.0, right: 30.0, bottom: 0.0),
            padding: const EdgeInsets.only(
                top: 5.0, left: 5.0, right: 5.0, bottom: 5.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        CustomTextView(
                            title: 'Conference',
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            textAlign: TextAlign.center),
                        Container(
                          height: 4,
                          width: 100,
                          child: Divider(
                            height: 3,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        CustomTextView(
                            title: 'Teams',
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            textAlign: TextAlign.center),
                        Container(
                          height: 4,
                          width: 50,
                          child: Divider(
                            height: 3,
                            color: grayBgColor,
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        CustomTextView(
                            title: 'Players',
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            textAlign: TextAlign.center),
                        Container(
                          height: 5,
                          width: 45,
                          child: Divider(
                            height: 4,
                            color: grayBgColor,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          Container(
            color: lightGrayBgColor,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
                top: 0.0, left: 30.0, right: 30.0, bottom: 0.0),
            padding: const EdgeInsets.only(
                top: 5.0, left: 5.0, right: 5.0, bottom: 5.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        CustomTextView(
                            title: 'West',
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            textAlign: TextAlign.center),
                        Container(
                          height: 4,
                          width: 35,
                          child: Divider(
                            height: 3,
                            color: lightGrayBgColor,
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        CustomTextView(
                            title: 'East',
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            textAlign: TextAlign.center),
                        Container(
                          height: 4,
                          width: 50,
                          child: Divider(
                            height: 3,
                            color: Colors.grey.shade800,
                          ),
                        )
                      ],
                    ),
                    // Column(
                    //   children: [
                    //     CustomTextView(
                    //         title: 'DET',
                    //         fontSize: 20.0,
                    //         fontWeight: FontWeight.bold,
                    //         color: Colors.black,
                    //         textAlign: TextAlign.center),
                    //     Container(
                    //       height: 5,
                    //       width: 45,
                    //       child: Divider(
                    //         height: 4,
                    //         color: grayBgColor,
                    //       ),
                    //     )
                    //   ],
                    // ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ScrollableDataTable()
        ],
      ),
    ));
  }

  GetStatsData() async {
    setState(() {
      isLoading = true;
    });
    var url = Uri.parse(CONSTANTS.baseUrl + CONSTANTS.fetchStatsData);
    // print("URL : $url");
    // print("data $data");
    var response = await http.get(url);
    // print("${response.statusCode}");
    print("Response ${response.body}");
    setState(() {
      isLoading = false;
    });
    var res = jsonDecode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        statsList = res;
      });
    } else if (response.statusCode == 400) {
      showToast(res['message']);
    } else if (response.statusCode == 401) {
      showToast(res['message']);
    } else {
      print(res['message']);
    }
  }

}

class ScrollableDataTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        border: TableBorder.symmetric(outside: BorderSide(color:Colors.grey.shade600) ),
        dataRowColor: MaterialStateProperty.all(Colors.white),
        headingRowColor: MaterialStateProperty.all(Colors.white),
        columns: [
          DataColumn(label: Text(' ')),
          DataColumn(label: Text('  ')),
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
            DataCell(Text('1',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),
            DataCell(Image.asset("assets/image/person.png",width: 20,height: 20,)),
            DataCell(Text('Boston Celtics',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.5,
                    color: Colors.blue,
                    fontFamily: 'Inter'))),
            DataCell(Text('82')),
            DataCell(Text('64')),
            DataCell(Text('18')),
            DataCell(Text('.780')),
            DataCell(Text('48.4')),
            DataCell(Text('120.6')),
            DataCell(Text('43.9')),
            DataCell(Text('90.2')),
            DataCell(Text('48.7')),
            DataCell(Text('16.5')),
            DataCell(Text('42.5')),
            DataCell(Text('38.8')),
            DataCell(Text('16.3')),
            DataCell(Text('20.2')),
            DataCell(Text('80.7')),
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
          DataRow(cells: [
            DataCell(Text('2',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),
            DataCell(Image.asset("assets/image/person.png",width: 20,height: 20,)),
            DataCell(Text('Denver Nuggets',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.5,
                    color: Colors.blue,
                    fontFamily: 'Inter'))),
            DataCell(Text('82')),
            DataCell(Text('57')),
            DataCell(Text('25')),
            DataCell(Text('.695')),
            DataCell(Text('48.1')),
            DataCell(Text('114.9')),
            DataCell(Text('44.0')),
            DataCell(Text('88.8')),
            DataCell(Text('49.8')),
            DataCell(Text('11.7')),
            DataCell(Text('31.2')),
            DataCell(Text('37.4')),
            DataCell(Text('15.1')),
            DataCell(Text('19.9')),
            DataCell(Text('76.2')),
            DataCell(Text('10.7')),
            DataCell(Text('33.7')),
            DataCell(Text('44.4')),
            DataCell(Text('29.5')),
            DataCell(Text('12.6')),
            DataCell(Text('7.1')),
            DataCell(Text('5.6')),
            DataCell(Text('4.8')),
            DataCell(Text('18.2')),
            DataCell(Text('17.9')),
            DataCell(Text('5.3')),
          ]),
          DataRow(cells: [
            DataCell(Text('3',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),
            DataCell(Image.asset("assets/image/person.png",width: 20,height: 20,)),
            DataCell(Text('Oklahoma City Thunder',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.5,
                    color: Colors.blue,
                    fontFamily: 'Inter'))),
            DataCell(Text('82')),
            DataCell(Text('57')),
            DataCell(Text('25')),
            DataCell(Text('.695')),
            DataCell(Text('48.3')),
            DataCell(Text('120.1')),
            DataCell(Text('44.5')),
            DataCell(Text('89.3')),
            DataCell(Text('49.9')),
            DataCell(Text('13.3')),
            DataCell(Text('34.2')),
            DataCell(Text('38.9')),
            DataCell(Text('17.7')),
            DataCell(Text('21.5')),
            DataCell(Text('82.5')),
            DataCell(Text('8.8')),
            DataCell(Text('33.2')),
            DataCell(Text('42.0')),
            DataCell(Text('27.1')),
            DataCell(Text('12.7')),
            DataCell(Text('8.5')),
            DataCell(Text('6.6')),
            DataCell(Text('5.1')),
            DataCell(Text('18.8')),
            DataCell(Text('18.9')),
            DataCell(Text('7.4')),
          ]),
          DataRow(cells: [
            DataCell(Text('4',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),
            DataCell(Image.asset("assets/image/person.png",width: 20,height: 20,)),
            DataCell(Text('Boston Celtics',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.5,
                    color: Colors.blue,
                    fontFamily: 'Inter'))),
            DataCell(Text('82')),
            DataCell(Text('64')),
            DataCell(Text('18')),
            DataCell(Text('.780')),
            DataCell(Text('48.4')),
            DataCell(Text('120.6')),
            DataCell(Text('43.9')),
            DataCell(Text('90.2')),
            DataCell(Text('48.7')),
            DataCell(Text('16.5')),
            DataCell(Text('42.5')),
            DataCell(Text('38.8')),
            DataCell(Text('16.3')),
            DataCell(Text('20.2')),
            DataCell(Text('80.7')),
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
          DataRow(cells: [
            DataCell(Text('5',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),
            DataCell(Image.asset("assets/image/person.png",width: 20,height: 20,)),
            DataCell(Text('Denver Nuggets',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.5,
                    color: Colors.blue,
                    fontFamily: 'Inter'))),
            DataCell(Text('82')),
            DataCell(Text('57')),
            DataCell(Text('25')),
            DataCell(Text('.695')),
            DataCell(Text('48.1')),
            DataCell(Text('114.9')),
            DataCell(Text('44.0')),
            DataCell(Text('88.8')),
            DataCell(Text('49.8')),
            DataCell(Text('11.7')),
            DataCell(Text('31.2')),
            DataCell(Text('37.4')),
            DataCell(Text('15.1')),
            DataCell(Text('19.9')),
            DataCell(Text('76.2')),
            DataCell(Text('10.7')),
            DataCell(Text('33.7')),
            DataCell(Text('44.4')),
            DataCell(Text('29.5')),
            DataCell(Text('12.6')),
            DataCell(Text('7.1')),
            DataCell(Text('5.6')),
            DataCell(Text('4.8')),
            DataCell(Text('18.2')),
            DataCell(Text('17.9')),
            DataCell(Text('5.3')),
          ]),
          DataRow(cells: [
            DataCell(Text('6',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),
            DataCell(Image.asset("assets/image/person.png",width: 20,height: 20,)),
            DataCell(Text('Oklahoma City Thunder',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.5,
                    color: Colors.blue,
                    fontFamily: 'Inter'))),
            DataCell(Text('82')),
            DataCell(Text('57')),
            DataCell(Text('25')),
            DataCell(Text('.695')),
            DataCell(Text('48.3')),
            DataCell(Text('120.1')),
            DataCell(Text('44.5')),
            DataCell(Text('89.3')),
            DataCell(Text('49.9')),
            DataCell(Text('13.3')),
            DataCell(Text('34.2')),
            DataCell(Text('38.9')),
            DataCell(Text('17.7')),
            DataCell(Text('21.5')),
            DataCell(Text('82.5')),
            DataCell(Text('8.8')),
            DataCell(Text('33.2')),
            DataCell(Text('42.0')),
            DataCell(Text('27.1')),
            DataCell(Text('12.7')),
            DataCell(Text('8.5')),
            DataCell(Text('6.6')),
            DataCell(Text('5.1')),
            DataCell(Text('18.8')),
            DataCell(Text('18.9')),
            DataCell(Text('7.4')),
          ]),
          DataRow(cells: [
            DataCell(Text('7',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),
            DataCell(Image.asset("assets/image/person.png",width: 20,height: 20,)),
            DataCell(Text('Boston Celtics',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.5,
                    color: Colors.blue,
                    fontFamily: 'Inter'))),
            DataCell(Text('82')),
            DataCell(Text('64')),
            DataCell(Text('18')),
            DataCell(Text('.780')),
            DataCell(Text('48.4')),
            DataCell(Text('120.6')),
            DataCell(Text('43.9')),
            DataCell(Text('90.2')),
            DataCell(Text('48.7')),
            DataCell(Text('16.5')),
            DataCell(Text('42.5')),
            DataCell(Text('38.8')),
            DataCell(Text('16.3')),
            DataCell(Text('20.2')),
            DataCell(Text('80.7')),
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
          DataRow(cells: [
            DataCell(Text('8',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),
            DataCell(Image.asset("assets/image/person.png",width: 20,height: 20,)),
            DataCell(Text('Denver Nuggets',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.5,
                    color: Colors.blue,
                    fontFamily: 'Inter'))),
            DataCell(Text('82')),
            DataCell(Text('57')),
            DataCell(Text('25')),
            DataCell(Text('.695')),
            DataCell(Text('48.1')),
            DataCell(Text('114.9')),
            DataCell(Text('44.0')),
            DataCell(Text('88.8')),
            DataCell(Text('49.8')),
            DataCell(Text('11.7')),
            DataCell(Text('31.2')),
            DataCell(Text('37.4')),
            DataCell(Text('15.1')),
            DataCell(Text('19.9')),
            DataCell(Text('76.2')),
            DataCell(Text('10.7')),
            DataCell(Text('33.7')),
            DataCell(Text('44.4')),
            DataCell(Text('29.5')),
            DataCell(Text('12.6')),
            DataCell(Text('7.1')),
            DataCell(Text('5.6')),
            DataCell(Text('4.8')),
            DataCell(Text('18.2')),
            DataCell(Text('17.9')),
            DataCell(Text('5.3')),
          ]),
          DataRow(cells: [
            DataCell(Text('9',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),
            DataCell(Image.asset("assets/image/person.png",width: 20,height: 20,)),
            DataCell(Text('Oklahoma City Thunder',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.5,
                    color: Colors.blue,
                    fontFamily: 'Inter'))),
            DataCell(Text('82')),
            DataCell(Text('57')),
            DataCell(Text('25')),
            DataCell(Text('.695')),
            DataCell(Text('48.3')),
            DataCell(Text('120.1')),
            DataCell(Text('44.5')),
            DataCell(Text('89.3')),
            DataCell(Text('49.9')),
            DataCell(Text('13.3')),
            DataCell(Text('34.2')),
            DataCell(Text('38.9')),
            DataCell(Text('17.7')),
            DataCell(Text('21.5')),
            DataCell(Text('82.5')),
            DataCell(Text('8.8')),
            DataCell(Text('33.2')),
            DataCell(Text('42.0')),
            DataCell(Text('27.1')),
            DataCell(Text('12.7')),
            DataCell(Text('8.5')),
            DataCell(Text('6.6')),
            DataCell(Text('5.1')),
            DataCell(Text('18.8')),
            DataCell(Text('18.9')),
            DataCell(Text('7.4')),
          ]),
          DataRow(cells: [
            DataCell(Text('10',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),
            DataCell(Image.asset("assets/image/person.png",width: 20,height: 20,)),
            DataCell(Text('Boston Celtics',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.5,
                    color: Colors.blue,
                    fontFamily: 'Inter'))),
            DataCell(Text('82')),
            DataCell(Text('64')),
            DataCell(Text('18')),
            DataCell(Text('.780')),
            DataCell(Text('48.4')),
            DataCell(Text('120.6')),
            DataCell(Text('43.9')),
            DataCell(Text('90.2')),
            DataCell(Text('48.7')),
            DataCell(Text('16.5')),
            DataCell(Text('42.5')),
            DataCell(Text('38.8')),
            DataCell(Text('16.3')),
            DataCell(Text('20.2')),
            DataCell(Text('80.7')),
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
          DataRow(cells: [
            DataCell(Text('11',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),
            DataCell(Image.asset("assets/image/person.png",width: 20,height: 20,)),
            DataCell(Text('Denver Nuggets',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.5,
                    color: Colors.blue,
                    fontFamily: 'Inter'))),
            DataCell(Text('82')),
            DataCell(Text('57')),
            DataCell(Text('25')),
            DataCell(Text('.695')),
            DataCell(Text('48.1')),
            DataCell(Text('114.9')),
            DataCell(Text('44.0')),
            DataCell(Text('88.8')),
            DataCell(Text('49.8')),
            DataCell(Text('11.7')),
            DataCell(Text('31.2')),
            DataCell(Text('37.4')),
            DataCell(Text('15.1')),
            DataCell(Text('19.9')),
            DataCell(Text('76.2')),
            DataCell(Text('10.7')),
            DataCell(Text('33.7')),
            DataCell(Text('44.4')),
            DataCell(Text('29.5')),
            DataCell(Text('12.6')),
            DataCell(Text('7.1')),
            DataCell(Text('5.6')),
            DataCell(Text('4.8')),
            DataCell(Text('18.2')),
            DataCell(Text('17.9')),
            DataCell(Text('5.3')),
          ]),
          DataRow(cells: [
            DataCell(Text('12',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),
            DataCell(Image.asset("assets/image/person.png",width: 20,height: 20,)),
            DataCell(Text('Oklahoma City Thunder',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.5,
                    color: Colors.blue,
                    fontFamily: 'Inter'))),
            DataCell(Text('82')),
            DataCell(Text('57')),
            DataCell(Text('25')),
            DataCell(Text('.695')),
            DataCell(Text('48.3')),
            DataCell(Text('120.1')),
            DataCell(Text('44.5')),
            DataCell(Text('89.3')),
            DataCell(Text('49.9')),
            DataCell(Text('13.3')),
            DataCell(Text('34.2')),
            DataCell(Text('38.9')),
            DataCell(Text('17.7')),
            DataCell(Text('21.5')),
            DataCell(Text('82.5')),
            DataCell(Text('8.8')),
            DataCell(Text('33.2')),
            DataCell(Text('42.0')),
            DataCell(Text('27.1')),
            DataCell(Text('12.7')),
            DataCell(Text('8.5')),
            DataCell(Text('6.6')),
            DataCell(Text('5.1')),
            DataCell(Text('18.8')),
            DataCell(Text('18.9')),
            DataCell(Text('7.4')),
          ]),
          // Add more rows as needed
        ],
      ),
    );
  }
}
