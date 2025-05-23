import 'package:flutter/material.dart';
import 'package:quickchance_app/features/home/presentation/widgets/oppcard.dart';
import 'package:quickchance_app/features/saved/data/datasources/remote/savedApiService.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Center(child: Text('SAVED OPPORTUNITIES')),
        SizedBox(height: 10),
        Expanded(
          child: FutureBuilder(
            future: SavedApiService().fetchSavedOpps(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator.adaptive());
              }
              if (snapshot.hasData) {
                if (snapshot.data!.length == 0) {
                  return Center(
                    child: Image.asset('././lib/images/no-search-found.png'),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  addAutomaticKeepAlives: true,
                  itemBuilder:
                      (context, index) => OppCard(
                        opps: snapshot.data![index].opp,
                        key: ValueKey(snapshot.data![index].id),
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
    );
  }
}
