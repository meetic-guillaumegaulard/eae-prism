import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

class SliderUsecases extends StatefulWidget {
  const SliderUsecases({super.key});

  @override
  State<SliderUsecases> createState() => _SliderUsecasesState();
}

class _SliderUsecasesState extends State<SliderUsecases> {
  int _singleValue1 = 25;
  int _singleValue2 = 18;
  int _singleValue3 = 50;
  RangeValues _rangeValue1 = const RangeValues(20, 60);
  RangeValues _rangeValue2 = const RangeValues(25, 35);
  RangeValues _rangeValue3 = const RangeValues(0, 100);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slider Use Cases'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section: Single Value Sliders
            _buildSectionTitle('Single Value Sliders'),
            const SizedBox(height: 16),

            _buildCard(
              title: 'Basic Slider (0-100)',
              child: SliderEAE.single(
                minValue: 0,
                maxValue: 100,
                initialValue: _singleValue1,
                label: 'Select a value',
                onChanged: (value) {
                  setState(() {
                    _singleValue1 = value;
                  });
                  debugPrint('Single slider value: $value');
                },
              ),
            ),
            const SizedBox(height: 16),

            _buildCard(
              title: 'Age Selector (18-80)',
              child: SliderEAE.single(
                minValue: 18,
                maxValue: 80,
                initialValue: _singleValue2,
                label: 'Select your age',
                onChanged: (value) {
                  setState(() {
                    _singleValue2 = value;
                  });
                  debugPrint('Age selected: $value');
                },
              ),
            ),
            const SizedBox(height: 16),

            _buildCard(
              title: 'Without Labels',
              child: SliderEAE.single(
                minValue: 0,
                maxValue: 100,
                initialValue: _singleValue3,
                showLabels: false,
                showMinMaxLabels: false,
                onChanged: (value) {
                  setState(() {
                    _singleValue3 = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 32),

            // Section: Range Sliders
            _buildSectionTitle('Range Sliders'),
            const SizedBox(height: 16),

            _buildCard(
              title: 'Basic Range (0-100)',
              child: SliderEAE.range(
                minValue: 0,
                maxValue: 100,
                initialRange: _rangeValue1,
                label: 'Select a range',
                onRangeChanged: (values) {
                  setState(() {
                    _rangeValue1 = values;
                  });
                  debugPrint(
                      'Range selected: ${values.start.round()} - ${values.end.round()}');
                },
              ),
            ),
            const SizedBox(height: 16),

            _buildCard(
              title: 'Age Range Selector (18-50)',
              child: SliderEAE.range(
                minValue: 18,
                maxValue: 50,
                initialRange: _rangeValue2,
                label: 'Select age range',
                onRangeChanged: (values) {
                  setState(() {
                    _rangeValue2 = values;
                  });
                  debugPrint(
                      'Age range: ${values.start.round()} - ${values.end.round()}');
                },
              ),
            ),
            const SizedBox(height: 16),

            _buildCard(
              title: 'Full Range (0-100)',
              child: SliderEAE.range(
                minValue: 0,
                maxValue: 100,
                initialRange: _rangeValue3,
                label: 'Price range',
                onRangeChanged: (values) {
                  setState(() {
                    _rangeValue3 = values;
                  });
                },
              ),
            ),
            const SizedBox(height: 16),

            _buildCard(
              title: 'Without Min/Max Labels',
              child: SliderEAE.range(
                minValue: 0,
                maxValue: 100,
                initialRange: const RangeValues(25, 75),
                label: 'Select range',
                showMinMaxLabels: false,
                onRangeChanged: (values) {
                  debugPrint(
                      'Range: ${values.start.round()} - ${values.end.round()}');
                },
              ),
            ),
            const SizedBox(height: 32),

            // Display current values
            _buildSectionTitle('Current Values'),
            const SizedBox(height: 16),
            _buildCard(
              title: 'Selected Values',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Single Value 1: $_singleValue1'),
                  const SizedBox(height: 8),
                  Text('Single Value 2 (Age): $_singleValue2'),
                  const SizedBox(height: 8),
                  Text('Single Value 3: $_singleValue3'),
                  const SizedBox(height: 8),
                  Text(
                      'Range 1: ${_rangeValue1.start.round()} - ${_rangeValue1.end.round()}'),
                  const SizedBox(height: 8),
                  Text(
                      'Range 2 (Age): ${_rangeValue2.start.round()} - ${_rangeValue2.end.round()}'),
                  const SizedBox(height: 8),
                  Text(
                      'Range 3 (Price): ${_rangeValue3.start.round()} - ${_rangeValue3.end.round()}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Widget _buildCard({
    required String title,
    required Widget child,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}
