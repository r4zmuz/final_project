import 'package:firebase_core/firebase_core.dart';

class FirebaseCoreApi {
  static Future<void> init() async {
    await Firebase.initializeApp();
  }
}