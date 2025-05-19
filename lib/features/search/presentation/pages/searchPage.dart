import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickchance_app/features/home/presentation/widgets/oppcard.dart';
import 'package:quickchance_app/features/search/presentation/bloc/search_cubit.dart';
import 'package:quickchance_app/features/search/presentation/widgets/mySearch.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchQuery = TextEditingController();
  @override
  void initState() {
    super.initState();
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
    return Column(
      children: [
        MySearch(searchQuery: searchQuery),
        SizedBox(height: 10),
        BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            if (state is SearchLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is SearchSuccess) {
              return Expanded(
                child: ListView.builder(
                  itemCount: state.response.length,
                  itemBuilder:
                      (context, index) => OppCard(opps: state.response[index]),
                ),
              );
            }
            if (state is SearchError) {
              return Center(child: Text(state.error));
            }
            return SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
