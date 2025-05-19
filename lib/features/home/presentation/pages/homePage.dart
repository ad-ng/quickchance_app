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
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 5),
        BlocBuilder<OpportunityCubit, OpportunityState>(
          builder: (context, state) {
            if (state is OpportunityLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is OpportunitySuccess) {
              return Expanded(
                child: ListView.builder(
                  itemCount: state.response.length,
                  itemBuilder: (context, index) {
                    return OppCard(opps: state.response[index]);
                  },
                ),
              );
            }
            return SizedBox.expand();
          },
        ),
      ],
    );
  }
}
