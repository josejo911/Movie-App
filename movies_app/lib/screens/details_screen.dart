import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';
import 'package:movies_app/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    //Cambiar luego por una isntancia de movie
    //Recibimos en movie la insntancia creada en la pantalla anterior
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie; 

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(movie),
          //El SliverList sirve para poder usar widgets normales
          //En un sliver solo se pueden usar widgets de la familia slivers
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(movie),
              _Overview(movie),
              CastingCards(movie.id),
              
            ]))
        ],

        ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {

  final Movie movie;

  const _CustomAppBar(this.movie); 

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true ,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          color: Colors.black12, //Asi aplicamos el translucido
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          child: Text(movie.title,
          style: TextStyle(fontSize: 16,),
          textAlign: TextAlign.center,
          ),
        ),
        background: ShaderMask(
            shaderCallback: (rect) {
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black, Colors.transparent],
            ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
          },
          blendMode: BlendMode.dstIn,
          child: FadeInImage(
            placeholder: AssetImage('assets/loading.gif'), 
            image:  NetworkImage(movie.fullBackdropPath),
            fit: BoxFit.cover,
            ),
        ),
        ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {

  final Movie movie;

  const _PosterAndTitle(this.movie);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      color: Colors.black,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Row(
        children: [
          Hero(
            tag: movie.heroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'), 
                image: NetworkImage(movie.fullPosterImg),
                height: 150,
                ),
            ),
          ),
          SizedBox(width: 20),

          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 190),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.title, 
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
                overflow: TextOverflow.ellipsis, maxLines: 2,),
                Text(movie.originalTitle, 
                style: TextStyle(color: Colors.white),
                overflow: TextOverflow.ellipsis, maxLines: 2,),
                Text('Lanzamiento: ${movie.releaseDate}', 
                style: TextStyle(color: Colors.white),
                overflow: TextOverflow.ellipsis, maxLines: 2,),
          
                Row(
                  children: [
                    Icon( Icons.star_outline, size: 15, color: Colors.grey,),
                    SizedBox(width: 5,),
                    Text('${movie.voteAverage}', style: TextStyle(color: Colors.white),)
                  ],
                )
              ],
            ),
          )
        ],

      ),
    );
  }
}

class _Overview extends StatelessWidget {

  final Movie movie;

  const _Overview(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      child: Text(movie.overview,
      textAlign: TextAlign.justify,
      style: TextStyle(color: Colors.white,),)
    );
  }
}

