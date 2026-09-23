import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Firebase Web API Key from your google-services.json
const String firebaseApiKey = 'AIzaSyA-fqiHyHPdD70lvZKagt3OvcHqYO4K5IM';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AuthScreen(),
  ));
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String _statusMessage = '';

  // Firebase Auth REST: Register User
  Future<void> _signUp() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() => _statusMessage = 'Please enter both email and password.');
      return;
    }

    setState(() {
      _isLoading = true;
      _statusMessage = '';
    });

    final url = Uri.parse(
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$firebaseApiKey',
    );

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (!mounted) return;
        _navigateToDashboard(data['email']);
      } else {
        setState(() {
          _statusMessage = data['error']?['message'] ?? 'Sign up failed';
        });
      }
    } catch (e) {
      setState(() => _statusMessage = 'Connection error: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // Firebase Auth REST: Sign In User
  Future<void> _signIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() => _statusMessage = 'Please enter both email and password.');
      return;
    }

    setState(() {
      _isLoading = true;
      _statusMessage = '';
    });

    final url = Uri.parse(
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$firebaseApiKey',
    );

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (!mounted) return;
        _navigateToDashboard(data['email']);
      } else {
        setState(() {
          _statusMessage = data['error']?['message'] ?? 'Sign in failed';
        });
      }
    } catch (e) {
      setState(() => _statusMessage = 'Connection error: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _navigateToDashboard(String email) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => DashboardScreen(userEmail: email),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Windows Firebase Authentication'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: 420,
          padding: const EdgeInsets.all(28.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 15,
                spreadRadius: 2,
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Personal Note Portal',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 24),
              if (_isLoading)
                const CircularProgressIndicator()
              else
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: _signIn,
                        child: const Text('Sign In'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: _signUp,
                        child: const Text('Register'),
                      ),
                    ),
                  ],
                ),
              if (_statusMessage.isNotEmpty) ...[
                const SizedBox(height: 18),
                Text(
                  _statusMessage,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Separate Screen: Shown upon successful registration / login
// ---------------------------------------------------------------------------
class DashboardScreen extends StatelessWidget {
  final String userEmail;

  const DashboardScreen({super.key, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('This is Login Screen'),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Logout',
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AuthScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Container(
          width: 480,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 15,
                spreadRadius: 2,
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 70),
              const SizedBox(height: 16),
              const Text(
                'This is Login Screen',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Authenticated Account: $userEmail',
                style: const TextStyle(fontSize: 15, color: Colors.black87),
              ),
              const SizedBox(height: 28),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                icon: const Icon(Icons.logout),
                label: const Text('Log Out'),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const AuthScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}