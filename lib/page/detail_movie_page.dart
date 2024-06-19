import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_provider_atha/provider/detail_movie_prodvider.dart';
import 'package:movie_app_provider_atha/utilities/helpers.dart';
import 'package:movie_app_provider_atha/widgets/shimmer_widget.dart';
import 'package:movie_app_provider_atha/widgets/try_again_widget.dart';
import 'package:provider/provider.dart';

class DetailMoviePage extends StatelessWidget {
  DetailMoviePage({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
      create: (context) => DetailMovieProvider(id: id),
      child: Consumer<DetailMovieProvider>(
        builder: (context, value, child) => Scaffold(
          body: SingleChildScrollView(
            child: value.loading == DataLoad.loading
                ? Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: ShimmerWidget(
                      width: width,
                      height: 343,
                    ),
                  )
                : value.loading == DataLoad.failed
                    ? TryAgainWidget(
                        onTapTryAgain: () {
                          value.getDetailMoviel();
                        },
                        child: ShimmerWidget(
                          width: width,
                          height: 343,
                        ),
                      )
                    : Column(
                        children: [
                          Stack(
                            children: [
                              Image.network(
                                baseImage + value.detailMovie.backdropPath,
                                fit: BoxFit.cover,
                                width: width,
                                height: height / 2,
                              ),
                              Container(
                                height: height / 2,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0XFF000000).withOpacity(0),
                                      Color(0XFF1E1E27),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 64,
                                left: 32,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 32,
                                  ),
                                  onPressed: () {
                                    print('kembali');
                                  },
                                ),
                              )
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(16),
                            color: Color(0XFF1E1E27),
                            height: height,
                            width: width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  value.detailMovie.title,
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  value.detailMovie.releaseDate,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                  maxLines: 6,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  height: 32.0,
                                ),
                                Text(
                                  value.detailMovie.tagline,
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
          ),
        ),
      ),
    );
  }
}
