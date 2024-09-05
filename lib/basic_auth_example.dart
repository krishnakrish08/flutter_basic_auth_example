import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';

class BasicAuthExample extends StatefulWidget {
  const BasicAuthExample({super.key});

  @override
  BasicAuthExampleState createState() => BasicAuthExampleState();
}

class BasicAuthExampleState extends State<BasicAuthExample> {
  final FlutterAppAuth _appAuth = const FlutterAppAuth();
  String? _accessToken;
  String? _idToken;
  String? _errorMessage;

  Future<void> _authenticate() async {
    try {
      final AuthorizationTokenResponse result =
          await _appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          'your_client_id', // Replace with your client ID
          'your_redirect_uri', // Replace with your redirect URI
          issuer: 'https://your-issuer.com', // Replace with your issuer URL
          scopes: ['openid', 'profile', 'email'], // Scopes you need
        ),
      );

      if (result != null) {
        setState(() {
          _accessToken = result.accessToken;
          _idToken = result.idToken;
          _errorMessage = null;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error during authentication: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter AppAuth Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_errorMessage != null) ...[
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 10),
            ],
            if (_accessToken != null && _idToken != null) ...[
              Text('Access Token: $_accessToken'),
              const SizedBox(height: 10),
              Text('ID Token: $_idToken'),
            ] else ...[
              const Text('Not authenticated'),
            ],
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _authenticate,
              child: const Text('Authenticate'),
            ),
          ],
        ),
      ),
    );
  }
}
