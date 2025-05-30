import 'package:flutter/material.dart';
import 'package:quickchance_app/features/dashboard/data/datasources/remote/dashboardApiService.dart';
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
                          leading: Text('${snapshot.data![index].id!}'),
                          trailing: SizedBox(
                            width: 100,
                            height: 20,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () {},
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
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Add New Category'),
                content: Container(
                  height: 40,
                  width: 140,
                  child: TextField(controller: catName),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      catName.clear();
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      DashboardApiService().addCategory(catName.text);
                      Navigator.pop(context);
                    },
                    child: Text('Add'),
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
