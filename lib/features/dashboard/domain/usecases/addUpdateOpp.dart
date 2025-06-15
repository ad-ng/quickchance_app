import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:quickchance_app/features/dashboard/data/datasources/remote/dashboardApiService.dart';
import 'package:quickchance_app/features/dashboard/presentation/widgets/mydate.dart';
import 'package:quickchance_app/features/dashboard/presentation/widgets/status_selector.dart';
import 'package:quickchance_app/features/home/data/models/opportunity_model.dart';
import 'package:quickchance_app/features/search/data/datasource/local/searchApiService.dart';
import 'package:toggle_switch/toggle_switch.dart';

void addUpdateOpp(
  BuildContext context,
  TextEditingController titleController,
  TextEditingController descriptionController,
  TextEditingController locationController,
  TextEditingController linkController,
  TextEditingController deadlineController,
  TextEditingController statusController,
  String nameOfAction,
  int? oppId,
) {
  int outsideCatId = 0;
  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (
          BuildContext context,
          void Function(void Function()) setState,
        ) {
          int catId = 0;
          return AlertDialog(
            title:
                (nameOfAction == 'Save')
                    ? Text('Add An Opportunity')
                    : Text('Update an Opportunity'),
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
                                            outsideCatId = catId;
                                            print(
                                              'category id changing: ${outsideCatId}',
                                            );
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
                  // (nameOfAction == 'Save')
                  //     ?

                  DashboardApiService().addOpportunity(
                    OpportunityModel(
                      title: titleController.text,
                      description: descriptionController.text,
                      status: statusController.text,
                      categoryId: outsideCatId,
                      deadline: deadlineController.text,
                      location: locationController.text,
                      oppLink: linkController.text,
                    ),
                  );
                  // : DashboardApiService().updateOpportunity(
                  //   OpportunityModel(
                  //     title: titleController.text,
                  //     description: descriptionController.text,
                  //     status: statusController.text,
                  //     categoryId: catId,
                  //     deadline: deadlineController.text,
                  //     location: locationController.text,
                  //     oppLink: linkController.text,
                  //   ),
                  //   oppId!,
                  // );

                  Navigator.pop(context);
                },
                child: Text(nameOfAction),
              ),
            ],
          );
        },
      );
    },
  );
}
