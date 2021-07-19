import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';
import 'package:movies_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate{

  @override
  // TODO: implement searchFieldLabel
  String? get searchFieldLabel => 'Buscar pelicula';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(
      onPressed: () => query = '', 
      icon: Icon(Icons.clear))];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: (){
        // En el close se puede enviar de regreso lo que se necesite y no null
        close(context, null );
      }, 
      icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('a');
  }

  Widget _emptyContainer(){
    return Container(
      color: Colors.black87,

        child: Center(
          child: Icon(Icons.movie_creation_outlined, color: Colors.white54, size: 130,),
        ),
      );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    
    if(query.isEmpty){
      return _emptyContainer();
    }

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    moviesProvider.getSuggestionsByQuery(query);
    
    return StreamBuilder(
      stream: moviesProvider.suggestionStream,
      builder: (_, AsyncSnapshot<List<Movie>> snapshot) {

        if(!snapshot.hasData) return _emptyContainer();

        final movies = snapshot.data!;

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (_, int index) => _MovieItem(movies[index])
          );

      },
    );
  }

}

class _MovieItem extends StatelessWidget {

  final Movie movie;

  const _MovieItem(this.movie);

  @override
  Widget build(BuildContext context) {

    movie.heroId = 'search-${movie.id}';

    return Container(
      color: Colors.black87,
      child: ListTile(
        leading: Hero(
          tag:  movie.heroId!,
          child: FadeInImage(
            placeholder: AssetImage('assets/no-image.jpg'), 
            image: NetworkImage(movie.fullPosterImg),
            width: 50,
            fit: BoxFit.contain,
            ),
        ),
          title: Text(movie.title, style: TextStyle(color: Colors.white),),
          subtitle: Text(movie.originalTitle, style: TextStyle(color: Colors.white),),
          onTap: (){
            Navigator.pushNamed(context, 'details', arguments: movie);
          },
        
      ),
    );
  }
}

