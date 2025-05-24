import 'package:quickchance_app/features/home/data/models/commentModel.dart';
import 'package:quickchance_app/features/home/data/models/opportunity_model.dart';

abstract class OppsRepo {
  Future<List<OpportunityModel>> fetchAllOpps();
  Future likingOpp(int oppId);
  Future unLikingOpp(int oppId);
  Future<List<CommentModel>> fetchAllComments(int oppId);
}
