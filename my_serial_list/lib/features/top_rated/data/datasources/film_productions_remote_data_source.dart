import 'dart:convert';

import 'package:my_serial_list/core/constants.dart';
import 'package:my_serial_list/core/error/exceptions.dart';
import 'package:my_serial_list/features/top_rated/data/models/film_production_rating_model.dart';
import 'package:my_serial_list/features/top_rated/domain/entities/film_production_rating.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

abstract class FilmProductionsRemoteDataSource {
  /// Calls the https://myseriallist.ml/api/FilmProduction/top_rated endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<FilmProductionRating>> getTopRated(int page);
}

class FilmProductionsRemoteDataSourceImpl
    implements FilmProductionsRemoteDataSource {
  final http.Client client;

  FilmProductionsRemoteDataSourceImpl({@required this.client});

  Future<List<FilmProductionRating>> getTopRated(int page) async {
    final response = await client.get(
      '$GET_TOP?page=$page',
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      return l
          .map((model) => FilmProductionRatingModel.fromJson(model))
          .toList();
    } else {
      throw ServerException(message: response.body);
    }
  }
}
