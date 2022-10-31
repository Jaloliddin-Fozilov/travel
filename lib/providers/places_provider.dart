import 'dart:io';

import 'package:flutter/material.dart';
import 'package:travel/database/places_db.dart';
import 'package:travel/models/place.dart';

class PlacesProvider with ChangeNotifier {
  List<Place> _list = [];
  List<Place> get list {
    return [..._list];
  }

  Place getById(String id) {
    return _list.firstWhere((place) => place.id == id);
  }

  void addPlace(String title, String description, String categoryId,
      double rating, File image, PlaceLocation placeLocation) {
    Place newPlace = Place(
      id: UniqueKey().toString(),
      title: title,
      description: description,
      categoryId: categoryId,
      rating: rating,
      location: placeLocation,
      image: image,
      isFavourite: false,
    );
    _list.add(newPlace);
    notifyListeners();
    PlacesDB.insert(
      'user_places',
      {
        'id': newPlace.id,
        'title': newPlace.title,
        'description': newPlace.description,
        'categoryId': newPlace.categoryId,
        'rating': newPlace.rating,
        'image': newPlace.image.path,
        'location_lat': newPlace.location.latitude,
        'location_lng': newPlace.location.longitude,
        'address': newPlace.location.address,
        'isFavourite': newPlace.isFavourite ? 1 : 0,
      },
    );
  }

  Future<void> getPlaces() async {
    final placesList = await PlacesDB.getData('user_places');
    _list = placesList
        .map(
          (place) => Place(
            id: place['id'],
            title: place['title'],
            description: place['description'],
            categoryId: place['categoryId'],
            rating: place['rating'],
            location: PlaceLocation(
              latitude: place['location_lat'],
              longitude: place['location_lng'],
              address: place['address'],
            ),
            image: File(place['image']),
            isFavourite: place['isFavourite'] == 1 ? true : false,
          ),
        )
        .toList();
    notifyListeners();
  }
}
