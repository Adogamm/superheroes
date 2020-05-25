import 'package:flutter/material.dart';
import 'main.dart';

class InformacionHeroe extends StatelessWidget {
  final SuperHeroes heroes;

  InformacionHeroe(this.heroes);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        title: Text("Información del heroe"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: SingleChildScrollView(
              child: Center(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(heroes.imagen)),
                            ),
                          ),

                        ),
                        Center(
                            child: Text(
                              heroes.nombre.toUpperCase(),
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 8),
                            )),
                        Center(
                          child: new Text(
                            heroes.identidadsecreta,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        Text(""),
                        Center(child: Text("EDAD: " + heroes.edad)),
                        Text(""),
                        Center(child: Text("ALTURA: " + heroes.altura)),
                        Text(""),
                        Center(child: Text("GENERO: " + heroes.genero)),
                        Text(""),
                        Center(child: Text("BREVE DESCRIPCIÓN: ")),
                        Text(""),
                        Text(heroes.descripcion)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}