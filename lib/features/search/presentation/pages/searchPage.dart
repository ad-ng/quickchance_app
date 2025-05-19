import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchQuery = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 45,
          margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
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
              hintText: 'search location, title, .....',
            ),
          ),
        ),
      ],
    );
  }
}
