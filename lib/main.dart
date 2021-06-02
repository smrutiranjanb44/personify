import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:personify/screens/picture_detail_screen.dart';
import './screens/add_picture_screen.dart';
import './screens/picture_list_screen.dart';
import './providers/personify_pictures.dart';
import './widgets/home_screen.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: PersonifyPictures(),
      child: MaterialApp(
        title: 'Personify',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
        routes: {
          AddPictureScreen.routeName: (ctx) => AddPictureScreen(),
          PicturesListScreen.routeName: (ctx) => PicturesListScreen(),
          PictureDetailScreen.routeName: (ctx) => PictureDetailScreen()
        },
      ),
    );
  }
}
