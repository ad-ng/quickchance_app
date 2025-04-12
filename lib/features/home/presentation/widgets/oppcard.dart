import 'package:flutter/material.dart';

class OppCard extends StatefulWidget {
  const OppCard({super.key});

  @override
  State<OppCard> createState() => _OppCardState();
}

class _OppCardState extends State<OppCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 60,
                    child: Image.network(
                      'https://static.vecteezy.com/system/resources/previews/024/183/525/non_2x/avatar-of-a-man-portrait-of-a-young-guy-illustration-of-male-character-in-modern-color-style-vector.jpg',
                    ),
                  ),
                  SizedBox(width: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'MYCULTURE',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '19 Posts',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Text('2h ago', style: TextStyle(fontWeight: FontWeight.w500)),
                ],
              ),
            ],
          ),

          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            margin: EdgeInsets.only(top: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                'https://assets.entrepreneur.com/content/3x2/2000/1709054067-ent24-marchapril-FastestGrowing-Intro.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            style: TextStyle(fontWeight: FontWeight.w500),
            'remaining essentially unchanged. It was with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishin',
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Row(
                children: [
                  SizedBox(width: 10),
                  Icon(Icons.favorite_border_rounded, color: Colors.grey),
                  SizedBox(width: 5),
                  Text('290', style: TextStyle(fontWeight: FontWeight.w400)),
                  SizedBox(width: 15),
                  Icon(Icons.comment, color: Colors.grey),
                  SizedBox(width: 5),
                  Text('30', style: TextStyle(fontWeight: FontWeight.w400)),
                  SizedBox(width: 15),
                  Icon(Icons.bookmark_border_outlined, color: Colors.grey),
                  SizedBox(width: 5),
                  Text('2', style: TextStyle(fontWeight: FontWeight.w400)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
