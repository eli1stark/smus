import '../../../../../../shared/helpers/handler.dart';
import '../../model/story_model.dart';
import 'repositories/story_by_id_repository.dart';

class StoryRepository {
  Future<Handler<StoryModel>> storyById(int id) {
    return storyByIdRepository(id);
  }
}
