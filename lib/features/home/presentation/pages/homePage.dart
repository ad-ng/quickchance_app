import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickchance_app/features/home/presentation/bloc/opportunity_cubit.dart';
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
        Expanded(
          child: BlocBuilder<OpportunityCubit, OpportunityState>(
            buildWhen: (previous, current) {
              return previous != current;
            },
            builder: (context, state) {
              if (state is OpportunityLoading) {
                return Center(child: CircularProgressIndicator.adaptive());
              }
              if (state is OpportunitySuccess) {
                return ListView.builder(
                  addAutomaticKeepAlives: true,
                  itemCount: state.response.length,
                  itemBuilder: (context, index) {
                    return OppCard(
                      opps: state.response[index],
                      key: ValueKey(state.response[index].id),
                    );
                  },
                );
              }
              return SizedBox.expand();
            },
          ),
        ),
      ],
    );
  }
}
