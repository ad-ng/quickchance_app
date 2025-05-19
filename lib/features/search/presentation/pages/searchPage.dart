import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popover/popover.dart';
import 'package:quickchance_app/features/home/presentation/widgets/oppcard.dart';
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

            SizedBox(width: 40),
            Builder(
              builder: (context) {
                return TextButton(
                  onPressed: () {
                    
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
                            activeBgColors: [
                              [Colors.yellow],
                              [Colors.yellow],
                              [Colors.yellow],
                              [Colors.yellow],
                              [Colors.yellow],
                              [Colors.yellow],
                              [Colors.yellow],
                              [Colors.yellow],
                            ],
                            inactiveBgColor:
                                Theme.of(context).colorScheme.surface,
                            labels: [
                              'All Types',
                              'ScholarShip',
                              'Land',
                              'Office',
                              'Cottage',
                              'Villa',
                              'Apartment',
                              'Residential House',
                            ],
                            onToggle: (index) {},
                          ),
                    );
                  },
                  child: Text(
                    'Type',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
          ],
        ),
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
