// Dependencies
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

// Data
import 'package:teste_desenvolvedor_flutter_target_sistemas/data/models/information_model.dart';
import 'package:teste_desenvolvedor_flutter_target_sistemas/data/models/user_model.dart';
import 'package:teste_desenvolvedor_flutter_target_sistemas/data/repositories/user_repository.dart';
import 'package:teste_desenvolvedor_flutter_target_sistemas/data/repositories/information_repository.dart';

// Pages
import 'package:teste_desenvolvedor_flutter_target_sistemas/ui/theme_provider.dart';
import 'package:teste_desenvolvedor_flutter_target_sistemas/ui/pages/informations_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userRepository = UserRepository();
  final informationRepository = UserRepository();

  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  bool isDarkTheme = false;
  User? user;

  _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
      prefs.setBool('isDarkTheme', isDarkTheme!);
    });
  }

  _saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isDarkTheme', isDarkTheme);
  }

  @override
  void initState() {
    super.initState();

    _loadSettings();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: IconButton(
                splashRadius: 20,
                icon: Icon(
                  isDarkTheme
                      ? Icons.dark_mode_rounded
                      : Icons.light_mode_rounded,
                  size: 24,
                  color: Theme.of(context).colorScheme.onTertiary,
                ),
                onPressed: () {
                  setState(() {
                    isDarkTheme = !isDarkTheme;
                    final provider =
                        Provider.of<ThemeProvider>(context, listen: false);
                    provider.toggleTheme(isDarkTheme);
                    _saveSettings();
                  });
                },
              ),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).colorScheme.background,
                Theme.of(context).colorScheme.onBackground,
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Política de Privacidade',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onTertiary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
