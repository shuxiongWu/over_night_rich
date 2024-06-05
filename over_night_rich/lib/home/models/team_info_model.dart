class TeamInfoModel {
  /*
  "team_id": "0",
                        "team_name": "水原三星蓝翼",
                        "rank": "4",
                        "rank_league": "韩K2联"
                         "host_goals": "1",
                "guest_goals": "2",
                "half_host_goals": "0",
                "half_guest_goals": "0",
  */
  final String team_id;
  final String team_name;
  final String rank;
  final String rank_league;
  final String half_goals;
  final String full_goals;

  TeamInfoModel({
    required this.team_id,
    required this.team_name,
    required this.rank,
    required this.rank_league,
    required this.half_goals,
    required this.full_goals,
  });

  //生成fromJson方法
  factory TeamInfoModel.fromJson(Map<String, dynamic> json) {
    return TeamInfoModel(
      team_id: json['team_id'] ?? "",
      team_name: json['team_name'] ?? "",
      rank: json['rank'] ?? "",
      rank_league: json['rank_league'] ?? "",
      half_goals: json['half_goals'] ?? "",
      full_goals: json['full_goals'] ?? "",
    );
  }
}