import 'package:backendless_sdk/backendless_sdk.dart';

export "appwrite.constant.dart";
export "tips.constant.dart";

Future<Map<dynamic, dynamic>?> getProfile(String userId) async {
  try {
    final whereClause = "ownerId = '$userId'";
    final queryBuilder = DataQueryBuilder()..whereClause = whereClause;

    final response =
        await Backendless.data.of("Profiles").find(queryBuilder);

    return response!.first;
  } catch (e) {
    return {};
  }
}
