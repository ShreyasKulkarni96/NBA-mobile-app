import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nbp/shimmerpage.dart';
import 'package:nbp/utility/colors.dart';
import 'package:nbp/utility/textview/custom_textview.dart';
import 'package:shimmer/shimmer.dart';

class GamesScreen extends StatefulWidget {
  @override
  _GamesScreenState createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen>
    with SingleTickerProviderStateMixin {
  var gamesList = [
    {
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
    },
    {
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
    },
    {
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
    },
    {
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
    },
    {
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
    },
    {
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
    },
    {
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
    },
    {
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
    },
    {
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
    tabController.addListener((){
      tabController.index=1;

    });
    Loading();
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
          height: 80,
        ),
        TabBar(
            onTap: (index) {
              tabController.index = 1;
            },
            tabAlignment: TabAlignment.center,
            labelColor: blackTextColor,
            dividerColor: Colors.white,
            indicatorColor: blackTextColor,
            indicatorWeight: 3,
            unselectedLabelColor: blackTextColor,
            labelStyle: TextStyle(
                fontSize: 18,
                fontFamily: 'Inter',
                color: blackTextColor,
                fontWeight: FontWeight.w500),
            unselectedLabelStyle: TextStyle(
                fontSize: 18,
                fontFamily: 'Inter',
                color: blackTextColor,
                fontWeight: FontWeight.w500),
            isScrollable: true,
            controller: tabController,
            tabs: const <Widget>[
              Tab(
                text: " Yesterday ",
              ),
              Tab(
                text: " Today ",
              ),
              Tab(
                text: " Tomorrow ",
              )
            ]),
        const SizedBox(
          height: 5,
        ),
        Expanded(
            child: TabBarView(
          controller: tabController,
          children: <Widget>[
            GamesYesterdaysListWidegt(),
            isLoading ? const LoadingListPage() : GamesTodaysListWidegt(),
            GamesTomarrowListWidegt(),
          ],
        )),
      ],
    ));
  }

  Widget GamesYesterdaysListWidegt() {
    return Center(
      child:  CustomTextView(
          title: 'coming soon',
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
          color:Colors.black,
          textAlign:TextAlign.center
      ),
    );
  }

  Widget GamesTomarrowListWidegt() {
    return Center(
     child: CustomTextView(
          title: 'coming soon',
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
          color:Colors.black,
          textAlign:TextAlign.center
      ),
    );
  }

  Widget GamesTodaysListWidegt() {
    return Center(
      child: ListView.builder(
          itemCount: gamesList.length,
          itemBuilder: (context, index) {
            return Container(
              color: grayBgColor,
              margin: EdgeInsets.only(
                  top: 10.0, left: 30.0, right: 30.0, bottom: 5.0),
              padding: EdgeInsets.all(20.0),
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
                    padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                    child: Image.asset(
                      "assets/image/team3.png",
                      width: 80,
                      height: 80,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Icon(
                    Icons.circle,
                    color: lightGrayBgColor,
                    size: 50,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: lightGrayBgColor,
                        shape: BoxShape.rectangle,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        )),
                    padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                    child: Image.asset(
                      "assets/image/team2.png",
                      width: 80,
                      height: 80,
                      fit: BoxFit.fill,
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
