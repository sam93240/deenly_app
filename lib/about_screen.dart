// about_screen.dart
// Écran À propos — Application UpYourDeen

import 'package:flutter/material.dart';
import 'app_locale.dart';
import 'translations.dart';

// ── Palette ──────────────────────────────────────────────────────────
const _kGreen = Color(0xFF1B4D38);
const _kGreenMd = Color(0xFF2A7A52);
const _kGold = Color(0xFFC8933A);
const _kBeige = Color(0xFFF6F0E3);
const _kCard = Color(0xFFFDFAF4);
const _kTxtDk = Color(0xFF1A130A);
const _kTxtMd = Color(0xFF5A4833);
const _kTxtLt = Color(0xFF8A7863);

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF121212) : _kBeige;
    final cardColor = isDark ? const Color(0xFF1E1E1E) : _kCard;
    final txtDk = isDark ? Colors.white : _kTxtDk;
    final txtMd = isDark ? Colors.white70 : _kTxtMd;
    final txtLt = isDark ? Colors.white54 : _kTxtLt;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(context.t.aboutTitle),
        backgroundColor: _kGreen,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 12),

          // ── Logo + Nom ──
          Center(
            child: Container(
              width: 90, height: 90,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [_kGreen, _kGreenMd],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: _kGreen.withValues(alpha: 0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Center(
                child: Text('ديني',
                  style: TextStyle(
                    fontSize: 32, fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text('UpYourDeen',
              style: TextStyle(
                fontSize: 28, fontWeight: FontWeight.w800,
                color: txtDk, letterSpacing: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Center(
            child: Text(context.t.appSlogan,
              style: TextStyle(
                fontSize: 14, color: _kGold,
                fontWeight: FontWeight.w500, fontStyle: FontStyle.italic,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Center(
            child: Text('Version 1.0.0',
              style: TextStyle(fontSize: 12, color: txtLt),
            ),
          ),

          const SizedBox(height: 32),

          // ── Mission ──
          _AboutCard(
            cardColor: cardColor,
            icon: Icons.mosque_rounded,
            iconColor: _kGreen,
            title: context.t.aboutMission,
            titleColor: txtDk,
            content: AppLocaleScope.of(context).tr(
              'UpYourDeen est une application gratuite conçue pour accompagner chaque musulman(e) dans son cheminement spirituel. Apprendre le Coran, comprendre les hadiths, renforcer sa foi et éduquer sa famille — tout cela dans une seule app, avec bienveillance et respect.',
              'UpYourDeen is a free app designed to accompany every Muslim on their spiritual journey. Learn the Quran, understand hadith, strengthen your faith, and educate your family — all in one app, with kindness and respect.'
            ),
            contentColor: txtMd,
          ),

          const SizedBox(height: 16),

          // ── Valeurs ──
          _AboutCard(
            cardColor: cardColor,
            icon: Icons.favorite_rounded,
            iconColor: const Color(0xFFE57373),
            title: context.t.aboutValues,
            titleColor: txtDk,
            content: AppLocaleScope.of(context).tr(
              'Pas de publicité. Pas de collecte de données personnelles. Pas de contenu douteux. UpYourDeen est un projet de Sadaqa Jariya — une aumône continue dont les récompenses perdurent, insha\'Allah.',
              'No ads. No personal data collection. No doubtful content. UpYourDeen is a Sadaqa Jariya project — continuous charity whose rewards endure, insha\'Allah.'
            ),
            contentColor: txtMd,
          ),

          const SizedBox(height: 16),

          // ── Sources ──
          _AboutCard(
            cardColor: cardColor,
            icon: Icons.menu_book_rounded,
            iconColor: _kGold,
            title: context.t.aboutSources,
            titleColor: txtDk,
            content: AppLocaleScope.of(context).tr(
              'Le contenu de UpYourDeen provient de sources authentiques :\n• Coran : Mushaf Uthmani (Hafs)\n• Hadiths : Sahih al-Bukhari, Sahih Muslim, Sunan compilations\n• Adhkar : Hisnul Muslim (La Citadelle du Musulman)\n• Fiqh : Les quatre écoles de jurisprudence\n\nNous nous efforçons de vérifier chaque contenu. Si tu trouves une erreur, contacte-nous.',
              'UpYourDeen content comes from authentic sources:\n• Quran: Mushaf Uthmani (Hafs)\n• Hadith: Sahih al-Bukhari, Sahih Muslim, Sunan compilations\n• Adhkar: Hisnul Muslim (Fortress of the Muslim)\n• Fiqh: The four schools of jurisprudence\n\nWe strive to verify every piece of content. If you find an error, contact us.'
            ),
            contentColor: txtMd,
          ),

          const SizedBox(height: 16),

          // ── Contact ──
          _AboutCard(
            cardColor: cardColor,
            icon: Icons.email_rounded,
            iconColor: const Color(0xFF5C5CFF),
            title: context.t.aboutContact,
            titleColor: txtDk,
            content: AppLocaleScope.of(context).tr(
              'Une question, une suggestion, ou tu veux contribuer ?\n\ncontact@upyourdeen.com\n\nQu\'Allah récompense tous ceux qui contribuent à ce projet.',
              'A question, a suggestion, or want to contribute?\n\ncontact@upyourdeen.com\n\nMay Allah reward all those who contribute to this project.'
            ),
            contentColor: txtMd,
          ),

          const SizedBox(height: 32),

          // ── Copyright ──
          Center(
            child: Column(
              children: [
                Text('بسم الله الرحمن الرحيم',
                  style: TextStyle(fontSize: 16, color: _kGold, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 12),
                Text(context.t.settingsCopyright,
                  style: TextStyle(fontSize: 12, color: txtLt),
                ),
                const SizedBox(height: 4),
                Text(context.t.aboutFooter,
                  style: TextStyle(fontSize: 11, color: txtLt, fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

// ── Carte réutilisable ──────────────────────────────────────────────

class _AboutCard extends StatelessWidget {
  final Color cardColor;
  final IconData icon;
  final Color iconColor;
  final String title;
  final Color titleColor;
  final String content;
  final Color contentColor;

  const _AboutCard({
    required this.cardColor,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.titleColor,
    required this.content,
    required this.contentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
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
                  color: iconColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 18, color: iconColor),
              ),
              const SizedBox(width: 12),
              Text(title, style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w700, color: titleColor,
              )),
            ],
          ),
          const SizedBox(height: 12),
          Text(content, style: TextStyle(
            fontSize: 13, color: contentColor, height: 1.6,
          )),
        ],
      ),
    );
  }
}
