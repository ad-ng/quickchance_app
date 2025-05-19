import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickchance_app/features/home/presentation/widgets/oppcard.dart';
import 'package:quickchance_app/features/search/presentation/bloc/search_cubit.dart';

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
        Container(
          height: 45,
          margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
          child: TextField(
            controller: searchQuery,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(45),
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(45),
                borderSide: BorderSide(color: Colors.grey),
              ),
              prefixIcon: Icon(Icons.search_rounded),
              suffixIcon: Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: IconButton(
                  onPressed: () {
                    searchQuery.clear();
                  },
                  icon: Icon(Icons.cancel),
                ),
              ),
              isDense: true,
              hintText: 'search location, title, .....',
            ),
          ),
        ),
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
