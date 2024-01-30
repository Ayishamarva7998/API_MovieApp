// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/constans/const.dart';
import 'package:movie_app/model/cast_model.dart';

import 'package:movie_app/model/model.dart';
import 'package:movie_app/service/api.dart';
import 'package:movie_app/widgets/back_btn.dart';


// ignore: must_be_immutable
class DetailsScreen extends StatelessWidget {
  DetailsScreen({super.key, required this.movie, required this.id});
  final MovieModel movie;
  int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar.large(
          leading: Backbutton(),
          expandedHeight: 500,
          pinned: true,
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(movie.title!,
                style: GoogleFonts.aBeeZee(
                    fontSize: 17, fontWeight: FontWeight.w600)),
            background: ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24)),
              child: Image.network(
                '${ApiConstants.imagePath}${movie.posterPath}',
                filterQuality: FilterQuality.high,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
            child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Overview",
                style: GoogleFonts.aBeeZee(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Divider(),
              Text(
                movie.overView!,
                style: GoogleFonts.roboto(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 13),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Release date: ',
                            style: GoogleFonts.roboto(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            movie.releaseDate!,
                            style: GoogleFonts.roboto(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    // SizedBox(width: 8),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(children: [
                        Text('Rating:',
                            style: GoogleFonts.roboto(
                                fontSize: 12, fontWeight: FontWeight.bold)),
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 14,
                        ),
                        Text('${movie.voteAverage!.toStringAsFixed(2)}/10',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold))
                      ]),
                    )
                  ],
                ),
              ),
              SizedBox(height: 5),
              FutureBuilder(
                // future:Provider.of<CastProvider>(context,listen: false).loadCast(context, id),
                future: ApiServices().getCast(
                  castUrl:
                      'https://api.themoviedb.org/3/movie/$id/credits?api_key=3c20bf0bac3997023d6185084b76a613',
                  context: context,
                ),
                builder: (context, AsyncSnapshot<List<CastModel>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text("No data available");
                  } else {
                    return SizedBox(
                      height: 130,
                      width: double.infinity,
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          CastModel casts = snapshot.data![index];
                          return Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: CircleAvatar(
                                      radius: 45,
                                      backgroundImage: NetworkImage(
                                          '${ApiConstants.imagePath}${casts.profilePath!}'),
                                    ),
                                  ),
                                ),
                                Text(casts.name!),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              )
            ],
          ),
        )),
      ]),
    );
  }
}