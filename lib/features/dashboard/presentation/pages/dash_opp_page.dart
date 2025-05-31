import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickchance_app/features/home/presentation/bloc/opportunity_cubit.dart';

class DashOppPage extends StatefulWidget {
  const DashOppPage({super.key});

  @override
  State<DashOppPage> createState() => _DashOppPageState();
}

class _DashOppPageState extends State<DashOppPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Opportunities Page'), centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<OpportunityCubit, OpportunityState>(
              builder: (context, state) {
                if (state is OpportunityLoading) {
                  return Center(child: CircularProgressIndicator.adaptive());
                }
                if (state is OpportunitySuccess) {
                  return ListView.builder(
                    addAutomaticKeepAlives: true,
                    itemCount: state.response.length,
                    itemBuilder:
                        (context, index) => ListTile(
                          title: Text(state.response[index].title),
                          subtitle: Text(state.response[index].user.email!),
                          trailing: SizedBox(
                            width: 60,
                            child: Row(
                              children: [
                                Icon(Icons.edit, color: Colors.blue[300]),
                                SizedBox(width: 10),
                                Icon(Icons.delete, color: Colors.red[300]),
                              ],
                            ),
                          ),
                        ),
                  );
                }
                return SizedBox.expand();
              },
            ),
          ),
        ],
      ),
    );
  }
}
