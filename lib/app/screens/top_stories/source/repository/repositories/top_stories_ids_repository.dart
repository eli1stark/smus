import '../../../../../../shared/helpers/handler.dart';
import '../../../model/top_stories_model.dart';
import '../../dto/top_stories_dto.dart';
import '../../service/top_stories_service.dart';

Future<Handler<TopStoriesModel>> topStoriesIdsRepository() async {
  final _service = TopStoriesService();

  try {
    final response = await _service.topStoriesIds();

    // Hear we are type casting as List<dynamic>
    // but usually we will deal with Map<String, dynamic>
    final responseData = response.data as List<dynamic>;

    final dto = TopStoriesDto.fromList(responseData);

    final model = dto.toModel();

    return Handler(model: model);
  } catch (e) {
    return Handler(error: '$e');
  }
}
