import 'package:flutter/material.dart';
import 'package:movies_app/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    //Cambiar luego por una isntancia de movie
    //Recibimos en movie la insntancia creada en la pantalla anterior
    final String movie = ModalRoute.of(context)?.settings.arguments.toString() ?? 'no-movie'; 

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(),
          //El SliverList sirve para poder usar widgets normales
          //En un sliver solo se pueden usar widgets de la familia slivers
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(),
              _Overview(),
              _Overview(),
              _Overview(),
              CastingCards(),
              
            ]))
        ],

        ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
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
          padding: EdgeInsets.only(bottom: 10),
          child: Text('movie.title',
          style: TextStyle(fontSize: 16),
          ),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'), 
          image:  NetworkImage('https://via.placeholder.com/500x300'),
          fit: BoxFit.cover,
          ),
        ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'), 
              image: NetworkImage('http://via.placeholder.com/200x300'),
              height: 150,),
          ),
          SizedBox(width: 20),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('movie.title', 
              style: textTheme.headline5,
              overflow: TextOverflow.ellipsis, maxLines: 2,),
              Text('movie.originalTitle', 
              style: textTheme.subtitle1,
              overflow: TextOverflow.ellipsis, maxLines: 1,),

              Row(
                children: [
                  Icon( Icons.star_outline, size: 15, color: Colors.grey,),
                  SizedBox(width: 5,),
                  Text('movie.voteAverage', style: Theme.of(context).textTheme.caption,)
                ],
              )
            ],
          )
        ],

      ),
    );
  }
}

class _Overview extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text('Sint esse Lorem enim tempor pariatur pariatur ipsum elit consectetur ipsum dolore adipisicing. Ipsum proident aliquip pariatur in elit anim proident irure pariatur culpa. Eiusmod eiusmod veniam laborum sit nisi irure eiusmod qui dolor veniam proident. Velit ea cillum aute ex excepteur. Ea nostrud enim id sit ea culpa qui.',
      textAlign: TextAlign.justify,
      style: Theme.of(context).textTheme.subtitle1,)
    );
  }
}

