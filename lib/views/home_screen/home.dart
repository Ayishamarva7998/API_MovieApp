

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/constans/const.dart';
import 'package:movie_app/controller/home_provider.dart';
import 'package:movie_app/widgets/movie_slider.dart';
import 'package:movie_app/widgets/trending.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Image.asset(
            "assets/logoname2.png",
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
            height: 45,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Trending Movies",
                  style: GoogleFonts.aBeeZee(color: Colors.white, fontSize: 20),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  child: FutureBuilder(
                      future: provider.getHomeScreen(
                          url: ApiConstants.trending, context: context),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                              child: Text(
                            snapshot.error.toString(),
                            style: const TextStyle(
                                color: Color.fromARGB(255, 255, 0, 0)),
                          ));
                        } else if (snapshot.hasData) {
                          return Trending(
                            snapshot: snapshot,
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ),
                // Trending();

                const SizedBox(height: 18),
                Text(
                  "Top Rated Movies",
                  style: GoogleFonts.aBeeZee(color: Colors.white, fontSize: 20),
                ),
                const SizedBox(height: 3),
                SizedBox(
                  child: FutureBuilder(
                      future: provider.getHomeScreen(
                          url: ApiConstants.topRated, context: context),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                              child: Text(
                            snapshot.error.toString(),
                            style: const TextStyle(
                                color: Color.fromARGB(255, 255, 0, 0)),
                          ));
                        } else if (snapshot.hasData) {
                          return MoviesSlider(
                            snapshot: snapshot,
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: Image.asset("assets/logoname2.png"),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ),

                // MoviesSlider(),
                const SizedBox(height: 18),
                Text(
                  "UpComing Movies",
                  style: GoogleFonts.aBeeZee(color: Colors.white, fontSize: 20),
                ),
                const SizedBox(height: 3),
                //MoviesSlider(),
                SizedBox(
                  child: FutureBuilder(
                      future: provider.getHomeScreen(
                          url: ApiConstants.upComing, context: context),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                              child: Text(
                            snapshot.error.toString(),
                            style: const TextStyle(
                                color: Color.fromARGB(255, 255, 0, 0)),
                          ));
                        } else if (snapshot.connectionState ==
                            ConnectionState.none) {
                          return const Center(
                            child: Text("lottie"),
                          );
                        } else if (snapshot.hasData) {
                          return MoviesSlider(
                            snapshot: snapshot,
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ),
                Text("Popular Movies",
                    style: GoogleFonts.aBeeZee(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.white)),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  child: FutureBuilder(
                    future: provider.getHomeScreen(
                        url: ApiConstants.popular, context: context),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else if (snapshot.hasData) {
                        return MoviesSlider(snapshot: snapshot);
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}