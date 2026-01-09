import 'package:dio/dio.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/character_model.dart';

abstract class CharactersRemoteDataSource {
  Future<List<CharacterModel>> getCharacters();
  Future<List<CharacterModel>> getCharactersByHouse(String house);
}

class CharactersRemoteDataSourceImpl implements CharactersRemoteDataSource {
  final Dio dio;

  CharactersRemoteDataSourceImpl(this.dio);

  @override
  Future<List<CharacterModel>> getCharacters() async {
    try {
      final response = await dio.get(ApiEndpoints.characters);
      return CharacterModel.fromJsonList(response.data);
    } on DioException catch (e) {
      throw ServerException(
        e.message ?? 'Erro ao buscar personagens',
      );
    }
  }

  @override
  Future<List<CharacterModel>> getCharactersByHouse(
    String house,
  ) async {
    try {
      final response = await dio.get(
        ApiEndpoints.charactersByHouse(house),
      );
      return CharacterModel.fromJsonList(response.data);
    } on DioException catch (e) {
      throw ServerException(
        e.message ?? 'Erro ao buscar personagens por casa',
      );
    }
  }
}
