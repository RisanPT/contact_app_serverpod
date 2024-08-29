import 'package:contact_serverpod/core/exception/base_exception.dart';

class ApiRequestFailedExpetion extends BaseException {
  ApiRequestFailedExpetion({int? statusCode, String? message})
      : super(message ??
            (statusCode == null
                ? "Request failed, please try again"
                : "Api request failed with statuscode $statusCode"));
}