import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nbp/utility/HelperClass.dart';
import 'package:nbp/utility/colors.dart';
import 'package:nbp/utility/textview/custom_textview.dart';

import 'CONSTANTS.dart';
import 'Model/Player.dart';

class GamesDetailsScreen extends StatefulWidget {
  var gameData;

  GamesDetailsScreen({super.key, required this.gameData});

  @override
  _GamesDetailsScreenState createState() => _GamesDetailsScreenState();
}

class _GamesDetailsScreenState extends State<GamesDetailsScreen>
    with SingleTickerProviderStateMixin {
  var gameData = {};
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
  List<Player> players = [];

  bool isHomeTeamClicked = true, isVisitorsTeamClicked = false;

  late TabController tabController;
  bool isLoading = true;
  late Timer _timer;
  List homeTeamStarters = [],
      homeTeamBench = [],
      visitorTeamStarters = [],
      visitorTeamBench = [];

  @override
  void initState() {
    super.initState();
    // Initialise Tab Controller
    tabController = TabController(length: 3, vsync: this, initialIndex: 1);
    tabController.addListener(() {
      tabController.index = 1;
    });
    gameData = widget.gameData;

    Loading();
    getData();
  }

  void getData() {
    // Home team starters
    homeTeamStarters =
        gameData['home_team']['show_spoilers']['starters']['players'];
    homeTeamStarters.forEach((player) {
      players.add(Player.fromJson(player, _getPosition(player)));
    });

    // Home team bench
    homeTeamBench = gameData['home_team']['show_spoilers']['bench']['players'];
    homeTeamBench.forEach((player) {
      players.add(Player.fromJson(player, 'Bench'));
    });

    // Visitor team starters
    visitorTeamStarters =
        gameData['visitor_team']['show_spoilers']['starters']['players'];
    visitorTeamStarters.forEach((player) {
      players.add(Player.fromJson(player, _getPosition(player)));
    });

    // Visitor team bench
    visitorTeamBench =
        gameData['visitor_team']['show_spoilers']['bench']['players'];
    visitorTeamBench.forEach((player) {
      players.add(Player.fromJson(player, 'Bench'));
    });

    // Now you have a list of Player objects
    players.forEach((player) {
      print('${player.fullName}: ${player.pts} points');
    });
  }

  String _getPosition(Map<String, dynamic> player) {
    if (player['PG'] == true) return 'PG';
    if (player['SG'] == true) return 'SG';
    if (player['SF'] == true) return 'SF';
    if (player['PF'] == true) return 'PF';
    if (player['C'] == true) return 'C';
    return 'Unknown';
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
                          child: Image.network(
                            gameData["home_team"]["image"].toString(),
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
                              title: gameData["period"].toString(),
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
                          child: Image.network(
                            gameData["visitor_team"]["image"].toString(),
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
                                  child: Image.network(
                                    gameData["home_team"]["image"].toString(),
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
                                  title: gameData["home_team_score"].toString(),
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
                              title: gameData["period"].toString(),
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
                                  child: Image.network(
                                    gameData["visitor_team"]["image"]
                                        .toString(),
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
                                  title:
                                      gameData["visitor_team_score"].toString(),
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
                color: lightGrayBgColor,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                    top: 30.0, left: 30.0, right: 30.0, bottom: 12.0),
                padding: const EdgeInsets.only(
                    top: 12.0, left: 20.0, right: 20.0, bottom: 70.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextView(
                        title: 'Winner : '+ gameData["home_team"]["name"]
                            .toString(),
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
                    QuarterSummaryDataTable()
                  ],
                ),
              )
            : Container(
                color: grayBgColor,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                    top: 30.0, left: 30.0, right: 30.0, bottom: 12.0),
                padding: const EdgeInsets.only(
                    top: 12.0, left: 5.0, right: 5.0, bottom: 12.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                            onTap: () {
                              setState(() {
                                isVisitorsTeamClicked = false;
                                isHomeTeamClicked = true;
                              });
                            },
                            child: Column(
                              children: [
                                CustomTextView(
                                    title: gameData["home_team"]["name"]
                                        .toString(),
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    textAlign: TextAlign.center),
                                Container(
                                  height: 4,
                                  width: 100,
                                  child: Divider(
                                    height: 3,
                                    color: isHomeTeamClicked
                                        ? Colors.grey.shade800
                                        : grayBgColor,
                                  ),
                                )
                              ],
                            )),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isVisitorsTeamClicked = true;
                              isHomeTeamClicked = false;
                            });
                          },
                          child: Column(
                            children: [
                              CustomTextView(
                                  title: gameData["visitor_team"]["name"]
                                      .toString(),
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  textAlign: TextAlign.center),
                              Container(
                                height: 4,
                                width: 100,
                                child: Divider(
                                  height: 3,
                                  color: isVisitorsTeamClicked
                                      ? Colors.grey.shade800
                                      : grayBgColor,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (isHomeTeamClicked) HomePlayerStartersTable(),
                    if (isHomeTeamClicked) HomePlayersBenchTable(),
                    if (isVisitorsTeamClicked) VisitorsPlayerStartersTable(),
                    if (isVisitorsTeamClicked) VisitorsPlayersBenchTable()
                  ],
                ),
              ),
      ],
    ));
  }

  GetGameData() async {
    setState(() {
      isLoading = true;
    });
    var url = Uri.parse(CONSTANTS.baseUrl + CONSTANTS.fetchGameData);

    var response = await http.get(url);
    // print("${response.statusCode}");
    print("Response ${response.body}");
    setState(() {
      isLoading = false;
    });
    var res = jsonDecode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        gameData = res;
      });
    } else if (response.statusCode == 400) {
      showToast(res['message']);
    } else if (response.statusCode == 401) {
      showToast(res['message']);
    } else {
      print(res['message']);
    }
  }

  GetGameDetails() async {
    setState(() {
      isLoading = true;
    });
    var url = Uri.parse(CONSTANTS.baseUrl +
        CONSTANTS.fetchGamesDetailsById +
        gameData["id"].toString());
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
        gamesList = res;
      });
    } else if (response.statusCode == 400) {
      showToast(res['message']);
    } else if (response.statusCode == 401) {
      showToast(res['message']);
    } else {
      print(res['message']);
    }
  }

  Widget HomePlayerStartersTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        // decoration: BoxDecoration(
        //   color: lightGrayBgColor,
        // ),
        border: TableBorder.all(color: Colors.grey.shade600),
        dataRowColor: MaterialStateProperty.all(Colors.white),
        headingRowColor: MaterialStateProperty.all(lightGrayBgColor),
        columns: const [
          DataColumn(
              label: Text(
            'STARTERS',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11.5,
                color: Colors.black,
                fontFamily: 'Inter'),
          )),
          DataColumn(
              label: Text(
            'MIN',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11.5,
                color: Colors.black,
                fontFamily: 'Inter'),
          )),
          DataColumn(
              label: Text(
            'PTS',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11.5,
                color: Colors.black,
                fontFamily: 'Inter'),
          )),
          DataColumn(
              label: Text(
            'REB',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11.5,
                color: Colors.black,
                fontFamily: 'Inter'),
          )),
          DataColumn(
              label: Text(
            'AST',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11.5,
                color: Colors.black,
                fontFamily: 'Inter'),
          )),
          DataColumn(
              label: Text(
            'STL',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11.5,
                color: Colors.black,
                fontFamily: 'Inter'),
          )),
        ],
        rows: [
          for (int i = 0; i < homeTeamStarters.length; i++)
            DataRow(cells: [
              DataCell(Text(
                homeTeamStarters[i]["full_name"].toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'),
              )),
              DataCell(Text(
                homeTeamStarters[i]["min"].toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'),
              )),
              DataCell(Text(
                homeTeamStarters[i]["pts"].toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'),
              )),
              DataCell(Text(
                homeTeamStarters[i]["reb"].toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'),
              )),
              DataCell(Text(
                homeTeamStarters[i]["ast"].toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'),
              )),
              DataCell(Text(
                homeTeamStarters[i]["stl"].toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'),
              )),
            ]),
        ],
      ),
    );
  }

  Widget HomePlayersBenchTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        // decoration: BoxDecoration(
        //   color: lightGrayBgColor,
        // ),
        border: TableBorder.all(color: Colors.grey.shade600),
        dataRowColor: MaterialStateProperty.all(Colors.white),
        headingRowColor: MaterialStateProperty.all(lightGrayBgColor),
        columns: const [
          DataColumn(
              label: Text(
            'BENCH',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11.5,
                color: Colors.black,
                fontFamily: 'Inter'),
          )),
          DataColumn(
              label: Text(
            'MIN',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11.5,
                color: Colors.black,
                fontFamily: 'Inter'),
          )),
          DataColumn(
              label: Text(
            'PTS',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11.5,
                color: Colors.black,
                fontFamily: 'Inter'),
          )),
          DataColumn(
              label: Text(
            'REB',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11.5,
                color: Colors.black,
                fontFamily: 'Inter'),
          )),
          DataColumn(
              label: Text(
            'AST',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11.5,
                color: Colors.black,
                fontFamily: 'Inter'),
          )),
          DataColumn(
              label: Text(
            'STL',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11.5,
                color: Colors.black,
                fontFamily: 'Inter'),
          )),
        ],
        rows: [
          for (int i = 0; i < homeTeamBench.length; i++)
            DataRow(cells: [
              DataCell(Text(
                homeTeamBench[i]["full_name"].toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'),
              )),
              DataCell(Text(
                homeTeamBench[i]["min"].toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'),
              )),
              DataCell(Text(
                homeTeamBench[i]["pts"].toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'),
              )),
              DataCell(Text(
                homeTeamBench[i]["reb"].toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'),
              )),
              DataCell(Text(
                homeTeamBench[i]["ast"].toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'),
              )),
              DataCell(Text(
                homeTeamBench[i]["stl"].toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'),
              )),
            ]),
        ],
      ),
    );
  }

  Widget VisitorsPlayerStartersTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        // decoration: BoxDecoration(
        //   color: lightGrayBgColor,
        // ),
        border: TableBorder.all(color: Colors.grey.shade600),
        dataRowColor: MaterialStateProperty.all(Colors.white),
        headingRowColor: MaterialStateProperty.all(lightGrayBgColor),
        columns: const [
          DataColumn(
              label: Text(
            'STARTERS',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11.5,
                color: Colors.black,
                fontFamily: 'Inter'),
          )),
          DataColumn(
              label: Text(
            'MIN',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11.5,
                color: Colors.black,
                fontFamily: 'Inter'),
          )),
          DataColumn(
              label: Text(
            'PTS',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11.5,
                color: Colors.black,
                fontFamily: 'Inter'),
          )),
          DataColumn(
              label: Text(
            'REB',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11.5,
                color: Colors.black,
                fontFamily: 'Inter'),
          )),
          DataColumn(
              label: Text(
            'AST',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11.5,
                color: Colors.black,
                fontFamily: 'Inter'),
          )),
          DataColumn(
              label: Text(
            'STL',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11.5,
                color: Colors.black,
                fontFamily: 'Inter'),
          )),
        ],
        rows: [
          for (int i = 0; i < visitorTeamStarters.length; i++)
            DataRow(cells: [
              DataCell(Text(
                visitorTeamStarters[i]["full_name"].toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'),
              )),
              DataCell(Text(
                visitorTeamStarters[i]["min"].toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'),
              )),
              DataCell(Text(
                visitorTeamStarters[i]["pts"].toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'),
              )),
              DataCell(Text(
                visitorTeamStarters[i]["reb"].toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'),
              )),
              DataCell(Text(
                visitorTeamStarters[i]["ast"].toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'),
              )),
              DataCell(Text(
                visitorTeamStarters[i]["stl"].toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'),
              )),
            ]),
        ],
      ),
    );
  }

  Widget VisitorsPlayersBenchTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        // decoration: BoxDecoration(
        //   color: lightGrayBgColor,
        // ),
        border: TableBorder.all(color: Colors.grey.shade600),
        dataRowColor: MaterialStateProperty.all(Colors.white),
        headingRowColor: MaterialStateProperty.all(lightGrayBgColor),
        columns: const [
          DataColumn(
              label: Text(
            'BENCH',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11.5,
                color: Colors.black,
                fontFamily: 'Inter'),
          )),
          DataColumn(
              label: Text(
            'MIN',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11.5,
                color: Colors.black,
                fontFamily: 'Inter'),
          )),
          DataColumn(
              label: Text(
            'PTS',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11.5,
                color: Colors.black,
                fontFamily: 'Inter'),
          )),
          DataColumn(
              label: Text(
            'REB',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11.5,
                color: Colors.black,
                fontFamily: 'Inter'),
          )),
          DataColumn(
              label: Text(
            'AST',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11.5,
                color: Colors.black,
                fontFamily: 'Inter'),
          )),
          DataColumn(
              label: Text(
            'STL',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11.5,
                color: Colors.black,
                fontFamily: 'Inter'),
          )),
        ],
        rows: [
          for (int i = 0; i < visitorTeamBench.length; i++)
            DataRow(cells: [
              DataCell(Text(
                visitorTeamBench[i]["full_name"].toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'),
              )),
              DataCell(Text(
                visitorTeamBench[i]["min"].toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'),
              )),
              DataCell(Text(
                visitorTeamBench[i]["pts"].toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'),
              )),
              DataCell(Text(
                visitorTeamBench[i]["reb"].toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'),
              )),
              DataCell(Text(
                visitorTeamBench[i]["ast"].toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'),
              )),
              DataCell(Text(
                visitorTeamBench[i]["stl"].toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'),
              )),
            ]),
        ],
      ),
    );
  }
}

class PlayersStatsTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        // decoration: BoxDecoration(
        //   color: lightGrayBgColor,
        // ),
        border: TableBorder.all(color: Colors.grey.shade600),
        dataRowColor: MaterialStateProperty.all(Colors.white),
        headingRowColor: MaterialStateProperty.all(lightGrayBgColor),
        columns: const [
          DataColumn(
              label: Text(
            'STARTERS',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11.5,
                color: Colors.black,
                fontFamily: 'Inter'),
          )),
          DataColumn(
              label: Text(
            'MIN',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11.5,
                color: Colors.black,
                fontFamily: 'Inter'),
          )),
          DataColumn(
              label: Text(
            'PTS',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11.5,
                color: Colors.black,
                fontFamily: 'Inter'),
          )),
          DataColumn(
              label: Text(
            'REB',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11.5,
                color: Colors.black,
                fontFamily: 'Inter'),
          )),
          DataColumn(
              label: Text(
            'AST',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11.5,
                color: Colors.black,
                fontFamily: 'Inter'),
          )),
          DataColumn(
              label: Text(
            'STL',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11.5,
                color: Colors.black,
                fontFamily: 'Inter'),
          )),
        ],
        rows: const [
          DataRow(cells: [
            DataCell(Text(
              'T. Brown Jr.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 11.5,
                  color: Colors.black,
                  fontFamily: 'Inter'),
            )),
            DataCell(Text(
              '22:35',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 11.5,
                  color: Colors.black,
                  fontFamily: 'Inter'),
            )),
            DataCell(Text(
              '0',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 11.5,
                  color: Colors.black,
                  fontFamily: 'Inter'),
            )),
            DataCell(Text(
              '3',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 11.5,
                  color: Colors.black,
                  fontFamily: 'Inter'),
            )),
            DataCell(Text(
              '0',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 11.5,
                  color: Colors.black,
                  fontFamily: 'Inter'),
            )),
            DataCell(Text(
              '2',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 11.5,
                  color: Colors.black,
                  fontFamily: 'Inter'),
            )),
          ]),
          DataRow(cells: [
            DataCell(Text(
              'C. Metu',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 11.5,
                  color: Colors.black,
                  fontFamily: 'Inter'),
            )),
            DataCell(Text(
              '34:46',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 11.5,
                  color: Colors.black,
                  fontFamily: 'Inter'),
            )),
            DataCell(Text(
              '7',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 11.5,
                  color: Colors.black,
                  fontFamily: 'Inter'),
            )),
            DataCell(Text(
              '11',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 11.5,
                  color: Colors.black,
                  fontFamily: 'Inter'),
            )),
            DataCell(Text(
              '2',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 11.5,
                  color: Colors.black,
                  fontFamily: 'Inter'),
            )),
            DataCell(Text(
              '0',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 11.5,
                  color: Colors.black,
                  fontFamily: 'Inter'),
            )),
          ]),
          DataRow(cells: [
            DataCell(Text(
              'J. Duren',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 11.5,
                  color: Colors.black,
                  fontFamily: 'Inter'),
            )),
            DataCell(Text(
              '27:32',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 11.5,
                  color: Colors.black,
                  fontFamily: 'Inter'),
            )),
            DataCell(Text('15',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),
            DataCell(Text('11',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),
            DataCell(Text('2',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),
            DataCell(Text('0',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),
          ]),
          DataRow(cells: [
            DataCell(Text('J. Ivey',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),
            DataCell(Text('31:46',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),
            DataCell(Text('25',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),
            DataCell(Text('5',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),
            DataCell(Text('4',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),
            DataCell(Text('0',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),
          ]),
          DataRow(cells: [
            DataCell(Text('M. Sasser',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),
            DataCell(Text('26:50',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),
            DataCell(Text('10',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),
            DataCell(Text('3',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),
            DataCell(Text('5',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),
            DataCell(Text('0',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),
          ]),
        ],
      ),
    );
  }

  Widget tableCell(String content) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        content,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 11.5,
            color: Colors.black,
            fontFamily: 'Inter'),
      ),
    );
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

        return Column(
          children: [
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
                  tableRow('T. Brown Jr.', ' SF', '22:35', '0', '3', '0', '2'),
                  tableRow('C. Metu', ' PF', '34:46', '7', '11', '2', '0'),
                  tableRow('J. Duren', ' C', '27:32', '15', '11', '2', '0'),
                  tableRow('J. Ivey', ' SG', '31:46', '25', '5', '4', '0'),
                  tableRow('M. Sasser', ' PG', '26:50', '10', '3', '5', '0'),
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
                  tableRow('J. Wiseman', ' ', '20:28', '8', '6', '2', '0'),
                  tableRow('J. Rhoden', ' ', '14:40', '2', '1', '0', '0'),
                  tableRow('M. Flynn', ' ', '21:10', '12', '0', '4', '0'),
                  tableRow('E. Fournier', ' ', '26:21', '21', '3', '0', '1'),
                  tableRow('J. Nowell', ' ', '10:27', '2', '1', '1', '0'),
                  tableRow('B. Boeheim', ' ', '03:25', '0', '0', '0', '0'),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  TableRow tableRow(String name, String name2, String min, String pts,
      String reb, String ast, String stl) {
    return TableRow(
      decoration: const BoxDecoration(color: Colors.white),
      children: [
        tableCell1(name, name2),
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
        style: const TextStyle(
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

class PlayersStatsTable2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        // decoration: BoxDecoration(
        //   color: lightGrayBgColor,
        // ),
        border: TableBorder.all(color: Colors.grey.shade600),
        dataRowColor: MaterialStateProperty.all(Colors.white),
        headingRowColor: MaterialStateProperty.all(lightGrayBgColor),
        columns: const [
          DataColumn(
              label: Text(
            'BENCH',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11.5,
                color: Colors.black,
                fontFamily: 'Inter'),
          )),
          DataColumn(
              label: Text(
            'MIN',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11.5,
                color: Colors.black,
                fontFamily: 'Inter'),
          )),
          DataColumn(
              label: Text(
            'PTS',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11.5,
                color: Colors.black,
                fontFamily: 'Inter'),
          )),
          DataColumn(
              label: Text(
            'REB',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11.5,
                color: Colors.black,
                fontFamily: 'Inter'),
          )),
          DataColumn(
              label: Text(
            'AST',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11.5,
                color: Colors.black,
                fontFamily: 'Inter'),
          )),
          DataColumn(
              label: Text(
            'STL',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11.5,
                color: Colors.black,
                fontFamily: 'Inter'),
          )),
        ],
        rows: const [
          DataRow(cells: [
            DataCell(Text(
              'T. Brown Jr.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 11.5,
                  color: Colors.black,
                  fontFamily: 'Inter'),
            )),
            DataCell(Text(
              '22:35',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 11.5,
                  color: Colors.black,
                  fontFamily: 'Inter'),
            )),
            DataCell(Text(
              '0',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 11.5,
                  color: Colors.black,
                  fontFamily: 'Inter'),
            )),
            DataCell(Text(
              '3',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 11.5,
                  color: Colors.black,
                  fontFamily: 'Inter'),
            )),
            DataCell(Text(
              '0',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 11.5,
                  color: Colors.black,
                  fontFamily: 'Inter'),
            )),
            DataCell(Text(
              '2',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 11.5,
                  color: Colors.black,
                  fontFamily: 'Inter'),
            )),
          ]),
          DataRow(cells: [
            DataCell(Text(
              'C. Metu',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 11.5,
                  color: Colors.black,
                  fontFamily: 'Inter'),
            )),
            DataCell(Text(
              '34:46',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 11.5,
                  color: Colors.black,
                  fontFamily: 'Inter'),
            )),
            DataCell(Text(
              '7',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 11.5,
                  color: Colors.black,
                  fontFamily: 'Inter'),
            )),
            DataCell(Text(
              '11',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 11.5,
                  color: Colors.black,
                  fontFamily: 'Inter'),
            )),
            DataCell(Text(
              '2',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 11.5,
                  color: Colors.black,
                  fontFamily: 'Inter'),
            )),
            DataCell(Text(
              '0',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 11.5,
                  color: Colors.black,
                  fontFamily: 'Inter'),
            )),
          ]),
          DataRow(cells: [
            DataCell(Text(
              'J. Duren',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 11.5,
                  color: Colors.black,
                  fontFamily: 'Inter'),
            )),
            DataCell(Text(
              '27:32',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 11.5,
                  color: Colors.black,
                  fontFamily: 'Inter'),
            )),
            DataCell(Text('15',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),
            DataCell(Text('11',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),
            DataCell(Text('2',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),
            DataCell(Text('0',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),
          ]),
          DataRow(cells: [
            DataCell(Text('J. Ivey',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),
            DataCell(Text('31:46',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),
            DataCell(Text('25',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),
            DataCell(Text('5',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),
            DataCell(Text('4',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),
            DataCell(Text('0',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),
          ]),
          DataRow(cells: [
            DataCell(Text('M. Sasser',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),
            DataCell(Text('26:50',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),
            DataCell(Text('10',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),
            DataCell(Text('3',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),
            DataCell(Text('5',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),
            DataCell(Text('0',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),
          ]),
        ],
      ),
    );
  }

  Widget tableCell(String content) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        content,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 11.5,
            color: Colors.black,
            fontFamily: 'Inter'),
      ),
    );
  }
}


class QuarterSummaryDataTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        border: TableBorder.symmetric(
            outside: BorderSide(color: Colors.grey.shade600)),
        dataRowColor: MaterialStateProperty.all(Colors.white),
        headingRowColor: MaterialStateProperty.all(Colors.white),
        columns: [
          DataColumn(label: Text('  ')),
          DataColumn(label: Text('Q1')),
          DataColumn(label: Text('Q2')),
          DataColumn(label: Text('Q3')),
          DataColumn(label: Text('Q4')),
          DataColumn(label: Text('T')),


        ],
        rows: [
          DataRow(cells: [

            DataCell(Image.asset(
              "assets/image/team2.png",
              width: 20,
              height: 20,
            )),
            DataCell(Text('20',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),

            DataCell(Text('22',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),

            DataCell(Text('24',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),
            DataCell(Text('26',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),
            DataCell(Text('86',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),
          ]),

          DataRow(cells: [

            DataCell(Image.asset(
              "assets/image/team3.png",
              width: 20,
              height: 20,
            )),
            DataCell(Text('37',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),

            DataCell(Text('26',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),

            DataCell(Text('23',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),
            DataCell(Text('21',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),

            DataCell(Text('107',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.5,
                    color: Colors.black,
                    fontFamily: 'Inter'))),
          ]),

          // Add more rows as needed
        ],
      ),
    );
  }
}
