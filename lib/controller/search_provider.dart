import 'package:flutter/material.dart';
import 'package:movie_app/constans/const.dart';

import 'package:movie_app/model/model.dart';
import 'package:movie_app/service/api.dart';


class SearchProvider extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  List<MovieModel> searchedResult = [];
  final ApiServices apiServices = ApiServices();

  void searchMovies(String query) async {
    if (query.isNotEmpty) {
      try {
        final searchUrl =
            "https://api.themoviedb.org/3/search/movie?query=$query&api_key=${ApiConstants.apiKey}";
        List<MovieModel> movies =
            await apiServices.searchMovie(searchUrl: searchUrl);

        searchedResult = movies;
        notifyListeners();
      } catch (e) {
        
        Exception(e);
        notifyListeners();
      }
    } else {
      searchedResult = [];
      notifyListeners();
    }
  }
}
