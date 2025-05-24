import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quickchance_app/features/home/data/datasources/remote/opportunityApiService.dart';
import 'package:quickchance_app/features/home/data/datasources/remote/opportunitySocketService.dart';
import 'package:quickchance_app/features/home/data/models/opportunity_model.dart';
import 'package:quickchance_app/features/saved/data/datasources/remote/savedApiService.dart';
import 'package:quickchance_app/features/saved/data/datasources/remote/savedSocketService.dart';
import 'package:timeago/timeago.dart' as timeago;

class OppCard extends StatefulWidget {
  final OpportunityModel opps;

  const OppCard({super.key, required this.opps});

  @override
  State<OppCard> createState() => _OppCardState();
}

class _OppCardState extends State<OppCard> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  int _likeCount = 0;
  int _savedCount = 0;
  bool checkIfLiked = false;
  bool checkIfSaved = false;
  final likeSocketService = OpportunitySocketService();
  final savedSocketService = SavedSocketService();

  @override
  void initState() {
    super.initState();
    likeSocketService.joinOpportunity(widget.opps.id!);
    likeSocketService.getLikeCount(widget.opps.id!);
    likeSocketService.checkIfLiked(widget.opps.id!);
    savedSocketService.checkIfSaved(widget.opps.id!);
    savedSocketService.getSavedCount(widget.opps.id!);

    // Listen to likes
    likeSocketService.socket.on('countLikesReply', (data) {
      if (data['opportunityId'] == widget.opps.id) {
        setState(() {
          _likeCount = data['likeCount']['TotalLikes'];
        });
      }
    });

    likeSocketService.socket.on('checkLikesReply', (data) {
      if (data['opportunityId'] == widget.opps.id) {
        setState(() {
          checkIfLiked = data['isLiked']['checkLike'];
        });
      }
    });

    savedSocketService.socket.on('checkSavedReply', (data) {
      if (data['opportunityId'] == widget.opps.id) {
        setState(() {
          checkIfSaved = data['isSaved'];
        });
      }
    });

    savedSocketService.socket.on('countSavedReply', (data) {
      if (data['opportunityId'] == widget.opps.id) {
        setState(() {
          _savedCount = data['SavedCount'];
        });
      }
    });
  }

  @override
  void dispose() {
    likeSocketService.socket.off('countLikesReply');
    likeSocketService.socket.off('checkLikesReply');
    savedSocketService.socket.off('checkSavedReply');
    savedSocketService.socket.off('countSavedReply');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 60,
                    child: Image.network(
                      'https://static.vecteezy.com/system/resources/previews/024/183/525/non_2x/avatar-of-a-man-portrait-of-a-young-guy-illustration-of-male-character-in-modern-color-style-vector.jpg',
                    ),
                  ),
                  SizedBox(width: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.opps.user.fullname!,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        timeago.format(DateTime.parse(widget.opps.updatedAt!)),
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: EdgeInsets.all(5),
                child: Text(
                  widget.opps.status,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            widget.opps.title,
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
          Text(widget.opps.description),
          Row(
            children: [
              Text(
                'Deadline:   ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                widget.opps.deadline!.substring(0, 10),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Location:   ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                widget.opps.location!,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Category:   ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                widget.opps.category.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Row(
                children: [
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      (checkIfLiked)
                          ? OpportunityApiService().unLikingOpp(widget.opps.id!)
                          : OpportunityApiService().likingOpp(widget.opps.id!);
                      setState(() {
                        checkIfLiked = !checkIfLiked;
                      });
                    },
                    child: Icon(
                      checkIfLiked
                          ? Icons.favorite
                          : Icons.favorite_border_sharp,
                      color: (checkIfLiked) ? Colors.red[300] : Colors.grey,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text('${_likeCount}'),
                  SizedBox(width: 15),
                  GestureDetector(
                    onTap:
                        () => context.pushNamed(
                          'commentPage',
                          pathParameters: {'oppId': "1"},
                        ),
                    child: Icon(Icons.comment, color: Colors.grey),
                  ),
                  SizedBox(width: 5),
                  FutureBuilder(
                    future: OpportunityApiService().totalComments(
                      widget.opps.id!,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) return const Text('0');
                      if (!snapshot.hasData) return const Text('0');
                      return Text('${snapshot.data}');
                    },
                  ),
                  SizedBox(width: 15),
                  GestureDetector(
                    onTap: () async {
                      checkIfSaved
                          ? await SavedApiService().unSavingOpp(widget.opps.id!)
                          : await SavedApiService().saveOpp(widget.opps.id!);
                      setState(() {
                        checkIfSaved = !checkIfSaved;
                      });
                    },
                    child: Icon(
                      checkIfSaved
                          ? Icons.bookmark_outlined
                          : Icons.bookmark_border_outlined,
                      color: checkIfSaved ? Colors.blue[300] : Colors.grey,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text('$_savedCount'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
