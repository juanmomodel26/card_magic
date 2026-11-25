import 'dart:convert';
import 'package:app_api_flutter/class_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

List<Carte> cartes = [];  

Future<List<Carte?>> recupCard(String recherche) async {

String url = 'https://api.scryfall.com/cards/search?q="$recherche"';
List<Carte> cartes = [];  
print(url);
  try {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    final reponse = await http.get(Uri.parse(url),headers: requestHeaders);
    print(reponse.body);
    print(reponse.statusCode);
    if (reponse.statusCode == 200) 
    {
      Map<String, dynamic> data = json.decode(reponse.body);
      for (Map<String,dynamic> carte in data["data"])
      {
        cartes.add(Carte.fromJson(carte));
        if (cartes.length >= 20){
          return cartes;
        }
      }
      return cartes; 
    } 
    else 
    {
      return [];
    }
  } 
  catch (e) 
  {
    return cartes;
  }
}