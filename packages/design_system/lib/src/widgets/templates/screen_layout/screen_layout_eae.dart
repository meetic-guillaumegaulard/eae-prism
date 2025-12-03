import 'package:flutter/material.dart';
import '../../../theme/brand_theme_extensions.dart';

/// Direction de la transition
enum TransitionDirection {
  left,
  right,
  up,
  down,
}

/// InheritedWidget qui fournit les données de transition aux descendants.
/// Utilisé pour animer uniquement le contenu tout en gardant les barres statiques.
class ScreenTransitionScope extends InheritedWidget {
  /// Animation principale (entrée de la nouvelle page)
  final Animation<double> animation;

  /// Animation secondaire (sortie de la page précédente)
  final Animation<double> secondaryAnimation;

  /// Direction de la transition
  final TransitionDirection direction;

  /// Si true, anime toute la page (barres incluses).
  /// Si false (défaut), seul le contenu est animé et les barres restent statiques.
  /// Utile pour les écrans de confirmation/succès où toute la page doit transitionner.
  final bool animateFullPage;

  const ScreenTransitionScope({
    super.key,
    required this.animation,
    required this.secondaryAnimation,
    this.direction = TransitionDirection.left,
    this.animateFullPage = false,
    required super.child,
  });

  /// Récupère le scope de transition si disponible
  static ScreenTransitionScope? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ScreenTransitionScope>();
  }

  @override
  bool updateShouldNotify(ScreenTransitionScope oldWidget) {
    return animation != oldWidget.animation ||
        secondaryAnimation != oldWidget.secondaryAnimation ||
        direction != oldWidget.direction ||
        animateFullPage != oldWidget.animateFullPage;
  }
}

/// Template component that manages screen layout with optional fixed top/bottom bars
/// and scroll indicators.
///
/// Uses Scaffold's native appBar and bottomNavigationBar.
/// When wrapped in a [ScreenTransitionScope], applies the transition animation
/// only to the content, keeping top and bottom bars static.
class ScreenLayoutEAE extends StatefulWidget {
  /// Optional fixed top bar widget (will be wrapped in a PreferredSize AppBar)
  final Widget? topBar;

  /// Height of the top bar (required if topBar is provided)
  final double topBarHeight;

  /// Optional fixed bottom bar widget (uses Scaffold's bottomNavigationBar)
  final Widget? bottomBar;

  /// Main scrollable content
  final Widget content;

  /// Background color for the entire screen
  final Color? backgroundColor;

  const ScreenLayoutEAE({
    Key? key,
    this.topBar,
    this.topBarHeight = kToolbarHeight,
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
    final canScrollDown =
        isScrollable && position.pixels < position.maxScrollExtent - 1;

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
    final screenLayoutTheme =
        Theme.of(context).extension<BrandScreenLayoutTheme>();
    final backgroundColor = widget.backgroundColor ??
        screenLayoutTheme?.backgroundColor ??
        Theme.of(context).colorScheme.surface;

    // Récupère le scope de transition si disponible
    final transitionScope = ScreenTransitionScope.maybeOf(context);

    // Construit le contenu scrollable
    Widget bodyContent = Stack(
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
                        (screenLayoutTheme?.scrollGradientColor ?? Colors.black)
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
                        (screenLayoutTheme?.scrollGradientColor ?? Colors.black)
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
    );

    // Si on a un scope de transition ET que animateFullPage est false,
    // applique l'animation au contenu uniquement (barres statiques)
    // Si animateFullPage est true, le ScreenTransitionScope anime toute la page
    if (transitionScope != null && !transitionScope.animateFullPage) {
      bodyContent = ClipRect(
        child: _AnimatedContent(
          animation: transitionScope.animation,
          secondaryAnimation: transitionScope.secondaryAnimation,
          direction: transitionScope.direction,
          child: bodyContent,
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      // AppBar statique (pas animée)
      appBar: widget.topBar != null
          ? _TopBarWrapper(
              height: widget.topBarHeight,
              showDivider: _showTopDivider,
              dividerThickness: screenLayoutTheme?.dividerThickness ?? 1.0,
              dividerColor:
                  screenLayoutTheme?.dividerColor ?? const Color(0xFFE0E0E0),
              backgroundColor: backgroundColor,
              child: widget.topBar!,
            )
          : null,
      // BottomNavigationBar statique (pas animée)
      bottomNavigationBar: widget.bottomBar != null
          ? _BottomBarWrapper(
              showDivider: _showBottomDivider,
              dividerThickness: screenLayoutTheme?.dividerThickness ?? 1.0,
              dividerColor:
                  screenLayoutTheme?.dividerColor ?? const Color(0xFFE0E0E0),
              backgroundColor: backgroundColor,
              child: widget.bottomBar!,
            )
          : null,
      body: bodyContent,
    );
  }
}

/// Widget qui applique l'animation de transition au contenu
class _AnimatedContent extends StatelessWidget {
  final Animation<double> animation;
  final Animation<double> secondaryAnimation;
  final TransitionDirection direction;
  final Widget child;

  const _AnimatedContent({
    required this.animation,
    required this.secondaryAnimation,
    required this.direction,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    // Offset de départ selon la direction (entrée de la nouvelle page)
    final Offset beginOffset = switch (direction) {
      TransitionDirection.left => const Offset(1.0, 0.0),
      TransitionDirection.right => const Offset(-1.0, 0.0),
      TransitionDirection.up => const Offset(0.0, 1.0),
      TransitionDirection.down => const Offset(0.0, -1.0),
    };

    final offsetAnimation = Tween<Offset>(
      begin: beginOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animation,
      curve: Curves.easeOutCubic,
    ));

    // Animation de sortie (page qui part)
    final exitOffset = switch (direction) {
      TransitionDirection.left => const Offset(-0.3, 0.0),
      TransitionDirection.right => const Offset(0.3, 0.0),
      TransitionDirection.up => const Offset(0.0, -0.3),
      TransitionDirection.down => const Offset(0.0, 0.3),
    };

    final secondaryOffsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: exitOffset,
    ).animate(CurvedAnimation(
      parent: secondaryAnimation,
      curve: Curves.easeOutCubic,
    ));

    return SlideTransition(
      position: secondaryOffsetAnimation,
      child: SlideTransition(
        position: offsetAnimation,
        child: child,
      ),
    );
  }
}

/// Wrapper for top bar that implements PreferredSizeWidget for Scaffold.appBar
class _TopBarWrapper extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final bool showDivider;
  final double dividerThickness;
  final Color dividerColor;
  final Color backgroundColor;
  final Widget child;

  const _TopBarWrapper({
    required this.height,
    required this.showDivider,
    required this.dividerThickness,
    required this.dividerColor,
    required this.backgroundColor,
    required this.child,
  });

  @override
  Size get preferredSize =>
      Size.fromHeight(height + (showDivider ? dividerThickness : 0));

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: SafeArea(
        bottom: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: height,
              child: child,
            ),
            // Animated divider below top bar
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: showDivider ? dividerThickness : 0,
              color: showDivider ? dividerColor : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}

/// Wrapper for bottom bar with animated divider
class _BottomBarWrapper extends StatelessWidget {
  final bool showDivider;
  final double dividerThickness;
  final Color dividerColor;
  final Color backgroundColor;
  final Widget child;

  const _BottomBarWrapper({
    required this.showDivider,
    required this.dividerThickness,
    required this.dividerColor,
    required this.backgroundColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Animated divider above bottom bar
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: showDivider ? dividerThickness : 0,
              color: showDivider ? dividerColor : Colors.transparent,
            ),
            child,
          ],
        ),
      ),
    );
  }
}
