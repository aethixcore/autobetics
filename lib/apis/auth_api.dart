import "package:appwrite/appwrite.dart";
import "package:appwrite/models.dart" as model;
import "package:autobetics/core/core.dart";
import "package:flutter/foundation.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:fpdart/fpdart.dart";

abstract class IAuthAPI {
  FutureEither<model.Account> signUp(
      {required String email, required String password, required String name});
  FutureEither<model.Session> signIn(
      {required String email, required String password});
  FutureEither<model.Session> logOut(String sessionId);
  FutureEither<model.Token> verifyEmail();
  FutureEither<dynamic> signWithGoogle();
  FutureEither<model.Account> getUser();
  FutureEither<model.Account> updateName({required String name});
  FutureEither<model.Token> signUpWithPhone({required String phone});
}

class AuthAPI extends ChangeNotifier implements IAuthAPI {
  AuthAPI({required Account account}) : _account = account;
  final Account _account;
  @override
  FutureEither<model.Account> signUp(
      {required String email,
      required String password,
      required String name}) async {
    try {
      final account = await _account.create(
          userId: ID.unique(), email: email, password: password, name: name);
      return right(account);
    } on AppwriteException catch (e, stackTrace) {
      return left(
          Failure(e.message ?? "Some unexpected error occured", stackTrace));
    } catch (e, stackTrace) {
      return left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  FutureEither<model.Token> verifyEmail() async {
    try {
      final token = await _account.createVerification(
          url: dotenv.get("VERIFY_EMAIL_URL"));
      if (kDebugMode) {
        print(token);
      }
      return right(token);
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print(e);
      }
      return left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  FutureEither<dynamic> signWithGoogle() async {
    try {
      final token = await _account.createOAuth2Session(provider: "google");
      return right(token);
    } catch (e, stackTrace) {
      return left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  FutureEither<model.Session> signIn(
      {required String email, required String password}) async {
    try {
      final account =
          await _account.createEmailSession(email: email, password: password);
      if (kDebugMode) {
        print(account);
      }
      return right(account);
    } on AppwriteException catch (e, stackTrace) {
      if (kDebugMode) {
        print(e);
      }
      return left(
          Failure(e.message ?? "Some unexpected error occured", stackTrace));
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print(e);
      }
      return left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  FutureEither<model.Account> getUser() async {
    try {
      final user = await _account.get();
      return right(user);
    } on AppwriteException catch (e, stackTrace) {
      if (kDebugMode) {
        print(e);
      }
      return left(
          Failure(e.message ?? "Some unexpected error occured", stackTrace));
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print(e);
      }
      return left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  FutureEither<model.Token> signUpWithPhone({required String phone}) async {
    try {
      final uid = ID.unique();
      final token =
          await _account.createPhoneSession(phone: phone, userId: uid);
      return right(token);
    } on AppwriteException catch (e, stackTrace) {
      if (kDebugMode) {
        print(e);
      }
      return left(
          Failure(e.message ?? "Some unexpected error occured", stackTrace));
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print(e);
      }
      return left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  FutureEither<model.Session> logOut(String sessionId) async {
    try {
      final session = await _account.deleteSession(sessionId: sessionId);
      return right(session);
    } on AppwriteException catch (e, stackTrace) {
      if (kDebugMode) {
        print(e);
      }
      return left(
          Failure(e.message ?? "Some unexpected error occured", stackTrace));
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print(e);
      }
      return left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  FutureEither<model.Account> updateName({required String name}) async {
    try {
      final account = await _account.updateName(name: name);
      return right(account);
    } on AppwriteException catch (e, stackTrace) {
      if (kDebugMode) {
        print(e);
      }
      return left(
          Failure(e.message ?? "Some unexpected error occured", stackTrace));
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print(e);
      }
      return left(Failure(e.toString(), stackTrace));
    }
  
  }
}
