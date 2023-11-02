import 'package:autobetics/core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ASupaBaseAPI {
  FutureEither<AuthResponse> signUp(
      {required String email, required String password});
  FutureEither<AuthResponse> signIn(
      {required String email, required String password});
  FutureEither<bool> signInWithGoogle();
}

final supabase = Supabase.instance.client;

class SupaBaseAPI implements ASupaBaseAPI {
  @override
  FutureEither<AuthResponse> signUp(
      {required String email, required String password}) async {
    try {
      final response =
          await supabase.auth.signUp(password: password, email: email);
      return right(response);
    } on AuthException catch (e, stackTrace) {
      return left(Failure(e.message, stackTrace));
    } catch (e, stackTrace) {
      return left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  FutureEither<bool> signInWithGoogle() async {
    try {
      final response = await supabase.auth.signInWithOAuth(Provider.google);
      return right(response);
    } on AuthException catch (e, stackTrace) {
      if (kDebugMode) {
        print(e.message);
      }
      return left(Failure(e.message, stackTrace));
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print(e);
      }
      return left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  FutureEither<AuthResponse> signIn(
      {required String email, required String password}) async {
    try {
      final response = await supabase.auth
          .signInWithPassword(password: password, email: email);
      return right(response);
    } on AuthException catch (e, stackTrace) {
      return left(Failure(e.message, stackTrace));
    } catch (e, stackTrace) {
      return left(Failure(e.toString(), stackTrace));
    }
  }
}
