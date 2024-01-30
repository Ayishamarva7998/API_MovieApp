// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:movie_app/model/model.dart';
import 'package:movie_app/service/api.dart';


class HomeProvider extends ChangeNotifier {
  final ApiServices movieApiService = ApiServices();
  List<MovieModel> movies = [];
  Future getHomeScreen({required url, required BuildContext context}) async {
    try {
      List<MovieModel> movieResults =
          await movieApiService.getMovies(apiUrl: url, context: context);
      movies = movieResults;
      notifyListeners();
      return movies;
    } catch (error) {
   

      Exception(error);
      notifyListeners();
    }
    notifyListeners();
  }
}
