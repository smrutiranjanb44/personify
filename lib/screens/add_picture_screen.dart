import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../widgets/image_input.dart';
import '../widgets/home_screen.dart';
import '../providers/personify_pictures.dart';

class AddPictureScreen extends StatefulWidget {
  static const routeName = '/add-place';

  @override
  _AddPictureScreenState createState() => _AddPictureScreenState();
}

class _AddPictureScreenState extends State<AddPictureScreen> {
  late File _pickedImage;

  final _titleController = TextEditingController();
  bool _validate = false;

  void _selectImage(File pickedImagejr) {
    _pickedImage = pickedImagejr;
  }

  void _savePlace() {
    if (_titleController.text.isEmpty) {
      setState(() {
        _titleController.text.isEmpty ? _validate = true : _validate = false;
      });
      if (_validate) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Title Can\'t Be Empty',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
          ),
          padding: EdgeInsets.all(4),
          backgroundColor: Colors.red[800],
        ));
      }
      return;
    }
    var beginningOfSentenceCase =
        toBeginningOfSentenceCase(_titleController.text.trim());
    Provider.of<PersonifyPictures>(context, listen: false).addPicture(
      beginningOfSentenceCase!,
      _pickedImage,
    );

    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          'Click a Picture',
          style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    TextField(
                      cursorColor: Colors.purple,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                          labelText: 'Title',
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  color: Colors.purple,
                                  width: 2)),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(style: BorderStyle.solid))),
                      controller: _titleController,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ImageInput(_selectImage),
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
                  onPrimary: Colors.white,
                  padding: EdgeInsets.all(15)),
              onPressed: _savePlace,
              child: Container(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.save,
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Text(
                      'Save',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
