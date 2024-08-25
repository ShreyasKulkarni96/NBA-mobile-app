import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:nbp/gamesDetailsScreen.dart';
import 'package:nbp/shimmerpage.dart';
import 'package:nbp/utility/HelperClass.dart';
import 'package:nbp/utility/colors.dart';
import 'package:nbp/utility/textview/custom_textview.dart';

import 'CONSTANTS.dart';

class GamesScreen extends StatefulWidget {
  @override
  _GamesScreenState createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen>
    with SingleTickerProviderStateMixin {
  List gamesList = [
    {
      "id": 1038045,
      "date": "2024-01-01",
      "season": 2023,
      "status": "Final",
      "period": 4,
      "time": "Final",
      "postseason": false,
      "home_team_score": 136,
      "visitor_team_score": 113,
      "home_team": {
        "id": 11,
        "conference": "West",
        "division": "Southwest",
        "city": "Houston",
        "name": "Rockets",
        "full_name": "Houston Rockets",
        "abbreviation": "HOU",
        "image": "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/hou.png&h=200&w=200",
        "show_spoilers": {
          "starters": {
            "players": [
              {
                "full_name": "Fred VanVleet",
                "min": 36.8,
                "pts": 22.5,
                "reb": 4.4,
                "ast": 7.5,
                "stl": 2.3,
                "PG": true
              },
              {
                "full_name": "Jalen Green",
                "min": 23.0,
                "pts": 13.0,
                "reb": 6.0,
                "ast": 3.0,
                "stl": 0.0,
                "SG": true
              },
              {
                "full_name": "Dillon Brooks",
                "min": 30.2,
                "pts": 10.8,
                "reb": 3.2,
                "ast": 1.2,
                "stl": 0.9,
                "SF": true
              },
              {
                "full_name": "Jabari Smith Jr.",
                "min": 33.0,
                "pts": 15.0,
                "reb": 8.0,
                "ast": 3.0,
                "stl": 0.0,
                "PF": true
              },
              {
                "full_name": "Alperen Sengun",
                "min": 29.0,
                "pts": 14.0,
                "reb": 6.0,
                "ast": 2.0,
                "stl": 2.0,
                "C": true
              }
            ]
          },
          "bench": {
            "players": [
              {
                "full_name": "Amen Thompson",
                "min": 40.0,
                "pts": 18.0,
                "reb": 11.0,
                "ast": 10.0,
                "stl": 3.0
              },
              {
                "full_name": "Tari Eason",
                "min": 24.0,
                "pts": 17.0,
                "reb": 4.0,
                "ast": 1.0,
                "stl": 3.0
              },
              {
                "full_name": "Steven Adams",
                "min": 27.0,
                "pts": 8.6,
                "reb": 11.5,
                "ast": 2.3,
                "stl": 0.9
              },
              {
                "full_name": "Cam Whitmore",
                "min": 36.0,
                "pts": 21.0,
                "reb": 6.0,
                "ast": 5.0,
                "stl": 0.0
              },
              {
                "full_name": "Jeff Green",
                "min": 12.0,
                "pts": 7.0,
                "reb": 2.0,
                "ast": 0.0,
                "stl": 0.0
              },
              {
                "full_name": "Jock Landale",
                "min": 21.0,
                "pts": 5.0,
                "reb": 4.0,
                "ast": 2.0,
                "stl": 1.0
              },
              {
                "full_name": "Aaron Holiday",
                "min": 17.0,
                "pts": 9.0,
                "reb": 2.0,
                "ast": 2.0,
                "stl": 1.0
              }
            ]
          }
        }
      },
      "visitor_team": {
        "id": 9,
        "conference": "East",
        "division": "Central",
        "city": "Detroit",
        "name": "Pistons",
        "full_name": "Detroit Pistons",
        "abbreviation": "DET",
        "image": "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/det.png&h=200&w=200",
        "show_spoilers": {
          "starters": {
            "players": [
              {
                "full_name": "Cade Cunningham",
                "min": 33.3,
                "pts": 33.7,
                "reb": 4.3,
                "ast": 5.7,
                "stl": 1.7,
                "PG": true
              },
              {
                "full_name": "Jaden Ivey",
                "min": 27.0,
                "pts": 13.0,
                "reb": 1.0,
                "ast": 2.0,
                "stl": 0.0,
                "SG": true
              },
              {
                "full_name": "Ausar Thompson",
                "min": 11.0,
                "pts": 4.0,
                "reb": 5.0,
                "ast": 0.0,
                "stl": 1.0,
                "SF": true
              },
              {
                "full_name": "Tobias Harris",
                "min": 33.4,
                "pts": 17.7,
                "reb": 7.9,
                "ast": 2.9,
                "stl": 0.6,
                "PF": true
              },
              {
                "full_name": "Jalen Duren",
                "min": 25.1,
                "pts": 13.4,
                "reb": 9.3,
                "ast": 1.7,
                "stl": 1.0,
                "C": true
              }
            ]
          },
          "bench": {
            "players": [
              {
                "full_name": "Marcus Sasser",
                "min": 31.0,
                "pts": 17.0,
                "reb": 3.0,
                "ast": 7.0,
                "stl": 0.0
              },
              {
                "full_name": "Malik Beasley",
                "min": 28.3,
                "pts": 9.1,
                "reb": 2.4,
                "ast": 1.3,
                "stl": 0.4
              },
              {
                "full_name": "Simone Fontecchio",
                "min": 35.0,
                "pts": 13.0,
                "reb": 8.0,
                "ast": 2.0,
                "stl": 0.0
              },
              {
                "full_name": "Isaiah Stewart",
                "min": 17.0,
                "pts": 5.0,
                "reb": 5.0,
                "ast": 1.0,
                "stl": 0.0
              },
              {
                "full_name": "Paul Reed",
                "min": 20.9,
                "pts": 8.7,
                "reb": 6.5,
                "ast": 1.5,
                "stl": 1.1
              },
              {
                "full_name": "Tim Hardaway Jr.",
                "min": 21.6,
                "pts": 7.8,
                "reb": 2.5,
                "ast": 1.7,
                "stl": 0.4
              }
            ]
          }
        }
      }
    },
    {
      "id": 1038043,
      "date": "2024-01-01",
      "season": 2023,
      "status": "Final",
      "period": 4,
      "time": "Final",
      "postseason": false,
      "home_team_score": 112,
      "visitor_team_score": 106,
      "home_team": {
        "id": 20,
        "conference": "East",
        "division": "Atlantic",
        "city": "New York",
        "name": "Knicks",
        "full_name": "New York Knicks",
        "abbreviation": "NYK",
        "image": "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/ny.png&h=200&w=200",
        "show_spoilers": {
          "starters": {
            "players": []
          },
          "bench": {
            "players": []
          }
        }
      },
      "visitor_team": {
        "id": 18,
        "conference": "West",
        "division": "Northwest",
        "city": "Minnesota",
        "name": "Timberwolves",
        "full_name": "Minnesota Timberwolves",
        "abbreviation": "MIN",
        "image": "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/min.png&h=200&w=200",
        "show_spoilers": {
          "starters": {
            "players": []
          },
          "bench": {
            "players": []
          }
        }
      }
    },
    {
      "id": 1038046,
      "date": "2024-01-01",
      "season": 2023,
      "status": "Final",
      "period": 4,
      "time": "Final",
      "postseason": false,
      "home_team_score": 113,
      "visitor_team_score": 122,
      "home_team": {
        "id": 17,
        "conference": "East",
        "division": "Central",
        "city": "Milwaukee",
        "name": "Bucks",
        "full_name": "Milwaukee Bucks",
        "abbreviation": "MIL",
        "image": "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/mil.png&h=200&w=200",
        "show_spoilers": {
          "starters": {
            "players": []
          },
          "bench": {
            "players": []
          }
        }
      },
      "visitor_team": {
        "id": 12,
        "conference": "East",
        "division": "Central",
        "city": "Indiana",
        "name": "Pacers",
        "full_name": "Indiana Pacers",
        "abbreviation": "IND",
        "image": "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/ind.png&h=200&w=200",
        "show_spoilers": {
          "starters": {
            "players": []
          },
          "bench": {
            "players": []
          }
        }
      }
    },
    {
      "id": 1038044,
      "date": "2024-01-01",
      "season": 2023,
      "status": "Final",
      "period": 4,
      "time": "Final",
      "postseason": false,
      "home_team_score": 124,
      "visitor_team_score": 121,
      "home_team": {
        "id": 28,
        "conference": "East",
        "division": "Atlantic",
        "city": "Toronto",
        "name": "Raptors",
        "full_name": "Toronto Raptors",
        "abbreviation": "TOR",
        "image": "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/tor.png&h=200&w=200",
        "show_spoilers": {
          "starters": {
            "players": []
          },
          "bench": {
            "players": []
          }
        }
      },
      "visitor_team": {
        "id": 6,
        "conference": "East",
        "division": "Central",
        "city": "Cleveland",
        "name": "Cavaliers",
        "full_name": "Cleveland Cavaliers",
        "image": "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/cle.png&h=200&w=200",
        "abbreviation": "CLE",
        "show_spoilers": {
          "starters": {
            "players": []
          },
          "bench": {
            "players": []
          }
        }
      }
    },
    {
      "id": 1038050,
      "date": "2024-01-01",
      "season": 2023,
      "status": "Final",
      "period": 4,
      "time": "Final",
      "postseason": false,
      "home_team_score": 121,
      "visitor_team_score": 104,
      "home_team": {
        "id": 13,
        "conference": "West",
        "division": "Pacific",
        "city": "LA",
        "name": "Clippers",
        "full_name": "LA Clippers",
        "abbreviation": "LAC",
        "image": "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/lac.png&h=200&w=200",
        "show_spoilers": {
          "starters": {
            "players": []
          },
          "bench": {
            "players": []
          }
        }
      },
      "visitor_team": {
        "id": 16,
        "conference": "East",
        "division": "Southeast",
        "city": "Miami",
        "name": "Heat",
        "full_name": "Miami Heat",
        "abbreviation": "MIA",
        "image": "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/mia.png&h=200&w=200",
        "show_spoilers": {
          "starters": {
            "players": []
          },
          "bench": {
            "players": []
          }
        }
      }
    },
    {
      "id": 1038047,
      "date": "2024-01-01",
      "season": 2023,
      "status": "Final",
      "period": 4,
      "time": "Final",
      "postseason": false,
      "home_team_score": 111,
      "visitor_team_score": 93,
      "home_team": {
        "id": 8,
        "conference": "West",
        "division": "Northwest",
        "city": "Denver",
        "name": "Nuggets",
        "full_name": "Denver Nuggets",
        "abbreviation": "DEN",
        "image": "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/den.png&h=200&w=200",
        "show_spoilers": {
          "starters": {
            "players": []
          },
          "bench": {
            "players": []
          }
        }
      },
      "visitor_team": {
        "id": 4,
        "conference": "East",
        "division": "Southeast",
        "city": "Charlotte",
        "name": "Hornets",
        "full_name": "Charlotte Hornets",
        "abbreviation": "CHA",
        "image": "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/cha.png&h=200&w=200",
        "show_spoilers": {
          "starters": {
            "players": []
          },
          "bench": {
            "players": []
          }
        }
      }
    },
    {
      "id": 1038049,
      "date": "2024-01-01",
      "season": 2023,
      "status": "Final",
      "period": 4,
      "time": "Final",
      "postseason": false,
      "home_team_score": 127,
      "visitor_team_score": 90,
      "home_team": {
        "id": 29,
        "conference": "West",
        "division": "Northwest",
        "city": "Utah",
        "name": "Jazz",
        "full_name": "Utah Jazz",
        "abbreviation": "UTA",
        "image": "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/utah.png&h=200&w=200",
        "show_spoilers": {
          "starters": {
            "players": []
          },
          "bench": {
            "players": []
          }
        }
      },
      "visitor_team": {
        "id": 7,
        "conference": "West",
        "division": "Southwest",
        "city": "Dallas",
        "name": "Mavericks",
        "full_name": "Dallas Mavericks",
        "abbreviation": "DAL",
        "image": "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/dal.png&h=200&w=200",
        "show_spoilers": {
          "starters": {
            "players": []
          },
          "bench": {
            "players": []
          }
        }
      }
    },
    {
      "id": 1038048,
      "date": "2024-01-01",
      "season": 2023,
      "status": "Final",
      "period": 4,
      "time": "Final",
      "postseason": false,
      "home_team_score": 109,
      "visitor_team_score": 88,
      "home_team": {
        "id": 24,
        "conference": "West",
        "division": "Pacific",
        "city": "Phoenix",
        "name": "Suns",
        "full_name": "Phoenix Suns",
        "abbreviation": "PHX",
        "image": "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/phx.png&h=200&w=200",
        "show_spoilers": {
          "starters": {
            "players": []
          },
          "bench": {
            "players": []
          }
        }
      },
      "visitor_team": {
        "id": 25,
        "conference": "West",
        "division": "Northwest",
        "city": "Portland",
        "name": "Trail Blazers",
        "full_name": "Portland Trail Blazers",
        "abbreviation": "POR",
        "image": "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/por.png&h=200&w=200",
        "show_spoilers": {
          "starters": {
            "players": []
          },
          "bench": {
            "players": []
          }
        }
      }
    },
    {
      "id": 1038051,
      "date": "2024-01-02",
      "season": 2023,
      "status": "Final",
      "period": 4,
      "time": "Final",
      "postseason": false,
      "home_team_score": 110,
      "visitor_team_score": 97,
      "home_team": {
        "id": 23,
        "conference": "East",
        "division": "Atlantic",
        "city": "Philadelphia",
        "name": "76ers",
        "full_name": "Philadelphia 76ers",
        "abbreviation": "PHI",
        "image": "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/phi.png&h=200&w=200",
        "show_spoilers": {
          "starters": {
            "players": []
          },
          "bench": {
            "players": []
          }
        }
      },
      "visitor_team": {
        "id": 5,
        "conference": "East",
        "division": "Central",
        "city": "Chicago",
        "name": "Bulls",
        "full_name": "Chicago Bulls",
        "abbreviation": "CHI",
        "image": "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/chi.png&h=200&w=200",
        "show_spoilers": {
          "starters": {
            "players": []
          },
          "bench": {
            "players": []
          }
        }
      }
    },
    {
      "id": 1038053,
      "date": "2024-01-02",
      "season": 2023,
      "status": "Final",
      "period": 4,
      "time": "Final",
      "postseason": false,
      "home_team_score": 112,
      "visitor_team_score": 85,
      "home_team": {
        "id": 19,
        "conference": "West",
        "division": "Southwest",
        "city": "New Orleans",
        "name": "Pelicans",
        "full_name": "New Orleans Pelicans",
        "abbreviation": "NOP",
        "image": "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/no.png&h=200&w=200",
        "show_spoilers": {
          "starters": {
            "players": []
          },
          "bench": {
            "players": []
          }
        }
      },
      "visitor_team": {
        "id": 3,
        "conference": "East",
        "division": "Atlantic",
        "city": "Brooklyn",
        "name": "Nets",
        "full_name": "Brooklyn Nets",
        "abbreviation": "BKN",
        "image": "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/bkn.png&h=200&w=200",
        "show_spoilers": {
          "starters": {
            "players": []
          },
          "bench": {
            "players": []
          }
        }
      }
    },
    {
      "id": 1038056,
      "date": "2024-01-02",
      "season": 2023,
      "status": "Final",
      "period": 4,
      "time": "Final",
      "postseason": false,
      "home_team_score": 104,
      "visitor_team_score": 111,
      "home_team": {
        "id": 26,
        "conference": "West",
        "division": "Pacific",
        "city": "Sacramento",
        "name": "Kings",
        "full_name": "Sacramento Kings",
        "abbreviation": "SAC",
        "image": "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/sac.png&h=200&w=200",
        "show_spoilers": {
          "starters": {
            "players": []
          },
          "bench": {
            "players": []
          }
        }
      },
      "visitor_team": {
        "id": 4,
        "conference": "East",
        "division": "Southeast",
        "city": "Charlotte",
        "name": "Hornets",
        "full_name": "Charlotte Hornets",
        "abbreviation": "CHA",
        "image": "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/cha.png&h=200&w=200",
        "show_spoilers": {
          "starters": {
            "players": []
          },
          "bench": {
            "players": []
          }
        }
      }
    },
    {
      "id": 1038055,
      "date": "2024-01-02",
      "season": 2023,
      "status": "Final",
      "period": 4,
      "time": "Final",
      "postseason": false,
      "home_team_score": 121,
      "visitor_team_score": 115,
      "home_team": {
        "id": 10,
        "conference": "West",
        "division": "Pacific",
        "city": "Golden State",
        "name": "Warriors",
        "full_name": "Golden State Warriors",
        "abbreviation": "GSW",
        "image": "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/gs.png&h=200&w=200",
        "show_spoilers": {
          "starters": {
            "players": []
          },
          "bench": {
            "players": []
          }
        }
      },
      "visitor_team": {
        "id": 22,
        "conference": "East",
        "division": "Southeast",
        "city": "Orlando",
        "name": "Magic",
        "full_name": "Orlando Magic",
        "abbreviation": "ORL",
        "image": "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/orl.png&h=200&w=200",
        "show_spoilers": {
          "starters": {
            "players": []
          },
          "bench": {
            "players": []
          }
        }
      }
    },
    {
      "id": 1038054,
      "date": "2024-01-02",
      "season": 2023,
      "status": "Final",
      "period": 4,
      "time": "Final",
      "postseason": false,
      "home_team_score": 127,
      "visitor_team_score": 123,
      "home_team": {
        "id": 21,
        "conference": "West",
        "division": "Northwest",
        "city": "Oklahoma City",
        "name": "Thunder",
        "full_name": "Oklahoma City Thunder",
        "abbreviation": "OKC",
        "image": "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/okc.png&h=200&w=200",
        "show_spoilers": {
          "starters": {
            "players": []
          },
          "bench": {
            "players": []
          }
        }
      },
      "visitor_team": {
        "id": 2,
        "conference": "East",
        "division": "Atlantic",
        "city": "Boston",
        "name": "Celtics",
        "full_name": "Boston Celtics",
        "abbreviation": "BOS",
        "image": "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/bos.png&h=200&w=200",
        "show_spoilers": {
          "starters": {
            "players": []
          },
          "bench": {
            "players": []
          }
        }
      }
    },
    {
      "id": 1038052,
      "date": "2024-01-02",
      "season": 2023,
      "status": "Final",
      "period": 4,
      "time": "Final",
      "postseason": false,
      "home_team_score": 106,
      "visitor_team_score": 98,
      "home_team": {
        "id": 15,
        "conference": "West",
        "division": "Southwest",
        "city": "Memphis",
        "name": "Grizzlies",
        "full_name": "Memphis Grizzlies",
        "abbreviation": "MEM",
        "image": "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/mem.png&h=200&w=200",
        "show_spoilers": {
          "starters": {
            "players": []
          },
          "bench": {
            "players": []
          }
        }
      },
      "visitor_team": {
        "id": 27,
        "conference": "West",
        "division": "Southwest",
        "city": "San Antonio",
        "name": "Spurs",
        "full_name": "San Antonio Spurs",
        "abbreviation": "SAS",
        "image": "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/sa.png&h=200&w=200",
        "show_spoilers": {
          "starters": {
            "players": []
          },
          "bench": {
            "players": []
          }
        }
      }
    },
    {
      "id": 1038057,
      "date": "2024-01-03",
      "season": 2023,
      "status": "Final",
      "period": 4,
      "time": "Final",
      "postseason": false,
      "home_team_score": 140,
      "visitor_team_score": 101,
      "home_team": {
        "id": 6,
        "conference": "East",
        "division": "Central",
        "city": "Cleveland",
        "name": "Cavaliers",
        "full_name": "Cleveland Cavaliers",
        "abbreviation": "CLE",
        "image": "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/cle.png&h=200&w=200",
        "show_spoilers": {
          "starters": {
            "players": []
          },
          "bench": {
            "players": []
          }
        }
      },
      "visitor_team": {
        "id": 30,
        "conference": "East",
        "division": "Southeast",
        "city": "Washington",
        "name": "Wizards",
        "full_name": "Washington Wizards",
        "abbreviation": "WAS",
        "image": "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/wsh.png&h=200&w=200",
        "show_spoilers": {
          "starters": {
            "players": []
          },
          "bench": {
            "players": []
          }
        }
      }
    },
    {
      "id": 1038064,
      "date": "2024-01-03",
      "season": 2023,
      "status": "Final",
      "period": 4,
      "time": "Final",
      "postseason": false,
      "home_team_score": 126,
      "visitor_team_score": 97,
      "home_team": {
        "id": 7,
        "conference": "West",
        "division": "Southwest",
        "city": "Dallas",
        "name": "Mavericks",
        "full_name": "Dallas Mavericks",
        "abbreviation": "DAL",
        "image": "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/dal.png&h=200&w=200",
        "show_spoilers": {
          "starters": {
            "players": []
          },
          "bench": {
            "players": []
          }
        }
      },
      "visitor_team": {
        "id": 25,
        "conference": "West",
        "division": "Northwest",
        "city": "Portland",
        "name": "Trail Blazers",
        "full_name": "Portland Trail Blazers",
        "abbreviation": "POR",
        "image": "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/por.png&h=200&w=200",
        "show_spoilers": {
          "starters": {
            "players": []
          },
          "bench": {
            "players": []
          }
        }
      }
    },
    {
      "id": 1038068,
      "date": "2024-01-03",
      "season": 2023,
      "status": "Final",
      "period": 6,
      "time": "Final",
      "postseason": false,
      "home_team_score": 138,
      "visitor_team_score": 135,
      "home_team": {
        "id": 26,
        "conference": "West",
        "division": "Pacific",
        "city": "Sacramento",
        "name": "Kings",
        "full_name": "Sacramento Kings",
        "abbreviation": "SAC",
        "image": "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/sac.png&h=200&w=200",
        "show_spoilers": {
          "starters": {
            "players": []
          },
          "bench": {
            "players": []
          }
        }
      },
      "visitor_team": {
        "id": 22,
        "conference": "East",
        "division": "Southeast",
        "city": "Orlando",
        "name": "Magic",
        "full_name": "Orlando Magic",
        "abbreviation": "ORL",
        "image": "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/orl.png&h=200&w=200",
        "show_spoilers": {
          "starters": {
            "players": []
          },
          "bench": {
            "players": []
          }
        }
      }
    },
    {
      "id": 1038067,
      "date": "2024-01-03",
      "season": 2023,
      "status": "Final",
      "period": 4,
      "time": "Final",
      "postseason": false,
      "home_team_score": 96,
      "visitor_team_score": 110,
      "home_team": {
        "id": 14,
        "conference": "West",
        "division": "Pacific",
        "city": "Los Angeles",
        "name": "Lakers",
        "full_name": "Los Angeles Lakers",
        "abbreviation": "LAL",
        "image": "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/lal.png&h=200&w=200",
        "show_spoilers": {
          "starters": {
            "players": []
          },
          "bench": {
            "players": []
          }
        }
      },
      "visitor_team": {
        "id": 16,
        "conference": "East",
        "division": "Southeast",
        "city": "Miami",
        "name": "Heat",
        "full_name": "Miami Heat",
        "abbreviation": "MIA",
        "image": "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/mia.png&h=200&w=200",
        "show_spoilers": {
          "starters": {
            "players": []
          },
          "bench": {
            "players": []
          }
        }
      }
    },
    {
      "id": 1038061,
      "date": "2024-01-03",
      "season": 2023,
      "status": "Final",
      "period": 4,
      "time": "Final",
      "postseason": false,
      "home_team_score": 112,
      "visitor_team_score": 101,
      "home_team": {
        "id": 11,
        "conference": "West",
        "division": "Southwest",
        "city": "Houston",
        "name": "Rockets",
        "full_name": "Houston Rockets",
        "abbreviation": "HOU",
        "image": "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/hou.png&h=200&w=200",
        "show_spoilers": {
          "starters": {
            "players": []
          },
          "bench": {
            "players": []
          }
        }
      },
      "visitor_team": {
        "id": 3,
        "conference": "East",
        "division": "Atlantic",
        "city": "Brooklyn",
        "name": "Nets",
        "full_name": "Brooklyn Nets",
        "abbreviation": "BKN",
        "image": "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/bkn.png&h=200&w=200",
        "show_spoilers": {
          "starters": {
            "players": []
          },
          "bench": {
            "players": []
          }
        }
      }
    },
    {
      "id": 1038062,
      "date": "2024-01-03",
      "season": 2023,
      "status": "Final",
      "period": 4,
      "time": "Final",
      "postseason": false,
      "home_team_score": 111,
      "visitor_team_score": 116,
      "home_team": {
        "id": 15,
        "conference": "West",
        "division": "Southwest",
        "city": "Memphis",
        "name": "Grizzlies",
        "full_name": "Memphis Grizzlies",
        "abbreviation": "MEM",
        "image": "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/mem.png&h=200&w=200",
        "show_spoilers": {
          "starters": {
            "players": []
          },
          "bench": {
            "players": []
          }
        }
      },
      "visitor_team": {
        "id": 28,
        "conference": "East",
        "division": "Atlantic",
        "city": "Toronto",
        "name": "Raptors",
        "full_name": "Toronto Raptors",
        "abbreviation": "TOR",
        "image": "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/tor.png&h=200&w=200",
        "show_spoilers": {
          "starters": {
            "players": []
          },
          "bench": {
            "players": []
          }
        }
      }
    },
    {
      "id": 1038063,
      "date": "2024-01-03",
      "season": 2023,
      "status": "Final",
      "period": 4,
      "time": "Final",
      "postseason": false,
      "home_team_score": 106,
      "visitor_team_score": 117,
      "home_team": {
        "id": 18,
        "conference": "West",
        "division": "Northwest",
        "city": "Minnesota",
        "name": "Timberwolves",
        "full_name": "Minnesota Timberwolves",
        "abbreviation": "MIN",
        "image": "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/min.png&h=200&w=200",
        "show_spoilers": {
          "starters": {
            "players": []
          },
          "bench": {
            "players": []
          }
        }
      },
      "visitor_team": {
        "id": 19,
        "conference": "West",
        "division": "Southwest",
        "city": "New Orleans",
        "name": "Pelicans",
        "full_name": "New Orleans Pelicans",
        "abbreviation": "NOP",
        "image": "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/no.png&h=200&w=200",
        "show_spoilers": {
          "starters": {
            "players": []
          },
          "bench": {
            "players": []
          }
        }
      }
    },
    {
      "id": 1038065,
      "date": "2024-01-03",
      "season": 2023,
      "status": "Final",
      "period": 4,
      "time": "Final",
      "postseason": false,
      "home_team_score": 122,
      "visitor_team_score": 131,
      "home_team": {
        "id": 24,
        "conference": "West",
        "division": "Pacific",
        "city": "Phoenix",
        "name": "Suns",
        "full_name": "Phoenix Suns",
        "abbreviation": "PHX",
        "image": "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/phx.png&h=200&w=200",
        "show_spoilers": {
          "starters": {
            "players": []
          },
          "bench": {
            "players": []
          }
        }
      },
      "visitor_team": {
        "id": 13,
        "conference": "West",
        "division": "Pacific",
        "city": "LA",
        "name": "Clippers",
        "full_name": "LA Clippers",
        "abbreviation": "LAC",
        "image": "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/lac.png&h=200&w=200",
        "show_spoilers": {
          "starters": {
            "players": []
          },
          "bench": {
            "players": []
          }
        }
      }
    },
    {
      "id": 1038066,
      "date": "2024-01-03",
      "season": 2023,
      "status": "Final",
      "period": 5,
      "time": "Final",
      "postseason": false,
      "home_team_score": 154,
      "visitor_team_score": 148,
      "home_team": {
        "id": 29,
        "conference": "West",
        "division": "Northwest",
        "city": "Utah",
        "name": "Jazz",
        "full_name": "Utah Jazz",
        "abbreviation": "UTA",
        "image": "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/utah.png&h=200&w=200",
        "show_spoilers": {
          "starters": {
            "players": []
          },
          "bench": {
            "players": []
          }
        }
      },
      "visitor_team": {
        "id": 9,
        "conference": "East",
        "division": "Central",
        "city": "Detroit",
        "name": "Pistons",
        "full_name": "Detroit Pistons",
        "abbreviation": "DET",
        "image": "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/det.png&h=200&w=200",
        "show_spoilers": {
          "starters": {
            "players": []
          },
          "bench": {
            "players": []
          }
        }
      }
    },
    {
      "id": 1038060,
      "date": "2024-01-03",
      "season": 2023,
      "status": "Final",
      "period": 4,
      "time": "Final",
      "postseason": false,
      "home_team_score": 116,
      "visitor_team_score": 100,
      "home_team": {
        "id": 20,
        "conference": "East",
        "division": "Atlantic",
        "city": "New York",
        "name": "Knicks",
        "full_name": "New York Knicks",
        "abbreviation": "NYK",
        "image": "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/ny.png&h=200&w=200",
        "show_spoilers": {
          "starters": {
            "players": []
          },
          "bench": {
            "players": []
          }
        }
      },
      "visitor_team": {
        "id": 5,
        "conference": "East",
        "division": "Central",
        "city": "Chicago",
        "name": "Bulls",
        "full_name": "Chicago Bulls",
        "abbreviation": "CHI",
        "image": "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/chi.png&h=200&w=200",
        "show_spoilers": {
          "starters": {
            "players": []
          },
          "bench": {
            "players": []
          }
        }
      }
    },
    {
      "id": 1038059,
      "date": "2024-01-03",
      "season": 2023,
      "status": "Final",
      "period": 4,
      "time": "Final",
      "postseason": false,
      "home_team_score": 141,
      "visitor_team_score": 138,
      "home_team": {
        "id": 1,
        "conference": "East",
        "division": "Southeast",
        "city": "Atlanta",
        "name": "Hawks",
        "full_name": "Atlanta Hawks",
        "abbreviation": "ATL",
        "image": "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/atl.png&h=200&w=200",
        "show_spoilers": {
          "starters": {
            "players": []
          },
          "bench": {
            "players": []
          }
        }
      },
      "visitor_team": {
        "id": 21,
        "conference": "West",
        "division": "Northwest",
        "city": "Oklahoma City",
        "name": "Thunder",
        "full_name": "Oklahoma City Thunder",
        "abbreviation": "OKC",
        "image": "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/okc.png&h=200&w=200",
        "show_spoilers": {
          "starters": {
            "players": []
          },
          "bench": {
            "players": []
          }
        }
      }
    }
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
            GamesTodaysListWidegt(),
            isLoading ? const LoadingListPage() : GamesTodaysListWidegt(),
            GamesTodaysListWidegt(),
          ],
        )),
      ],
    ));
  }

  Widget GamesYesterdaysListWidegt() {
    return Center(
      child: CustomTextView(
          title: 'coming soon',
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
          color: Colors.black,
          textAlign: TextAlign.center),
    );
  }

  Widget GamesTomarrowListWidegt() {
    return Center(
      child: CustomTextView(
          title: 'coming soon',
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
          color: Colors.black,
          textAlign: TextAlign.center),
    );
  }

  Widget GamesTodaysListWidegt() {
    return Center(
      child: ListView.builder(
          itemCount: gamesList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => GamesDetailsScreen(
                        gameData: gamesList[index])));
              },
              child: Container(
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
                      child: Image.network(
                        gamesList[index]["home_team"]["image"].toString(),
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
                      child: Image.network(
                        gamesList[index]["visitor_team"]["image"].toString(),
                        width: 80,
                        height: 80,
                        fit: BoxFit.fill,
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  GetGameList(var id) async {
    setState(() {
      isLoading = true;
      gamesList.clear();
    });
    var date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    var url = Uri.parse(CONSTANTS.baseUrl + CONSTANTS.fetchGames + date);
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

  GetGameYesterdayList(var id) async {
    setState(() {
      isLoading = true;
      gamesList.clear();
    });
    var date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    var url = Uri.parse(CONSTANTS.baseUrl + CONSTANTS.fetchGames + date);
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

  GetGameTomarrowList(var id) async {
    setState(() {
      isLoading = true;
      gamesList.clear();
    });
    var date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    var url = Uri.parse(CONSTANTS.baseUrl + CONSTANTS.fetchGames + date);
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
}
