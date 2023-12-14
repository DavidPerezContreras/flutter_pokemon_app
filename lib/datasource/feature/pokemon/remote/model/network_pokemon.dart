import 'dart:convert';
/*
class NetworkPokemon {
  List<Ability> abilities;
  int id;
  String name;

  NetworkPokemon({
    required this.abilities,
    required this.id,
    required this.name,
  });

  NetworkPokemon copyWith({
    List<Ability>? abilities,
    int? id,
    String? name,
  }) =>
      NetworkPokemon(
        abilities: abilities ?? this.abilities,
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory NetworkPokemon.fromRawJson(String str) =>
      NetworkPokemon.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NetworkPokemon.fromJson(Map<String, dynamic> json) => NetworkPokemon(
        abilities: List<Ability>.from(
            json["abilities"].map((x) => Ability.fromJson(x))),
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "abilities": List<dynamic>.from(abilities.map((x) => x.toJson())),
        "id": id,
        "name": name,
      };
}
*/
