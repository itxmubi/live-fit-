import 'package:flutter/material.dart';

class EmailSignInForm extends StatelessWidget {
  List<Widget> _buildChildren() {
    return [
      TextField(
        decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'test@example.com',
        ),
      ),
      SizedBox(
        height: 8.0,
      ),
      TextField(
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'Password',
        ),
      ),
      SizedBox(
        height: 8.0,
      ),
      ElevatedButton(
        onPressed: () {},
        child: Text('Sign In'),
      ),
      SizedBox(
        height: 8.0,
      ),
      TextButton(
        onPressed: () {},
        child: Text('Need Another Account? Register'),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(),
      ),
    );
  }
}
