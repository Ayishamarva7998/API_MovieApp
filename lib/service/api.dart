// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/model/cast_model.dart';

import 'package:movie_app/model/model.dart';

class ApiServices {
  static Dio dio = Dio();

  Future<List<MovieModel>> getMovies(
      {required apiUrl, required BuildContext context}) async {
    try {
      final response = await dio.get(apiUrl);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonList = response.data;
        List<dynamic> movies = jsonList["results"];
        return movies.map((json) {
          return MovieModel.fromJson(json);
        }).toList();
      } else {
        log("Something is missing");

        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<List<MovieModel>> searchMovie({required searchUrl}) async {
    try {
      final response = await dio.get(searchUrl);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonList = response.data;
        List<dynamic> movies = jsonList["results"];
        return movies.map((json) {
          return MovieModel.fromJson(json);
        }).toList();
      } else {
        log("Something is missing");

        return [];
      }
    } catch (e) {
      log("unable to fetch data:$e");
      return [];
    }
  }

  Future<List<CastModel>> getCast(
      {required castUrl, required BuildContext context}) async {
    try {
      final response = await dio.get(castUrl);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        if (data.containsKey("cast")) {
          final List<dynamic> results = data["cast"];
          return results.map((cast) => CastModel.fromJson(cast)).toList();
        } else {
          throw Exception('No "cast" key in response');
        }
      } else {
        log("${response.statusCode}");

        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
