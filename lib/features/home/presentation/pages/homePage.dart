import 'package:flutter/material.dart';
import 'package:quickchance_app/features/home/presentation/widgets/categoryCard.dart';
import 'package:quickchance_app/features/home/presentation/widgets/oppcard.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 5),
        Wrap(
          children: [
            CategoryCard(catName: 'Technology'),
            CategoryCard(catName: 'scholarship'),
            CategoryCard(catName: 'training'),
            CategoryCard(catName: 'news'),
            CategoryCard(catName: 'competition'),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 2,
            itemBuilder: (context, index) => OppCard(),
          ),
        ),
      ],
    );
  }
}
