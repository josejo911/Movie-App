import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/helpers/debouncer.dart';
import 'package:movies_app/models/models.dart';
import 'package:movies_app/models/search_movies_response.dart';
import 'package:movies_app/models/upcoming_movies.dart';
import 'package:movies_app/widgets/casting_cards.dart';


class MoviesProvider extends ChangeNotifier{

  String _apiKey    = 'a10090864886bde48c34c2398d8bcc2b';
  String _baseUrl   = 'api.themoviedb.org';
  String _language  = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  List<Movie> upcomingMovies = [];


  Map<int, List<Cast>> movieCast = {};

  int _popularPage = 0;
  int _upcomingPage = 0;

  final debouncer = Debouncer(
    duration: Duration(
      milliseconds: 500),

  );
  
  final StreamController<List<Movie>> _suggestionStreamController  = new StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream => this._suggestionStreamController.stream;


  
  //Constructor
  MoviesProvider(){

    print('MoviesProvider Inicializado');

    this.getOnDisplayMovies();
    this.getPopularMovies();
    this.getUpcomingMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {

      final url = Uri.https(_baseUrl, endpoint, {
      'api_key'   : _apiKey,
      'language'  : _language,
      'page'      : '$page'
      });

      //Await the http get reponmse, then deocde the unformatted response
      final response = await http.get(url);
      return response.body;


  }

  getOnDisplayMovies() async{

    final jsonData = await this._getJsonData('3/movie/now_playing');
      // nowPlayingResponse contiene todas las respuestas de las peliculas
      final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);
      onDisplayMovies = nowPlayingResponse.results;
      notifyListeners();
  }

  getPopularMovies() async{
      //Aumentamos en 1 para cargar la nueva pagina 
      _popularPage++;

      final jsonData = await this._getJsonData('3/movie/popular', _popularPage);
      // nowPlayingResponse contiene todas las respuestas de las peliculas
      final popularResponse = PopularMovies.fromJson(jsonData);
      popularMovies = [ ...popularMovies, ...popularResponse.results];
      
      notifyListeners();
  }

    getUpcomingMovies() async{
      //Aumentamos en 1 para cargar la nueva pagina 
      _upcomingPage++;

      final jsonData = await this._getJsonData('3/movie/upcoming', _upcomingPage);
      // nowPlayingResponse contiene todas las respuestas de las peliculas
      final upcomingResponse = UpcomingMovies.fromJson(jsonData);
      upcomingMovies = [ ...upcomingMovies, ...upcomingResponse.results];
      
      notifyListeners();
  }

  Future<List<Cast>> getMovieCast( int movieId ) async {
    //Revisamos si ya se ha hecho la peticion para no duplicar
    if(movieCast.containsKey(movieId)){
      return movieCast[movieId]!;

    }
    final jsonData = await this._getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);

    movieCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovies(String query) async{

      final url = Uri.https(_baseUrl, '3/search/movie', {
      'api_key'   : _apiKey,
      'language'  : _language,
      'query'     : query
      });

      final response = await http.get(url);
      final searchMovieResponse = SearchResponse.fromJson(response.body);

      return searchMovieResponse.results;
  }

  void getSuggestionsByQuery(String searchTerm){

    debouncer.value = '';
    debouncer.onValue = (value) async{
      // print('Tenemos el valor a buscar: ${value}');
      final results = await this.searchMovies(value);
      this._suggestionStreamController.add(results);
    };

    final timer = Timer.periodic(Duration(milliseconds: 300), (_) {
       debouncer.value = searchTerm;

    });

    Future.delayed(Duration(milliseconds: 301)).then((_)=> timer.cancel());

  }

}