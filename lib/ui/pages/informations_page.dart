// Dependencies
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

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

  final usernameTextController = TextEditingController();
  final addInformationTextController = TextEditingController();

  bool isDarkTheme = false;
  List<Information> informationsList = [];
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

  _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    await launchUrl(uri);
  }

  @override
  void initState() {
    super.initState();

    _loadSettings();

    informationRepository.getInformationList().then((value) {
      setState(() {
        informationsList = value;
        informationsList.sort((b, a) {
          return DateTime.parse((b.dateTime).toIso8601String())
              .compareTo(DateTime.parse((a.dateTime).toIso8601String()));
        });
      });
    });
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
                    children: [
                      Scrollbar(
                        interactive: true,
                        radius: Radius.circular(5),
                        thickness: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: ListView(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            children: [
                              for (Information information
                                  in informationsList.reversed)
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        shadowColor: Colors.transparent,
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Row(
                                          children: [
                                            Text(
                                              information.details,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSecondary,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {},
                                              splashRadius: 18,
                                              splashColor: Colors.transparent,
                                              icon: Icon(
                                                Icons.edit,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSecondary,
                                                size: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Card(
                          elevation: 3,
                          shadowColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            minLines: 1,
                            maxLines: 5,
                            maxLengthEnforcement: null,
                            controller: addInformationTextController,
                            onEditingComplete: () {
                              Information newInformation = Information(
                                details: addInformationTextController.text,
                                dateTime: DateTime.now(),
                              );
                              errorText = null;
                              setState(() {
                                informationsList.add(newInformation);
                                informationRepository
                                    .saveInformationList(informationsList);
                              });
                            },
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
                              hintText: "Digite seu texto",
                              hintStyle: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondary),
                              errorText: errorText,
                            ),
                            cursorColor:
                                Theme.of(context).colorScheme.onSecondary,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color:
                                    Theme.of(context).colorScheme.onSecondary),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Information newInformation = Information(
                              details: addInformationTextController.text,
                              dateTime: DateTime.now(),
                            );
                            errorText = null;
                            setState(() {
                              informationsList.add(newInformation);
                              informationRepository
                                  .saveInformationList(informationsList);
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 5,
                            shadowColor: Colors.black,
                            backgroundColor:
                                Theme.of(context).colorScheme.onPrimary,
                            minimumSize: Size(64, 64),
                            shape: CircleBorder(),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            child: Icon(
                              Icons.add_rounded,
                              size: 32,
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () {
                        _launchURL("https://www.google.com");
                      },
                      child: Text(
                        'Política de Privacidade',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onTertiary,
                        ),
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
