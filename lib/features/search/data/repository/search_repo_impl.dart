import 'package:quickchance_app/features/home/data/models/opportunity_model.dart';
import 'package:quickchance_app/features/search/data/datasource/local/searchApiService.dart';
import 'package:quickchance_app/features/search/domain/repository/search_repo.dart';

class SearchRepoImpl implements SearchRepo {
  @override
  Future<List<OpportunityModel>> searchOpp(String searchQuery) async {
    return await SearchApiService().searchOpps(searchQuery);
  }
}
