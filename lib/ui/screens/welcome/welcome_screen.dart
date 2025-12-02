import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../auth/login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  // --- PALETA DE COLORES MEJORADA ---
  static const Color primaryColor = Color(0xFF5B2273);
  static const Color primaryLight = Color(0xFF7B3A93);
  static const Color secondaryColor = Color(0xFFFAFAFA);
  static const Color accentColor = Color(0xFFE91E63);

  // --- IMÁGENES DEL CARRUSEL ---
  final List<String> _demoImages = const [
    'https://images.unsplash.com/photo-1503220317375-aaad61436b1b?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
    'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?ixlib=rb-1.2.1&auto=format&fit=crop&w=1353&q=80',
    'https://images.unsplash.com/photo-1519055548599-6d4d129508c4?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
    'https://images.unsplash.com/photo-1682687982501-1e58ab814714?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: secondaryColor,
      
      // --- NAVBAR MEJORADO Y MÁS LLAMATIVO ---
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100), // <--- MODIFICADO: Más alto para el logo
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, secondaryColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            boxShadow: [
              BoxShadow(
                color: primaryColor.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              child: Row(
                children: [
                  // --- LOGO SOLITARIO Y GRANDE ---
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withOpacity(0.15),
                            blurRadius: 15,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 70, // <--- MODIFICADO: Logo más grande
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => 
                            const Icon(Icons.travel_explore, color: primaryColor, size: 60),
                      ),
                    ),
                  ),
                  // Se eliminó el texto "Aventour" aquí
                  
                  const Spacer(),
                  
                  if (size.width > 800) ...[
                    _NavBarItem(title: 'Inicio', onTap: () {}, isActive: true),
                    _NavBarItem(title: 'Destinos', onTap: () {}),
                    _NavBarItem(title: 'Agencias', onTap: () {}),
                    const SizedBox(width: 16),
                  ],
                  // Botón de login
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      gradient: const LinearGradient(
                        colors: [primaryColor, primaryLight],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: primaryColor.withOpacity(0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginScreen()),
                          );
                        },
                        borderRadius: BorderRadius.circular(14),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          child: Row(
                            children: [
                              Icon(Icons.person_outline, color: Colors.white, size: 20),
                              SizedBox(width: 8),
                              Text(
                                'Iniciar Sesión',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      // --- CUERPO ---
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- HERO SECTION ---
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    secondaryColor,
                    Colors.white,
                  ],
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // --- CARRUSEL CON MARCO ANIMADO ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: _AnimatedPurpleBorderContainer( // <--- MODIFICADO: Widget animado
                      primaryColor: primaryColor,
                      child: _EnhancedCarousel(
                        images: _demoImages,
                        primaryColor: primaryColor,
                      ),
                    ),
                  ),

                  const SizedBox(height: 60),

                  // Descripción mejorada
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 700),
                      child: Text(
                        'Planifica viajes inolvidables, encuentra rutas exclusivas\ny conecta con agencias certificadas de todo el mundo.',
                        textAlign: TextAlign.center,
                        style: textTheme.titleMedium?.copyWith(
                          color: Colors.grey[600],
                          height: 1.6,
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // CTA Button
                  _GradientButton(
                    onPressed: () {},
                    text: 'EMPIEZA TU EXPERIENCIA',
                  ),
                  
                  const SizedBox(height: 80),
                ],
              ),
            ),

            // --- SECCIÓN DE CARACTERÍSTICAS ---
            Container(
              padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 24),
              color: Colors.white,
              width: double.infinity,
              child: Column(
                children: [
                  Text(
                    'Tu viaje perfecto te espera',
                    style: textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Descubre por qué miles de viajeros confían en nosotros',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 60),
                  
                  Wrap(
                    spacing: 32,
                    runSpacing: 32,
                    alignment: WrapAlignment.center,
                    children: const [
                      _EnhancedFeatureCard(
                        icon: Icons.diamond_outlined,
                        title: 'Destinos Exclusivos',
                        description: 'Acceso a lugares seleccionados por su calidad y prestigio.',
                        color: primaryColor,
                        gradient: [Color(0xFF5B2273), Color(0xFF7B3A93)],
                      ),
                      _EnhancedFeatureCard(
                        icon: Icons.map_outlined,
                        title: 'Rutas a Medida',
                        description: 'Itinerarios personalizados diseñados para viajeros exigentes.',
                        color: Color(0xFFE91E63),
                        gradient: [Color(0xFFE91E63), Color(0xFFF48FB1)],
                      ),
                      _EnhancedFeatureCard(
                        icon: Icons.verified_user_outlined,
                        title: 'Agencias Premium',
                        description: 'Conecta solo con servicios certificados y de alta categoría.',
                        color: Color(0xFF9C27B0),
                        gradient: [Color(0xFF9C27B0), Color(0xFFBA68C8)],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // --- FOOTER ---
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF5B2273), Color(0xFF3A1548)],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 32),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.travel_explore, color: Colors.white, size: 28),
                        SizedBox(width: 12),
                        Text(
                          'Aventour',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      '© 2025 Aventour Inc. Todos los derechos reservados.',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================= WIDGETS MEJORADOS =================

// --- NUEVO: Contenedor con borde morado animado ---
class _AnimatedPurpleBorderContainer extends StatefulWidget {
  final Widget child;
  final Color primaryColor;

  const _AnimatedPurpleBorderContainer({required this.child, required this.primaryColor});

  @override
  State<_AnimatedPurpleBorderContainer> createState() => __AnimatedPurpleBorderContainerState();
}

class __AnimatedPurpleBorderContainerState extends State<_AnimatedPurpleBorderContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.all(6.0), // Grosor del borde animado
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), 
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.lerp(widget.primaryColor, Colors.purpleAccent, _controller.value)!,
                Color.lerp(Colors.deepPurple.shade900, widget.primaryColor, _controller.value)!,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: widget.primaryColor.withOpacity(0.3 + (_controller.value * 0.2)),
                blurRadius: 20,
                offset: const Offset(0, 10),
              )
            ],
          ),
          child: child, // El contenido (carrusel) va aquí adentro
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.antiAlias,
        child: widget.child,
      ),
    );
  }
}

// --- Carrusel mejorado con indicadores ---
class _EnhancedCarousel extends StatefulWidget {
  final List<String> images;
  final Color primaryColor;

  const _EnhancedCarousel({required this.images, required this.primaryColor});

  @override
  State<_EnhancedCarousel> createState() => _EnhancedCarouselState();
}

class _EnhancedCarouselState extends State<_EnhancedCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 500.0, // Altura del carrusel
                  autoPlay: true,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                  autoPlayInterval: const Duration(seconds: 5),
                  autoPlayAnimationDuration: const Duration(milliseconds: 1000),
                  autoPlayCurve: Curves.easeInOutCubic,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                items: widget.images.map((imageUrl) {
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (ctx, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: Colors.grey[200],
                            child: Center(
                              child: CircularProgressIndicator(
                                color: widget.primaryColor,
                              ),
                            ),
                          );
                        },
                      ),
                      // Overlay gradient
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.3),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        // Indicadores (Puntos)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.images.asMap().entries.map((entry) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: _currentIndex == entry.key ? 30 : 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: _currentIndex == entry.key
                    ? widget.primaryColor
                    : Colors.grey.shade300,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

// --- Botón gradient mejorado ---
class _GradientButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const _GradientButton({required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF5B2273), Color(0xFF7B3A93)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF5B2273).withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward, color: Colors.white, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --- Item de navegación mejorado ---
class _NavBarItem extends StatefulWidget {
  final String title;
  final VoidCallback onTap;
  final bool isActive;

  const _NavBarItem({
    required this.title,
    required this.onTap,
    this.isActive = false,
  });

  @override
  State<_NavBarItem> createState() => _NavBarItemState();
}

class _NavBarItemState extends State<_NavBarItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  color: widget.isActive || _isHovered
                      ? WelcomeScreen.primaryColor
                      : Colors.grey[700],
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2,
                width: _isHovered || widget.isActive ? 20 : 0,
                decoration: BoxDecoration(
                  color: WelcomeScreen.primaryColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Feature card mejorada ---
class _EnhancedFeatureCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final List<Color> gradient;

  const _EnhancedFeatureCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.gradient,
  });

  @override
  State<_EnhancedFeatureCard> createState() => _EnhancedFeatureCardState();
}

class _EnhancedFeatureCardState extends State<_EnhancedFeatureCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 340,
        padding: const EdgeInsets.all(36),
        transform: Matrix4.translationValues(0, _isHovered ? -8 : 0, 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _isHovered ? widget.color.withOpacity(0.3) : Colors.grey.shade200,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? widget.color.withOpacity(0.2)
                  : Colors.black.withOpacity(0.05),
              blurRadius: _isHovered ? 30 : 15,
              offset: Offset(0, _isHovered ? 15 : 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: widget.gradient),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: widget.color.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Icon(widget.icon, size: 36, color: Colors.white),
            ),
            const SizedBox(height: 24),
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: widget.color,
                letterSpacing: -0.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              widget.description,
              style: TextStyle(
                color: Colors.grey[600],
                height: 1.6,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}