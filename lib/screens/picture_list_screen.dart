import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:personify/providers/personify_pictures.dart';
import './add_picture_screen.dart';
import '../widgets/picture_item.dart';

class PicturesListScreen extends StatefulWidget {
  static const routeName = '/picture-list';

  @override
  _PicturesListScreenState createState() => _PicturesListScreenState();
}

class _PicturesListScreenState extends State<PicturesListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Personify",
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddPictureScreen.routeName);
              },
              icon: Icon(Icons.add_a_photo_outlined))
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<PersonifyPictures>(context, listen: false)
            .fetchAndSetPictures(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<PersonifyPictures>(
                builder: (ctx, pictures, _) {
                  if (pictures.items.length > 0) {
                    return GridView.builder(
                      padding: const EdgeInsets.all(10.0),
                      itemCount: pictures.items.length,
                      itemBuilder: (ctx, i) => PictureItem(
                        pictures.items[i].id,
                        pictures.items[i].title,
                        pictures.items[i].image,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: MediaQuery.of(context).size.width /
                            ((MediaQuery.of(context).size.height +
                                    MediaQuery.of(context).padding.top) /
                                1.9),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                    );
                  } else
                    return Center(
                      child: const Text(
                        'Got no pictures yet, start adding some!',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    );
                },
              ),
      ),
    );
  }
}
