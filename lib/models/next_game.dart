class NextGameModel {

  final String title;
  final String thumbnailUrl;
  final DateTime timeBegin;
  final DateTime timeEnd;
  final num prizePool;
  final bool isAvailable;

  NextGameModel._({
    this.title,
    this.thumbnailUrl,
    this.timeBegin,
    this.timeEnd,
    this.prizePool,
    this.isAvailable
  });

  factory NextGameModel.fromJson(Map<String, dynamic> json) {
    int startTimeSeconds = json['timeBegin']['_seconds'];
    int endTimeSeconds = json['timeEnd']['_seconds'];

    return new NextGameModel._(
      title: json['title'],
      thumbnailUrl: json['thumbnailUrl'],
      timeBegin: DateTime.fromMillisecondsSinceEpoch(startTimeSeconds * 1000),
      timeEnd: DateTime.fromMillisecondsSinceEpoch(endTimeSeconds * 1000),
      prizePool: json['prizePool'] as num,
      isAvailable: json['isAvailable']
    );
  }
}
