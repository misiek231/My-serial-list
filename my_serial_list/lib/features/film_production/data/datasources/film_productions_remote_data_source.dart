import 'dart:convert';

import 'package:my_serial_list/core/constants.dart';
import 'package:my_serial_list/core/error/exceptions.dart';
import 'package:my_serial_list/features/film_production/data/models/film_production_model.dart';
import 'package:my_serial_list/features/film_production/data/models/film_production_rating_model.dart';
import 'package:my_serial_list/features/film_production/domain/entities/film_production.dart';
import 'package:my_serial_list/features/film_production/domain/entities/film_production_rating.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

abstract class FilmProductionsRemoteDataSource {
  /// Calls the https://myseriallist.ml/api/FilmProduction/top_rated endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<FilmProductionRating>> getTopRated(int page);

  Future<FilmProduction> getFilmProduction(int id);
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

  @override
  Future<FilmProduction> getFilmProduction(int id) async {
    final response = await client.get(
      '$GET_FILM_PRODUCTION/$id',
    );

    if (response.statusCode == 200) {
      return FilmProductionModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException(message: response.body);
    }
  }
}
