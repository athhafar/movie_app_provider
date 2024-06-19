import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movie_app_provider_atha/page/detail_movie_page.dart';
import 'package:movie_app_provider_atha/provider/movie_provider.dart';
import 'package:movie_app_provider_atha/utilities/helpers.dart';
import 'package:movie_app_provider_atha/widgets/shimmer_widget.dart';
import 'package:movie_app_provider_atha/widgets/try_again_widget.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MoviePage extends StatelessWidget {
  MoviePage({super.key});
  final RefreshController refreshController = RefreshController();
  final TextEditingController textFieldController = TextEditingController();
  Timer? _timer;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
      create: (BuildContext context) => MovieProvider(),
      child: Consumer<MovieProvider>(
        builder: (BuildContext context, value, Widget? child) => SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                TextFormField(
                  controller: textFieldController,
                  onChanged: (val) {
                    print("Kata yang dimasukkan: $val");
                    if (_timer?.isActive ?? false) _timer?.cancel();
                    _timer = Timer(const Duration(milliseconds: 200), () {
                      value.isSearch = val.isNotEmpty;
                      value.valueSearch = val;
                      value.searchMo();
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: const TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        value.isSearch = false;
                        value.searchMovieModel.clear();
                        textFieldController.clear();
                        value.valueSearch = "";

                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                      },
                      icon: const Icon(
                        Icons.close,
                        size: 32,
                      ),
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                value.isSearch == false
                    ? Expanded(
                        child: SmartRefresher(
                          enablePullDown: true,
                          enablePullUp: value.enablePullUp,
                          controller: refreshController,
                          onRefresh: () async {
                            await Future.delayed(
                                const Duration(milliseconds: 1000));
                            value.getMovie(reset: true);
                            refreshController.refreshCompleted();
                          },
                          onLoading: () async {
                            await Future.delayed(
                                const Duration(milliseconds: 1000));
                            value.getMovie();
                            refreshController.loadComplete();
                          },
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                value.loading == DataLoad.loading
                                    ? Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: ShimmerWidget(
                                          width: width,
                                          height: 343,
                                        ),
                                      )
                                    : value.loading == DataLoad.failed
                                        ? TryAgainWidget(
                                            onTapTryAgain: () {
                                              value.getMovie();
                                            },
                                            child: ShimmerWidget(
                                              width: width,
                                              height: 343,
                                            ),
                                          )
                                        : value.loading == DataLoad.done
                                            ? Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                        vertical: 8),
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemCount:
                                                      value.movieList.length,
                                                  padding: EdgeInsets.zero,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Container(
                                                      margin:
                                                          const EdgeInsets.all(
                                                              4),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color: Color(
                                                                0x19000000),
                                                            blurRadius: 24,
                                                            offset:
                                                                Offset(0, 11),
                                                          ),
                                                        ],
                                                      ),
                                                      child: Material(
                                                        color:
                                                            Colors.transparent,
                                                        child: InkWell(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                          onTap: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        DetailMoviePage(
                                                                  id: value
                                                                      .movieList[
                                                                          index]
                                                                      .id,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4),
                                                                child: Image
                                                                    .network(
                                                                  baseImage +
                                                                          value
                                                                              .movieList[index]
                                                                              .backdropPath ??
                                                                      "https://res.cloudinary.com/dotz74j1p/image/upload/v1715660683/no-image.jpg",
                                                                  height: 195,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(4),
                                                                child: Text(
                                                                  value
                                                                      .movieList[
                                                                          index]
                                                                      .title,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(4),
                                                                child: Text(
                                                                  value
                                                                      .movieList[
                                                                          index]
                                                                      .releaseDate,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              )
                                            : SizedBox(),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              value.loadingSearch == DataLoad.loading
                                  ? Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: ShimmerWidget(
                                        width: width,
                                        height: 343,
                                      ),
                                    )
                                  : value.loadingSearch == DataLoad.failed
                                      ? TryAgainWidget(
                                          onTapTryAgain: () {
                                            value.getMovie();
                                          },
                                          child: ShimmerWidget(
                                            width: width,
                                            height: 343,
                                          ),
                                        )
                                      : value.loadingSearch == DataLoad.done
                                          ? Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 8),
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount: value
                                                    .searchMovieModel.length,
                                                padding: EdgeInsets.zero,
                                                itemBuilder: (context, index) {
                                                  return Container(
                                                    margin:
                                                        const EdgeInsets.all(4),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      boxShadow: const [
                                                        BoxShadow(
                                                          color:
                                                              Color(0x19000000),
                                                          blurRadius: 24,
                                                          offset: Offset(0, 11),
                                                        ),
                                                      ],
                                                    ),
                                                    child: Material(
                                                      color: Colors.transparent,
                                                      child: InkWell(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        onTap: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  DetailMoviePage(
                                                                id: value
                                                                    .searchMovieModel[
                                                                        index]
                                                                    .id,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4),
                                                              child:
                                                                  Image.network(
                                                                baseImage +
                                                                        value
                                                                            .searchMovieModel[index]
                                                                            .backdropPath ??
                                                                    "https://res.cloudinary.com/dotz74j1p/image/upload/v1715660683/no-image.jpg",
                                                                height: 195,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(4),
                                                              child: Text(
                                                                value
                                                                    .searchMovieModel[
                                                                        index]
                                                                    .title,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(4),
                                                              child: Text(
                                                                value
                                                                    .movieList[
                                                                        index]
                                                                    .releaseDate,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            )
                                          : SizedBox(),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
