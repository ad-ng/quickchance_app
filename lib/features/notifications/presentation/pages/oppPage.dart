import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quickchance_app/features/home/data/models/opportunity_model.dart';
import 'package:quickchance_app/features/home/presentation/widgets/oppcard.dart';

class OppPage extends StatefulWidget {
  final OpportunityModel opportunityModel;
  const OppPage({super.key, required this.opportunityModel});

  @override
  State<OppPage> createState() => _OppPageState();
}

class _OppPageState extends State<OppPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Opp Page'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => context.goNamed('landingPage'),
            icon: Icon(Icons.home_filled),
          ),
        ],
      ),
      body: Column(children: [OppCard(opps: widget.opportunityModel)]),
    );
  }
}
