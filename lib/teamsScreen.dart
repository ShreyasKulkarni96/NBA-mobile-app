import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nbp/shimmerpage.dart';
import 'package:nbp/utility/HelperClass.dart';
import 'package:nbp/utility/colors.dart';
import 'package:nbp/utility/textview/custom_textview.dart';

import 'CONSTANTS.dart';

class TeamsScreen extends StatefulWidget {
  @override
  _TeamsScreenState createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen>
    with SingleTickerProviderStateMixin {
  var teamsList = [
    {
      "id": 1,
      "teamName": "Boston Celtics",
      "image": "assets/image/team3.png",
      "isSelected": false,
    },
    {
      "id": 2,
      "teamName": "Boston Celtics",
      "image": "assets/image/team3.png",
      "isSelected": false,
    },
    {
      "id": 3,
      "teamName": "Boston Celtics",
      "image": "assets/image/team3.png",
      "isSelected": false,
    },
  ];
  var playersList = [
    {
      "id": 1,
      "playerName": "Precious Achiuwa",
      "image": "assets/image/person.png",
      "isSelected": false,
    },
    {
      "id": 2,
      "playerName": "Steven Adams",
      "image": "assets/image/person.png",
      "isSelected": false,
    },
    {
      "id": 3,
      "playerName": "Bam Adebayo",
      "image": "assets/image/person.png",
      "isSelected": false,
    },
    {
      "id": 4,
      "playerName": "Ochai Agbaji",
      "image": "assets/image/person.png",
      "isSelected": false,
    },
  ];

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
    GetTeamsList();
  }

  Future<void> Loading() async {
    _timer = Timer(Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const SizedBox(
          height: 40,
        ),
        Expanded(
          child: isLoading ? const LoadingListPage() : TeamsListWidegt(),
        ),
      ],
    ));
  }

  Widget TeamsListWidegt() {
    return Center(
      child: ListView.builder(
          itemCount: teamsList.length,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => GamesDetailsScreen()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: lightGrayBgColor,
                        shape: BoxShape.rectangle,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(30),
                        )),
                    margin: EdgeInsets.only(
                        top: 10.0, left: 10.0, right: 10.0, bottom: 5.0),
                    padding: EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                          child: Image.asset(
                            teamsList[index]["image"].toString(),
                            width: 60,
                            height: 60,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextView(
                                title: teamsList[index]["teamName"],
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                textAlign: TextAlign.center),
                            CustomTextView(
                                title: 'Tap for detail team view',
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: grayBgColor,
                                textAlign: TextAlign.center),
                          ],
                        ),
                        if (teamsList[index]["isSelected"] == false)
                          InkWell(
                            onTap: () {
                              setState(() {
                                teamsList[index]["isSelected"] = true;
                              });
                            },
                            child: Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: Colors.black,
                              size: 25,
                            ),
                          ),
                        if (teamsList[index]["isSelected"] == true)
                          InkWell(
                            onTap: () {
                              setState(() {
                                teamsList[index]["isSelected"] = false;

                                GetPlayerList(teamsList[index]["id"]);
                              });
                            },
                            child: const Icon(
                              Icons.keyboard_arrow_up_outlined,
                              color: Colors.black,
                              size: 25,
                            ),
                          )
                      ],
                    ),
                  ),
                ),
                if (teamsList[index]["isSelected"] == true &&
                    playersList.isNotEmpty)
                  playerListWidegt()
              ],
            );
          }),
    );
  }

  Widget playerListWidegt() {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
          itemCount: playersList.length,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                // Navigator.of(context).push(MaterialPageRoute(builder: (context) => GamesDetailsScreen()));
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: index % 2 == 0 ? lightGrayBgColor : Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5),
                      )),
                  margin: EdgeInsets.only(
                      top: 20.0, left: 10.0, right: 20.0, bottom: 5.0),
                  padding: EdgeInsets.all(20.0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                          child: Image.asset(
                            playersList[index]["image"].toString(),
                            width: 60,
                            height: 60,
                            fit: BoxFit.fill,
                          ),
                        ),
                        CustomTextView(
                            title: playersList[index]["playerName"],
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            textAlign: TextAlign.center),
                      ],
                    ),
                  )),
            );
          }),
    );
  }

  GetTeamsList() async {
    setState(() {
      isLoading = true;
      teamsList.clear();
    });

    var url = Uri.parse(CONSTANTS.baseUrl + CONSTANTS.fetchTeams);
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
        teamsList = res;
        for (int i = 0; i < teamsList.length; i++) {
          teamsList[i]["isSelected"] = false;
        }
      });
    } else if (response.statusCode == 400) {
      showToast(res['message']);
    } else if (response.statusCode == 401) {
      showToast(res['message']);
    } else {
      print(res['message']);
    }
  }

  GetPlayerList(var id) async {
    setState(() {
      isLoading = true;
      playersList.clear();
    });

    var url = Uri.parse(CONSTANTS.baseUrl + CONSTANTS.fetchTeamsDetails + id);
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
        playersList = res;
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
