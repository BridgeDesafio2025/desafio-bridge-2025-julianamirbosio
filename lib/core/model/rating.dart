class Rating {
  final int userId;
  final String userName;
  final double score;
  final String? comment;
  final DateTime? date;

  Rating({
    required this.userId,
    required this.userName,
    required this.score,
    this.comment,
    this.date,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      userId: json['userId'] ?? 0,
      userName: json['userName'] ?? 'Usuário',
      score: json['score'] != null ? (json['score'] as num).toDouble() : 0.0,
      comment: json['comment'],
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'score': score,
      'comment': comment,
      'date': date?.toIso8601String(),
    };
  }
}
