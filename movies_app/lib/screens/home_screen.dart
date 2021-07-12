import 'package:flutter/material.dart';
import 'package:movies_app/widgets/widgets.dart';
class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas en cines'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: (){

          }, icon: Icon(Icons.search_outlined)
          )
        ],
        
      ),
      body: SingleChildScrollView( // Este widget permite hacer scroll
          child: Column(
            children: [
              //Tarjetas principales
              CardSwiper(),
              //Slider de peliculas
              MovieSlider(),
              MovieSlider(),
              MovieSlider(),
              MovieSlider()


              //Listado de peliculas
            ],
        )
      )
    );

  }
}