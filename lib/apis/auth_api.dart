// import "package:appwrite/appwrite.dart";
// import "package:appwrite/models.dart" as model;
// import "package:autobetics/core/core.dart";
// import "package:flutter_dotenv/flutter_dotenv.dart";
// import "package:fpdart/fpdart.dart";

// abstract class IAuthAPI {
//   FutureEither<model.Account> signUp(
//       {required String email, required String password, required String name});
//   FutureEither<model.Token> verifyEmail();
//   FutureEither<dynamic> signWithGoogle();
// }

// class AuthAPI implements IAuthAPI {
//   AuthAPI({required Account account}) : _account = account;
//   final Account _account;
//   @override
//   FutureEither<model.Account> signUp(
//       {required String email,
//       required String password,
//       required String name}) async {
//     try {
//       final account = await _account.create(
//           userId: ID.unique(), email: email, password: password, name: name);
//       return right(account);
//     } on AppwriteException catch (e, stackTrace) {
//       return left(
//           Failure(e.message ?? "Some unexpected error occured", stackTrace));
//     } catch (e, stackTrace) {
//       return left(Failure(e.toString(), stackTrace));
//     }
//   }

//   @override
//   FutureEither<model.Token> verifyEmail() async {
//     try {
//       final token =
//           await _account.createVerification(url: dotenv.get("VERIFY_URI"));
//       return right(token);
//     } catch (e, stackTrace) {
//       return left(Failure(e.toString(), stackTrace));
//     }
//   }
  
//   @override
//   FutureEither<dynamic> signWithGoogle() async {
//     try {
//       final token =
//           await _account.createOAuth2Session(provider: "google");
//       return right(token);
//     } catch (e, stackTrace) {
//       return left(Failure(e.toString(), stackTrace));
//     }
//   }
// }
