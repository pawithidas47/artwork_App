import 'package:flutter/material.dart';
import '../model/artItem.dart'; // นำเข้า ArtItem

class ArtProvider with ChangeNotifier {
  List<ArtItem> _artworks = [];

  List<ArtItem> get artworks => _artworks;

  void addArtwork(String title, String artist, int year, String description, int number, String category, DateTime dateAdded) {
    final newArt = ArtItem(
      title: title,
      artist: artist,
      year: year,
      description: description,
      number: number,
      category: category,
      dateAdded: dateAdded,
    );
    _artworks.add(newArt);
    notifyListeners();
  }
}
