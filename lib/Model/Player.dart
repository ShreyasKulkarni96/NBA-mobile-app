class Player {
  final String fullName;
  final double min;
  final double pts;
  final double reb;
  final double ast;
  final double stl;
  final String position;

  Player({
    required this.fullName,
    required this.min,
    required this.pts,
    required this.reb,
    required this.ast,
    required this.stl,
    required this.position,
  });

  factory Player.fromJson(Map<String, dynamic> json, String position) {
    return Player(
      fullName: json['full_name'],
      min: json['min'].toDouble(),
      pts: json['pts'].toDouble(),
      reb: json['reb'].toDouble(),
      ast: json['ast'].toDouble(),
      stl: json['stl'].toDouble(),
      position: position,
    );
  }
}
