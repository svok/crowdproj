import 'Team.dart';

enum ApiResponseStatuses { success, error }

class ApiResponse {
  ApiResponse({
    this.status,
    this.errors,
    this.timeRequested,
    this.timeFinished,
  }) : super();

  DateTime timeRequested;
  DateTime timeFinished;
  ApiResponseStatuses status;
  List<ApiError> errors;
}

class ApiResponseTeamGet extends ApiResponse {
  ApiResponseTeamGet({
    this.team,
    ApiResponseStatuses status,
    List<ApiError> errors,
    DateTime timeRequested,
    DateTime timeFinished,
  }) : super(
          status: status,
          errors: errors,
          timeRequested: timeRequested,
          timeFinished: timeFinished,
        );
  Team team;
}

class ApiResponseTeamSave extends ApiResponse {
  ApiResponseTeamSave({
    ApiResponseStatuses status,
    List<ApiError> errors,
    DateTime timeRequested,
    DateTime timeFinished,
  }) : super(
          status: status,
          errors: errors,
          timeRequested: timeRequested,
          timeFinished: timeFinished,
        );
}

class ApiError {
  ApiError({
    this.code,
    this.field,
    this.message,
    this.description,
    this.level,
  }) : super();
  String code;
  String field;
  String message;
  String description;
  ErrorLevels level;

  static List<ApiError> errorsForField(Iterable errors, String field) =>
      errors?.where((element) => element.field == field)?.toList();

  static String errorString(Iterable errors, String field) =>
      errorsForField(errors, field).map((e) => e.message).join("\n");
}

enum ErrorLevels { fatal, error, warning, info }
