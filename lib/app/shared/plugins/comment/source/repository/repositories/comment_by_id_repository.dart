import '../../../../../../../shared/helpers/handler.dart';
import '../../../model/comment_model.dart';
import '../../dto/comment_dto.dart';
import '../../service/comment_service.dart';

Future<Handler<CommentModel>> commentByIdRepository(int id) async {
  final _service = CommentService();

  try {
    final response = await _service.commentById(id);

    final responseData = response.data as Map<String, dynamic>;

    final dto = CommentDto.fromJson(responseData);

    final model = dto.toModel();

    return Handler(model: model);
  } catch (e) {
    return Handler(error: 'e');
  }
}
