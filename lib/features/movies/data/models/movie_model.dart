class MovieModel {
  final int id;
  final String title;
  final String description;
  final int year;

  MovieModel({
    required this.id,
    required this.title,
    required this.description,
    required this.year,
  });

  // 👇 МІНЕ ОСЫ ЖЕТІСПЕЙ ЖАТҚАН БӨЛІК
  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      year: json['year'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'year': year,
    };
  }
}
