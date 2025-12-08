import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

Widget buildDefaultTextInput(BuildContext context) {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(24.0),
      child: TextInputEAE(
        label: 'Email',
        hintText: 'Enter your email',
      ),
    ),
  );
}

Widget buildTextInputStates(BuildContext context) {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextInputEAE(
            label: 'Enabled',
            hintText: 'Type something...',
          ),
          SizedBox(height: 16),
          TextInputEAE(
            label: 'Disabled',
            hintText: 'Cannot type here',
            enabled: false,
          ),
          SizedBox(height: 16),
          TextInputEAE(
            label: 'Error',
            hintText: 'Something went wrong',
            errorText: 'Invalid input',
          ),
          SizedBox(height: 16),
          TextInputEAE(
            label: 'Password',
            obscureText: true,
          ),
        ],
      ),
    ),
  );
}

Widget buildTextInputNoLabel(BuildContext context) {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextInputEAE(
            hintText: 'Type something...',
          ),
          SizedBox(height: 16),
          TextInputEAE(
            hintText: 'Cannot type here',
            enabled: false,
          ),
          SizedBox(height: 16),
          TextInputEAE(
            hintText: 'Something went wrong',
            errorText: 'Invalid input',
          ),
          SizedBox(height: 16),
          TextInputEAE(
            hintText: 'Password',
            obscureText: true,
          ),
        ],
      ),
    ),
  );
}
