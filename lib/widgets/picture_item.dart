import 'dart:io';
import 'package:flutter/material.dart';

import 'package:personify/screens/picture_detail_screen.dart';

class PictureItem extends StatelessWidget {
  final String id;
  final String title;
  final File image;
  PictureItem(this.id, this.title, this.image);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(PictureDetailScreen.routeName, arguments: id);
          },
          child: Hero(
            tag: id,
            child: FadeInImage(
              placeholder: AssetImage('assets/fade.jpg'),
              image: FileImage(image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.grey[800],
          title: Center(
              child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          )),
        ),
      ),
    );
  }
}
