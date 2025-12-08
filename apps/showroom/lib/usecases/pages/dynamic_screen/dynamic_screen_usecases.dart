import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

class DynamicScreenUsecases extends StatelessWidget {
  const DynamicScreenUsecases({super.key});

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

/// Panel to display form data on the right side
class _FormDataPanel extends StatelessWidget {
  final Map<String, dynamic> formData;
  final String title;

  const _FormDataPanel({
    required this.formData,
    this.title = 'Form Data',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border(
          left: BorderSide(color: Colors.grey[300]!, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border(
                bottom: BorderSide(color: Colors.grey[300]!, width: 1),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.data_object, size: 18, color: Colors.grey[700]),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: formData.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'Fill in the form to see data here',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(12),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: SelectableText(
                        const JsonEncoder.withIndent('  ').convert(formData),
                        style: TextStyle(
                          fontSize: 11,
                          fontFamily: 'monospace',
                          color: Colors.grey[800],
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),
          ),
        ],
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
            "exit": "submit"
          }
        }
      ]
    }
  ]
}
''';

    return Row(
      children: [
        Expanded(
          child: DynamicScreen(
            jsonString: jsonString,
            onFormChanged: (values) {
              setState(() {
                _formData = values;
              });
            },
            onExit: (destination, values) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      'Exit: $destination - Values: ${jsonEncode(values)}'),
                  duration: const Duration(seconds: 3),
                ),
              );
            },
          ),
        ),
        _FormDataPanel(
          formData: _formData,
          title: 'Login Data',
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
    return Row(
      children: [
        Expanded(
          child: DynamicScreen.fromAsset(
            'assets/example_screen.json',
            onFormChanged: (values) {
              setState(() {
                _formData = values;
              });
            },
            onExit: (destination, values) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Exit: $destination'),
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
        _FormDataPanel(
          formData: _formData,
          title: 'User Profile',
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
    const config = ScreenConfig(
      template: 'screen_layout',
      header: [
        ComponentConfig(
          type: 'container',
          props: {'padding': 16},
          children: [
            ComponentConfig(
              type: 'text',
              props: {
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
          props: {
            'mainAxisAlignment': 'start',
            'crossAxisAlignment': 'stretch',
          },
          children: [
            ComponentConfig(
              type: 'padding',
              props: {'padding': 16},
              children: [
                ComponentConfig(
                  type: 'text',
                  props: {
                    'text': 'Select your gender',
                    'type': 'title_medium',
                  },
                ),
              ],
            ),
            ComponentConfig(
              type: 'padding',
              props: {
                'padding': {'left': 16, 'right': 16, 'bottom': 16}
              },
              children: [
                ComponentConfig(
                  type: 'selectable_button_group',
                  props: {
                    'labels': ['Male', 'Female', 'Other'],
                    'field': 'profile.gender',
                    'defaultValue': 'Male',
                  },
                ),
              ],
            ),
            ComponentConfig(
              type: 'padding',
              props: {'padding': 16},
              children: [
                ComponentConfig(
                  type: 'text',
                  props: {
                    'text': 'Your height',
                    'type': 'title_medium',
                  },
                ),
              ],
            ),
            ComponentConfig(
              type: 'padding',
              props: {
                'padding': {'left': 16, 'right': 16, 'bottom': 16}
              },
              children: [
                ComponentConfig(
                  type: 'height_slider',
                  props: {
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
              props: {'padding': 16},
              children: [
                ComponentConfig(
                  type: 'text',
                  props: {
                    'text': 'Your interests',
                    'type': 'title_medium',
                  },
                ),
              ],
            ),
            ComponentConfig(
              type: 'padding',
              props: {
                'padding': {'left': 16, 'right': 16, 'bottom': 16}
              },
              children: [
                ComponentConfig(
                  type: 'selectable_tag_group',
                  props: {
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
          props: {'padding': 16},
          children: [
            ComponentConfig(
              type: 'row',
              props: {'mainAxisAlignment': 'spaceEvenly'},
              children: [
                ComponentConfig(
                  type: 'button',
                  props: {
                    'label': 'Reset',
                    'variant': 'outline',
                    'exit': 'reset',
                  },
                ),
                ComponentConfig(
                  type: 'button',
                  props: {
                    'label': 'Save Profile',
                    'variant': 'primary',
                    'exit': 'submit',
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );

    return Row(
      children: [
        Expanded(
          child: DynamicScreen(
            config: config,
            onFormChanged: (values) {
              setState(() {
                _formData = values;
              });
            },
            onExit: (destination, values) {
              if (destination == 'reset') {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Form reset!')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Exit: $destination - ${jsonEncode(values)}'),
                    duration: const Duration(seconds: 3),
                  ),
                );
              }
            },
          ),
        ),
        _FormDataPanel(
          formData: _formData,
          title: 'Profile Data',
        ),
      ],
    );
  }
}
