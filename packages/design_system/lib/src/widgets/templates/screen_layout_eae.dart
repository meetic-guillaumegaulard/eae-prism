import 'package:flutter/material.dart';
import '../../theme/brand_theme_extensions.dart';

/// Template component that manages screen layout with optional fixed top/bottom bars
/// and scroll indicators
class ScreenLayoutEAE extends StatefulWidget {
  /// Optional fixed top bar widget
  final Widget? topBar;

  /// Optional fixed bottom bar widget
  final Widget? bottomBar;

  /// Main scrollable content
  final Widget content;

  /// Background color for the entire screen
  final Color? backgroundColor;

  const ScreenLayoutEAE({
    Key? key,
    this.topBar,
    this.bottomBar,
    required this.content,
    this.backgroundColor,
  }) : super(key: key);

  @override
  State<ScreenLayoutEAE> createState() => _ScreenLayoutEAEState();
}

class _ScreenLayoutEAEState extends State<ScreenLayoutEAE> {
  final ScrollController _scrollController = ScrollController();
  bool _showTopDivider = false;
  bool _showBottomDivider = false;
  bool _canScrollDown = false;
  bool _canScrollUp = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateScrollState);
    // Check initial scroll state after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateScrollState();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateScrollState);
    _scrollController.dispose();
    super.dispose();
  }

  void _updateScrollState() {
    if (!_scrollController.hasClients) return;

    final position = _scrollController.position;
    final hasTopBar = widget.topBar != null;
    final hasBottomBar = widget.bottomBar != null;

    // Check if content is scrollable
    final isScrollable = position.maxScrollExtent > 0;

    // Check if we can scroll down (not at the bottom)
    final canScrollDown = isScrollable && position.pixels < position.maxScrollExtent - 1;

    // Check if we can scroll up (not at the top)
    final canScrollUp = isScrollable && position.pixels > 1;

    // Show dividers only if content is scrollable
    final showTopDivider = hasTopBar && isScrollable;
    final showBottomDivider = hasBottomBar && isScrollable;

    setState(() {
      _showTopDivider = showTopDivider;
      _showBottomDivider = showBottomDivider;
      _canScrollDown = canScrollDown;
      _canScrollUp = canScrollUp;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenLayoutTheme = Theme.of(context).extension<BrandScreenLayoutTheme>();
    final backgroundColor = widget.backgroundColor ?? 
        screenLayoutTheme?.backgroundColor ?? 
        Theme.of(context).colorScheme.surface;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar (fixed)
            if (widget.topBar != null) ...[
              widget.topBar!,
              // Divider below top bar (only visible when content is scrollable)
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: _showTopDivider ? (screenLayoutTheme?.dividerThickness ?? 1.0) : 0,
                color: _showTopDivider
                    ? (screenLayoutTheme?.dividerColor ?? const Color(0xFFE0E0E0))
                    : Colors.transparent,
              ),
            ],

            // Scrollable content with gradient indicators
            Expanded(
              child: Stack(
                children: [
                  // Main scrollable content
                  SingleChildScrollView(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: widget.content,
                  ),

                  // Top gradient indicator (visible when can scroll up)
                  if (_canScrollUp && widget.topBar != null)
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: IgnorePointer(
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 200),
                          opacity: _canScrollUp ? 1.0 : 0.0,
                          child: Container(
                            height: screenLayoutTheme?.scrollGradientHeight ?? 16.0,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  (screenLayoutTheme?.scrollGradientColor ??
                                          Colors.black)
                                      .withValues(alpha: 0.1),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                  // Bottom gradient indicator (visible when can scroll down)
                  if (_canScrollDown && widget.bottomBar != null)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: IgnorePointer(
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 200),
                          opacity: _canScrollDown ? 1.0 : 0.0,
                          child: Container(
                            height: screenLayoutTheme?.scrollGradientHeight ?? 16.0,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  (screenLayoutTheme?.scrollGradientColor ??
                                          Colors.black)
                                      .withValues(alpha: 0.1),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Bottom bar (fixed)
            if (widget.bottomBar != null) ...[
              // Divider above bottom bar (only visible when content is scrollable)
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: _showBottomDivider ? (screenLayoutTheme?.dividerThickness ?? 1.0) : 0,
                color: _showBottomDivider
                    ? (screenLayoutTheme?.dividerColor ?? const Color(0xFFE0E0E0))
                    : Colors.transparent,
              ),
              widget.bottomBar!,
            ],
          ],
        ),
      ),
    );
  }
}

