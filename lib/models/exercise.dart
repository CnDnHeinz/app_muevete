class Exercise {
  String name;
  String description;
  String time;
  String image;
  String video;
  String audio;
  String level;
  String type;
  String category;
  String author;

  Exercise(this.name, this.description, this.time, this.image, this.video,
      this.audio, this.level, this.type, this.category, this.author);

  factory Exercise.fromJson(Map<String, dynamic> json) => new Exercise(
        json["name"],
        json["description"],
        json["time"],
        json["image"],
        json["video"],
        json["audio"],
        json["level"],
        json["type"],
        json["category"],
        json["author"],
      );
}
