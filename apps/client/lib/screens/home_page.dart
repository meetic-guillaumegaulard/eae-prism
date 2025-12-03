import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

class HomePage extends StatefulWidget {
  final Brand brand;

  const HomePage({super.key, required this.brand});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// Configuration initiale de l'écran (étape 1 du formulaire)
  ScreenConfig get _initialConfig => const ScreenConfig(
        template: 'screen_layout',
        props: {'backgroundColor': '#FFFFFF'},
        header: [
          ComponentConfig(
            type: 'container',
            props: {'padding': 16},
            children: [
              ComponentConfig(
                type: 'text',
                props: {
                  'text': 'Bienvenue !',
                  'type': 'headline_medium',
                  'fontWeight': 'bold',
                },
              ),
            ],
          ),
        ],
        content: [
          ComponentConfig(
            type: 'column',
            props: {'crossAxisAlignment': 'stretch'},
            children: [
              ComponentConfig(
                type: 'padding',
                props: {'padding': 16},
                children: [
                  ComponentConfig(
                    type: 'text',
                    props: {
                      'text': 'Commencez votre inscription',
                      'type': 'body_large',
                      'textAlign': 'center',
                    },
                  ),
                ],
              ),
              ComponentConfig(
                type: 'padding',
                props: {'padding': 16},
                children: [
                  ComponentConfig(
                    type: 'text_input',
                    props: {
                      'label': 'Prénom',
                      'hintText': 'Entrez votre prénom',
                      'field': 'firstName',
                    },
                  ),
                ],
              ),
              ComponentConfig(
                type: 'padding',
                props: {'padding': 16},
                children: [
                  ComponentConfig(
                    type: 'text_input',
                    props: {
                      'label': 'Nom',
                      'hintText': 'Entrez votre nom',
                      'field': 'lastName',
                    },
                  ),
                ],
              ),
              ComponentConfig(
                type: 'padding',
                props: {'padding': 16},
                children: [
                  ComponentConfig(
                    type: 'progress_bar',
                    props: {
                      'value': 33,
                      'showCounter': true,
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
        footer: [
          ComponentConfig(
            type: 'container',
            props: {'padding': 16},
            children: [
              ComponentConfig(
                type: 'button',
                props: {
                  'label': 'Continuer',
                  'variant': 'primary',
                  'isFullWidth': true,
                  'apiEndpoint': '/screens/step2',
                },
              ),
            ],
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return DynamicScreen(
      config: _initialConfig,
      baseUrl: 'http://localhost:3000/api',
      onFormChanged: (values) {
        // Debug: affiche les valeurs du formulaire
        debugPrint('Form values: $values');
      },
      onSubmit: (values) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Formulaire soumis: ${values.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );
      },
      onApiError: (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur: $error'),
            backgroundColor: Colors.red,
          ),
        );
      },
    );
  }
}
