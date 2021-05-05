import '../../../../../../../shared/helpers/handler.dart';
import '../../../model/story_model.dart';
import '../../dto/story_dto.dart';
import '../../service/story_service.dart';

Future<Handler<StoryModel>> storyByIdRepository(int id) async {
  final _service = StoryService();

  try {
    final response = await _service.storyById(id);

    final responseData = response.data as Map<String, dynamic>;

    final dto = StoryDto.fromJson(responseData);

    final model = dto.toModel();

    return Handler(model: model);
  } catch (e) {
    return Handler(error: '$e');
  }
}
