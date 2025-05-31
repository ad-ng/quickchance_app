import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickchance_app/features/search/presentation/bloc/search_cubit.dart';
import 'package:quickchance_app/features/search/presentation/widgets/mySearch.dart';

class DashOppPage extends StatefulWidget {
  const DashOppPage({super.key});

  @override
  State<DashOppPage> createState() => _DashOppPageState();
}

class _DashOppPageState extends State<DashOppPage> {
  TextEditingController searchQuery = TextEditingController();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SearchCubit>(context).searchOpp('');
    searchQuery.addListener(() {
      BlocProvider.of<SearchCubit>(context).searchOpp(searchQuery.text);
    });
  }

  @override
  void dispose() {
    searchQuery.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Opportunities Page'), centerTitle: true),
      body: Column(
        children: [
          MySearch(searchQuery: searchQuery),
          Expanded(
            child: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                if (state is SearchLoading) {
                  return Center(child: CircularProgressIndicator.adaptive());
                }
                if (state is SearchSuccess) {
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
