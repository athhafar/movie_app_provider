import 'package:flutter/material.dart';
import 'package:movie_app_provider_atha/model/detail_movie_model.dart';
import 'package:movie_app_provider_atha/services/api_endpoint.dart';
import 'package:movie_app_provider_atha/services/api_services.dart';
import 'package:movie_app_provider_atha/utilities/helpers.dart';

class DetailMovieProvider extends ChangeNotifier {
  var id = 0;
  late DetailMovieModel detailMovie;
  var loading = DataLoad.done;

  DetailMovieProvider({required this.id}) {
    getDetailMoviel();
  }

  void getDetailMoviel() async {
    loading = DataLoad.loading;
    // notifyListeners();
    try {
      var data = await ApiServices.api(
        type: APIMethod.get,
        endpoint: APiEndpoint.detail,
        param: "/${id.toString()}",
      );
      if (data != null) {
        detailMovie = DetailMovieModel.fromJson(data);
        loading = DataLoad.done;
      } else {
        loading = DataLoad.failed;
      }
    } catch (e) {
      loading = DataLoad.failed;
    }
    notifyListeners();
  }
}
