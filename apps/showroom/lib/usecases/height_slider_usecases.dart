import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

class HeightSliderUsecases extends StatefulWidget {
  const HeightSliderUsecases({Key? key}) : super(key: key);

  @override
  State<HeightSliderUsecases> createState() => _HeightSliderUsecasesState();
}

class _HeightSliderUsecasesState extends State<HeightSliderUsecases> {
  int _heightMetric = 170; // cm
  int _heightImperial = 66; // inches (5'6")
  int _heightCustomMetric = 180;
  int _heightCustomImperial = 72; // inches (6'0")

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Height Slider Use Cases'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section: Metric System
            _buildSectionTitle('Metric System (cm)'),
            const SizedBox(height: 16),

            _buildCard(
              title: 'Basic Height Slider - Metric',
              child: Center(
                child: HeightSliderEAE(
                  minValue: 140,
                  maxValue: 220,
                  initialValue: _heightMetric,
                  label: 'Select your height',
                  measurementSystem: HeightMeasurementSystem.metric,
                  scaleInterval: 10,
                  onChanged: (value) {
                    setState(() {
                      _heightMetric = value;
                    });
                    debugPrint('Height (metric): $value cm');
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),

            _buildCard(
              title: 'Shorter Scale - Metric (150-200cm)',
              child: Center(
                child: HeightSliderEAE(
                  minValue: 150,
                  maxValue: 200,
                  initialValue: _heightCustomMetric,
                  label: 'Height Range',
                  measurementSystem: HeightMeasurementSystem.metric,
                  scaleInterval: 5,
                  sliderHeight: 300,
                  onChanged: (value) {
                    setState(() {
                      _heightCustomMetric = value;
                    });
                    debugPrint('Height (custom metric): $value cm');
                  },
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Section: Imperial System
            _buildSectionTitle('Imperial System (feet/inches)'),
            const SizedBox(height: 16),

            _buildCard(
              title: 'Basic Height Slider - Imperial',
              child: Center(
                child: HeightSliderEAE(
                  minValue: 52, // 4'4"
                  maxValue: 82, // 6'10"
                  initialValue: _heightImperial,
                  label: 'Select your height',
                  measurementSystem: HeightMeasurementSystem.imperial,
                  scaleInterval: 5,
                  onChanged: (value) {
                    setState(() {
                      _heightImperial = value;
                    });
                    final feet = value ~/ 12;
                    final inches = value % 12;
                    debugPrint('Height (imperial): $feet\' $inches"');
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),

            _buildCard(
              title: 'Custom Range - Imperial (5\'0" - 6\'6")',
              child: Center(
                child: HeightSliderEAE(
                  minValue: 60, // 5'0"
                  maxValue: 78, // 6'6"
                  initialValue: _heightCustomImperial,
                  label: 'Height Range',
                  measurementSystem: HeightMeasurementSystem.imperial,
                  scaleInterval: 3,
                  sliderHeight: 350,
                  onChanged: (value) {
                    setState(() {
                      _heightCustomImperial = value;
                    });
                    final feet = value ~/ 12;
                    final inches = value % 12;
                    debugPrint('Height (custom imperial): $feet\' $inches"');
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),

            _buildCard(
              title: 'Without Label',
              child: Center(
                child: HeightSliderEAE(
                  minValue: 52,
                  maxValue: 82,
                  initialValue: 70,
                  measurementSystem: HeightMeasurementSystem.imperial,
                  scaleInterval: 6,
                  showCurrentValue: false,
                  sliderHeight: 300,
                  onChanged: (value) {
                    debugPrint('Height: $value inches');
                  },
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Display current values
            _buildSectionTitle('Current Values'),
            const SizedBox(height: 16),
            _buildCard(
              title: 'Selected Heights',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Metric Height: $_heightMetric cm'),
                  const SizedBox(height: 8),
                  Text(
                      'Imperial Height: ${_heightImperial ~/ 12}\' ${_heightImperial % 12}"'),
                  const SizedBox(height: 8),
                  Text('Custom Metric: $_heightCustomMetric cm'),
                  const SizedBox(height: 8),
                  Text(
                      'Custom Imperial: ${_heightCustomImperial ~/ 12}\' ${_heightCustomImperial % 12}"'),
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

