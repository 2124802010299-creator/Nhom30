class Question {
  final String id;
  final String category;
  final String content;
  final List<String> options;
  final int correctIndex;

  Question({
    required this.id,
    required this.category,
    required this.content,
    required this.options,
    required this.correctIndex,
  });

  // ===== FIRESTORE =====
  factory Question.fromMap(String id, Map<String, dynamic> data) {
    return Question(
      id: id,
      category: data['category'],
      content: data['content'],
      options: List<String>.from(data['options']),
      correctIndex: data['correctIndex'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'content': content,
      'options': options,
      'correctIndex': correctIndex,
    };
  }

  // ===== LOCAL STORAGE =====
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'content': content,
      'options': options,
      'correctIndex': correctIndex,
    };
  }

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      category: json['category'],
      content: json['content'],
      options: List<String>.from(json['options']),
      correctIndex: json['correctIndex'],
    );
  }
}
