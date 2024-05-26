import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:real_estate_app/global/common/toast.dart';
import 'package:real_estate_app/features/user_auth/user_auth_implementation/firebase_auth_services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isSigning = false;
  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool showPassword = false;

  @override
  void dispose() {
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
              'Faça o login',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 1),
            const Text(
              'Por favor preencha os dados abaixo para login',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 60),
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
              obscureText: !showPassword,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock_outline),
                labelText: 'Senha',
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    showPassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    // lógica de recuperação de senha
                  },
                  child: const Text(
                    'Esqueceu a Senha?',
                    style: TextStyle(color: Color.fromARGB(255, 18, 90, 158)),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  child: Text(
                    showPassword ? 'Ocultar Senha' : 'Mostrar Senha',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 18, 90, 158)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signIn,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: _isSigning
                  ? const CircularProgressIndicator(
                      color: Color.fromARGB(255, 255, 255, 255))
                  : const Text(
                      'Login',
                      style: TextStyle(
                        color: Color.fromARGB(255, 18, 90, 158),
                        fontSize: 16,
                      ),
                    ),
            ),
            const SizedBox(height: 100),
            Row(
              children: [
                Expanded(child: Divider(color: Colors.grey[400])),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text('OR'),
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
                  Navigator.pushNamed(context, '/signUp');
                },
                child: const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Não tem uma conta?',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      TextSpan(
                        text: ' Register',
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

  Widget _buildSocialLoginButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
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

  void _signIn() async {
    setState(() {
      _isSigning = true;
    });

    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
      _isSigning = false;
    });

    if (user != null) {
      if (mounted) {
        // Atualizar o provider com os dados do usuário logado
        final userModel = Provider.of<UserModel>(context, listen: false);
        userModel.setUserData(
          id: user.uid,
          username: user.displayName ?? '',
          email: user.email ?? '',
          phone: user.phoneNumber ?? '',
        );

        showToast(message: "Usuário logado com sucesso");
        Navigator.pushNamed(context, "/home");
      }
    } else {
      if (mounted) {
        showToast(message: "Ocorreu algum erro");
      }
    }
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

        final UserCredential userCredential =
            await _firebaseAuth.signInWithCredential(credential);
        final User? user = userCredential.user;

        if (user != null) {
          if (mounted) {
            // Atualizar o provider com os dados do usuário logado
            final userModel = Provider.of<UserModel>(context, listen: false);
            userModel.setUserData(
              id: user.uid,
              username: user.displayName ?? '',
              email: user.email ?? '',
              phone: user.phoneNumber ?? '',
            );

            Navigator.pushNamed(context, "/home");
          }
        }
      }
    } catch (e) {
      if (mounted) {
        showToast(message: "Algo deu errado $e");
      }
    }
  }
}
