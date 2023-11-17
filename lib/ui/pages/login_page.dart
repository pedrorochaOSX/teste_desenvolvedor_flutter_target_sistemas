// Dependencies
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

// Data
import 'package:teste_desenvolvedor_flutter_target_sistemas/data/models/user_model.dart';
import 'package:teste_desenvolvedor_flutter_target_sistemas/data/repositories/user_repository.dart';

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

  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  bool isDarkTheme = false;
  User? user;
  String? errorText;
  bool passwordVisible = false;

  _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
      prefs.setBool('isDarkTheme', isDarkTheme);
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
                  color: Theme.of(context).colorScheme.onInverseSurface,
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
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).colorScheme.background,
                Theme.of(context).colorScheme.onBackground,
              ],
            ),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 64),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: Text(
                                    "Usuário",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onTertiary,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                            TextField(
                              minLines: 1,
                              maxLines: 1,
                              maxLength: 20,
                              maxLengthEnforcement: null,
                              controller: usernameTextController,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[a-zA-Z0-9]')),
                              ],
                              decoration: InputDecoration(
                                counterText: "",
                                contentPadding: EdgeInsets.only(
                                    top: 16, bottom: 16, left: 30, right: 30),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(8)),
                                filled: true,
                                fillColor:
                                    Theme.of(context).colorScheme.onPrimary,
                                labelText: null,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16),
                                  child: Icon(
                                    Icons.person_rounded,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                                errorText: errorText,
                              ),
                              cursorColor:
                                  Theme.of(context).colorScheme.onSecondary,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondary),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: Text(
                                    "Senha",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onTertiary,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                            TextField(
                              minLines: 1,
                              maxLines: 1,
                              maxLength: 20,
                              maxLengthEnforcement: null,
                              controller: passwordTextController,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[a-zA-Z0-9]')),
                              ],
                              obscureText: passwordVisible ? false : true,
                              decoration: InputDecoration(
                                counterText: "",
                                contentPadding: EdgeInsets.only(
                                    top: 16, bottom: 16, left: 30, right: 30),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(8)),
                                filled: true,
                                fillColor:
                                    Theme.of(context).colorScheme.onPrimary,
                                labelText: null,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16),
                                  child: Icon(
                                    Icons.lock_rounded,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                                suffixIcon: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 4, right: 8),
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        passwordVisible = !passwordVisible;
                                      });
                                    },
                                    splashRadius: 16,
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    icon: passwordVisible
                                        ? Icon(
                                            Icons.visibility_rounded,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            size: 24,
                                          )
                                        : Icon(
                                            Icons.visibility_off_rounded,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            size: 24,
                                          ),
                                  ),
                                ),
                                errorText: errorText,
                              ),
                              cursorColor:
                                  Theme.of(context).colorScheme.onSecondary,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondary),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (usernameTextController.text.isEmpty ||
                                  passwordTextController.text.isEmpty) {
                                ScaffoldMessenger.of(context).clearSnackBars();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Por favor, preencha os campos acima.",
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary,
                                        fontSize: 14,
                                      ),
                                    ),
                                    duration: Duration(seconds: 2),
                                    backgroundColor:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                );
                              } else if (passwordTextController.text.length <
                                  3) {
                                ScaffoldMessenger.of(context).clearSnackBars();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "A senha deve ser maior que 2 caracteres.",
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary,
                                        fontSize: 14,
                                      ),
                                    ),
                                    duration: Duration(seconds: 2),
                                    backgroundColor:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                );
                              } else {
                                FocusScope.of(context).unfocus();
                                usernameTextController.clear();
                                passwordTextController.clear();

                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                        secondaryAnimation) {
                                      return InformationsPage();
                                    },
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      const begin = Offset(1.0, 0.0);
                                      const end = Offset.zero;
                                      const curve = Curves.easeInOutCubic;

                                      var slideAnimation =
                                          Tween(begin: begin, end: end).animate(
                                              CurvedAnimation(
                                                  parent: animation,
                                                  curve: curve));
                                      return SlideTransition(
                                        position: slideAnimation,
                                        child: child,
                                      );
                                    },
                                    transitionDuration:
                                        Duration(milliseconds: 100),
                                  ),
                                );
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shadowColor: Colors.transparent,
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            minimumSize: Size(200, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32),
                            ),
                          ),
                          child: Text(
                            "Entrar",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.surface),
                          ),
                        ),
                      ),
                    ],
                  ),
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
      ),
    );
  }
}
