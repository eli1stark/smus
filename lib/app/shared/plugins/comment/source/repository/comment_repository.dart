import '../../../../../../shared/helpers/handler.dart';
import '../../model/comment_model.dart';
import 'repositories/comment_by_id_repository.dart';

class CommentRepository {
  Future<Handler<CommentModel>> commentById(int id) {
    return commentByIdRepository(id);
  }
}
