import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/personify_pictures.dart';

class PictureDetailScreen extends StatelessWidget {
  static const routeName = '/picture-detail';
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments;
    final selectedPicture =
        Provider.of<PersonifyPictures>(context, listen: false)
            .findById(id.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedPicture.title,
          style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Container(
        color: Colors.grey[800],
        padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white, width: 3)),
              height: MediaQuery.of(context).size.height / 1.5,
              width: double.infinity,
              child: Image.file(
                selectedPicture.image,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Clicked at: " + selectedPicture.time,
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.white,
              ),
              onPressed: () {
                Provider.of<PersonifyPictures>(context, listen: false)
                    .deletePicture(selectedPicture.id);
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.delete,
                color: Colors.red,
                semanticLabel: "Delete",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
