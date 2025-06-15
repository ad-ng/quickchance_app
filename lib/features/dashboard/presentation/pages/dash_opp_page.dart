import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickchance_app/features/dashboard/data/datasources/remote/dashboardApiService.dart';
import 'package:quickchance_app/features/dashboard/domain/usecases/addUpdateOpp.dart';
import 'package:quickchance_app/features/search/presentation/bloc/search_cubit.dart';
import 'package:quickchance_app/features/search/presentation/widgets/mySearch.dart';

class DashOppPage extends StatefulWidget {
  const DashOppPage({super.key});

  @override
  State<DashOppPage> createState() => _DashOppPageState();
}

class _DashOppPageState extends State<DashOppPage> {
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
                                GestureDetector(
                                  onTap: () {
                                    titleController.text =
                                        state.response[index].title;
                                    descriptionController.text =
                                        state.response[index].description;
                                    locationController.text =
                                        state.response[index].location ?? ' ';
                                    linkController.text =
                                        state.response[index].oppLink ?? ' ';
                                    deadlineController.text =
                                        state.response[index].deadline!;
                                    statusController.text =
                                        state.response[index].status;
                                    addUpdateOpp(
                                      context,
                                      titleController,
                                      descriptionController,
                                      locationController,
                                      linkController,
                                      deadlineController,
                                      statusController,
                                      'Update',
                                      state.response[index].id,
                                    );
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.blue[300],
                                  ),
                                ),
                                SizedBox(width: 10),
                                GestureDetector(
                                  onTap:
                                      () => showDialog(
                                        context: context,
                                        builder:
                                            (context) => AlertDialog(
                                              title: Text(
                                                'Delete Confirmation',
                                              ),
                                              content: Text(
                                                'Are you sure you want to delete this opportunity?',
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Cancel'),
                                                ),
                                                TextButton(
                                                  onPressed: () async {
                                                    await DashboardApiService()
                                                        .deleteOpportunity(
                                                          state
                                                              .response[index]
                                                              .id!,
                                                        );
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Delete'),
                                                ),
                                              ],
                                            ),
                                      ),
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red[300],
                                  ),
                                ),
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
        onPressed:
            () => addUpdateOpp(
              context,
              titleController,
              descriptionController,
              locationController,
              linkController,
              deadlineController,
              statusController,
              'Save',
              0,
            ),
        child: Icon(Icons.add),
      ),
    );
  }
}
