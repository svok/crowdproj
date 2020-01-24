import 'package:crowdproj_models/api.dart';
import 'package:dio/dio.dart';

class TeamsService {

  String basePath;
  CrowdprojModels _models;

  TeamsService({this.basePath}): super() {
    BaseOptions _options = new BaseOptions(
      baseUrl: basePath,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    Dio _dio = Dio(_options);
    _models = CrowdprojModels(dio: _dio);
  }

  get service => _models;
}
