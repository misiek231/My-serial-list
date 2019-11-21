import 'dart:convert';

import 'package:http/http.dart';
import 'package:my_serial_list/core/constants.dart';
import 'package:my_serial_list/core/error/exceptions.dart';
import 'package:my_serial_list/core/usecases/usecase.dart';
import 'package:my_serial_list/features/account/domain/entities/user/token.dart';
import 'package:my_serial_list/features/account/domain/usecases/get_token.dart';
import 'package:my_serial_list/features/film_production/data/models/comment_model.dart';
import 'package:my_serial_list/features/film_production/data/models/episode_model.dart';
import 'package:my_serial_list/features/film_production/data/models/film_production_model.dart';
import 'package:my_serial_list/features/film_production/data/models/film_production_rating_model.dart';
import 'package:my_serial_list/features/film_production/domain/entities/comment.dart';
import 'package:my_serial_list/features/film_production/domain/entities/episode.dart';
import 'package:my_serial_list/features/film_production/domain/entities/film_production.dart';
import 'package:my_serial_list/features/film_production/domain/entities/film_production_rating.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../../../../injection_container.dart';

abstract class FilmProductionsRemoteDataSource {
  /// Calls the https://myseriallist.ml/api/FilmProduction/top_rated endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<FilmProductionRating>> getAll(
      int page, FilmProductionType type, String query);

  Future<FilmProduction> getFilmProduction(int id);

  Future<List<Comment>> getComments(int id);

  Future<List<Episode>> getEpisodes(int filmProductionId, int season);
}

class FilmProductionsRemoteDataSourceImpl
    implements FilmProductionsRemoteDataSource {
  final http.Client client;
  GetToken getToken = sl();

  FilmProductionsRemoteDataSourceImpl({@required this.client});

  @override
  Future<List<FilmProductionRating>> getAll(
      int page, FilmProductionType type, String query) async {
    Response response;
    try {
      String link = '$GET_ALL';
      link += page != null ? '?page=$page' : '';
      link += type != null ? '&type=${type.index}' : '';
      link += query == null || query == "" ? '' : '&search=$query';

      response = await client.get(
        link,
        headers: {
          'Content-Type': 'application/json',
        },
      );
    } catch (_) {
      throw ServerException(message: 'Błąd łączenia z serwerem');
    }

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      return l
          .map((model) => FilmProductionRatingModel.fromJson(model))
          .toList();
    } else {
      throw ServerException(message: response.reasonPhrase);
    }
  }

  @override
  Future<FilmProduction> getFilmProduction(int id) async {
    Response response;

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    (await getToken(NoParams())).fold((failure) {}, (succes) {
      headers['authorization'] = "bearer " + succes.token;
    });

    try {
      response = await client.get(
        '$GET_FILM_PRODUCTION/$id',
        headers: headers,
      );
    } catch (_) {
      throw ServerException(message: 'Błąd łączenia z serwerem');
    }

    if (response.statusCode == 200) {
      return FilmProductionModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException(message: response.body);
    }
  }

  @override
  Future<List<Comment>> getComments(int id) async {
    Response response;
    try {
      response = await client.get(
        '$GET_COMMENTS/$id',
      );
    } catch (_) {
      throw ServerException(message: 'Błąd łączenia z serwerem');
    }

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      return l.map((model) => CommentModel.fromJson(model)).toList();
    } else {
      throw ServerException(message: response.body);
    }
  }

  @override
  Future<List<Episode>> getEpisodes(int filmProductionId, int season) async {
    Response response;
    try {
      response = await client.get(
        '$GET_EPISODES?filmProductionId=$filmProductionId&season=$season',
      );
    } catch (_) {
      throw ServerException(message: 'Błąd łączenia z serwerem');
    }

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      return l.map((model) => EpisodeModel.fromJson(model)).toList();
    } else {
      throw ServerException(message: response.body);
    }
  }
}
