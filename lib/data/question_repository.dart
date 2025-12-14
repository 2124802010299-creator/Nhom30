import '../models/question.dart';
import 'online_question_repository.dart';

class QuestionRepository {
  static Future<List<Question>> load({
    required String category,
    required bool online,
  }) async {
    if (online) {
      return await OnlineQuestionRepository.fetchByCategory(category);
    } else {
      // nếu chưa làm offline thì trả rỗng
      return [];
    }
  }
}
