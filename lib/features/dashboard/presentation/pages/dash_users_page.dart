import 'package:flutter/material.dart';
import 'package:quickchance_app/features/dashboard/data/datasources/remote/dashboardApiService.dart';
import 'package:quickchance_app/features/dashboard/domain/usecases/addUpdateUser.dart';

class DashUsersPage extends StatefulWidget {
  const DashUsersPage({super.key});

  @override
  State<DashUsersPage> createState() => _DashUsersPageState();
}

class _DashUsersPageState extends State<DashUsersPage> {
  TextEditingController searchQuery = TextEditingController();
  TextEditingController fullname = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();

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
                                  GestureDetector(
                                    onTap: () {
                                      fullname.text =
                                          snapshot.data![index].fullname!;
                                      username.text =
                                          snapshot.data![index].username!;
                                      email.text = snapshot.data![index].email!;
                                      addUpdateUser(
                                        context,
                                        'Update a User',
                                        'Update',
                                        fullname,
                                        username,
                                        email,
                                        (snapshot.data![index].gender ==
                                                'Not Specified')
                                            ? 'Gender'
                                            : snapshot.data![index].gender,
                                        snapshot.data![index].role!,
                                        snapshot.data![index].id,
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
                                                  'Are you sure you want to delete this user?',
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
                                                      DashboardApiService()
                                                          .deleteUser(
                                                            snapshot
                                                                .data![index]
                                                                .id,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          fullname.clear();
          username.clear();
          email.clear();
          addUpdateUser(
            context,
            'Add New User',
            'Register',
            fullname,
            username,
            email,
            'Gender',
            'Role',
            0,
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
