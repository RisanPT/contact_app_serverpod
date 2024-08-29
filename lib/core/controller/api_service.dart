import 'package:contact_serverpod/core/exception/api_failed%20exception.dart';
import 'package:contact_serverpod/core/model/model.dart';
import 'package:dio/dio.dart';

class ApiServices {
  static final _dio = Dio(BaseOptions(baseUrl: 'http://192.168.10.144:8080',));
  static Future<List<ContactModel>> getContact() async {
    try {
      final res = await _dio.post('/contact', data: {"method": "getContact"});

      return List<ContactModel>.from(
        (res.data as List<dynamic>).map(
          (e) => ContactModel.fromJson(e),
        ),
      );
    } on DioException catch (e) {
      throw ApiRequestFailedExpetion(statusCode: e.response?.statusCode);
    }
  }

  static Future<void> add(
      {required String name, required String mobile}) async {
    try {
      await _dio.post('/contact',
          data: {"method": "addContact", "name": name, "mobile": mobile});
    } on DioException catch (e) {
      throw ApiRequestFailedExpetion(statusCode: e.response?.data);
    }
  }

  static Future<void> update(
      {required int id, required String name, required String mobile}) async {
    try {
      await _dio.post('/contact',
          data: {"method": "update", "id": id, "name": name, "mobile": mobile});
    } on DioException catch (e) {
      throw ApiRequestFailedExpetion(statusCode: e.response?.data);
    }
  }

  static Future<void> delete({
    required int id,
  }) async {
    try {
      await _dio.post('/contact', data: {
        "method": "delete",
        "id": id,
      });
    } on DioException catch (e) {
      throw ApiRequestFailedExpetion(statusCode: e.response?.data);
    }
  }
}
