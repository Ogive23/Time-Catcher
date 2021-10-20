import 'dart:math';

import 'package:flutter/material.dart';

List<Map<String, String>> list = [
  {
    'identifier': List.generate(10, (index) => Random().nextInt(5)).join(),
    'image': 'https://cdn.picpng.com/man/icon-man-33232.png',
    'name': 'Mahmoued'
  },
  {
    'identifier': List.generate(10, (index) => Random().nextInt(5)).join(),
    'image':
        'https://www.pngall.com/wp-content/uploads/2016/05/Man-PNG-Image.png',
    'name': 'Mohamed'
  },
  {
    'identifier': List.generate(10, (index) => Random().nextInt(5)).join(),
    'image':
        'https://img.pngio.com/slide2-menpng-rm-web-lab-men-png-635_540.png',
    'name': 'Ali'
  },
  {
    'identifier': List.generate(10, (index) => Random().nextInt(5)).join(),
    'image': 'https://www.freeiconspng.com/uploads/men-hair-png-33.png',
    'name': 'Ismail'
  },
  {
    'identifier': List.generate(10, (index) => Random().nextInt(5)).join(),
    'image': 'https://www.freeiconspng.com/uploads/men-hair-png-33.png',
    'name': 'Ismail'
  },
  {
    'identifier': List.generate(10, (index) => Random().nextInt(5)).join(),
    'image': 'https://www.freeiconspng.com/uploads/men-hair-png-33.png',
    'name': 'Ismail'
  },
];

class SearchResultPage extends StatelessWidget {
  final String searchText;
  late double w, h;

  SearchResultPage({required this.searchText});
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    print(list);
    return Container(
      width: w,
      constraints: BoxConstraints(maxHeight: h / 2),
      margin: EdgeInsets.symmetric(horizontal: w / 20),
      decoration: BoxDecoration(color: Colors.grey.withOpacity(0.5)),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: list
              .where((person) => person['identifier']!.contains(searchText))
              .map((person) => Card(
                    color: Colors.transparent,
                    elevation: 0.0,
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Image.network(person['image']!),
                      ),
                      title: Text(
                        person['name']!,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
