import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popover/popover.dart';
import 'package:quickchance_app/features/dashboard/data/datasources/remote/dashboardApiService.dart';
import 'package:quickchance_app/features/dashboard/presentation/widgets/mydate.dart';
import 'package:quickchance_app/features/dashboard/presentation/widgets/status_selector.dart';
import 'package:quickchance_app/features/home/data/models/opportunity_model.dart';
import 'package:quickchance_app/features/search/data/datasource/local/searchApiService.dart';
import 'package:quickchance_app/features/search/presentation/bloc/search_cubit.dart';
import 'package:quickchance_app/features/search/presentation/widgets/mySearch.dart';
import 'package:toggle_switch/toggle_switch.dart';

class DashOppPage extends StatefulWidget {
  const DashOppPage({super.key});

  @override
  State<DashOppPage> createState() => _DashOppPageState();
}

class _DashOppPageState extends State<DashOppPage> {
  int catId = 0;
  TextEditingController searchQuery = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  TextEditingController deadlineController = TextEditingController();
  TextEditingController statusController = TextEditingController();

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
                          subtitle: Text(state.response[index].user!.email!),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Add An Opportunity'),
                content: SingleChildScrollView(
                  child: Container(
                    height: 430,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: titleController,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(),
                            labelText: 'title',
                          ),
                        ),
                        SizedBox(height: 8),
                        TextField(
                          controller: descriptionController,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(),
                            labelText: 'description',
                          ),
                          maxLines: 3,
                        ),
                        SizedBox(height: 8),
                        TextField(
                          controller: locationController,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(),
                            labelText: 'location',
                          ),
                        ),
                        SizedBox(height: 8),
                        TextField(
                          controller: linkController,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(),
                            labelText: 'link',
                          ),
                        ),
                        SizedBox(height: 8),
                        MyDate(dobController: deadlineController),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Builder(
                              builder: (context) {
                                return TextButton(
                                  onPressed: () async {
                                    final cats =
                                        await SearchApiService()
                                            .fetchAllCategories();
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
                                                Theme.of(
                                                  context,
                                                ).colorScheme.surface,
                                            labels:
                                                cats
                                                    .map((item) => item.name)
                                                    .toList(),
                                            onToggle: (index) {
                                              setState(() {
                                                catId = cats[index!].id!;
                                              });
                                            },
                                          ),
                                    );
                                  },
                                  child: Text(
                                    'Categories',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              },
                            ),
                            StatusSelector(statusController: statusController),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      titleController.clear();
                      descriptionController.clear();
                      locationController.clear();
                      linkController.clear();
                      deadlineController.clear();
                      statusController.clear();

                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      DashboardApiService().addOpportunity(
                        OpportunityModel(
                          title: titleController.text,
                          description: descriptionController.text,
                          status: statusController.text,
                          categoryId: catId,
                          deadline: deadlineController.text,
                          location: locationController.text,
                          oppLink: linkController.text,
                        ),
                      );
                      Navigator.pop(context);
                    },
                    child: Text('add'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
