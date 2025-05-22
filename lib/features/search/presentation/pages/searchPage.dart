import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popover/popover.dart';
import 'package:quickchance_app/features/home/presentation/widgets/oppcard.dart';
import 'package:quickchance_app/features/search/data/datasource/local/searchApiService.dart';
import 'package:quickchance_app/features/search/presentation/bloc/search_cubit.dart';
import 'package:quickchance_app/features/search/presentation/widgets/mySearch.dart';
import 'package:toggle_switch/toggle_switch.dart';

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
    return Column(
      children: [
        MySearch(searchQuery: searchQuery),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Builder(
              builder: (context) {
                return TextButton(
                  onPressed: () {
                    showPopover(
                      direction: PopoverDirection.bottom,
                      context: context,
                      bodyBuilder:
                          (context) => ToggleSwitch(
                            minWidth: 90.0,
                            initialLabelIndex: 2,
                            cornerRadius: 20.0,
                            activeFgColor: Colors.white,
                            inactiveBgColor:
                                Theme.of(context).colorScheme.surface,
                            totalSwitches: 3,
                            labels: ['OPEN', 'CLOSED', 'ALL'],
                            activeBgColors: [
                              [Colors.blue],
                              [Colors.pink],
                              [Colors.blue],
                            ],
                            onToggle: (index) {
                              if (index == 0) {
                                BlocProvider.of<SearchCubit>(
                                  context,
                                ).filterOpp('open');
                                Navigator.pop(context);
                              } else if (index == 1) {
                                BlocProvider.of<SearchCubit>(
                                  context,
                                ).filterOpp('closed');
                                Navigator.pop(context);
                              } else {
                                BlocProvider.of<SearchCubit>(
                                  context,
                                ).searchOpp('');
                                Navigator.pop(context);
                              }
                            },
                          ),
                    );
                  },
                  child: Text(
                    'Status',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
            Builder(
              builder: (context) {
                return TextButton(
                  onPressed: () async {
                    final cats = await SearchApiService().fetchAllCategories();
                    print('fetched categories: ${cats.length}');
                    showPopover(
                      context: context,
                      bodyBuilder:
                          (context) => ToggleSwitch(
                            activeFgColor: Colors.black54,
                            fontSize: 17,
                            isVertical: true,
                            minWidth: 150.0,
                            radiusStyle: true,
                            cornerRadius: 20.0,
                            initialLabelIndex: 0,
                            inactiveBgColor:
                                Theme.of(context).colorScheme.surface,
                            labels: cats.map((item) => item.name).toList(),
                            onToggle: (index) {
                              BlocProvider.of<SearchCubit>(
                                context,
                              ).searchOpp(cats[index!].name);
                              Navigator.pop(context);
                            },
                          ),
                    );
                  },
                  child: Text(
                    'Categories',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
            TextButton(
              onPressed: () {
                BlocProvider.of<SearchCubit>(context).searchOpp('');
              },
              child: Text(
                'Clear',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        Expanded(
          child: BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              if (state is SearchLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is SearchSuccess) {
                if (state.response.length == 0) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 70),
                    child: Center(
                      child: Image.asset('././lib/images/no-search-found.png'),
                    ),
                  );
                }
                return ListView.builder(
                  addAutomaticKeepAlives: true,
                  itemCount: state.response.length,
                  itemBuilder:
                      (context, index) => OppCard(
                        opps: state.response[index],
                        key: ValueKey(state.response[index].id),
                      ),
                );
              }
              if (state is SearchError) {
                return Center(child: Text(state.error));
              }
              return SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}
