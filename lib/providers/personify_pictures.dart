import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../models/picture.dart';
import '../helpers/db_helper.dart';

class PersonifyPictures with ChangeNotifier {
  var uuid = Uuid();
  DateTime now = DateTime.now();
  List<Picture> _items = [];
  List<Picture> get items {
    return [..._items];
  }

  Picture findById(String id) {
    return _items.firstWhere((place) => place.id == id);
  }

  Future<void> addPicture(
    String pickedTitle,
    File pickedImage,
  ) async {
    final newPicture = Picture(
      id: uuid.v4(),
      image: pickedImage,
      title: pickedTitle,
      time: DateFormat("dd-MM-yyyy - kk:mm a").format(now).toString(),
    );
    _items.add(newPicture);
    notifyListeners();
    DBHelper.insert('user_pictures', {
      'id': newPicture.id,
      'title': newPicture.title,
      'image': newPicture.image.path,
      'time': newPicture.time,
    });
  }

  Future<void> deletePicture(String id) async {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
    DBHelper.delete('user_pictures', id);
  }

  Future<void> fetchAndSetPictures() async {
    final dataList = await DBHelper.getData('user_pictures');
    _items = dataList
        .map(
          (item) => Picture(
              id: item['id'],
              title: item['title'],
              image: File(item['image']),
              time: item['time']),
        )
        .toList();
    notifyListeners();
  }
}
