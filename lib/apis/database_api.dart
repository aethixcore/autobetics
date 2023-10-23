import "package:appwrite/appwrite.dart";
import "package:appwrite/models.dart" as model;
import "package:autobetics/core/core.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:fpdart/fpdart.dart";

abstract class IDBAPI {
  FutureEither<model.Document> createDocument(
      {required String uId, required String colId, required Map data});
  FutureEither<model.Document> deleteDocument(
      {required String uId, required String colId});
  FutureEither<model.Document> getDocument(
      {required String uId, required String colId});
  FutureEither<model.Document> updateDocument(
      {required String uId, required String colId, required Map data});
}

class DBAPI implements IDBAPI {
  DBAPI({required Databases db}) : _db = db;
  final Databases _db;
  @override
  FutureEither<model.Document> getDocument(
      {required String uId, required String colId}) async {
    try {
      print("==== uid =====");
      print(uId);
      final document = await _db.getDocument(
          databaseId: dotenv.get("DATABASE_ID"),
          collectionId: colId,
          documentId: uId);
      print(document);
      return right(document);
    } on AppwriteException catch (e, stackTrace) {
      print(e);
      return left(
          Failure(e.message ?? "Some unexpected error occured", stackTrace));
    } catch (e, stackTrace) {
      print(e);
      return left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  FutureEither<model.Document> createDocument(
      {required String uId, required String colId, required Map data}) async {
    try {
      final document = await _db.createDocument(
          documentId: uId,
          databaseId: dotenv.get("DATABASE_ID"),
          collectionId: colId,
          data: data,
          permissions: [
            Permission.read(Role.users()),
            Permission.update(Role.users()),
            Permission.update(Role.users()),
            Permission.delete(Role.users()),
          ]);
      return right(document);
    } on AppwriteException catch (e, stackTrace) {
      return left(
          Failure(e.message ?? "Some unexpected error occured", stackTrace));
    } catch (e, stackTrace) {
      return left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  FutureEither<model.Document> deleteDocument(
      {required String uId, required String colId}) async {
    try {
      final document = await _db.deleteDocument(
          documentId: uId,
          databaseId: dotenv.get("DATABASE_ID"),
          collectionId: colId);
      return right(document);
    } on AppwriteException catch (e, stackTrace) {
      return left(
          Failure(e.message ?? "Some unexpected error occured", stackTrace));
    } catch (e, stackTrace) {
      return left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  FutureEither<model.Document> updateDocument(
      {required String uId, required String colId, required Map data}) async {
    try {
      final document = await _db.updateDocument(
          documentId: uId,
          databaseId: dotenv.get("DATABASE_ID"),
          collectionId: colId,
          data: data);
      return right(document);
    } on AppwriteException catch (e, stackTrace) {
      return left(
          Failure(e.message ?? "Some unexpected error occured", stackTrace));
    } catch (e, stackTrace) {
      return left(Failure(e.toString(), stackTrace));
    }
  }
}
