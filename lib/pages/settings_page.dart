import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:real_estate_app/main.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Definições"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1520078452277-0832598937e5?q=80&w=1760&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                ),
                radius: 30,
              ),
              const SizedBox(height: 10),
              const Text(
                "Melvin Tivane",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              _buildSettingsGroup(
                context,
                items: [
                  _buildSettingsItem(
                    context,
                    icon: Icons.person,
                    text: "Perfil",
                    iconColor: Colors.red,
                    onTap: () {
                      Navigator.pushNamed(context, '/profile');
                    },
                  ),
                  _buildSettingsItem(
                    context,
                    icon: Icons.notifications,
                    text: "Notificações",
                    iconColor: Colors.blueGrey,
                    onTap: () {
                      // Lógica para notificações
                    },
                  ),
                  _buildSettingsItem(
                    context,
                    icon: Icons.lock,
                    text: "Mudar senha",
                    iconColor: Colors.green,
                    onTap: () {
                      Navigator.pushNamed(context, '/change_password');
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildSettingsGroup(
                context,
                items: [
                  _buildSettingsItem(
                    context,
                    icon: Icons.brightness_6,
                    text: "Aparência",
                    iconColor: Colors.orange,
                    onTap: () {
                      Navigator.of(context).pop();
                      (context.findAncestorStateOfType<MyAppState>())!.toggleTheme();
                    },
                  ),
                  _buildSettingsItem(
                    context,
                    icon: Icons.favorite,
                    text: "Favoritos",
                    iconColor: Colors.red,
                    onTap: () {
                      Navigator.pushNamed(context, '/favorites_page');
                    },
                  ),
                  _buildSettingsItem(
                    context,
                    icon: Icons.privacy_tip,
                    text: "Política e Privacidade",
                    iconColor: Colors.deepPurple,
                    onTap: () {
                      // Lógica para política e privacidade
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildSettingsItem(
                context,
                icon: Icons.exit_to_app,
                text: "Terminar Sessão",
                textColor: Colors.red,
                iconColor: Colors.red,
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsItem(BuildContext context, {required IconData icon, required String text, Color? textColor, Color? iconColor, VoidCallback? onTap}) {
    return ListTile(
      leading: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: iconColor ?? Colors.black),
        ),
      ),
      title: Text(
        text,
        style: TextStyle(
          color: textColor ?? const Color.fromARGB(255, 77, 77, 77),
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: onTap,
    );
  }

  Widget _buildSettingsGroup(BuildContext context, {required List<Widget> items}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: items,
      ),
    );
  }
}
