import 'package:flutter/material.dart';
import 'package:quickchance_app/features/dashboard/data/datasources/remote/dashboardApiService.dart';

class DashUsersPage extends StatefulWidget {
  const DashUsersPage({super.key});

  @override
  State<DashUsersPage> createState() => _DashUsersPageState();
}

class _DashUsersPageState extends State<DashUsersPage> {
  TextEditingController searchQuery = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Users Page'), centerTitle: true),
      body: Column(
        children: [
          Container(
            height: 45,
            margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
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
                hintText: 'search email, username, .....',
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: FutureBuilder(
              future: DashboardApiService().fetchAllUser(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder:
                        (context, index) => Card(
                          child: ListTile(
                            title: Text(snapshot.data![index].email!),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(snapshot.data![index].fullname!),
                                Text(snapshot.data![index].role!),
                              ],
                            ),
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
                        ),
                  );
                }
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }
                return SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
