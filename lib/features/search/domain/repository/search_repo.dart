import 'package:quickchance_app/features/home/data/models/opportunity_model.dart';

abstract class SearchRepo {
  Future<List<OpportunityModel>> searchOpp(String searchQuery);
  Future<List<OpportunityModel>> filterOpp(String oppStatus);
}
