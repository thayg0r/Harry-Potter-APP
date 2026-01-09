import 'package:dio/dio.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/spell_model.dart';

abstract class SpellsRemoteDataSource {
  Future<List<SpellModel>> getSpells();
}

class SpellsRemoteDataSourceImpl implements SpellsRemoteDataSource {
  final Dio dio;

  SpellsRemoteDataSourceImpl(this.dio);

  @override
  Future<List<SpellModel>> getSpells() async {
    try {
      final response = await dio.get(ApiEndpoints.spells);
      return SpellModel.fromJsonList(response.data);
    } on DioException catch (e) {
      throw ServerException(
        e.message ?? 'Erro ao buscar magias',
      );
    }
  }
}
