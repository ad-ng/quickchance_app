import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickchance_app/features/home/data/datasources/remote/opportunityApiService.dart';
import 'package:quickchance_app/features/home/presentation/bloc/opportunity_cubit.dart';
import 'package:quickchance_app/features/home/presentation/widgets/categoryCard.dart';
import 'package:quickchance_app/features/home/presentation/widgets/oppcard.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    BlocProvider.of<OpportunityCubit>(context).fetchAllOpps();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 5),

        Wrap(
          children: [
            CategoryCard(catName: 'Technology'),
            CategoryCard(catName: 'scholarship'),
            CategoryCard(catName: 'training'),
            CategoryCard(catName: 'news'),
            CategoryCard(catName: 'competition'),
          ],
        ),
        Expanded(
          child: FutureBuilder(
            future: OpportunityApiService().fetchAllOpps(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                if (snapshot.data!.length == 0) {
                  return Center(
                    child: Image.asset('././lib/images/no-search-found.png'),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder:
                      (context, index) => OppCard(opps: snapshot.data![index]),
                );
              }
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }
              return SizedBox.shrink();
            },
          ),
        ),
        // BlocBuilder<OpportunityCubit, OpportunityState>(
        //   builder: (context, state) {
        //     if (state is OpportunityLoading) {
        //       return Center(child: CircularProgressIndicator.adaptive());
        //     }
        //     if (state is OpportunityError) {
        //       return Center(child: Text(state.error));
        //     }
        //     if (state is OpportunitySuccess) {
        //       return Expanded(
        //         child: ListView.builder(
        //           itemCount: state.response.length,
        //           itemBuilder: (context, index) {
        //             BlocProvider.of<OpportunityCubit>(
        //               context,
        //             ).totalLikes(state.response[index].id!);
        //             return OppCard(opps: state.response[index]);
        //           },
        //         ),
        //       );
        //     }
        //     return SizedBox.shrink();
        //   },
        // ),
      ],
    );
  }
}
