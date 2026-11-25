import 'package:flutter/material.dart';

class Widgetcard extends StatelessWidget {
  final String? nom;
  final String? img;

  const Widgetcard({this.nom, this.img});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 150,
      child: Column(
        children: [
          Container(
            height: 150,
            width: 150,
            child: Image.network(
              img ?? "https://cards.scryfall.io/small/front/f/8/f8067745-35b6-4abd-9ae9-712159a26c89.jpg?1783930711",
            ),
          ),
          Container(height: 50, width: 150, child: Text(nom ?? "zombie", textAlign: TextAlign.center,)),
        ],
      ),
    );
  }
}
