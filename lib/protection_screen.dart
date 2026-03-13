// protection_screen.dart — Module Protection · Application Deenly
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'protection_data.dart';
import 'protection_versets_data.dart';
import 'protection_roqya_data.dart';
import 'protection_remedes_data.dart';
import 'protection_duas_data.dart';

// ── Palette ───────────────────────────────────────────────────────────────
const _kDeep     = Color(0xFF1A0A2E);
const _kPrimary  = Color(0xFF2D1B4E);
const _kMedium   = Color(0xFF5A3A8A);
const _kAccent   = Color(0xFFC8933A);
const _kAccentLt = Color(0xFFFFF4DC);
const _kBg       = Color(0xFFF6F0E3);
const _kCard     = Color(0xFFFFFFFF);
const _kBorder   = Color(0xFFD6C9AF);
const _kDark     = Color(0xFF1A130A);
const _kMid      = Color(0xFF5A4833);
const _kLight    = Color(0xFF8A7863);
const _kRed      = Color(0xFFD32F2F);
const _kRedLt    = Color(0xFFFFEBEE);

// ══════════════════════════════════════════════════════════════════════════
// ÉCRAN PRINCIPAL — Hub avec 6 sections
// ══════════════════════════════════════════════════════════════════════════
class ProtectionScreen extends StatelessWidget {
  const ProtectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      body: CustomScrollView(
        slivers: [
          // ── Header ────────────────────────────────────────────────────
          SliverAppBar(
            expandedHeight: 140,
            pinned: true,
            backgroundColor: _kDeep,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [_kDeep, _kPrimary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Text('\uD83D\uDEE1\uFE0F', style: TextStyle(fontSize: 28)),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('Protection',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    )),
                                SizedBox(height: 2),
                                Text('Roqya \u00b7 Versets \u00b7 Rem\u00e8des',
                                    style: TextStyle(
                                      color: Color(0xFFB8A0D0),
                                      fontSize: 12,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // ── SOS Button ────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 6),
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const _SosScreen()),
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [_kRed, Color(0xFFB71C1C)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: _kRed.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50, height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Center(
                          child: Text('\uD83C\uDD98', style: TextStyle(fontSize: 28)),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('SOS \u2014 Urgence Spirituelle',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(height: 3),
                            Text('Je me sens mal, que faire maintenant ?',
                                style: TextStyle(
                                  color: Color(0xFFFFCDD2),
                                  fontSize: 12,
                                )),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 18),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ── Sections Grid ─────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  // Section 1 — Comprendre
                  _SectionCard(
                    title: 'Comprendre',
                    emoji: '\uD83D\uDCDA',
                    description: 'Jinn, sorcellerie, mauvais oeil, waswas...',
                    color: const Color(0xFF4A2D7A),
                    colorLight: const Color(0xFFEDE7F6),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const _ComprendreScreen()),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Section 2 — Versets de Protection
                  _SectionCard(
                    title: 'Versets de Protection',
                    emoji: '\uD83D\uDCD6',
                    description: 'Ayat al-Kursi, Mu\'awwidhat, versets anti-sihr...',
                    color: const Color(0xFF1B4D38),
                    colorLight: const Color(0xFFE8F4EE),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const _VersetsScreen()),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Section 3 — Programmes de Roqya
                  _SectionCard(
                    title: 'Programmes de Roqya',
                    emoji: '\uD83D\uDCFF',
                    description: 'G\u00e9n\u00e9rale, mauvais oeil, sorcellerie, waswas...',
                    color: const Color(0xFF2D1B4E),
                    colorLight: const Color(0xFFF3ECFA),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const _RoqyaScreen()),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Section 4 — Remèdes Prophétiques
                  _SectionCard(
                    title: 'Rem\u00e8des Proph\u00e9tiques',
                    emoji: '\uD83C\uDF3F',
                    description: 'Miel, nigelle, hijama, sidr, eau coranis\u00e9e...',
                    color: const Color(0xFF5A3A1A),
                    colorLight: const Color(0xFFF5EDE0),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const _RemedesScreen()),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Section 5 — Invocations de Protection
                  _SectionCard(
                    title: 'Invocations de Protection',
                    emoji: '\uD83E\uDD32',
                    description: 'Matin, maison, couple, enfants, cauchemars...',
                    color: const Color(0xFFC8933A),
                    colorLight: const Color(0xFFFFF4DC),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const _DuasProtScreen()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Section Card Widget ─────────────────────────────────────────────────
class _SectionCard extends StatelessWidget {
  final String title;
  final String emoji;
  final String description;
  final Color color;
  final Color colorLight;
  final VoidCallback onTap;

  const _SectionCard({
    required this.title,
    required this.emoji,
    required this.description,
    required this.color,
    required this.colorLight,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: _kCard,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: _kBorder, width: 1.2),
          boxShadow: const [
            BoxShadow(color: Color(0x0E000000), blurRadius: 8, offset: Offset(0, 2)),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 50, height: 50,
              decoration: BoxDecoration(
                color: colorLight,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: color.withOpacity(0.2)),
              ),
              alignment: Alignment.center,
              child: Text(emoji, style: const TextStyle(fontSize: 24)),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                        color: color,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      )),
                  const SizedBox(height: 3),
                  Text(description,
                      style: const TextStyle(color: _kLight, fontSize: 11),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: _kLight.withOpacity(0.6), size: 20),
          ],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
// SOS SCREEN
// ══════════════════════════════════════════════════════════════════════════
class _SosScreen extends StatelessWidget {
  const _SosScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      appBar: AppBar(
        backgroundColor: _kRed,
        foregroundColor: Colors.white,
        title: const Text('\uD83C\uDD98 Urgence Spirituelle'),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(14),
        itemCount: kSosSteps.length,
        itemBuilder: (ctx, i) {
          final step = kSosSteps[i];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _kCard,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: i == 0 ? _kRed.withOpacity(0.3) : _kBorder),
                boxShadow: const [
                  BoxShadow(color: Color(0x10000000), blurRadius: 5, offset: Offset(0, 2)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 36, height: 36,
                        decoration: BoxDecoration(
                          color: i == 0 ? _kRedLt : _kAccentLt,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(step.emoji, style: const TextStyle(fontSize: 18)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Row(
                          children: [
                            Container(
                              width: 24, height: 24,
                              decoration: BoxDecoration(
                                color: _kMedium,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '${i + 1}',
                                  style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(step.title,
                                  style: const TextStyle(
                                    color: _kDark,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(step.instruction,
                      style: const TextStyle(color: _kMid, fontSize: 13, height: 1.6)),
                  if (step.arabic != null) ...[
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _kAccentLt,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Text(step.arabic!,
                              style: const TextStyle(
                                color: _kDark,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                height: 1.8,
                              ),
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.rtl),
                          if (step.phonetic != null) ...[
                            const SizedBox(height: 6),
                            Text(step.phonetic!,
                                style: const TextStyle(
                                  color: _kAccent,
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                ),
                                textAlign: TextAlign.center),
                          ],
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
// COMPRENDRE SCREEN — Articles éducatifs
// ══════════════════════════════════════════════════════════════════════════
class _ComprendreScreen extends StatelessWidget {
  const _ComprendreScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      appBar: AppBar(
        backgroundColor: _kDeep,
        foregroundColor: Colors.white,
        title: const Text('\uD83D\uDCDA Comprendre'),
        elevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(14),
        itemCount: kProtectionArticles.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (ctx, i) {
          final article = kProtectionArticles[i];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => _ArticleDetailScreen(article: article)),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: _kCard,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: _kBorder),
                boxShadow: const [
                  BoxShadow(color: Color(0x0E000000), blurRadius: 8, offset: Offset(0, 2)),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 48, height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDE7F6),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    alignment: Alignment.center,
                    child: Text(article.emoji, style: const TextStyle(fontSize: 22)),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(article.title,
                            style: const TextStyle(
                              color: _kDark,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            )),
                        const SizedBox(height: 3),
                        Text(article.subtitle,
                            style: const TextStyle(color: _kLight, fontSize: 11)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDE7F6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('${article.sections.length}',
                        style: const TextStyle(
                          color: _kMedium,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        )),
                  ),
                  const SizedBox(width: 4),
                  Icon(Icons.chevron_right_rounded, color: _kLight.withOpacity(0.6), size: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ArticleDetailScreen extends StatelessWidget {
  final ProtectionArticle article;
  const _ArticleDetailScreen({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      appBar: AppBar(
        backgroundColor: _kDeep,
        foregroundColor: Colors.white,
        title: Text('${article.emoji} ${article.title}'),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(14),
        itemCount: article.sections.length,
        itemBuilder: (ctx, i) {
          final section = article.sections[i];
          return Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _kCard,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: _kBorder),
                boxShadow: const [
                  BoxShadow(color: Color(0x10000000), blurRadius: 5, offset: Offset(0, 2)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(section.heading,
                      style: const TextStyle(
                        color: _kMedium,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      )),
                  const SizedBox(height: 10),
                  Text(section.body,
                      style: const TextStyle(
                        color: _kMid,
                        fontSize: 13,
                        height: 1.7,
                      )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
// VERSETS SCREEN
// ══════════════════════════════════════════════════════════════════════════
class _VersetsScreen extends StatelessWidget {
  const _VersetsScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      appBar: AppBar(
        backgroundColor: _kDeep,
        foregroundColor: Colors.white,
        title: const Text('\uD83D\uDCD6 Versets de Protection'),
        elevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(14),
        itemCount: kVersetsProtection.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (ctx, i) {
          final v = kVersetsProtection[i];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => _VersetDetailScreen(verset: v)),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: _kCard,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: _kBorder),
                boxShadow: const [
                  BoxShadow(color: Color(0x0E000000), blurRadius: 8, offset: Offset(0, 2)),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 48, height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F4EE),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    alignment: Alignment.center,
                    child: Text(v.emoji, style: const TextStyle(fontSize: 22)),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(v.title,
                            style: const TextStyle(
                              color: Color(0xFF1B4D38),
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            )),
                        const SizedBox(height: 3),
                        Text(v.reference,
                            style: const TextStyle(color: _kLight, fontSize: 11)),
                      ],
                    ),
                  ),
                  if (v.repeat > 1)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _kAccentLt,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text('\u00d7${v.repeat}',
                          style: const TextStyle(color: _kAccent, fontSize: 10, fontWeight: FontWeight.w700)),
                    ),
                  const SizedBox(width: 4),
                  Icon(Icons.chevron_right_rounded, color: _kLight.withOpacity(0.6), size: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _VersetDetailScreen extends StatelessWidget {
  final VersetProtection verset;
  const _VersetDetailScreen({required this.verset});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      appBar: AppBar(
        backgroundColor: _kDeep,
        foregroundColor: Colors.white,
        title: Text('${verset.emoji} ${verset.title}'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            // Arabic
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [_kDeep, _kPrimary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  Text(verset.arabic,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        height: 2.0,
                      ),
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl),
                  const SizedBox(height: 14),
                  Text(verset.reference,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 12,
                      )),
                ],
              ),
            ),
            const SizedBox(height: 14),
            // Phonetic
            _DetailCard(
              label: 'Phon\u00e9tique',
              child: Text(verset.phonetic,
                  style: const TextStyle(color: _kAccent, fontSize: 13, fontStyle: FontStyle.italic, height: 1.6)),
            ),
            const SizedBox(height: 10),
            // Translation
            _DetailCard(
              label: 'Traduction',
              child: Text(verset.translation,
                  style: const TextStyle(color: _kMid, fontSize: 13, height: 1.6)),
            ),
            const SizedBox(height: 10),
            // Power
            _DetailCard(
              label: 'Puissance de ce verset',
              child: Text(verset.power,
                  style: const TextStyle(color: _kMid, fontSize: 13, height: 1.6)),
            ),
            const SizedBox(height: 10),
            // When to recite
            _DetailCard(
              label: 'Quand le r\u00e9citer',
              child: Row(
                children: [
                  const Icon(Icons.access_time, color: _kAccent, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(verset.whenToRecite,
                        style: const TextStyle(color: _kMid, fontSize: 13, height: 1.4)),
                  ),
                ],
              ),
            ),
            if (verset.repeat > 1) ...[
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: _kAccentLt,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.repeat, color: _kAccent, size: 18),
                    const SizedBox(width: 8),
                    Text('R\u00e9p\u00e9ter \u00d7${verset.repeat}',
                        style: const TextStyle(color: _kAccent, fontSize: 14, fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _DetailCard extends StatelessWidget {
  final String label;
  final Widget child;
  const _DetailCard({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(color: _kMedium, fontSize: 12, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
// ROQYA SCREEN
// ══════════════════════════════════════════════════════════════════════════
class _RoqyaScreen extends StatelessWidget {
  const _RoqyaScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      appBar: AppBar(
        backgroundColor: _kDeep,
        foregroundColor: Colors.white,
        title: const Text('\uD83D\uDCFF Programmes de Roqya'),
        elevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(14),
        itemCount: kRoqyaPrograms.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (ctx, i) {
          final prog = kRoqyaPrograms[i];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => _RoqyaDetailScreen(program: prog)),
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _kCard,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: _kBorder),
                boxShadow: const [
                  BoxShadow(color: Color(0x0E000000), blurRadius: 8, offset: Offset(0, 2)),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 50, height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3ECFA),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    alignment: Alignment.center,
                    child: Text(prog.emoji, style: const TextStyle(fontSize: 24)),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(prog.title,
                            style: const TextStyle(
                              color: _kDark,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            )),
                        const SizedBox(height: 3),
                        Text(prog.description,
                            style: const TextStyle(color: _kLight, fontSize: 11),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3ECFA),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(prog.duration,
                            style: const TextStyle(color: _kMedium, fontSize: 9, fontWeight: FontWeight.w600)),
                      ),
                      const SizedBox(height: 4),
                      Text('${prog.steps.length} \u00e9tapes',
                          style: const TextStyle(color: _kLight, fontSize: 9)),
                    ],
                  ),
                  const SizedBox(width: 4),
                  Icon(Icons.chevron_right_rounded, color: _kLight.withOpacity(0.6), size: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _RoqyaDetailScreen extends StatelessWidget {
  final RoqyaProgram program;
  const _RoqyaDetailScreen({required this.program});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      appBar: AppBar(
        backgroundColor: _kDeep,
        foregroundColor: Colors.white,
        title: Text('${program.emoji} ${program.title}'),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          // Intro
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFF3ECFA),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _kMedium.withOpacity(0.2)),
            ),
            child: Text(program.intro,
                style: const TextStyle(color: _kMid, fontSize: 13, height: 1.6)),
          ),
          const SizedBox(height: 16),
          // Steps
          ...List.generate(program.steps.length, (i) {
            final step = program.steps[i];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: _kCard,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: _kBorder),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 28, height: 28,
                          decoration: const BoxDecoration(
                            color: _kMedium,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text('${i + 1}',
                                style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(step.instruction,
                              style: const TextStyle(color: _kDark, fontSize: 13, height: 1.5)),
                        ),
                        if (step.repeat > 1)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: _kAccentLt,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text('\u00d7${step.repeat}',
                                style: const TextStyle(color: _kAccent, fontSize: 11, fontWeight: FontWeight.w700)),
                          ),
                      ],
                    ),
                    if (step.reference != null) ...[
                      const SizedBox(height: 6),
                      Padding(
                        padding: const EdgeInsets.only(left: 38),
                        child: Text(step.reference!,
                            style: const TextStyle(color: _kLight, fontSize: 11, fontStyle: FontStyle.italic)),
                      ),
                    ],
                    if (step.arabic != null) ...[
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: _kAccentLt,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text(step.arabic!,
                                style: const TextStyle(
                                  color: _kDark,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  height: 1.8,
                                ),
                                textAlign: TextAlign.center,
                                textDirection: TextDirection.rtl),
                            if (step.phonetic != null) ...[
                              const SizedBox(height: 6),
                              Text(step.phonetic!,
                                  style: const TextStyle(
                                    color: _kAccent,
                                    fontSize: 12,
                                    fontStyle: FontStyle.italic,
                                  ),
                                  textAlign: TextAlign.center),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
// REMÈDES SCREEN
// ══════════════════════════════════════════════════════════════════════════
class _RemedesScreen extends StatelessWidget {
  const _RemedesScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      appBar: AppBar(
        backgroundColor: _kDeep,
        foregroundColor: Colors.white,
        title: const Text('\uD83C\uDF3F Rem\u00e8des Proph\u00e9tiques'),
        elevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(14),
        itemCount: kRemedesProphetiques.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (ctx, i) {
          final r = kRemedesProphetiques[i];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => _RemedeDetailScreen(remede: r)),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: _kCard,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: _kBorder),
                boxShadow: const [
                  BoxShadow(color: Color(0x0E000000), blurRadius: 8, offset: Offset(0, 2)),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 48, height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5EDE0),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    alignment: Alignment.center,
                    child: Text(r.emoji, style: const TextStyle(fontSize: 22)),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(r.name,
                            style: const TextStyle(
                              color: Color(0xFF5A3A1A),
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            )),
                        const SizedBox(height: 2),
                        Text(r.arabicName,
                            style: const TextStyle(color: _kAccent, fontSize: 12)),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right_rounded, color: _kLight.withOpacity(0.6), size: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _RemedeDetailScreen extends StatelessWidget {
  final RemedeProphetique remede;
  const _RemedeDetailScreen({required this.remede});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      appBar: AppBar(
        backgroundColor: _kDeep,
        foregroundColor: Colors.white,
        title: Text('${remede.emoji} ${remede.name}'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF5A3A1A), Color(0xFF7A5A2A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  Text(remede.emoji, style: const TextStyle(fontSize: 48)),
                  const SizedBox(height: 8),
                  Text(remede.arabicName,
                      style: const TextStyle(color: _kAccent, fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(remede.name,
                      style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            const SizedBox(height: 14),
            _DetailCard(label: 'Description', child: Text(remede.description, style: const TextStyle(color: _kMid, fontSize: 13, height: 1.6))),
            const SizedBox(height: 10),
            _DetailCard(
              label: 'Hadith',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(remede.hadith, style: const TextStyle(color: _kMid, fontSize: 13, height: 1.6, fontStyle: FontStyle.italic)),
                  const SizedBox(height: 6),
                  Text(remede.hadithSource, style: const TextStyle(color: _kLight, fontSize: 11)),
                ],
              ),
            ),
            const SizedBox(height: 10),
            _DetailCard(label: 'Utilisation', child: Text(remede.utilisation, style: const TextStyle(color: _kMid, fontSize: 13, height: 1.6))),
            const SizedBox(height: 10),
            _DetailCard(
              label: 'Bienfaits',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: remede.bienfaits.map((b) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('\u2714 ', style: TextStyle(color: _kAccent, fontSize: 12)),
                      Expanded(child: Text(b, style: const TextStyle(color: _kMid, fontSize: 12.5, height: 1.4))),
                    ],
                  ),
                )).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
// DUAS DE PROTECTION SCREEN
// ══════════════════════════════════════════════════════════════════════════
class _DuasProtScreen extends StatelessWidget {
  const _DuasProtScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      appBar: AppBar(
        backgroundColor: _kDeep,
        foregroundColor: Colors.white,
        title: const Text('\uD83E\uDD32 Invocations de Protection'),
        elevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(14),
        itemCount: kDuasProtection.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (ctx, i) {
          final cat = kDuasProtection[i];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => _DuaCatDetailScreen(category: cat)),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: _kCard,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: _kBorder),
                boxShadow: const [
                  BoxShadow(color: Color(0x0E000000), blurRadius: 8, offset: Offset(0, 2)),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 48, height: 48,
                    decoration: BoxDecoration(
                      color: _kAccentLt,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    alignment: Alignment.center,
                    child: Text(cat.emoji, style: const TextStyle(fontSize: 22)),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(cat.title,
                            style: const TextStyle(color: _kAccent, fontSize: 14, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 3),
                        Text(cat.description,
                            style: const TextStyle(color: _kLight, fontSize: 11)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _kAccentLt,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('${cat.duas.length}',
                        style: const TextStyle(color: _kAccent, fontSize: 10, fontWeight: FontWeight.w700)),
                  ),
                  const SizedBox(width: 4),
                  Icon(Icons.chevron_right_rounded, color: _kLight.withOpacity(0.6), size: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _DuaCatDetailScreen extends StatelessWidget {
  final DuaCategory category;
  const _DuaCatDetailScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      appBar: AppBar(
        backgroundColor: _kDeep,
        foregroundColor: Colors.white,
        title: Text('${category.emoji} ${category.title}'),
        elevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(14),
        itemCount: category.duas.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (ctx, i) {
          final dua = category.duas[i];
          return Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _kBorder),
              boxShadow: const [
                BoxShadow(color: Color(0x10000000), blurRadius: 5, offset: Offset(0, 2)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(dua.arabic,
                    style: const TextStyle(
                      color: _kDark,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      height: 1.8,
                    ),
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl),
                const SizedBox(height: 8),
                Text(dua.phonetic,
                    style: const TextStyle(color: _kAccent, fontSize: 13, fontStyle: FontStyle.italic),
                    textAlign: TextAlign.left),
                const SizedBox(height: 6),
                Text(dua.translation,
                    style: const TextStyle(color: _kMid, fontSize: 12.5, height: 1.6)),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(dua.source,
                        style: const TextStyle(color: _kLight, fontSize: 11, fontStyle: FontStyle.italic)),
                    if (dua.repeat > 1)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: _kAccentLt,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text('\u00d7${dua.repeat}',
                            style: const TextStyle(color: _kAccent, fontSize: 12, fontWeight: FontWeight.w600)),
                      ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
