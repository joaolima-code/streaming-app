import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../model/home_category_model.dart';
import '../model/home_config_image_model.dart';

part 'home_remote_datasource.g.dart';

@RestApi()
abstract class HomeRemoteDatasource {
  factory HomeRemoteDatasource(Dio dio, {String baseUrl}) =
      _HomeRemoteDatasource;

  @GET('/configuration')
  Future<HomeConfigImageModel> configImages();

  @GET('/genre/movie/list')
  Future<HomeListCategoriesModel> listCategories({
    @Query('language') String language = 'pt-BR',
  });
}
