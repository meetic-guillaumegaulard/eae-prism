import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

class DynamicScreenUsecases extends StatelessWidget {
  const DynamicScreenUsecases({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dynamic Screen'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'From JSON String'),
              Tab(text: 'From Asset File'),
              Tab(text: 'Custom Config'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _JsonStringExample(),
            _AssetFileExample(),
            _CustomConfigExample(),
          ],
        ),
      ),
    );
  }
}

/// Example using a JSON string directly
class _JsonStringExample extends StatefulWidget {
  const _JsonStringExample();

  @override
  State<_JsonStringExample> createState() => _JsonStringExampleState();
}

class _JsonStringExampleState extends State<_JsonStringExample> {
  Map<String, dynamic> _formData = {};

  @override
  Widget build(BuildContext context) {
    const jsonString = '''
{
  "template": "screen_layout",
  "header": [
    {
      "type": "container",
      "props": { "padding": 16 },
      "children": [
        {
          "type": "text",
          "props": {
            "text": "Simple Login Form",
            "type": "headline_medium"
          }
        }
      ]
    }
  ],
  "content": [
    {
      "type": "column",
      "props": {
        "crossAxisAlignment": "stretch"
      },
      "children": [
        {
          "type": "padding",
          "props": { "padding": 16 },
          "children": [
            {
              "type": "text_input",
              "props": {
                "label": "Username",
                "hintText": "Enter your username",
                "field": "username"
              }
            }
          ]
        },
        {
          "type": "padding",
          "props": { "padding": 16 },
          "children": [
            {
              "type": "text_input",
              "props": {
                "label": "Password",
                "hintText": "Enter your password",
                "obscureText": true,
                "field": "password"
              }
            }
          ]
        },
        {
          "type": "padding",
          "props": { "padding": 16 },
          "children": [
            {
              "type": "labeled_control",
              "props": {
                "htmlLabel": "Remember me",
                "field": "rememberMe",
                "defaultValue": false,
                "controlType": "checkbox"
              }
            }
          ]
        }
      ]
    }
  ],
  "footer": [
    {
      "type": "container",
      "props": { "padding": 16 },
      "children": [
        {
          "type": "button",
          "props": {
            "label": "Login",
            "variant": "primary",
            "isFullWidth": true,
            "action": "submit"
          }
        }
      ]
    }
  ]
}
''';

    return Column(
      children: [
        Expanded(
          child: DynamicScreen(
            jsonString: jsonString,
            onFormChanged: (values) {
              setState(() {
                _formData = values;
              });
            },
            onSubmit: (values) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Login! Values: ${jsonEncode(values)}'),
                  duration: const Duration(seconds: 3),
                ),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.grey[200],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Form Data (auto-collected):',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                const JsonEncoder.withIndent('  ').convert(_formData),
                style: const TextStyle(fontSize: 12, fontFamily: 'monospace'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Example loading from an asset file
class _AssetFileExample extends StatefulWidget {
  const _AssetFileExample();

  @override
  State<_AssetFileExample> createState() => _AssetFileExampleState();
}

class _AssetFileExampleState extends State<_AssetFileExample> {
  Map<String, dynamic> _formData = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: DynamicScreen.fromAsset(
            'assets/example_screen.json',
            onFormChanged: (values) {
              setState(() {
                _formData = values;
              });
            },
            onSubmit: (values) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Form submitted!'),
                  action: SnackBarAction(
                    label: 'View JSON',
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Form Data'),
                          content: SingleChildScrollView(
                            child: Text(
                              const JsonEncoder.withIndent('  ')
                                  .convert(values),
                              style: const TextStyle(fontFamily: 'monospace'),
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Close'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  duration: const Duration(seconds: 5),
                ),
              );
            },
          ),
        ),
        if (_formData.isNotEmpty)
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey[200],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Form Data (nested JSON):',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  const JsonEncoder.withIndent('  ').convert(_formData),
                  style: const TextStyle(fontSize: 11, fontFamily: 'monospace'),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

/// Example using ScreenConfig object directly
class _CustomConfigExample extends StatefulWidget {
  const _CustomConfigExample();

  @override
  State<_CustomConfigExample> createState() => _CustomConfigExampleState();
}

class _CustomConfigExampleState extends State<_CustomConfigExample> {
  Map<String, dynamic> _formData = {};

  @override
  Widget build(BuildContext context) {
    // Create a config programmatically
    final config = ScreenConfig(
      template: 'screen_layout',
      header: [
        ComponentConfig(
          type: 'container',
          props: const {'padding': 16},
          children: [
            ComponentConfig(
              type: 'text',
              props: const {
                'text': 'Preferences',
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
          props: const {
            'mainAxisAlignment': 'start',
            'crossAxisAlignment': 'stretch',
          },
          children: [
            ComponentConfig(
              type: 'padding',
              props: const {'padding': 16},
              children: [
                ComponentConfig(
                  type: 'text',
                  props: const {
                    'text': 'Select your gender',
                    'type': 'title_medium',
                  },
                ),
              ],
            ),
            ComponentConfig(
              type: 'padding',
              props: const {
                'padding': {'left': 16, 'right': 16, 'bottom': 16}
              },
              children: [
                ComponentConfig(
                  type: 'selectable_button_group',
                  props: const {
                    'labels': ['Male', 'Female', 'Other'],
                    'field': 'profile.gender',
                    'defaultValue': 'Male',
                  },
                ),
              ],
            ),
            ComponentConfig(
              type: 'padding',
              props: const {'padding': 16},
              children: [
                ComponentConfig(
                  type: 'text',
                  props: const {
                    'text': 'Your height',
                    'type': 'title_medium',
                  },
                ),
              ],
            ),
            ComponentConfig(
              type: 'padding',
              props: const {
                'padding': {'left': 16, 'right': 16, 'bottom': 16}
              },
              children: [
                ComponentConfig(
                  type: 'height_slider',
                  props: const {
                    'field': 'profile.height',
                    'minValue': 140,
                    'maxValue': 220,
                    'defaultValue': 175,
                  },
                ),
              ],
            ),
            ComponentConfig(
              type: 'padding',
              props: const {'padding': 16},
              children: [
                ComponentConfig(
                  type: 'text',
                  props: const {
                    'text': 'Your interests',
                    'type': 'title_medium',
                  },
                ),
              ],
            ),
            ComponentConfig(
              type: 'padding',
              props: const {
                'padding': {'left': 16, 'right': 16, 'bottom': 16}
              },
              children: [
                ComponentConfig(
                  type: 'selectable_tag_group',
                  props: const {
                    'labels': [
                      'Travel',
                      'Music',
                      'Sports',
                      'Movies',
                      'Food',
                      'Art'
                    ],
                    'field': 'profile.interests',
                    'defaultValue': ['Travel', 'Music'],
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
          props: const {'padding': 16},
          children: [
            ComponentConfig(
              type: 'row',
              props: const {'mainAxisAlignment': 'spaceEvenly'},
              children: [
                ComponentConfig(
                  type: 'button',
                  props: const {
                    'label': 'Reset',
                    'variant': 'outline',
                    'action': 'reset',
                  },
                ),
                ComponentConfig(
                  type: 'button',
                  props: const {
                    'label': 'Save Profile',
                    'variant': 'primary',
                    'action': 'submit',
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );

    return Column(
      children: [
        Expanded(
          child: DynamicScreen(
            config: config,
            actions: {
              'reset': () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Form reset!')),
                );
              },
            },
            onFormChanged: (values) {
              setState(() {
                _formData = values;
              });
            },
            onSubmit: (values) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Profile saved! ${jsonEncode(values)}'),
                  duration: const Duration(seconds: 3),
                ),
              );
            },
          ),
        ),
        if (_formData.isNotEmpty)
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey[200],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Profile Data:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  const JsonEncoder.withIndent('  ').convert(_formData),
                  style: const TextStyle(fontSize: 11, fontFamily: 'monospace'),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
