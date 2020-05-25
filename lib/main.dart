import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:superheroes/info.dart';
import 'package:superheroes/splash_screen.dart';

void main() {
  runApp(new MaterialApp(
    home: new Splash_Screen(),
    theme: ThemeData.dark(),
    debugShowCheckedModeBanner: false,
  ));
}

class HomePage extends StatefulWidget {
  @override
  homePageState createState() => new homePageState();
}

class homePageState extends State<HomePage> {
  Future<String> _loadAsset() async {
    return await rootBundle.loadString('assets/heroes.json');
  }

  Future<List<SuperHeroes>> _getHeroes() async {
    String jsonString = await _loadAsset();
    var jsonData = jsonDecode(jsonString);

    List<SuperHeroes> heroes = [];
    for (var i in jsonData) {
      SuperHeroes he = SuperHeroes(
          i["imagen"],
          i["nombre"],
          i["identidadsecreta"],
          i["edad"],
          i["altura"],
          i["genero"],
          i["descripcion"]);
      heroes.add(he);
    }
    return heroes;
  }

  String searchString = "";
  bool _isSearching = false;
  final searchController = TextEditingController();

  AudioPlayer audioPlayer;
  AudioCache audioCache;

  final audioname = "avengers.mp3";

  @override
  void initState() {
    super.initState();

    audioPlayer = AudioPlayer();
    audioCache = AudioCache();

    setState(() {
      audioCache.loop(audioname);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        title: _isSearching
            ? TextField(
                decoration: InputDecoration(
                    hintText: "Buscando un superheroe",
                    icon: Icon(Icons.search)),
                onChanged: (value) {
                  setState(() {
                    searchString = value;
                  });
                },
                controller: searchController,
              )
            : Text("Superheroes"),
        actions: <Widget>[
          !_isSearching
              ? IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      searchString = "";
                      this._isSearching = !this._isSearching;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      this._isSearching = !this._isSearching;
                    });
                  },
                )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          child: FutureBuilder(
            future: _getHeroes(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: Text("Cargando..."),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return snapshot.data[index].nombre.contains(searchString)
                        ? ListTile(
                            leading: CircleAvatar(
                              radius: 20,
                              child: ClipOval(
                                child: new SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: new Image.network(
                                      snapshot.data[index].imagen.toString()),
                                ),
                              ),
                            ),
                            title: Text(snapshot.data[index].nombre
                                .toString()
                                .toUpperCase()),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => InformacionHeroe(
                                          snapshot.data[index])));
                            },
                          )
                        : Container();
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class SuperHeroes {
  final String imagen;
  final String nombre;
  final String identidadsecreta;
  final String edad;
  final String altura;
  final String genero;
  final String descripcion;

  SuperHeroes(this.imagen, this.nombre, this.identidadsecreta, this.edad,
      this.altura, this.genero, this.descripcion);
}
