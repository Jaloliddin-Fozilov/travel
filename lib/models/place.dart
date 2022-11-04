import 'dart:io';

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;
  PlaceLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
  });
}

class Place {
  final String id;
  final String title;
  final String description;
  final String categoryId;
  final double rating;
  final PlaceLocation location;
  final File image;
  late bool isFavourite;
  Place({
    required this.id,
    required this.title,
    required this.description,
    required this.categoryId,
    required this.rating,
    required this.location,
    required this.image,
    required this.isFavourite,
  });
}
