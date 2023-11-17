// Dependencies
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

// Data
import 'package:teste_desenvolvedor_flutter_target_sistemas/data/models/information_model.dart';
import 'package:teste_desenvolvedor_flutter_target_sistemas/data/repositories/information_repository.dart';

// Pages
import 'package:teste_desenvolvedor_flutter_target_sistemas/ui/theme_provider.dart';

class InformationsPage extends StatefulWidget {
  const InformationsPage({super.key});

  @override
  State<InformationsPage> createState() => _InformationsPageState();
}

class _InformationsPageState extends State<InformationsPage> {
  final informationRepository = InformationRepository();

  final addInformationTextController = TextEditingController();

  bool isDarkTheme = false;
  List<Information> informations = [];
  String? errorText;

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
          title: Text(
            'Informations',
            style: TextStyle(
                color: Theme.of(context).colorScheme.onInverseSurface,
                fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.transparent,
          leading: IconButton(
            splashRadius: 20,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).colorScheme.onInverseSurface,
            ),
            color: Theme.of(context).colorScheme.onSecondary,
          ),
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
                    children: [],
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
