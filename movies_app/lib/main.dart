import 'package:flutter/material.dart';
import 'package:movies_app/providers/movies_provider.dart';
import 'package:movies_app/screens/screens.dart';
import 'package:provider/provider.dart';


//Only use Mateapp
 
 //Se inicializa AppState porque se carga toda la informacion necesaria del provider
void main() => runApp(AppState()); 

class AppState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MoviesProvider(),
        lazy: false,)
      ],
      child: MyApp(),
      
      );
  }
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      initialRoute: 'home', //Cuando se crea la app se inicializa en home
      routes: {
        'home': ( _ ) => HomeScreen(),
        'details': ( _ ) => DetailsScreen(),
      },

      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
          color: Colors.indigo
        )
      )

    );
  }
}