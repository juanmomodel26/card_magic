class Carte{

  String nom;
  String img;

  Carte({
    required this.nom,
    required this.img
  });

  factory Carte.fromJson(Map<String, dynamic> json) => Carte(
    nom: json["name"] as String,
    img: json["image_uris"]["normal"]
  );
}