class QuizModel {
  final String question;
  final List<String> incorrectAnswers;
  final String correctAnswers;

  QuizModel(
      {required this.question,
      required this.incorrectAnswers,
      required this.correctAnswers});

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
        question: json["question"],
        incorrectAnswers: List<String>.from(json["incorrectAnswers"].map((x)=>x)),
        correctAnswers: json["correctAnswer"]
        );
  }
}
