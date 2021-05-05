import '../../../../../shared/helpers/handler.dart';
import '../../model/top_stories_model.dart';
import 'repositories/top_stories_ids_repository.dart';

class TopStoriesRepository {
  Future<Handler<TopStoriesModel>> topStoriesIds() {
    return topStoriesIdsRepository();
  }
}
