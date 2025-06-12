import 'package:flutter/material.dart';
import 'package:quickchance_app/features/dashboard/data/datasources/remote/dashboardApiService.dart';
import 'package:quickchance_app/features/dashboard/domain/usecases/addUpdateCat.dart';
import 'package:quickchance_app/features/search/data/datasource/local/searchApiService.dart';

class DashCatPage extends StatefulWidget {
  const DashCatPage({super.key});

  @override
  State<DashCatPage> createState() => _DashCatPageState();
}

class _DashCatPageState extends State<DashCatPage> {
  TextEditingController catName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Categories'), centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: SearchApiService().fetchAllCategories(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder:
                        (context, index) => ListTile(
                          title: Text(snapshot.data![index].name),
                          leading: Text('${index + 1}'),
                          trailing: SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    catName.text = snapshot.data![index].name;
                                    addOrUpdateCategory(
                                      context,
                                      catName,
                                      'Update',
                                      'Update Category',
                                      snapshot.data![index].id,
                                    );
                                  },
                                  icon: Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed:
                                      () => showDialog(
                                        context: context,
                                        builder:
                                            (context) => AlertDialog(
                                              title: Text(
                                                'Delete Confirmation',
                                              ),
                                              content: Text(
                                                'Are you sure you want to delete this category?',
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
                                                        .deleteCategory(
                                                          snapshot
                                                              .data![index]
                                                              .id!,
                                                        );
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Delete'),
                                                ),
                                              ],
                                            ),
                                      ),
                                  icon: Icon(Icons.delete),
                                ),
                              ],
                            ),
                          ),
                        ),
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            () => addOrUpdateCategory(
              context,
              catName,
              'Add',
              'Add New Category',
              0,
            ),
        child: Icon(Icons.add),
      ),
    );
  }
}
