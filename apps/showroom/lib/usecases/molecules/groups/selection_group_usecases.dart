import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

// ==============================================================
// Radio Button Group - OKCupid Example (Gender Selection)
// ==============================================================

enum Gender { man, woman, other }

class _RadioGroupDemo extends StatefulWidget {
  @override
  State<_RadioGroupDemo> createState() => _RadioGroupDemoState();
}

class _RadioGroupDemoState extends State<_RadioGroupDemo> {
  Gender? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: SelectionGroupEAE<Gender>(
            options: const [
              SelectionOption(label: 'Man', value: Gender.man),
              SelectionOption(label: 'Woman', value: Gender.woman),
            ],
            selectionType: SelectionType.radio,
            selectedValue: _selectedGender,
            onRadioChanged: (value) {
              setState(() {
                _selectedGender = value;
              });
            },
            actionLabel: 'See all',
            onActionTap: () {
              // Navigate to full gender list
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('See all genders tapped')),
              );
            },
            // showCard et cardBackgroundColor utilisent les valeurs du thème
          ),
        ),
      ),
    );
  }
}

Widget buildRadioGroupOKC(BuildContext context) {
  return _RadioGroupDemo();
}

// ==============================================================
// Radio Button Group - Simple Example
// ==============================================================

enum PaymentMethod { creditCard, paypal, applePay }

class _SimpleRadioGroupDemo extends StatefulWidget {
  @override
  State<_SimpleRadioGroupDemo> createState() => _SimpleRadioGroupDemoState();
}

class _SimpleRadioGroupDemoState extends State<_SimpleRadioGroupDemo> {
  PaymentMethod? _selectedPayment = PaymentMethod.creditCard;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Payment Method',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              SelectionGroupEAE<PaymentMethod>(
                options: const [
                  SelectionOption(
                      label: 'Credit Card', value: PaymentMethod.creditCard),
                  SelectionOption(label: 'PayPal', value: PaymentMethod.paypal),
                  SelectionOption(
                      label: 'Apple Pay', value: PaymentMethod.applePay),
                ],
                selectionType: SelectionType.radio,
                selectedValue: _selectedPayment,
                onRadioChanged: (value) {
                  setState(() {
                    _selectedPayment = value;
                  });
                },
              ),
              const SizedBox(height: 24),
              Text('Selected: ${_selectedPayment?.toString() ?? "None"}'),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildSimpleRadioGroup(BuildContext context) {
  return _SimpleRadioGroupDemo();
}

// ==============================================================
// Checkbox Group - Interests Example
// ==============================================================

enum Interest { sports, music, art, travel, reading, gaming }

class _CheckboxGroupDemo extends StatefulWidget {
  @override
  State<_CheckboxGroupDemo> createState() => _CheckboxGroupDemoState();
}

class _CheckboxGroupDemoState extends State<_CheckboxGroupDemo> {
  List<Interest> _selectedInterests = [Interest.music];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Your Interests',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              SelectionGroupEAE<Interest>(
                options: const [
                  SelectionOption(label: 'Sports', value: Interest.sports),
                  SelectionOption(label: 'Music', value: Interest.music),
                  SelectionOption(label: 'Art', value: Interest.art),
                  SelectionOption(label: 'Travel', value: Interest.travel),
                ],
                selectionType: SelectionType.checkbox,
                selectedValues: _selectedInterests,
                onCheckboxChanged: (values) {
                  setState(() {
                    _selectedInterests = values;
                  });
                },
                actionLabel: 'See all interests',
                onActionTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('See all interests tapped')),
                  );
                },
              ),
              const SizedBox(height: 24),
              Text('Selected: ${_selectedInterests.length} interests'),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildCheckboxGroup(BuildContext context) {
  return _CheckboxGroupDemo();
}

// ==============================================================
// Checkbox Group - No Action Item
// ==============================================================

enum Language { english, spanish, french, german }

class _SimpleCheckboxGroupDemo extends StatefulWidget {
  @override
  State<_SimpleCheckboxGroupDemo> createState() =>
      _SimpleCheckboxGroupDemoState();
}

class _SimpleCheckboxGroupDemoState extends State<_SimpleCheckboxGroupDemo> {
  List<Language> _selectedLanguages = [Language.english];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Languages You Speak',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              SelectionGroupEAE<Language>(
                options: const [
                  SelectionOption(label: 'English', value: Language.english),
                  SelectionOption(label: 'Spanish', value: Language.spanish),
                  SelectionOption(label: 'French', value: Language.french),
                  SelectionOption(label: 'German', value: Language.german),
                ],
                selectionType: SelectionType.checkbox,
                selectedValues: _selectedLanguages,
                onCheckboxChanged: (values) {
                  setState(() {
                    _selectedLanguages = values;
                  });
                },
              ),
              const SizedBox(height: 24),
              Text(
                  'Selected: ${_selectedLanguages.map((l) => l.name).join(", ")}'),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildSimpleCheckboxGroup(BuildContext context) {
  return _SimpleCheckboxGroupDemo();
}

// ==============================================================
// Compact Spacing Example
// ==============================================================

enum NotificationPref { email, sms, push }

class _CompactSelectionDemo extends StatefulWidget {
  @override
  State<_CompactSelectionDemo> createState() => _CompactSelectionDemoState();
}

class _CompactSelectionDemoState extends State<_CompactSelectionDemo> {
  List<NotificationPref> _selectedPrefs = [NotificationPref.email];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Notification Preferences',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              SelectionGroupEAE<NotificationPref>(
                options: const [
                  SelectionOption(
                      label: 'Email notifications',
                      value: NotificationPref.email),
                  SelectionOption(
                      label: 'SMS notifications', value: NotificationPref.sms),
                  SelectionOption(
                      label: 'Push notifications',
                      value: NotificationPref.push),
                ],
                selectionType: SelectionType.checkbox,
                selectedValues: _selectedPrefs,
                onCheckboxChanged: (values) {
                  setState(() {
                    _selectedPrefs = values;
                  });
                },
                spacing: 8.0, // Compact spacing
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildCompactSelection(BuildContext context) {
  return _CompactSelectionDemo();
}

// ==============================================================
// Without Chevron Example
// ==============================================================

enum AgeRange { range18_24, range25_34, range35_44, range45Plus }

class _NoChevronDemo extends StatefulWidget {
  @override
  State<_NoChevronDemo> createState() => _NoChevronDemoState();
}

class _NoChevronDemoState extends State<_NoChevronDemo> {
  AgeRange? _selectedRange;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: SelectionGroupEAE<AgeRange>(
            options: const [
              SelectionOption(label: '18-24', value: AgeRange.range18_24),
              SelectionOption(label: '25-34', value: AgeRange.range25_34),
              SelectionOption(label: '35-44', value: AgeRange.range35_44),
            ],
            selectionType: SelectionType.radio,
            selectedValue: _selectedRange,
            onRadioChanged: (value) {
              setState(() {
                _selectedRange = value;
              });
            },
            actionLabel: 'Custom age range',
            onActionTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Custom age range tapped')),
              );
            },
            showActionChevron: false, // No chevron
            // showCard et cardBackgroundColor utilisent les valeurs du thème
          ),
        ),
      ),
    );
  }
}

Widget buildNoChevronSelection(BuildContext context) {
  return _NoChevronDemo();
}

// ==============================================================
// Without Card Example
// ==============================================================

enum Pet { dog, cat, bird, fish }

class _NoCardDemo extends StatefulWidget {
  @override
  State<_NoCardDemo> createState() => _NoCardDemoState();
}

class _NoCardDemoState extends State<_NoCardDemo> {
  Pet? _selectedPet = Pet.dog;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Your Pet (No Card)',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              SelectionGroupEAE<Pet>(
                options: const [
                  SelectionOption(label: 'Dog', value: Pet.dog),
                  SelectionOption(label: 'Cat', value: Pet.cat),
                  SelectionOption(label: 'Bird', value: Pet.bird),
                  SelectionOption(label: 'Fish', value: Pet.fish),
                ],
                selectionType: SelectionType.radio,
                selectedValue: _selectedPet,
                onRadioChanged: (value) {
                  setState(() {
                    _selectedPet = value;
                  });
                },
                showCard: false, // No card, no dividers
              ),
              const SizedBox(height: 24),
              Text(
                'Selected: ${_selectedPet?.toString() ?? "None"}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildNoCardSelection(BuildContext context) {
  return _NoCardDemo();
}

// ==============================================================
// Max Selections Example
// ==============================================================

enum Skill {
  communication,
  leadership,
  teamwork,
  problemSolving,
  creativity,
  technical
}

class _MaxSelectionsDemo extends StatefulWidget {
  @override
  State<_MaxSelectionsDemo> createState() => _MaxSelectionsDemoState();
}

class _MaxSelectionsDemoState extends State<_MaxSelectionsDemo> {
  List<Skill> _selectedSkills = [Skill.communication];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Your Top 3 Skills',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Maximum 3 selections allowed',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
              const SizedBox(height: 16),
              SelectionGroupEAE<Skill>(
                options: const [
                  SelectionOption(
                      label: 'Communication', value: Skill.communication),
                  SelectionOption(label: 'Leadership', value: Skill.leadership),
                  SelectionOption(label: 'Teamwork', value: Skill.teamwork),
                  SelectionOption(
                      label: 'Problem Solving', value: Skill.problemSolving),
                  SelectionOption(label: 'Creativity', value: Skill.creativity),
                  SelectionOption(label: 'Technical', value: Skill.technical),
                ],
                selectionType: SelectionType.checkbox,
                selectedValues: _selectedSkills,
                onCheckboxChanged: (values) {
                  setState(() {
                    _selectedSkills = values;
                  });
                },
                maxSelections: 3, // ← Limite à 3 sélections
              ),
              const SizedBox(height: 24),
              Text(
                'Selected: ${_selectedSkills.length}/3',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildMaxSelectionsDemo(BuildContext context) {
  return _MaxSelectionsDemo();
}
