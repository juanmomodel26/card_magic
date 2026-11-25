import 'package:app_api_flutter/backend/api.dart';
import 'package:app_api_flutter/class_card.dart';
import 'package:app_api_flutter/widgets/widgetcard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: pageaccueil());
  }
}

class pageaccueil extends StatefulWidget {
  const pageaccueil({super.key});
  State<pageaccueil> createState() => pageaccueilState();
}

class pageaccueilState extends State<pageaccueil> {
  final TextEditingController _searchController = TextEditingController();
  String rechercher(String recherche) {
    setState(() {
      _searchController.text = recherche;
    });
    return _searchController.text;
  }

  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: Column(
          children: [
            Padding(padding: EdgeInsetsGeometry.only(top: 50)),
            TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "entrez le nom d'une carte",
              ),
              onChanged: rechercher,
            ),
            SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Row(
                children: [
                  FutureBuilder(
                    future: recupCard(_searchController.text),

                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(child: CircularProgressIndicator(), margin: EdgeInsets.only(left: 175, top: 150));
                      }
                      if (snapshot.data!.length < 1 || snapshot.data == null) {
                        return Container(child: Text("Aucune annonce trouvée"), margin: EdgeInsets.only(left: 125, top: 150));
                      }
                      if (snapshot.data!.length > 1) {
                        return Container(
                          height: MediaQuery.of(context).size.height-200,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: GridView.builder(
                              padding: const EdgeInsets.all(12),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 12,
                                    mainAxisSpacing: 12,
                                    childAspectRatio: 0.8, 
                                  ),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                final card = snapshot.data![index];
                                return Widgetcard(nom: card!.nom, img: card.img);
                              },
                            ),
                          ),
                        );
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
