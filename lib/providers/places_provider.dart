import 'dart:io';

import 'package:flutter/material.dart';
import 'package:travel/database/places_db.dart';
import 'package:travel/models/place.dart';

class PlacesProvider with ChangeNotifier {
  List<Place> _list = [];
  List<Place> get list {
    return [..._list];
  }

  void addPlace(String title, File image) {
    PlaceLocation placeLocation =
        PlaceLocation(latitude: '1', longitude: '1', address: 'address');
    Place newPlace = Place(
      id: UniqueKey().toString(),
      title: title,
      location: placeLocation,
      image: image,
    );
    _list.add(newPlace);
    notifyListeners();
    PlacesDB.insert('user_places', {'id': newPlace.id, 'title': newPlace.title, 'image': newPlace.image.path,},);
  }
}
