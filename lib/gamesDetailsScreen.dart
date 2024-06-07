import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nbp/shimmerpage.dart';
import 'package:nbp/utility/colors.dart';
import 'package:nbp/utility/textview/custom_textview.dart';
import 'package:shimmer/shimmer.dart';

class GamesDetailsScreen extends StatefulWidget {
  @override
  _GamesDetailsScreenState createState() => _GamesDetailsScreenState();
}

class _GamesDetailsScreenState extends State<GamesDetailsScreen>
    with SingleTickerProviderStateMixin {
  var gamesList = {
    "id": 1,
    "date": "2018-10-16",
    "season": 2018,
    "status": "Final",
    "period": 4,
    "time": " ",
    "postseason": false,
    "home_team_score": 105,
    "visitor_team_score": 87,
    "home_team": {
      "id": 2,
      "conference": "East",
      "division": "Atlantic",
      "city": "Boston",
      "name": "Celtics",
      "full_name": "Boston Celtics",
      "abbreviation": "BOS"
    },
    "visitor_team": {
      "id": 23,
      "conference": "East",
      "division": "Atlantic",
      "city": "Philadelphia",
      "name": "76ers",
      "full_name": "Philadelphia 76ers",
      "abbreviation": "PHI"
    }
  };

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
          GamesDetailsWidegt(),
          GamesDetails2Widegt()
          // TabBar(
          //     onTap: (index) {
          //       tabController.index = 1;
          //     },
          //     tabAlignment: TabAlignment.center,
          //     labelColor: blackTextColor,
          //     dividerColor: Colors.white,
          //     indicatorColor: blackTextColor,
          //     indicatorWeight: 3,
          //     unselectedLabelColor: blackTextColor,
          //     labelStyle: TextStyle(
          //         fontSize: 18,
          //         fontFamily: 'Inter',
          //         color: blackTextColor,
          //         fontWeight: FontWeight.w500),
          //     unselectedLabelStyle: TextStyle(
          //         fontSize: 18,
          //         fontFamily: 'Inter',
          //         color: blackTextColor,
          //         fontWeight: FontWeight.w500),
          //     isScrollable: true,
          //     controller: tabController,
          //     tabs: const <Widget>[
          //       Tab(
          //         text: " Yesterday ",
          //       ),
          //       Tab(
          //         text: " Today ",
          //       ),
          //       Tab(
          //         text: " Tomorrow ",
          //       )
          //     ]),
          // const SizedBox(
          //   height: 5,
          // ),
          // Expanded(
          //     child: TabBarView(
          //   controller: tabController,
          //   children: <Widget>[
          //     GamesYesterdaysListWidegt(),
          //     isLoading ? const LoadingListPage() : GamesTodaysListWidegt(),
          //     GamesTomarrowListWidegt(),
          //   ],
          // )),
        ],
      ),
    ));
  }

  Widget GamesDetailsWidegt() {
    return Center(
        child: _switchValue == false
            ? Column(
                children: [
                  Container(
                    color: grayBgColor,
                    margin: const EdgeInsets.only(
                        top: 12.0, left: 30.0, right: 30.0, bottom: 0.0),
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: lightGrayBgColor,
                              shape: BoxShape.rectangle,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              )),
                          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                          child: Image.asset(
                            "assets/image/team3.png",
                            width: 80,
                            height: 80,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: lightGrayBgColor,
                            shape: BoxShape.circle,
                            // borderRadius: const BorderRadius.all(
                            //   Radius.circular(25),
                            // )
                          ),
                          padding: const EdgeInsets.all(8),
                          child: CustomTextView(
                              title: '7.0',
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              textAlign: TextAlign.center),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: lightGrayBgColor,
                              shape: BoxShape.rectangle,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              )),
                          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                          child: Image.asset(
                            "assets/image/team2.png",
                            width: 80,
                            height: 80,
                            fit: BoxFit.fill,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: lightGrayBgColor,
                    margin: const EdgeInsets.only(
                        top: 0.0, left: 30.0, right: 30.0, bottom: 12.0),
                    padding: const EdgeInsets.only(
                        top: 12.0, left: 20.0, right: 20.0, bottom: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomTextView(
                            title: 'Playoffs',
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            textAlign: TextAlign.center),
                        CustomTextView(
                            title: 'Game 3',
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            textAlign: TextAlign.center),
                        CustomTextView(
                            title: 'FINAL/OT1',
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            textAlign: TextAlign.center),
                      ],
                    ),
                  )
                ],
              )
            : Column(
                children: [
                  Container(
                    color: grayBgColor,
                    margin: const EdgeInsets.only(
                        top: 12.0, left: 30.0, right: 30.0, bottom: 0.0),
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: lightGrayBgColor,
                                  shape: BoxShape.rectangle,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  )),
                              padding:
                                  const EdgeInsets.fromLTRB(15, 10, 15, 10),
                              child: ImageFiltered(
                                  imageFilter:
                                      ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                  child: Image.asset(
                                    "assets/image/team3.png",
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.fill,
                                  )),
                            ),
                            Positioned(
                                child: Container(
                              width: 80,
                              height: 80,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  )),
                              margin: const EdgeInsets.fromLTRB(15, 15, 15, 10),
                              padding:
                                  const EdgeInsets.fromLTRB(15, 10, 15, 10),
                              child: CustomTextView(
                                  title: '110',
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  textAlign: TextAlign.center),
                            ))
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: lightGrayBgColor,
                            shape: BoxShape.circle,
                            // borderRadius: const BorderRadius.all(
                            //   Radius.circular(25),
                            // )
                          ),
                          padding: const EdgeInsets.all(8),
                          child: CustomTextView(
                              title: '7.0',
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              textAlign: TextAlign.center),
                        ),
                        Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: lightGrayBgColor,
                                  shape: BoxShape.rectangle,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  )),
                              padding:
                                  const EdgeInsets.fromLTRB(15, 10, 15, 10),
                              child: ImageFiltered(
                                  imageFilter:
                                      ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                  child: Image.asset(
                                    "assets/image/team2.png",
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.fill,
                                  )),
                            ),
                            Positioned(
                                child: Container(
                              width: 80,
                              height: 80,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  )),
                              margin: const EdgeInsets.fromLTRB(15, 15, 15, 10),
                              padding:
                                  const EdgeInsets.fromLTRB(15, 10, 15, 10),
                              child: CustomTextView(
                                  title: '102',
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  textAlign: TextAlign.center),
                            ))
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: lightGrayBgColor,
                    margin: const EdgeInsets.only(
                        top: 0.0, left: 30.0, right: 30.0, bottom: 12.0),
                    padding: const EdgeInsets.only(
                        top: 12.0, left: 20.0, right: 20.0, bottom: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomTextView(
                            title: 'Playoffs',
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            textAlign: TextAlign.center),
                        const SizedBox(
                          width: 3,
                        ),
                        CustomTextView(
                            title: 'Game 3',
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            textAlign: TextAlign.center),
                        const SizedBox(
                          width: 3,
                        ),
                        CustomTextView(
                            title: 'FINAL/OT1',
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            textAlign: TextAlign.center),
                        const SizedBox(
                          width: 3,
                        ),
                        CustomTextView(
                            title: 'SAC lead 2-1',
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            textAlign: TextAlign.center)
                      ],
                    ),
                  )
                ],
              ));
  }

  Widget GamesDetails2Widegt() {
    return Center(
        child: Column(
      children: [
        Container(
          color: lightGrayBgColor,
          margin: const EdgeInsets.only(
              top: 12.0, left: 30.0, right: 30.0, bottom: 0.0),
          padding: const EdgeInsets.only(
              top: 5.0, left: 20.0, right: 20.0, bottom: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextView(
                  title: 'Show Spoilers',
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  textAlign: TextAlign.center),
              CupertinoSwitch(
                value: _switchValue,
                onChanged: (value) {
                  setState(() {
                    _switchValue = value;
                  });
                },
              ),
            ],
          ),
        ),
        _switchValue == false
            ? Container(
                color: grayBgColor,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                    top: 0.0, left: 30.0, right: 30.0, bottom: 12.0),
                padding: const EdgeInsets.only(
                    top: 12.0, left: 20.0, right: 20.0, bottom: 70.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextView(
                        title: 'Winner',
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        textAlign: TextAlign.center),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomTextView(
                        title: 'Starters',
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        textAlign: TextAlign.center),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomTextView(
                        title: 'Leading Scorer',
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        textAlign: TextAlign.center),
                    Container(
                        color: lightGrayBgColor,
                        margin: const EdgeInsets.only(
                            top: 5.0, left: 5.0, right: 5.0, bottom: 0.0),
                        padding: const EdgeInsets.only(
                            top: 5.0, left: 20.0, right: 12.0, bottom: 5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    CustomTextView(
                                        title: 'SAC',
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w500,
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
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    CustomTextView(
                                        title: 'DET',
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        textAlign: TextAlign.center),
                                    Container(
                                      height: 4,
                                      width: 35,
                                      child: Divider(
                                        height: 3,
                                        color: Colors.grey.shade800,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: CustomTextView(
                                  title: 'J. Ivey',
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  textAlign: TextAlign.start),
                            )
                          ],
                        )),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomTextView(
                        title: 'Free Throws',
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        textAlign: TextAlign.center),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomTextView(
                        title: 'Turnovers',
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        textAlign: TextAlign.center),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomTextView(
                        title: 'Score Differential',
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        textAlign: TextAlign.center),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomTextView(
                        title: 'Quarter Summary',
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        textAlign: TextAlign.center),
                  ],
                ),
              )
            : Container(
                color: grayBgColor,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                    top: 0.0, left: 30.0, right: 30.0, bottom: 12.0),
                padding: const EdgeInsets.only(
                    top: 12.0, left: 5.0, right: 5.0, bottom: 12.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            CustomTextView(
                                title: 'Summary',
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                textAlign: TextAlign.center),
                            Container(
                              height: 4,
                              width: 35,
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
                                title: 'Box Score',
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                textAlign: TextAlign.center),
                            Container(
                              height: 4,
                              width: 90,
                              child: Divider(
                                height: 3,
                                color: Colors.grey.shade800,
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            CustomTextView(
                                title: 'Plays',
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
                    PlayersStatsTable1()
                  ],
                ),
              ),
      ],
    ));
  }
}


class PlayersStatsTable1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columnWidth = (constraints.maxWidth - 16) / 8;
        final columnWidth1 = (constraints.maxWidth - 16) / 3;
        final columnWidth2 = (constraints.maxWidth - 16) / 6;

        return

          Column(children: [
            Padding(
            padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 1),
            child: Table(
              columnWidths: {
                0: FixedColumnWidth(columnWidth1),
                1: FixedColumnWidth(columnWidth2),
                2: FixedColumnWidth(columnWidth),
                3: FixedColumnWidth(columnWidth),
                4: FixedColumnWidth(columnWidth),
                5: FixedColumnWidth(columnWidth),
              },
              border: TableBorder.all(color: Colors.grey.shade300),
              children: [
                TableRow(
                  decoration: BoxDecoration(
                    color: lightGrayBgColor,
                  ),
                  children: [
                    tableCell('STARTERS'),
                    tableCell('MIN'),
                    tableCell('PTS'),
                    tableCell('REB'),
                    tableCell('AST'),
                    tableCell('STL'),
                  ],
                ),
                tableRow('T. Brown Jr.',' SF', '22:35', '0', '3', '0', '2'),
                tableRow('C. Metu',' PF', '34:46', '7', '11', '2', '0'),
                tableRow('J. Duren',' C', '27:32', '15', '11', '2', '0'),
                tableRow('J. Ivey',' SG', '31:46', '25', '5', '4', '0'),
                tableRow('M. Sasser',' PG', '26:50', '10', '3', '5', '0'),
              ],
            ),
          ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0.0, 0, 8),
              child: Table(
                columnWidths: {
                  0: FixedColumnWidth(columnWidth1),
                  1: FixedColumnWidth(columnWidth2),
                  2: FixedColumnWidth(columnWidth),
                  3: FixedColumnWidth(columnWidth),
                  4: FixedColumnWidth(columnWidth),
                  5: FixedColumnWidth(columnWidth),
                },
                border: TableBorder.all(color: Colors.grey.shade300),
                children: [
                  TableRow(
                    decoration: BoxDecoration(
                      color: lightGrayBgColor,
                    ),
                    children: [
                      tableCell('BENCH'),
                      tableCell('MIN'),
                      tableCell('PTS'),
                      tableCell('REB'),
                      tableCell('AST'),
                      tableCell('STL'),
                    ],
                  ),
                  tableRow('J. Wiseman',' ', '20:28', '8', '6', '2', '0'),
                  tableRow('J. Rhoden',' ', '14:40', '2', '1', '0', '0'),
                  tableRow('M. Flynn',' ', '21:10', '12', '0', '4', '0'),
                  tableRow('E. Fournier',' ', '26:21', '21', '3', '0', '1'),
                  tableRow('J. Nowell',' ', '10:27', '2', '1', '1', '0'),
                  tableRow('B. Boeheim',' ', '03:25', '0', '0', '0', '0'),



                ],
              ),
            )],)
          ;
      },
    );
  }

  TableRow tableRow(
      String name,String name2, String min, String pts, String reb, String ast, String stl) {
    return TableRow(
      decoration: BoxDecoration(color: Colors.white),
      children: [
        tableCell1(name,name2),
        tableCell(min),
        tableCell(pts),
        tableCell(reb),
        tableCell(ast),
        tableCell(stl),
      ],
    );
  }

  Widget tableCell(String content) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        content,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 11.5,
            color: Colors.black,
            fontFamily: 'Inter'),
      ),
    );
  }

  Widget tableCell1(String content, String content1) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
                text: content,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter')),
            TextSpan(
                text: content1,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.grey.shade700,
                    fontFamily: 'Inter')),
          ],
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}


