import 'package:flutter/material.dart';
import 'package:quickchance_app/features/home/presentation/widgets/myappbar.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          MyAppBar(),
          // ListView(children: [Icon(Icons.person)]),
          SizedBox(
            height: 100,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: 7,
              scrollDirection: Axis.horizontal,
              itemBuilder:
                  (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        'https://images.vexels.com/content/145908/preview/male-avatar-maker-2a7919.png',
                      ),
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
