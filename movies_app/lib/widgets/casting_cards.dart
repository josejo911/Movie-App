import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';
import 'package:movies_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {

  final int movieId;

  const CastingCards ( this.movieId);

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getMovieCast(movieId),
      builder: (_, AsyncSnapshot<List<Cast>> snapshot) {

        //DEPENDE SI TENGO O NO DATA SI TENGO REGRESO EL CONTAINER DONDE ESTA LA INFO   
      if( !snapshot.hasData ){
        return Container(
          height: 180,
          constraints: BoxConstraints(maxWidth: 150),
          child: CupertinoActivityIndicator(),
        );
      }
      
      final cast = snapshot.data!;

      return Container(
      color: Colors.black,
      padding: EdgeInsets.only(),
      width: double.infinity,
      height: 180,
      child: ListView.builder(
        itemCount: cast.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, int index) => _CastCard(cast[index])),
      );
      },
    );

  }
}

class _CastCard extends StatelessWidget {

  final Cast actor;

  const _CastCard( this.actor);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Container(
        color: Colors.black,
        margin: EdgeInsets.symmetric(horizontal: 10),
        width: 110,
        height: 100,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'), 
                image: NetworkImage(actor.fullProfilePath),
                height: 140,
                width: 100,
                fit: BoxFit.cover,
                ),
            ),
            SizedBox(height: 5,),
            Text(
              actor.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
              
            )
          ],
        ),
        
      ),
    );
  }
}