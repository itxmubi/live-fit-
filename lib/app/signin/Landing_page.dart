import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_app/app/signin/sign_in_page.dart';
import 'package:time_tracker_app/services/auth.dart';

import '../home_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key key, this.auth}) : super(key: key);
  final AuthBase auth;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: auth.authstateschanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final User user = snapshot.data;
            if (user == null) {
              return SignInPage(
                auth: auth,
              );
            }
            return HomePage(
              auth: auth,
            );
          }
          return Scaffold(
            body: Column(
              children: [
                Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
          );
        });
  }
}

//C:\Users\Mubashir Nawaz\.android
//

// keytool -exportcert -alias androiddebugkey -keystore "C:\Users\Mubashir Nawaz\.android\debug.keystore" | "C:\openssl-0.9.8k_WIN32\bin\openssl" sha1 -binary | "C:\openssl-0.9.8k_WIN32\bin\openssl" base64
