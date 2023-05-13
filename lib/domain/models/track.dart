class Track {
  late final String position;
  late final String name;
  late final int durationInSeconds;

  Track({
    required this.position,
    required this.name,
    required this.durationInSeconds,
  });

  Map<String, dynamic> toJson() => {
        'position': position,
        'name': name,
        'durationInSeconds': durationInSeconds,
      };
}
