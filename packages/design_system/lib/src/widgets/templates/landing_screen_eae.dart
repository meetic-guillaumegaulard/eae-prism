import 'package:flutter/material.dart';
import '../../theme/brand_theme_extensions.dart';
import '../../brands/brand_config.dart' show LandingLogoAlignment;
import '../atoms/button_eae.dart';

/// Configuration pour le landing screen
class LandingScreenConfig {
  /// Image de fond mobile
  final ImageProvider? backgroundImageMobile;
  
  /// Image de fond desktop
  final ImageProvider? backgroundImageDesktop;
  
  /// Logo en mode large (pour mobile)
  final Widget? logoLarge;
  
  /// Logo en mode small (pour le bandeau desktop)
  final Widget? logoSmall;
  
  /// Texte du bouton dans le bandeau desktop
  final String? topBarButtonText;
  
  /// Callback du bouton dans le bandeau desktop
  final VoidCallback? onTopBarButtonPressed;

  const LandingScreenConfig({
    this.backgroundImageMobile,
    this.backgroundImageDesktop,
    this.logoLarge,
    this.logoSmall,
    this.topBarButtonText,
    this.onTopBarButtonPressed,
  });
}

/// Template component for landing screens with responsive layout
/// 
/// Mobile mode:
/// - Full screen background image
/// - Large logo with configurable alignment and padding
/// - Content below the logo
/// - Fixed bottom bar for actions
/// 
/// Desktop mode:
/// - Full screen background image
/// - Fixed top bar with small logo and outline button
/// - Centered card with shadow containing the content
class LandingScreenEAE extends StatelessWidget {
  /// Configuration for images and logos
  final LandingScreenConfig config;
  
  /// Main content (displayed below logo on mobile, inside card on desktop)
  final Widget content;
  
  /// Fixed bottom bar content (mobile only)
  final Widget? bottomBar;

  const LandingScreenEAE({
    super.key,
    required this.config,
    required this.content,
    this.bottomBar,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<BrandLandingScreenTheme>();
    final breakpoint = theme?.mobileBreakpoint ?? 600.0;
    
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < breakpoint;
        
        return isMobile 
            ? _buildMobileLayout(context, theme)
            : _buildDesktopLayout(context, theme);
      },
    );
  }

  Widget _buildMobileLayout(BuildContext context, BrandLandingScreenTheme? theme) {
    final alignment = theme?.mobileLogoAlignment ?? LandingLogoAlignment.center;
    final paddingTop = theme?.mobileLogoPaddingTop ?? 60.0;
    final paddingBottom = theme?.mobileLogoPaddingBottom ?? 32.0;
    final paddingHorizontal = theme?.mobileLogoPaddingHorizontal ?? 24.0;
    final backgroundColor = theme?.mobileBackgroundColor;

    CrossAxisAlignment crossAlignment;
    switch (alignment) {
      case LandingLogoAlignment.left:
        crossAlignment = CrossAxisAlignment.start;
      case LandingLogoAlignment.right:
        crossAlignment = CrossAxisAlignment.end;
      case LandingLogoAlignment.center:
        crossAlignment = CrossAxisAlignment.center;
    }

    return Scaffold(
      backgroundColor: config.backgroundImageMobile == null ? backgroundColor : null,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image (only if provided)
          if (config.backgroundImageMobile != null)
            Image(
              image: config.backgroundImageMobile!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          
          // Content
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: crossAlignment,
                      children: [
                        // Logo with padding
                        if (config.logoLarge != null)
                          Padding(
                            padding: EdgeInsets.only(
                              top: paddingTop,
                              bottom: paddingBottom,
                              left: paddingHorizontal,
                              right: paddingHorizontal,
                            ),
                            child: config.logoLarge!,
                          ),
                        
                        // Content below logo
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
                          child: content,
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Fixed bottom bar
                if (bottomBar != null) bottomBar!,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, BrandLandingScreenTheme? theme) {
    final topBarHeight = theme?.desktopTopBarHeight ?? 64.0;
    final topBarPaddingH = theme?.desktopTopBarPaddingHorizontal ?? 24.0;
    final topBarPaddingV = theme?.desktopTopBarPaddingVertical ?? 12.0;
    final topBarBackgroundColor = theme?.desktopTopBarBackgroundColor;
    final topBarBoxShadow = theme?.desktopTopBarBoxShadow;
    final cardMaxWidth = theme?.desktopCardMaxWidth ?? 480.0;
    final cardBorderRadius = theme?.desktopCardBorderRadius ?? 16.0;
    final cardElevation = theme?.desktopCardElevation ?? 8.0;
    final cardPadding = theme?.desktopCardPadding ?? const EdgeInsets.all(32.0);
    final cardBackgroundColor = theme?.desktopCardBackgroundColor ?? Colors.white;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          if (config.backgroundImageDesktop != null)
            Image(
              image: config.backgroundImageDesktop!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          
          // Content overlay
          Column(
            children: [
              // Top bar with optional background and shadow
              Container(
                height: topBarHeight,
                padding: EdgeInsets.symmetric(horizontal: topBarPaddingH, vertical: topBarPaddingV),
                decoration: BoxDecoration(
                  color: topBarBackgroundColor,
                  boxShadow: topBarBoxShadow != null ? [topBarBoxShadow] : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Small logo on the left
                    if (config.logoSmall != null) config.logoSmall!,
                    const Spacer(),
                    
                    // Outline button on the right
                    if (config.topBarButtonText != null)
                      ButtonEAE(
                        label: config.topBarButtonText!,
                        variant: ButtonEAEVariant.outline,
                        onPressed: config.onTopBarButtonPressed,
                      ),
                  ],
                ),
              ),
              
              // Centered card
              Expanded(
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: cardMaxWidth),
                    child: SingleChildScrollView(
                      child: Card(
                        elevation: cardElevation,
                        color: cardBackgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(cardBorderRadius),
                        ),
                        child: Padding(
                          padding: cardPadding,
                          child: content,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

