import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'controllers/voice_search_controller.dart';
import 'models/interest.dart';
import 'data/interests_data.dart';

/// Interest selection page with voice search
class InterestsPage extends ConsumerStatefulWidget {
  const InterestsPage({super.key});

  @override
  ConsumerState<InterestsPage> createState() => _InterestsPageState();
}

class _InterestsPageState extends ConsumerState<InterestsPage> {
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize speech (but don't start automatically on web)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(voiceSearchControllerProvider.notifier).initialize();
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(voiceSearchControllerProvider);
    final controller = ref.read(voiceSearchControllerProvider.notifier);

    // Meetic colors
    const meeticPrimary = Color(0xFFE9006D);
    const meeticDark = Color(0xFF2B0A3D);
    const meeticSurface = Color(0xFFF5F4F9);
    const meeticBorder = Color(0xFFC5C0D0);

    return Scaffold(
      backgroundColor: meeticSurface,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(context),

            // Selected interests chips (with loading indicator)
            if (state.selectedIds.isNotEmpty || state.isProcessing)
              _buildSelectedChips(state, controller),

            // Results list
            Expanded(
              child: _buildResultsGrid(state, controller),
            ),

            // Listening indicator and controls
            _buildListeningIndicator(state, controller),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    const meeticPrimary = Color(0xFFE9006D);
    const meeticDark = Color(0xFF2B0A3D);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon:
                    const Icon(Icons.chevron_left, color: meeticDark, size: 28),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  ref.read(voiceSearchControllerProvider.notifier).reset();
                },
                icon: const Icon(Icons.refresh, color: meeticDark),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Tell me what you like...',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
              color: meeticDark,
              fontFamily: 'Lora',
              letterSpacing: -0.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'I\'ll recommend interests for you',
            style: TextStyle(
              fontSize: 14,
              color: meeticDark.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedChips(
      VoiceSearchState state, VoiceSearchController controller) {
    return Container(
      margin: const EdgeInsets.only(top: 12, bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerLeft,
      child: Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 8,
        runSpacing: 8,
        children: [
          // Loading indicator when processing AI call
          if (state.isProcessing)
            Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFE9006D).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFFE9006D).withOpacity(0.3),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(
                        Color(0xFFE9006D),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Thinking...',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFE9006D),
                    ),
                  ),
                ],
              ),
            ),
          // Selected interest chips
          ...state.selectedInterests.asMap().entries.map((entry) {
            final index = entry.key;
            final interest = entry.value;
            return _InterestChip(
              interest: interest,
              index: index,
              isSelected: true,
              onTap: () => controller.toggleSelection(interest.id),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildResultsGrid(
      VoiceSearchState state, VoiceSearchController controller) {
    // Filter out selected interests - they appear in the selected section
    final interests =
        allInterests.where((i) => !state.isSelected(i.id)).toList();

    // Group by category
    final Map<String, List<Interest>> groupedInterests = {};
    for (final interest in interests) {
      groupedInterests.putIfAbsent(interest.category, () => []).add(interest);
    }

    // Keep category order
    final categoryOrder = [
      'Sports',
      'Music',
      'Tech',
      'Art',
      'Nature',
      'Food',
      'Travel',
      'Culture',
      'Social',
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: categoryOrder
            .where((cat) => groupedInterests.containsKey(cat))
            .map((category) {
          final categoryInterests = groupedInterests[category]!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category title
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 8, left: 4),
                child: Text(
                  category,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _getCategoryColor(category),
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              // Category interests
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: categoryInterests.asMap().entries.map((entry) {
                  final index = entry.key;
                  final interest = entry.value;
                  return _InterestChip(
                    interest: interest,
                    index: index,
                    isSelected: false,
                    onTap: () => controller.toggleSelection(interest.id),
                  );
                }).toList(),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    return switch (category) {
      'Sports' => const Color(0xFF22C55E),
      'Music' => const Color(0xFFF472B6),
      'Tech' => const Color(0xFF3B82F6),
      'Art' => const Color(0xFFF59E0B),
      'Nature' => const Color(0xFF10B981),
      'Food' => const Color(0xFFEF4444),
      'Travel' => const Color(0xFF8B5CF6),
      'Culture' => const Color(0xFF6366F1),
      'Social' => const Color(0xFFEC4899),
      _ => const Color(0xFF6B7280),
    };
  }

  Widget _buildListeningIndicator(
    VoiceSearchState state,
    VoiceSearchController controller,
  ) {
    const meeticPrimary = Color(0xFFE9006D);
    const meeticDark = Color(0xFF2B0A3D);
    const meeticBorder = Color(0xFFC5C0D0);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Sound visualization
          if (state.isListening) _SoundWaveIndicator(level: state.soundLevel),

          if (state.isListening) const SizedBox(height: 12),

          // Text field + buttons
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: meeticBorder),
            ),
            child: Row(
              children: [
                // Mic button
                GestureDetector(
                  onTap: () {
                    if (state.isListening) {
                      controller.stopSession();
                    } else {
                      controller.startSession();
                    }
                  },
                  child: Container(
                    width: 48,
                    height: 48,
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: state.isListening
                          ? meeticPrimary.withOpacity(0.1)
                          : meeticBorder.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(999),
                      border: state.isListening
                          ? Border.all(color: meeticPrimary)
                          : null,
                    ),
                    child: Icon(
                      state.isListening ? Icons.stop : Icons.mic,
                      color: state.isListening
                          ? meeticPrimary
                          : meeticDark.withOpacity(0.5),
                      size: 22,
                    ),
                  ),
                ),

                // Text field
                Expanded(
                  child: TextField(
                    controller: _textController,
                    style: const TextStyle(color: meeticDark, fontSize: 14),
                    decoration: InputDecoration(
                      hintText: state.isListening
                          ? 'Listening...'
                          : 'Or type here...',
                      hintStyle: TextStyle(
                        color: meeticDark.withOpacity(0.4),
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 14,
                      ),
                    ),
                    onSubmitted: (text) {
                      if (text.isNotEmpty) {
                        controller.processTextInput(text);
                        _textController.clear();
                      }
                    },
                  ),
                ),

                // Send button
                GestureDetector(
                  onTap: state.isProcessing
                      ? null
                      : () {
                          if (_textController.text.isNotEmpty) {
                            controller.processTextInput(_textController.text);
                            _textController.clear();
                          }
                        },
                  child: Container(
                    width: 48,
                    height: 48,
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF4D9A), Color(0xFFE9006D)],
                      ),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: state.isProcessing
                        ? const Padding(
                            padding: EdgeInsets.all(14),
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.send, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          Text(
            state.isListening
                ? 'Speak, I\'m listening...'
                : 'Use mic or text to describe your interests',
            style: TextStyle(
              fontSize: 12,
              color: meeticDark.withOpacity(0.5),
            ),
          ),

          // Selection counter
          if (state.selectedIds.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              '${state.selectedIds.length} selected',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFFE9006D),
              ),
            ),
          ] else if (state.filteredIds.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              '${state.filteredIds.length} suggestion${state.filteredIds.length > 1 ? 's' : ''}',
              style: TextStyle(
                fontSize: 12,
                color: meeticDark.withOpacity(0.5),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Interest chip (~40px height, inline) - Meetic style
class _InterestChip extends StatelessWidget {
  final Interest interest;
  final int index;
  final bool isSelected;
  final VoidCallback onTap;

  // Meetic colors
  static const meeticPrimary = Color(0xFFE9006D);
  static const meeticDark = Color(0xFF2B0A3D);
  static const meeticBorder = Color(0xFFD8C7E0);

  const _InterestChip({
    required this.interest,
    required this.index,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? meeticDark.withOpacity(0.1)
              : const Color(0xFFFFFBF5),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? meeticPrimary : meeticBorder,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (interest.emoji != null) ...[
              Text(interest.emoji!, style: const TextStyle(fontSize: 16)),
              const SizedBox(width: 6),
            ],
            Text(
              interest.name,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: meeticDark,
              ),
            ),
            if (isSelected) ...[
              const SizedBox(width: 6),
              Container(
                width: 18,
                height: 18,
                decoration: const BoxDecoration(
                  color: meeticPrimary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, size: 12, color: Colors.white),
              ),
            ],
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(
          duration: const Duration(milliseconds: 200),
          delay: Duration(milliseconds: (index * 10).clamp(0, 200)),
        )
        .slideX(
          begin: 0.05,
          duration: const Duration(milliseconds: 200),
          delay: Duration(milliseconds: (index * 10).clamp(0, 200)),
          curve: Curves.easeOut,
        );
  }

  Color _getCategoryColor(String category) {
    return switch (category) {
      'Sports' => const Color(0xFF22C55E),
      'Music' => const Color(0xFFF472B6),
      'Tech' => const Color(0xFF3B82F6),
      'Art' => const Color(0xFFF59E0B),
      'Nature' => const Color(0xFF10B981),
      'Food' => const Color(0xFFEF4444),
      'Travel' => const Color(0xFF8B5CF6),
      'Culture' => const Color(0xFF6366F1),
      'Social' => const Color(0xFFEC4899),
      _ => const Color(0xFF6B7280),
    };
  }
}

/// Sound wave visual indicator - Meetic style
class _SoundWaveIndicator extends StatelessWidget {
  final double level;

  const _SoundWaveIndicator({required this.level});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(9, (index) {
          // Calculate each bar height based on sound level
          final distanceFromCenter = (index - 4).abs();
          final baseHeight = 8.0 + (4 - distanceFromCenter) * 4.0;
          final animatedHeight =
              baseHeight + (level * 20 * (1 - distanceFromCenter / 4));

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              width: 4,
              height: animatedHeight.clamp(4.0, 40.0),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFE9006D),
                    Color(0xFFFF4D9A),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        }),
      ),
    );
  }
}

