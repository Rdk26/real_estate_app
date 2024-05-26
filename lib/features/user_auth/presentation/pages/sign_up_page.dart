import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:real_estate_app/global/common/toast.dart';
import 'package:real_estate_app/features/user_auth/user_auth_implementation/firebase_auth_services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isSigningUp = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            const Text(
              'Crie sua conta',
              style: TextStyle(
                color: Color.fromARGB(255, 18, 90, 158),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 1),
            const Text(
              'Por favor preencha os dados abaixo para criar uma conta',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 60),
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person_outline),
                labelText: 'Nome',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _phoneNumberController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.phone_android_outlined),
                labelText: 'Telefone',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email_outlined),
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.lock_outline),
                labelText: 'Senha',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signUp,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: isSigningUp
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Registar',
                      style: TextStyle(
                          color: Color.fromARGB(255, 18, 90, 158),
                          fontSize: 16)),
            ),
            const SizedBox(height: 100),
            Row(
              children: [
                Expanded(child: Divider(color: Colors.grey[400])),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text('OU'),
                ),
                Expanded(child: Divider(color: Colors.grey[400])),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSocialLoginButton(
                  icon: FontAwesomeIcons.google,
                  color: Colors.red,
                  onTap: _signInWithGoogle,
                ),
                const SizedBox(width: 20),
                _buildSocialLoginButton(
                  icon: FontAwesomeIcons.facebook,
                  color: Colors.blue,
                  onTap: () {
                    // lógica de login com Facebook
                  },
                ),
              ],
            ),
            const SizedBox(height: 2),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Já tem uma conta?',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      TextSpan(
                        text: ' Login',
                        style: TextStyle(
                          color: Color.fromARGB(255, 18, 90, 158),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialLoginButton(
      {required IconData icon,
      required Color color,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }

  void _signUp() async {
    setState(() {
      isSigningUp = true;
    });

    String username = _usernameController.text;
    String phoneNumber = _phoneNumberController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    if (user != null) {
      await user.updateDisplayName(username);
      await user.reload();
      user = _firebaseAuth.currentUser;

      print(user);

      await _firestore.collection('users').doc(user!.uid).set({
        'id': user.uid,
        'name': username,
        'email': email,
        'phoneNumber': phoneNumber,
        // 'address': {'street': '123 Main St', 'city': 'Anytown'},
      });

      if (mounted) {
        showToast(message: "Usuário foi criado com sucesso");
        Navigator.pushNamed(context, "/home");
      }
    } else {
      showToast(message: "Algo deu errado, verifique as credenciais");
    }

    setState(() {
      isSigningUp = false;
    });
  }

  _signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        await _firebaseAuth.signInWithCredential(credential);
        if (mounted) {
          Navigator.pushNamed(context, "/home");
        }
      }
    } catch (e) {
      if (mounted) {
        showToast(message: "Algo deu errado $e");
      }
    }
  }
}
