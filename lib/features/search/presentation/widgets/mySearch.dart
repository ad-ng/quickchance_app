import 'package:flutter/material.dart';

class MySearch extends StatefulWidget {
  final TextEditingController searchQuery;
  const MySearch({super.key, required this.searchQuery});

  @override
  State<MySearch> createState() => _MySearchState();
}

class _MySearchState extends State<MySearch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
      child: TextField(
        controller: widget.searchQuery,
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
                widget.searchQuery.clear();
              },
              icon: Icon(Icons.cancel),
            ),
          ),
          isDense: true,
          hintText: 'search location, title, .....',
        ),
      ),
    );
  }
}
