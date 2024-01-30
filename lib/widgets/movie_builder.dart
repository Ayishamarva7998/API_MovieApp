import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/constans/const.dart';
import 'package:movie_app/views/details_screen/details.dart';



import 'package:movie_app/model/model.dart';


// ignore: must_be_immutable
class ListItem extends StatelessWidget {
  ListItem({super.key, required this.snapshot});
  AsyncSnapshot snapshot;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics:  const BouncingScrollPhysics(),
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          MovieModel data = snapshot.data[index];
          return Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(
                                id: snapshot.data[index].id,
                                movie: snapshot.data[index]),
                          ));
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      color: Colors.amber,
                      child: Image.network(
                          '${ApiConstants.imagePath}${snapshot.data![index].posterPath}',
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${data.title}',
                      maxLines: 3,
                      overflow: TextOverflow.fade,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        RatingBarIndicator(
                            itemSize: 20,
                            rating: snapshot.data[index].voteAverage / 2,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return const Icon(
                                Icons.star,
                                color: Colors.amber,
                              );
                            }),
                        Text(
                          "${(snapshot.data[index].voteAverage / 2).toStringAsFixed(1)}",
                          style: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Release Date:${data.releaseDate}",
                        style: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        });
  }
}