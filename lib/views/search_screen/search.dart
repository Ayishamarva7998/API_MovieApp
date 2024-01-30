import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/constans/const.dart';
import 'package:movie_app/controller/search_provider.dart';
import 'package:movie_app/views/details_screen/details.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Image.asset(
          "assets/logoname2.png",
          fit: BoxFit.cover,
          filterQuality: FilterQuality.high,
          height: 45,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                fillColor: const Color.fromARGB(0, 255, 255, 255),
                filled: true,
                hintText: "Search...",
                hintStyle: const TextStyle(color: Colors.white),
              ),
              onChanged: (value) {
                searchProvider.searchMovies(value);
              },
            ),
            const SizedBox(
                height:
                    16),
                    
            Expanded(
              child: Stack(
                children: [
                  searchProvider.searchedResult.isNotEmpty
                      ? GridView.builder(
                          itemCount: searchProvider.searchedResult.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            crossAxisCount: 3,
                            childAspectRatio: 1 / 1.4,
                          ),
                          itemBuilder: (context, index) {
                            final searchData =
                                searchProvider.searchedResult[index];
                            final posterPath = searchData.posterPath;
                            if (posterPath != null &&
                                ApiConstants.imagePath.isNotEmpty) {
                              final imageUrl =
                                  '${ApiConstants.imagePath}$posterPath';
                              return GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.all(1.2),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(imageUrl),
                                        fit: BoxFit.fill,
                                        filterQuality: FilterQuality.high,
                                      ),
                                      color: const Color.fromARGB(
                                          255, 10, 22, 112),
                                      borderRadius: BorderRadius.circular(19),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => DetailsScreen(
                                      id: searchData.id!,
                                      movie: searchData,
                                    ),
                                  ));
                                },
                              );
                            } else {
                              return const Text("No Data");
                            }
                          },
                        )
                      : Center(
                          child: Text(
                            "Search Movies",
                            style: GoogleFonts.aBeeZee(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}