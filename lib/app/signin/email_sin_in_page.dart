import 'package:flutter/material.dart';

import 'email_sign_in_form.dart';

class EmailSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" Sign In"),
        elevation: 2.0,
      ),
      body: Card(
        child: EmailSignInForm(),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
