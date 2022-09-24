import 'package:boilerplate/constants/font_family.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatefulWidget {
  FavoritesScreen({Key? key}) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: false,
        elevation: 0.0,
        title: Text(
          'favoritos',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
            fontFamily: FontFamily.comfortaa,
            fontSize: 27.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
