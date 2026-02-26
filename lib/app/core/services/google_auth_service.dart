import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  Future<String?> signInWithGoogle() async {
    try {
      // 1. Inicializar (Asegúrate de tener los permisos correctos en Google Cloud)
      await _googleSignIn.initialize(
        serverClientId:
            '483388781036-o3dfsjtufllvbv6lrr9mtkg61jd40csq.apps.googleusercontent.com',
      );

      // 2. Iniciar el flujo interactivo
      // Nota: Aunque uses scopeHint: ['email'], Google a veces prefiere
      // que los scopes estén definidos en la consola de APIs.
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate(
        scopeHint: [
          'openid',
          'https://www.googleapis.com/auth/userinfo.email',
          'https://www.googleapis.com/auth/userinfo.profile'
        ],
      );

      // 3. Obtener el idToken
      final String? idToken = googleUser.authentication.idToken;

      if (idToken == null) {
        throw Exception("No se pudo obtener el ID Token");
      }

      // 4. Crear la credencial para Firebase
      // Al usar el idToken, Firebase extraerá el email real automáticamente
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: idToken,
      );

      // 5. Iniciar sesión en Firebase
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      // ¡Aquí está el truco!
      // No uses googleUser.email, usa userCredential.user?.email
      debugPrint("Email real desde Firebase: ${userCredential.user?.email}");

      return idToken;
    } catch (e) {
      debugPrint("Error en Google Sign-In: $e");
      return null;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
