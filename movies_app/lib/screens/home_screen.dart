import 'package:flutter/material.dart';
import 'package:movies_app/providers/movies_provider.dart';
import 'package:movies_app/search/search_delegate.dart';
import 'package:movies_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Explorar' ,style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => showSearch(
              context: context, 
              delegate: MovieSearchDelegate())

          , icon: Icon(Icons.search_outlined)
          )
        ],
        
      ),
      body: SingleChildScrollView( // Este widget permite hacer scroll
          child: Column(
            
            children: [
              //Tarjetas principales
              CardSwiper(movies: moviesProvider.onDisplayMovies,),
              //Slider de peliculas
              MovieSlider(
                movies: moviesProvider.popularMovies,
                title: "Populares",
                onNextPage: () => moviesProvider.getPopularMovies(),
              ),
              MovieSlider(
                movies: moviesProvider.upcomingMovies,
                title: "Proximos lanzamientos",
                onNextPage: () => moviesProvider.getUpcomingMovies(),
              ),
              MovieSlider(
                movies: moviesProvider.onDisplayMovies,
                title: "Top 20 en tu pais",
                onNextPage: () => moviesProvider.onDisplayMovies,
              ),

              //Listado de peliculas
            ],
        )
      )
    );

  }
}