import 'package:quickchance_app/features/home/data/datasources/remote/opportunityApiService.dart';
import 'package:quickchance_app/features/home/data/models/opportunity_model.dart';
import 'package:quickchance_app/features/home/domain/repository/opps_repo.dart';

class OppsRepoImpl implements OppsRepo {
  @override
  Future<List<OpportunityModel>> fetchAllOpps() async {
    return await OpportunityApiService().fetchAllOpps();
  }

  @override
  Future likingOpp(int oppId) async {
    return await OpportunityApiService().likingOpp(oppId);
  }

  @override
  Future unLikingOpp(int oppId) async {
    return await OpportunityApiService().unLikingOpp(oppId);
  }
}
