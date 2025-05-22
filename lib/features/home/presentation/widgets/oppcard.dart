import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickchance_app/features/home/data/datasources/remote/opportunityApiService.dart';
import 'package:quickchance_app/features/home/data/datasources/remote/opportunitySocketService.dart';
import 'package:quickchance_app/features/home/data/models/opportunity_model.dart';
import 'package:quickchance_app/features/home/presentation/bloc/opportunity_cubit.dart';
import 'package:quickchance_app/features/saved/data/datasources/remote/savedApiService.dart';
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

  int? _likeCount;
  bool checkIfLiked = false;
  final socketService = OpportunitySocketService();

  @override
  void initState() {
    super.initState();
    socketService.joinOpportunity(widget.opps.id!);
    socketService.getLikeCount(widget.opps.id!);
    socketService.checkIfLiked(widget.opps.id!);

    // Listen to likes
    socketService.socket.on('countLikesReply', (data) {
      if (data['opportunityId'] == widget.opps.id) {
        setState(() {
          _likeCount = data['likeCount']['TotalLikes'];
        });
      }
    });

    socketService.socket.on('checkLikesReply', (data) {
      if (data['opportunityId'] == widget.opps.id) {
        setState(() {
          checkIfLiked = data['isLiked']['checkLike'];
        });
      }
    });
  }

  @override
  void dispose() {
    socketService.socket.off('countLikesReply');
    socketService.socket.off('checkLikesReply');
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
                      BlocProvider.of<OpportunityCubit>(
                        context,
                      ).likeOrDislike(widget.opps.id!, checkIfLiked);
                    },
                    child: Icon(
                      Icons.favorite_border_sharp,
                      color: (checkIfLiked) ? Colors.red[300] : Colors.grey,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text('${_likeCount}'),
                  SizedBox(width: 15),
                  Icon(Icons.comment, color: Colors.grey),
                  SizedBox(width: 5),
                  FutureBuilder(
                    future: OpportunityApiService().totalComments(
                      widget.opps.id!,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text('${snapshot.data}');
                      }
                      return SizedBox.shrink();
                    },
                  ),
                  SizedBox(width: 15),
                  GestureDetector(
                    onTap: () async {
                      bool isOppSaved = await SavedApiService().checkIsSaved(
                        widget.opps.id!,
                      );
                      isOppSaved
                          ? await SavedApiService().unSavingOpp(widget.opps.id!)
                          : await SavedApiService().saveOpp(widget.opps.id!);
                    },
                    child: Icon(
                      Icons.bookmark_border_outlined,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(width: 5),
                  FutureBuilder(
                    future: OpportunityApiService().totalSaved(widget.opps.id!),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text('${snapshot.data}');
                      }
                      return SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
