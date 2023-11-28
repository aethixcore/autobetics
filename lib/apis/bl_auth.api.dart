import 'dart:convert';

import 'package:autobetics/core/core.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ABackendlessAPI {
  FutureEither<BackendlessUser?> signUp({
    required String email,
    required String password,
    required String name,
    required String dob,
    required double bmi,
    required double sbp,
    required double dbp,
    required List<String> goals,
  });
  Future<void> signOut();
  FutureEither<BackendlessUser?> signIn(
      {required String email, required String password});
  FutureEither<BackendlessUser?> signInWithGoogle();
  FutureEither<BackendlessUser> getCurrentUserDetails(BuildContext context);
}

class BackendlessAPI implements ABackendlessAPI {
  @override
  FutureEither<BackendlessUser?> signUp({
    required String email,
    required String password,
    required String name,
    required String dob,
    required double bmi,
    required double sbp,
    required double dbp,
    required List<String> goals,
  }) async {
    try {
      final BackendlessUser user = BackendlessUser();
      user.email = email;
      user.password = password;
      user.setProperty("name", name);
      user.setProperty("dob", dob);
      user.setProperty("sbp", sbp);
      user.setProperty("bmi", bmi);
      user.setProperty("dbp", dbp);
      user.setProperty("goals", jsonEncode(goals));
      final response = await Backendless.userService.register(user);
      return right(response);
    } on BackendlessException catch (e, stackTrace) {
      return left(Failure(e.message, stackTrace));
    } catch (e, stackTrace) {
      return left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  FutureEither<BackendlessUser?> signIn(
      {required String email, required String password}) async {
    try {
      final response =
          await Backendless.userService.login(email, password, true);
      return right(response);
    } on BackendlessException catch (e, stackTrace) {
      return left(Failure(e.message, stackTrace));
    } catch (e, stackTrace) {
      return left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  FutureEither<BackendlessUser?> signInWithGoogle() async {
    try {
      final response =
          await Backendless.userService.loginWithOauth2("google", "", {}, true);
      return right(response);
    } on BackendlessException catch (e, stackTrace) {
      return left(Failure(e.message, stackTrace));
    } catch (e, stackTrace) {
      return left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  FutureEither<BackendlessUser> getCurrentUserDetails(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final user = await Backendless.userService.getCurrentUser();
      return right(user!);
    } on PlatformException catch (e, stackTrace) {
      prefs.setBool("logout", true);
      await signOut();
      Future.delayed(const Duration(milliseconds: 3000));
      Navigator.pushReplacementNamed(context, "/login");
      return left(Failure(e.message!, stackTrace));
    } catch (e, stackTrace) {
      prefs.setBool("logout", true);
      await signOut();
      Future.delayed(const Duration(milliseconds: 3000));
      Navigator.pushReplacementNamed(context, "/login");
      return left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  Future<void> signOut() async {
    try{
     await Backendless.userService.logout();
    } on PlatformException catch (e, stackTrace){
      debugPrint(e.message);
    }catch (e, stackTrace){
      debugPrint(e.toString());
    }
  }
}
