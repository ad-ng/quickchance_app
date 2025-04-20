import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        // Expanded(
        //   child: ListView.builder(
        //     itemCount: 2,
        //     itemBuilder: (context, index) => OppCard(),
        //   ),
        // ),
        BlocBuilder<OpportunityCubit, OpportunityState>(
          builder: (context, state) {
            if (state is OpportunityLoading) {
              return Center(child: CircularProgressIndicator.adaptive());
            }
            if (state is OpportunityError) {
              return Center(child: Text(state.error));
            }
            if (state is OpportunitySuccess) {
              return Expanded(
                child: ListView.builder(
                  itemCount: state.response.length,
                  itemBuilder:
                      (context, index) => OppCard(opps: state.response[index]),
                ),
              );
            }
            return SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
