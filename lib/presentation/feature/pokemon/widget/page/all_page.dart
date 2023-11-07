import 'package:flutter/material.dart';
import 'package:flutter_app/model/pokemon.dart';
import 'package:flutter_app/presentation/feature/pokemon/widget/pokemon_list_widget.dart';


//ruta /home
class AllPage extends StatefulWidget {
  const AllPage({super.key});

  @override
  State<AllPage> createState() => _AllPageState();
}

class _AllPageState extends State<AllPage>{
  @override
  Widget build(BuildContext context) {
    return  PokemonListWidget();
  }
}
