// hadith_screen.dart — UpYourDeen · Module Hadith (v3 – share image feature)

import 'dart:math';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_locale.dart';
import 'translations.dart';
import 'hadith_repository.dart';

// ── Palette ──────────────────────────────────────────────────────────────────
const _kGreenDeep    = Color(0xFF0A2018);
const _kGreenPrimary = Color(0xFF1B4D38);
const _kGreenMedium  = Color(0xFF2A7A52);
const _kGold         = Color(0xFFC8933A);
const _kGoldLight    = Color(0xFFFFF4DC);
const _kBeige        = Color(0xFFF6F0E3);
const _kBeigeCard    = Color(0xFFFFFFFF);
const _kBeigeBorder  = Color(0xFFD6C9AF);
const _kTextDark     = Color(0xFF1A130A);
const _kTextMid      = Color(0xFF5A4833);
const _kTextLight    = Color(0xFF8A7863);
const _kRed          = Color(0xFFE53935);
const _kRedLight     = Color(0xFFFFEBEB);
const _kBlue         = Color(0xFF1CB0F6);
const _kBlueLight    = Color(0xFFE7F7FF);
const _kOrange       = Color(0xFFFF9800);
const _kGreen        = Color(0xFF4CAF50);
const _kGreenLight   = Color(0xFFE8F5E9);

// ── Format de partage ─────────────────────────────────────────────────────────
enum _ShareFormat { square, story }


// ══════════════════════════════════════════════════════════════════════════════
// ÉCRAN PRINCIPAL
// ══════════════════════════════════════════════════════════════════════════════
class HadithScreen extends StatefulWidget {
  const HadithScreen({super.key});

  @override
  State<HadithScreen> createState() => _HadithScreenState();
}

class _HadithScreenState extends State<HadithScreen> {
  String         _selectedCategorie = 'Tous';
  final Set<int> _favoris           = {};

  static const _kFavorisKey = 'deenly_hadith_favoris';

  @override
  void initState() {
    super.initState();
    _loadFavoris();
  }

  Future<void> _loadFavoris() async {
    final prefs = await SharedPreferences.getInstance();
    final list  = prefs.getStringList(_kFavorisKey) ?? [];
    if (mounted) {
      setState(() {
        _favoris.clear();
        _favoris.addAll(list.map((s) => int.tryParse(s) ?? -1).where((i) => i >= 0));
      });
    }
  }

  Future<void> _saveFavoris() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_kFavorisKey, _favoris.map((i) => i.toString()).toList());
  }

  // Hadith du jour basé sur le jour de l'année (change chaque jour)
  int get _hadithDuJourIndex => DateTime.now().dayOfYear % HadithRepository.instance.data.length;

  List<MapEntry<int, HadithModel>> get _filteredHadiths {
    final all = HadithRepository.instance.data.asMap().entries.toList();
    if (_selectedCategorie == 'Tous') return all;
    return all.where((e) => e.value.categorie == _selectedCategorie).toList();
  }

  void _toggleFavori(int index) {
    setState(() => _favoris.contains(index) ? _favoris.remove(index) : _favoris.add(index));
    _saveFavoris();
  }

  void _openDetail(int index) {
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => HadithDetailScreen(
        hadith:          HadithRepository.instance.data[index],
        hadithIndex:     index,
        isFavori:        _favoris.contains(index),
        onToggleFavori:  () => _toggleFavori(index),
        allHadiths:      HadithRepository.instance.data,
        allFavoris:      _favoris,
        onOpenHadith:    (idx) => _openDetail(idx),
      ),
    ));
  }

  void _showSagesseAleatoire() {
    final idx = Random().nextInt(HadithRepository.instance.data.length);
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _SagesseSheet(
        hadith:         HadithRepository.instance.data[idx],
        isFavori:       _favoris.contains(idx),
        onToggleFavori: () => _toggleFavori(idx),
        onVoirDetails:  () { Navigator.pop(context); _openDetail(idx); },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredHadiths;
    return Scaffold(
      backgroundColor: _kBeige,
      body: Column(children: [
        _buildHeader(context),
        Expanded(
          child: CustomScrollView(slivers: [
            if (_selectedCategorie == 'Tous') ...[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: _HadithDuJourBanner(
                    hadith:             HadithRepository.instance.data[_hadithDuJourIndex],
                    isFavori:           _favoris.contains(_hadithDuJourIndex),
                    onLireExplication:  () => _openDetail(_hadithDuJourIndex),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                  child: _SagesseButton(onTap: _showSagesseAleatoire),
                ),
              ),
            ],
            SliverToBoxAdapter(
              child: _CategoriesFilter(
                categories: HadithRepository.instance.categories,
                selected:   _selectedCategorie,
                onSelect:   (cat) => setState(() => _selectedCategorie = cat),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, i) {
                    final entry = filtered[i];
                    return _HadithCard(
                      hadith:         entry.value,
                      isFavori:       _favoris.contains(entry.key),
                      onToggleFavori: () => _toggleFavori(entry.key),
                      onTap:          () => _openDetail(entry.key),
                    );
                  },
                  childCount: filtered.length,
                ),
              ),
            ),
          ]),
        ),
      ]),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(context, MaterialPageRoute(
          builder: (_) => HadithQuizScreen(hadiths: HadithRepository.instance.data),
        )),
        backgroundColor: _kGold,
        foregroundColor: _kGreenDeep,
        icon:  const Icon(Icons.quiz_rounded),
        label: Text(context.t.hadithQuizButton, style: const TextStyle(fontWeight: FontWeight.w800)),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [_kGreenDeep, _kGreenPrimary],
          begin: Alignment.topLeft, end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: Row(children: [
            GestureDetector(
              onTap: () => Navigator.maybePop(context),
              child: Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                ),
                child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 15),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('الأحاديث النبوية',
                    style: TextStyle(color: _kGold, fontSize: 18, fontWeight: FontWeight.w700, height: 1.4)),
                Text(context.t.hadithSubtitle,
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.55), fontSize: 11)),
              ]),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
              ),
              child: Text('${HadithRepository.instance.data.length} hadiths',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 11, fontWeight: FontWeight.w700)),
            ),
          ]),
        ),
      ),
    );
  }
}

// Extension utilitaire
extension on DateTime {
  int get dayOfYear {
    final start = DateTime(year, 1, 1);
    return difference(start).inDays;
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// HADITH DU JOUR BANNER
// ══════════════════════════════════════════════════════════════════════════════
class _HadithDuJourBanner extends StatelessWidget {
  final HadithModel hadith;
  final bool        isFavori;
  final VoidCallback onLireExplication;

  const _HadithDuJourBanner({
    required this.hadith,
    required this.isFavori,
    required this.onLireExplication,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_kGreenPrimary, _kGreenMedium],
          begin: Alignment.topLeft, end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [BoxShadow(color: _kGreenPrimary.withValues(alpha: 0.3), blurRadius: 18, offset: const Offset(0, 6))],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: _kGold.withValues(alpha: 0.22),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              const Text('⭐', style: TextStyle(fontSize: 11)),
              const SizedBox(width: 5),
              Text(context.t.hadithOfTheDay, style: const TextStyle(color: _kGold, fontWeight: FontWeight.w800, fontSize: 11)),
            ]),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(hadith.categorie,
                style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 10, fontWeight: FontWeight.w600)),
          ),
        ]),
        const SizedBox(height: 14),
        Text(hadith.arabe,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            style: const TextStyle(color: _kGold, fontSize: 18, height: 1.9)),
        const SizedBox(height: 6),
        Text(hadith.phonetique,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.white.withValues(alpha: 0.55),
                fontSize: 10.5,
                height: 1.5,
                fontStyle: FontStyle.italic)),
        const SizedBox(height: 10),
        Text(hadith.traductionLocale,
            style: const TextStyle(color: Colors.white, fontSize: 13, height: 1.55)),
        const SizedBox(height: 6),
        Text('— ${hadith.narrateur}',
            style: TextStyle(color: Colors.white.withValues(alpha: 0.65), fontSize: 11)),
        const SizedBox(height: 14),
        GestureDetector(
          onTap: onLireExplication,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(context.t.hadithReadExplanation, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700)),
                const SizedBox(width: 6),
                const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 14),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// BOUTON SAGESSE ALÉATOIRE
// ══════════════════════════════════════════════════════════════════════════════
class _SagesseButton extends StatelessWidget {
  final VoidCallback onTap;
  const _SagesseButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        decoration: BoxDecoration(
          color: _kGoldLight,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _kGold.withValues(alpha: 0.4), width: 1.5),
        ),
        child: Row(children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _kGold.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text('🌟', style: TextStyle(fontSize: 18)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(context.t.hadithRandomWisdom,
                  style: const TextStyle(color: _kTextDark, fontSize: 13, fontWeight: FontWeight.w800)),
              const SizedBox(height: 2),
              Text(context.t.hadithDiscoverRandom,
                  style: const TextStyle(color: _kTextLight, fontSize: 11)),
            ]),
          ),
          const Icon(Icons.shuffle_rounded, color: _kGold, size: 20),
        ]),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// FILTRE CATÉGORIES
// ══════════════════════════════════════════════════════════════════════════════
class _CategoriesFilter extends StatelessWidget {
  final List<String>     categories;
  final String           selected;
  final Function(String) onSelect;

  const _CategoriesFilter({required this.categories, required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _kBeigeCard,
      child: SizedBox(
        height: 46,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
          itemCount: categories.length,
          itemBuilder: (context, i) {
            final cat        = categories[i];
            final isSelected = cat == selected;
            return GestureDetector(
              onTap: () => onSelect(cat),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                decoration: BoxDecoration(
                  color:  isSelected ? _kGreenPrimary : _kBeige,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? _kGreenPrimary : _kBeigeBorder,
                    width: 1.5,
                  ),
                ),
                child: Text(context.t.translateHadithCategory(cat),
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected ? Colors.white : _kTextMid,
                      fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                    )),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// CARTE HADITH (liste)
// ══════════════════════════════════════════════════════════════════════════════
class _HadithCard extends StatelessWidget {
  final HadithModel  hadith;
  final bool         isFavori;
  final VoidCallback onToggleFavori;
  final VoidCallback onTap;

  const _HadithCard({
    required this.hadith,
    required this.isFavori,
    required this.onToggleFavori,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: _kBeigeCard,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _kBeigeBorder, width: 1.2),
        boxShadow: const [BoxShadow(color: Color(0x08000000), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Row(children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                decoration: BoxDecoration(
                  color: _kGreenPrimary.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(hadith.categorie,
                    style: const TextStyle(fontSize: 11, color: _kGreenPrimary, fontWeight: FontWeight.w800)),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  final text = '${hadith.arabe}\n\n« ${hadith.traductionLocale} »\n— ${hadith.narrateur}\n${hadith.source}';
                  Share.share(text);
                },
                behavior: HitTestBehavior.opaque,
                child: const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Icon(Icons.ios_share_rounded, color: _kTextLight, size: 18),
                ),
              ),
              const SizedBox(width: 4),
              GestureDetector(
                onTap: onToggleFavori,
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Icon(
                    isFavori ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
                    color: isFavori ? _kRed : _kTextLight,
                    size: 20,
                  ),
                ),
              ),
            ]),
            const SizedBox(height: 12),
            Text(hadith.arabe,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 17, color: _kTextDark, height: 1.8)),
            const SizedBox(height: 4),
            Text(hadith.phonetique,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 10.5,
                    color: _kTextLight,
                    fontStyle: FontStyle.italic,
                    letterSpacing: 0.2)),
            const SizedBox(height: 6),
            Text(hadith.traductionLocale,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12, color: _kTextMid, height: 1.5)),
            const SizedBox(height: 8),
            Row(children: [
              Text(hadith.narrateur,
                  style: const TextStyle(fontSize: 11, color: _kGreenPrimary, fontWeight: FontWeight.w700)),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios_rounded, size: 11, color: _kTextLight),
            ]),
          ]),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// ÉCRAN DÉTAIL
// ══════════════════════════════════════════════════════════════════════════════
class HadithDetailScreen extends StatefulWidget {
  final HadithModel         hadith;
  final int                 hadithIndex;
  final bool                isFavori;
  final VoidCallback         onToggleFavori;
  final List<HadithModel>   allHadiths;
  final Set<int>            allFavoris;
  final Function(int)       onOpenHadith;

  const HadithDetailScreen({
    super.key,
    required this.hadith,
    required this.hadithIndex,
    required this.isFavori,
    required this.onToggleFavori,
    required this.allHadiths,
    required this.allFavoris,
    required this.onOpenHadith,
  });

  @override
  State<HadithDetailScreen> createState() => _HadithDetailScreenState();
}

class _HadithDetailScreenState extends State<HadithDetailScreen> {
  late bool _isFavori;

  @override
  void initState() {
    super.initState();
    _isFavori = widget.isFavori;
  }

  void _toggleFavori() {
    setState(() => _isFavori = !_isFavori);
    widget.onToggleFavori();
  }

  void _copyText() {
    final text = '${widget.hadith.arabe}\n\n« ${widget.hadith.traductionLocale} »\n— ${widget.hadith.narrateur}\n${widget.hadith.source}';
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(context.t.hadithCopiedClipboard),
      backgroundColor: _kGreenPrimary,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(16),
    ));
  }

  void _showShareOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _ShareBottomSheet(hadith: widget.hadith, hadithIndex: widget.hadithIndex),
    );
  }

  List<MapEntry<int, HadithModel>> get _similarHadiths =>
      widget.allHadiths.asMap().entries
          .where((e) => e.key != widget.hadithIndex && e.value.categorie == widget.hadith.categorie)
          .take(3)
          .toList();

  @override
  Widget build(BuildContext context) {
    final similar = _similarHadiths;

    return Scaffold(
      backgroundColor: _kBeige,
      body: Column(children: [
        // Header
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [_kGreenDeep, _kGreenPrimary],
                begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Row(children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(9),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 15),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(widget.hadith.categorie,
                      style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700)),
                ),
                GestureDetector(
                  onTap: _toggleFavori,
                  child: Container(
                    padding: const EdgeInsets.all(9),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      _isFavori ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
                      color: _isFavori ? _kRed : Colors.white,
                      size: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _showShareOptions,
                  child: Container(
                    padding: const EdgeInsets.all(9),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.ios_share_rounded, color: Colors.white, size: 18),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _copyText,
                  child: Container(
                    padding: const EdgeInsets.all(9),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.copy_rounded, color: Colors.white, size: 18),
                  ),
                ),
              ]),
            ),
          ),
        ),

        // Contenu
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [

              // Texte arabe
              Container(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0D3A25), Color(0xFF1B5E40)],
                    begin: Alignment.topLeft, end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [BoxShadow(color: _kGreenPrimary.withValues(alpha: 0.28), blurRadius: 20, offset: const Offset(0, 6))],
                ),
                child: Text(widget.hadith.arabe,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: _kGold, fontSize: 22, height: 2.0)),
              ),

              const SizedBox(height: 10),

              // Phonétique
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: _kGreenPrimary.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _kGreenPrimary.withValues(alpha: 0.12)),
                ),
                child: Text(widget.hadith.phonetique,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: _kTextMid,
                        fontSize: 12.5,
                        height: 1.6,
                        fontStyle: FontStyle.italic,
                        letterSpacing: 0.2)),
              ),

              const SizedBox(height: 10),

              // Traduction
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: _kGoldLight,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: _kGold.withValues(alpha: 0.35)),
                ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    const Text('🌍', style: TextStyle(fontSize: 14)),
                    const SizedBox(width: 6),
                    Text(context.t.hadithTranslation, style: const TextStyle(color: Color(0xFFA85C00), fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1)),
                  ]),
                  const SizedBox(height: 10),
                  Text(widget.hadith.traductionLocale,
                      style: const TextStyle(color: _kTextDark, fontSize: 15, height: 1.65, fontStyle: FontStyle.italic)),
                ]),
              ),

              const SizedBox(height: 10),

              // Source & narrateur
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: _kGreenPrimary.withValues(alpha: 0.07),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: _kGreenPrimary.withValues(alpha: 0.18)),
                ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    const Icon(Icons.person_outline_rounded, color: _kGreenPrimary, size: 15),
                    const SizedBox(width: 6),
                    Expanded(child: Text(widget.hadith.narrateur,
                        style: const TextStyle(color: _kGreenPrimary, fontSize: 13, fontWeight: FontWeight.w700))),
                  ]),
                  const SizedBox(height: 4),
                  Row(children: [
                    const Icon(Icons.menu_book_rounded, color: _kTextLight, size: 14),
                    const SizedBox(width: 6),
                    Expanded(child: Text(widget.hadith.source,
                        style: const TextStyle(color: _kTextMid, fontSize: 11))),
                  ]),
                ]),
              ),

              const SizedBox(height: 14),

              // Explication
              _DetailSection(
                icon: '💡',
                label: context.t.hadithExplication,
                color: _kBlueLight,
                borderColor: _kBlue.withValues(alpha: 0.3),
                labelColor: const Color(0xFF0078A8),
                content: widget.hadith.explicationLocale,
              ),

              const SizedBox(height: 10),

              // Application quotidienne
              _DetailSection(
                icon: '🌱',
                label: context.t.hadithDailyApp,
                color: _kGreenLight,
                borderColor: _kGreenPrimary.withValues(alpha: 0.3),
                labelColor: _kGreenPrimary,
                content: widget.hadith.applicationLocale,
              ),

              // Hadiths similaires
              if (similar.isNotEmpty) ...[
                const SizedBox(height: 24),
                Text(context.t.hadithSimilar,
                    style: const TextStyle(color: _kTextDark, fontSize: 15, fontWeight: FontWeight.w800)),
                const SizedBox(height: 10),
                ...similar.map((e) => _SimilarCard(
                  hadith: e.value,
                  onTap: () {
                    Navigator.pop(context);
                    widget.onOpenHadith(e.key);
                  },
                )),
              ],
            ]),
          ),
        ),
      ]),
    );
  }
}

class _DetailSection extends StatelessWidget {
  final String icon;
  final String label;
  final Color  color;
  final Color  borderColor;
  final Color  labelColor;
  final String content;

  const _DetailSection({
    required this.icon,
    required this.label,
    required this.color,
    required this.borderColor,
    required this.labelColor,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text(icon, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(color: labelColor, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1)),
        ]),
        const SizedBox(height: 10),
        Text(content, style: const TextStyle(color: _kTextDark, fontSize: 13, height: 1.65)),
      ]),
    );
  }
}

class _SimilarCard extends StatelessWidget {
  final HadithModel  hadith;
  final VoidCallback onTap;

  const _SimilarCard({required this.hadith, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _kBeigeCard,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _kBeigeBorder),
        ),
        child: Row(children: [
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(hadith.arabe,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14, color: _kTextDark, height: 1.7)),
              const SizedBox(height: 4),
              Text(hadith.narrateur,
                  style: const TextStyle(fontSize: 11, color: _kGreenPrimary, fontWeight: FontWeight.w700)),
            ]),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_forward_ios_rounded, size: 13, color: _kTextLight),
        ]),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// CARTE HADITH PARTAGEABLE
// ══════════════════════════════════════════════════════════════════════════════
class _HadithShareCard extends StatelessWidget {
  final HadithModel  hadith;
  final int          hadithIndex;
  final _ShareFormat format;

  const _HadithShareCard({
    super.key,
    required this.hadith,
    required this.hadithIndex,
    this.format = _ShareFormat.square,
  });

  @override
  Widget build(BuildContext context) {
    final bool   isStory = format == _ShareFormat.story;
    const double w       = 360;
    final double h       = isStory ? 640 : 360;

    // Sélection automatique du background selon l'ID du hadith
    const _kBackgrounds = [
      'assets/hadith_cards/bg_noir_mandala.jpg',
      'assets/hadith_cards/bg_beige_lanterne.jpg',
      'assets/hadith_cards/bg_mosquee_coucher.jpg',
      'assets/hadith_cards/bg_vert_cadre.jpg',
      'assets/hadith_cards/bg_nuit_croissant.jpg',
      'assets/hadith_cards/bg_kaaba_nuit.jpg',
      'assets/hadith_cards/bg_nature_lumiere.jpg',
      'assets/hadith_cards/bg_coran_ouvert.jpg',
      'assets/hadith_cards/bg_misbaha_or.jpg',
    ];
    final bgAsset = _kBackgrounds[hadithIndex % _kBackgrounds.length];

    return SizedBox(
      width: w, height: h,
      child: Stack(children: [
        // ── Background photo ──────────────────────────────────────────────────
        Positioned.fill(
          child: Image.asset(
            bgAsset,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: const Color(0xFF0F2A1C),
            ),
          ),
        ),

        // ── Overlay sombre pour lisibilité du texte ───────────────────────────
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withValues(alpha: 0.55),
                  Colors.black.withValues(alpha: 0.35),
                  Colors.black.withValues(alpha: 0.55),
                ],
                begin: Alignment.topCenter,
                end:   Alignment.bottomCenter,
              ),
            ),
          ),
        ),

        // ── Bandes dorées haut / bas ──────────────────────────────────────────
        Positioned(
          top: 0, left: 0, right: 0,
          child: Container(height: 3, color: const Color(0xFFC8933A).withValues(alpha: 0.85)),
        ),
        Positioned(
          bottom: 0, left: 0, right: 0,
          child: Container(height: 3, color: const Color(0xFFC8933A).withValues(alpha: 0.85)),
        ),

        // ── Contenu ───────────────────────────────────────────────────────────
        // ClipRect + FittedBox : si le hadith est long, tout le contenu
        // est réduit proportionnellement pour ne jamais déborder.
        Positioned.fill(
          child: ClipRect(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(28, 22, 28, 18),
              child: LayoutBuilder(
                builder: (_, constraints) => FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: constraints.maxWidth,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Logo UpYourDeen / ديني
                        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          const Text('UpYourDeen',
                              style: TextStyle(
                                  color: Color(0xFFC8933A), fontSize: 18,
                                  fontWeight: FontWeight.w900, letterSpacing: 2.5)),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            width: 1, height: 14,
                            color: const Color(0xFFC8933A).withValues(alpha: 0.45),
                          ),
                          const Text('ديني',
                              style: TextStyle(
                                  color: Color(0xFFC8933A), fontSize: 18,
                                  fontWeight: FontWeight.w700)),
                        ]),

                        SizedBox(height: isStory ? 36 : 20),

                        // قال رسول الله ﷺ
                        Text('قَالَ رَسُولُ اللَّهِ ﷺ',
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.42),
                                fontSize: 12, letterSpacing: 0.3)),

                        SizedBox(height: isStory ? 22 : 12),

                        // Texte arabe
                        Text(hadith.arabe,
                            textDirection: TextDirection.rtl,
                            textAlign:     TextAlign.center,
                            style: const TextStyle(
                                color: Color(0xFFC8933A),
                                fontSize: 17, height: 2.0, fontWeight: FontWeight.w500)),

                        SizedBox(height: isStory ? 10 : 8),

                        // Phonétique
                        Text(hadith.phonetique,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.38),
                                fontSize: isStory ? 11 : 10,
                                height: 1.5,
                                fontStyle: FontStyle.italic)),

                        SizedBox(height: isStory ? 20 : 12),

                        // Séparateur doré
                        Row(children: [
                          Expanded(child: Container(
                            height: 1,
                            color: const Color(0xFFC8933A).withValues(alpha: 0.22),
                          )),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text('✦',
                                style: TextStyle(
                                    color: const Color(0xFFC8933A).withValues(alpha: 0.55),
                                    fontSize: 10)),
                          ),
                          Expanded(child: Container(
                            height: 1,
                            color: const Color(0xFFC8933A).withValues(alpha: 0.22),
                          )),
                        ]),

                        SizedBox(height: isStory ? 28 : 16),

                        // Traduction française
                        Text('« ${hadith.traductionLocale} »',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.88),
                                fontSize: isStory ? 15 : 13,
                                height: 1.75,
                                fontStyle: FontStyle.italic)),

                        // Espace flexible remplacé par SizedBox fixe
                        // (Spacer() ne fonctionne pas avec FittedBox/mainAxisSize.min)
                        SizedBox(height: isStory ? 28 : 16),

                        // Pastille source
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.055),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: const Color(0xFFC8933A).withValues(alpha: 0.22)),
                          ),
                          child: Text(hadith.source,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.58),
                                  fontSize: 10.5, letterSpacing: 0.2)),
                        ),

                        const SizedBox(height: 10),

                        // Signature UpYourDeen
                        Text(context.t.hadithAppSlogan,
                            style: TextStyle(
                                color: const Color(0xFFC8933A).withValues(alpha: 0.55),
                                fontSize: 10, letterSpacing: 1.3)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

// ── Motif islamique (étoiles octogonales discrètes) ───────────────────────────
class _IslamicPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color   = const Color(0xFFC8933A).withValues(alpha: 0.048)
      ..style   = PaintingStyle.stroke
      ..strokeWidth = 0.7;

    const double step = 85.0;
    const double r    = 26.0;

    for (double x = 0; x <= size.width  + step; x += step) {
      for (double y = 0; y <= size.height + step; y += step) {
        _drawOctaStar(canvas, paint, x, y, r);
      }
    }
  }

  void _drawOctaStar(Canvas canvas, Paint paint, double cx, double cy, double r) {
    final path = Path();
    for (int i = 0; i < 8; i++) {
      final a      = i * pi / 4 - pi / 8;
      final radius = i % 2 == 0 ? r : r * 0.42;
      final x      = cx + radius * cos(a);
      final y      = cy + radius * sin(a);
      if (i == 0) { path.moveTo(x, y); } else { path.lineTo(x, y); }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _IslamicPatternPainter old) => false;
}

// ══════════════════════════════════════════════════════════════════════════════
// BOTTOM SHEET PARTAGE IMAGE
// ══════════════════════════════════════════════════════════════════════════════
class _ShareBottomSheet extends StatefulWidget {
  final HadithModel hadith;
  final int         hadithIndex;
  const _ShareBottomSheet({required this.hadith, required this.hadithIndex});

  @override
  State<_ShareBottomSheet> createState() => _ShareBottomSheetState();
}

class _ShareBottomSheetState extends State<_ShareBottomSheet> {
  _ShareFormat _format       = _ShareFormat.square;
  bool         _isGenerating = false;

  Future<Uint8List> _renderCard() async {
    final isStory = _format == _ShareFormat.story;
    return ScreenshotController().captureFromWidget(
      // MaterialApp avec debugShowCheckedModeBanner: false pour éviter
      // le bandeau jaune/noir "DEBUG" dans l'image générée.
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Directionality(
          textDirection: TextDirection.ltr,
          child: _HadithShareCard(hadith: widget.hadith, hadithIndex: widget.hadithIndex, format: _format),
        ),
      ),
      pixelRatio: 3.0,
      targetSize: Size(360, isStory ? 640 : 360),
    );
  }

  Future<void> _share() async {
    setState(() => _isGenerating = true);
    try {
      final bytes = await _renderCard();
      final name = 'deenly_hadith_${DateTime.now().millisecondsSinceEpoch}.png';
      if (kIsWeb) {
        // Sur le web : copier le texte du hadith au lieu de l'image
        final text = '${widget.hadith.arabe}\n\n« ${widget.hadith.traductionLocale} »\n— ${widget.hadith.narrateur}\n${widget.hadith.source}\n\nUpYourDeen · Élève ta foi';
        await Share.share(text);
      } else {
        await Share.shareXFiles(
          [XFile.fromData(bytes, mimeType: 'image/png', name: name)],
          subject: 'UpYourDeen · Élève ta foi',
        );
      }
    } catch (e) {
      if (mounted) {
        // Fallback : partage texte si l'image échoue
        try {
          final text = '${widget.hadith.arabe}\n\n« ${widget.hadith.traductionLocale} »\n— ${widget.hadith.narrateur}\n${widget.hadith.source}\n\nUpYourDeen · Élève ta foi';
          await Share.share(text);
        } catch (_) {
          if (!mounted) return;
          final messenger = ScaffoldMessenger.of(context);
          final errorMsg = context.t.hadithShareError;
          messenger.showSnackBar(SnackBar(
            content: Text('$errorMsg : $e'),
            backgroundColor: _kRed,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ));
        }
      }
    } finally {
      if (mounted) setState(() => _isGenerating = false);
    }
  }

  Future<void> _save() async {
    setState(() => _isGenerating = true);
    try {
      final bytes = await _renderCard();
      final name = 'deenly_hadith_${DateTime.now().millisecondsSinceEpoch}.png';
      await Share.shareXFiles(
        [XFile.fromData(bytes, mimeType: 'image/png', name: name)],
        subject: 'UpYourDeen · Élève ta foi',
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(context.t.hadithImageShared),
          backgroundColor: _kGreenPrimary,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${context.t.hadithSaveError} : $e'),
          backgroundColor: _kRed,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ));
      }
    } finally {
      if (mounted) setState(() => _isGenerating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isStory = _format == _ShareFormat.story;
    return Container(
      decoration: const BoxDecoration(
        color: _kBeigeCard,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
      child: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          // Handle
          Center(child: Container(
            margin: const EdgeInsets.only(top: 12, bottom: 20),
            width: 40, height: 4,
            decoration: BoxDecoration(
              color: _kBeigeBorder,
              borderRadius: BorderRadius.circular(99),
            ),
          )),

          // Titre
          Text(context.t.hadithShareTitle,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: _kTextDark)),
          const SizedBox(height: 4),
          Text(context.t.hadithShareSubtitle,
              style: TextStyle(fontSize: 12, color: _kTextLight)),

          const SizedBox(height: 20),

          // Sélecteur de format
          Row(children: [
            Expanded(child: _ShareFormatButton(
              label:      context.t.hadithShareSquare,
              sublabel:   '1080 × 1080',
              icon:       Icons.crop_square_rounded,
              isSelected: _format == _ShareFormat.square,
              onTap:      () => setState(() => _format = _ShareFormat.square),
            )),
            const SizedBox(width: 12),
            Expanded(child: _ShareFormatButton(
              label:      context.t.hadithShareStory,
              sublabel:   '1080 × 1920',
              icon:       Icons.crop_portrait_rounded,
              isSelected: _format == _ShareFormat.story,
              onTap:      () => setState(() => _format = _ShareFormat.story),
            )),
          ]),

          const SizedBox(height: 20),

          // Aperçu de la carte
          Container(
            height: isStory ? 280 : 230,
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: FittedBox(
                fit: BoxFit.contain,
                child: SizedBox(
                  width: 360,
                  height: isStory ? 640 : 360,
                  child: _HadithShareCard(hadith: widget.hadith, hadithIndex: widget.hadithIndex, format: _format),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Boutons d'action
          Row(children: [
            // Sauvegarder
            GestureDetector(
              onTap: _isGenerating ? null : _save,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                decoration: BoxDecoration(
                  color: _kBeige,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: _kBeigeBorder),
                ),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  const Icon(Icons.download_rounded, color: _kGreenPrimary, size: 18),
                  const SizedBox(width: 6),
                  Text(context.t.hadithSaveButton,
                      style: const TextStyle(
                          color: _kGreenPrimary,
                          fontSize: 12, fontWeight: FontWeight.w800)),
                ]),
              ),
            ),
            const SizedBox(width: 10),
            // Partager
            Expanded(
              child: GestureDetector(
                onTap: _isGenerating ? null : _share,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF0A2018), _kGreenPrimary],
                    ),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                          color: _kGreenPrimary.withValues(alpha: 0.28),
                          blurRadius: 12,
                          offset: const Offset(0, 4)),
                    ],
                  ),
                  child: _isGenerating
                      ? const Center(child: SizedBox(
                          width: 18, height: 18,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2)))
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.ios_share_rounded,
                                color: Colors.white, size: 17),
                            const SizedBox(width: 7),
                            Text(context.t.hadithShareImageButton,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w800)),
                          ]),
                ),
              ),
            ),
          ]),
        ]),
      ),
    );
  }
}

class _ShareFormatButton extends StatelessWidget {
  final String     label;
  final String     sublabel;
  final IconData   icon;
  final bool       isSelected;
  final VoidCallback onTap;

  const _ShareFormatButton({
    required this.label,
    required this.sublabel,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
        decoration: BoxDecoration(
          color: isSelected ? _kGreenPrimary.withValues(alpha: 0.09) : _kBeige,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? _kGreenPrimary : _kBeigeBorder,
            width: isSelected ? 2.0 : 1.5,
          ),
        ),
        child: Column(children: [
          Icon(icon, color: isSelected ? _kGreenPrimary : _kTextLight, size: 26),
          const SizedBox(height: 5),
          Text(label,
              style: TextStyle(
                  color: isSelected ? _kGreenPrimary : _kTextDark,
                  fontWeight: FontWeight.w800, fontSize: 12)),
          Text(sublabel,
              style: const TextStyle(color: _kTextLight, fontSize: 10)),
        ]),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// SAGESSE ALÉATOIRE (Bottom Sheet)
// ══════════════════════════════════════════════════════════════════════════════
class _SagesseSheet extends StatefulWidget {
  final HadithModel  hadith;
  final bool         isFavori;
  final VoidCallback onToggleFavori;
  final VoidCallback onVoirDetails;

  const _SagesseSheet({
    required this.hadith,
    required this.isFavori,
    required this.onToggleFavori,
    required this.onVoirDetails,
  });

  @override
  State<_SagesseSheet> createState() => _SagesseSheetState();
}

class _SagesseSheetState extends State<_SagesseSheet> {
  late bool _isFavori;

  @override
  void initState() {
    super.initState();
    _isFavori = widget.isFavori;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: _kBeigeCard,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        // Handle
        Center(
          child: Container(
            margin: const EdgeInsets.only(top: 12, bottom: 20),
            width: 40, height: 4,
            decoration: BoxDecoration(color: _kBeigeBorder, borderRadius: BorderRadius.circular(99)),
          ),
        ),

        // Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: _kGoldLight,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: _kGold.withValues(alpha: 0.4)),
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            const Text('🌟', style: TextStyle(fontSize: 13)),
            const SizedBox(width: 6),
            Text(context.t.hadithRandomWisdom,
                style: const TextStyle(color: _kGold, fontSize: 12, fontWeight: FontWeight.w800)),
          ]),
        ),

        const SizedBox(height: 20),

        // Arabe
        Text(widget.hadith.arabe,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            style: const TextStyle(color: _kTextDark, fontSize: 20, height: 1.9)),

        const SizedBox(height: 8),

        // Phonétique
        Text(widget.hadith.phonetique,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: _kTextLight,
                fontSize: 11,
                height: 1.55,
                fontStyle: FontStyle.italic)),

        const SizedBox(height: 14),
        const Divider(color: _kBeigeBorder),
        const SizedBox(height: 14),

        // Traduction
        Text(widget.hadith.traductionLocale,
            textAlign: TextAlign.center,
            style: const TextStyle(color: _kTextMid, fontSize: 14, height: 1.6, fontStyle: FontStyle.italic)),

        const SizedBox(height: 10),

        Text('— ${widget.hadith.narrateur}',
            textAlign: TextAlign.center,
            style: const TextStyle(color: _kGreenPrimary, fontSize: 12, fontWeight: FontWeight.w700)),
        Text(widget.hadith.source,
            textAlign: TextAlign.center,
            style: const TextStyle(color: _kTextLight, fontSize: 11)),

        const SizedBox(height: 24),

        // Boutons
        Row(children: [
          // Favori
          GestureDetector(
            onTap: () { setState(() => _isFavori = !_isFavori); widget.onToggleFavori(); },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              decoration: BoxDecoration(
                color: _isFavori ? _kRedLight : _kBeige,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: _isFavori ? _kRed.withValues(alpha: 0.4) : _kBeigeBorder),
              ),
              child: Row(children: [
                Icon(_isFavori ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
                    color: _isFavori ? _kRed : _kTextLight, size: 18),
                const SizedBox(width: 6),
                Text(_isFavori ? context.t.hadithFavorite : context.t.hadithAdd,
                    style: TextStyle(color: _isFavori ? _kRed : _kTextMid, fontSize: 12, fontWeight: FontWeight.w700)),
              ]),
            ),
          ),
          const SizedBox(width: 10),
          // Voir détail
          Expanded(
            child: GestureDetector(
              onTap: widget.onVoirDetails,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [_kGreenPrimary, _kGreenMedium]),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(context.t.hadithViewExplanation, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w800)),
                  const SizedBox(width: 6),
                  const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 14),
                ]),
              ),
            ),
          ),
        ]),
      ]),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// QUIZ HADITHS
// ══════════════════════════════════════════════════════════════════════════════
class _QuizQuestion {
  final String       arabe;
  final String       question;
  final String       correctAnswer;
  final List<String> options;

  _QuizQuestion({
    required this.arabe,
    required this.question,
    required this.correctAnswer,
    required this.options,
  });
}

class HadithQuizScreen extends StatefulWidget {
  final List<HadithModel> hadiths;
  const HadithQuizScreen({super.key, required this.hadiths});

  @override
  State<HadithQuizScreen> createState() => _HadithQuizScreenState();
}

class _HadithQuizScreenState extends State<HadithQuizScreen>
    with SingleTickerProviderStateMixin {
  late final List<_QuizQuestion> _questions;
  int     _current     = 0;
  int     _score       = 0;
  bool    _showFeedback = false;
  bool    _lastCorrect  = false;
  String? _selected;
  bool    _done        = false;

  late AnimationController _feedCtrl;
  late Animation<Offset>   _feedSlide;

  @override
  void initState() {
    super.initState();
    _questions = _buildQuestions();
    _feedCtrl  = AnimationController(vsync: this, duration: const Duration(milliseconds: 280));
    _feedSlide = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(CurvedAnimation(parent: _feedCtrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _feedCtrl.dispose();
    super.dispose();
  }

  List<_QuizQuestion> _buildQuestions() {
    final rng     = Random();
    final indices = List.generate(widget.hadiths.length, (i) => i)..shuffle(rng);
    final picked  = indices.take(5).toList();

    return picked.asMap().entries.map((entry) {
      final qIdx   = entry.key;
      final hIdx   = entry.value;
      final h      = widget.hadiths[hIdx];
      final others = (List<int>.from(indices.where((i) => i != hIdx))..shuffle(rng)).take(3).toList();
      final type   = qIdx % 3;

      String question;
      String correct;
      List<String> opts;

      if (type == 0) {
        question = AppLocale().isFrench ? 'Qui a rapporté ce hadith ?' : 'Who narrated this hadith?';
        correct  = h.narrateur;
        opts     = [correct, ...others.map((i) => widget.hadiths[i].narrateur)];
      } else if (type == 1) {
        question = AppLocale().isFrench ? 'Quelle est la traduction de ce hadith ?' : 'What is the translation of this hadith?';
        correct  = h.traductionLocale;
        opts     = [correct, ...others.map((i) => widget.hadiths[i].traductionLocale)];
      } else {
        question = AppLocale().isFrench ? 'Quelle est la meilleure explication ?' : 'What is the best explanation?';
        String shorten(String s) => s.length > 90 ? '${s.substring(0, 87)}...' : s;
        correct  = shorten(h.explicationLocale);
        opts     = [correct, ...others.map((i) => shorten(widget.hadiths[i].explicationLocale))];
      }
      opts.shuffle(rng);

      return _QuizQuestion(
        arabe:         h.arabe,
        question:      question,
        correctAnswer: correct,
        options:       opts,
      );
    }).toList();
  }

  void _onAnswer(String answer) {
    if (_showFeedback) return;
    final correct = answer == _questions[_current].correctAnswer;
    if (correct) _score++;
    setState(() { _selected = answer; _lastCorrect = correct; _showFeedback = true; });
    _feedCtrl.forward(from: 0);
  }

  void _next() {
    _feedCtrl.reverse();
    Future.delayed(const Duration(milliseconds: 180), () {
      if (!mounted) return;
      setState(() {
        _showFeedback = false;
        _selected     = null;
        if (_current + 1 >= _questions.length) { _done = true; }
        else { _current++; }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_done) return _buildResult(context);

    final q        = _questions[_current];
    final progress = _current / _questions.length;

    return Scaffold(
      backgroundColor: _kBeige,
      body: SafeArea(
        child: Stack(children: [
          Column(children: [
            // Top bar
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [_kGreenDeep, Color(0xFF112B1E)],
                    begin: Alignment.topLeft, end: Alignment.bottomRight),
              ),
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
              child: Column(children: [
                Row(children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.14),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.close_rounded, color: Colors.white, size: 18),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(context.t.hadithQuizButton,
                        style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w800)),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: _kGold.withValues(alpha: 0.22),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text('⚡ $_score / ${_questions.length}',
                        style: const TextStyle(color: _kGold, fontSize: 12, fontWeight: FontWeight.w800)),
                  ),
                ]),
                const SizedBox(height: 14),
                ClipRRect(
                  borderRadius: BorderRadius.circular(99),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 6,
                    backgroundColor: Colors.white.withValues(alpha: 0.18),
                    valueColor: const AlwaysStoppedAnimation(_kGold),
                  ),
                ),
              ]),
            ),

            // Question
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),
                child: Column(children: [
                  // Badge question
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: _kGold.withValues(alpha: 0.13),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: _kGold.withValues(alpha: 0.35)),
                    ),
                    child: Text(q.question,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: _kGold, fontSize: 12, fontWeight: FontWeight.w700)),
                  ),
                  const SizedBox(height: 18),

                  // Arabe
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF0D3A25), Color(0xFF1B5E40)],
                        begin: Alignment.topLeft, end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [BoxShadow(color: _kGreenPrimary.withValues(alpha: 0.28), blurRadius: 16, offset: const Offset(0, 5))],
                    ),
                    child: Text(q.arabe,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: _kGold, fontSize: 18, height: 1.9)),
                  ),
                  const SizedBox(height: 20),

                  // Options
                  ...q.options.map((opt) => _buildOption(opt, q.correctAnswer)),
                ]),
              ),
            ),
          ]),

          // Feedback
          if (_showFeedback)
            Positioned(
              bottom: 0, left: 0, right: 0,
              child: SlideTransition(
                position: _feedSlide,
                child: _buildFeedback(q),
              ),
            ),
        ]),
      ),
    );
  }

  Widget _buildOption(String opt, String correct) {
    Color bg     = _kBeigeCard;
    Color border = _kBeigeBorder;
    Color text   = _kTextDark;
    Widget? icon;

    if (_showFeedback) {
      if (opt == _selected) {
        if (_lastCorrect) {
          bg = _kGreenLight; border = _kGreen; text = const Color(0xFF1B6B2B);
          icon = const Icon(Icons.check_circle_rounded, color: _kGreen, size: 20);
        } else {
          bg = _kRedLight; border = _kRed; text = const Color(0xFF9B1A1A);
          icon = const Icon(Icons.cancel_rounded, color: _kRed, size: 20);
        }
      } else if (opt == correct && !_lastCorrect) {
        bg = _kGreenLight; border = _kGreen; text = const Color(0xFF1B6B2B);
        icon = const Icon(Icons.check_circle_rounded, color: _kGreen, size: 20);
      }
    }

    return GestureDetector(
      onTap: _showFeedback ? null : () => _onAnswer(opt),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: border, width: 1.5),
        ),
        child: Row(children: [
          Expanded(child: Text(opt, style: TextStyle(color: text, fontSize: 13, fontWeight: FontWeight.w600, height: 1.4))),
          ?icon,
        ]),
      ),
    );
  }

  Widget _buildFeedback(_QuizQuestion q) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 30),
      decoration: BoxDecoration(
        color: _lastCorrect ? _kGreenLight : _kRedLight,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(top: BorderSide(color: _lastCorrect ? _kGreen : _kRed, width: 2)),
      ),
      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text(_lastCorrect ? '✅' : '❌', style: const TextStyle(fontSize: 22)),
          const SizedBox(width: 10),
          Text(_lastCorrect ? context.t.hadithQuizCorrect : context.t.hadithQuizIncorrect,
              style: TextStyle(
                color: _lastCorrect ? const Color(0xFF1B6B2B) : const Color(0xFF9B1A1A),
                fontSize: 16, fontWeight: FontWeight.w800,
              )),
        ]),
        if (!_lastCorrect) ...[
          const SizedBox(height: 8),
          Text(context.t.hadithQuizGoodAnswer, style: TextStyle(color: Colors.grey[600], fontSize: 11)),
          const SizedBox(height: 3),
          Text(q.correctAnswer,
              style: const TextStyle(color: _kTextDark, fontSize: 12, fontWeight: FontWeight.w700)),
        ],
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _next,
            style: ElevatedButton.styleFrom(
              backgroundColor: _lastCorrect ? _kGreen : _kRed,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              padding: const EdgeInsets.symmetric(vertical: 14), elevation: 0,
            ),
            child: Text(context.t.hadithQuizContinue, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
          ),
        ),
      ]),
    );
  }

  Widget _buildResult(BuildContext context) {
    final total  = _questions.length;
    final pct    = _score / total;
    final passed = pct >= 0.60;

    return Scaffold(
      backgroundColor: _kBeige,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(children: [
            const SizedBox(height: 24),
            Text(pct >= 0.80 ? '🏆' : pct >= 0.60 ? '⭐' : '📚',
                style: const TextStyle(fontSize: 80)),
            const SizedBox(height: 16),
            Text(passed ? context.t.hadithQuizBravo : context.t.hadithQuizAlmost,
                style: TextStyle(
                  color: passed ? _kGreenPrimary : _kOrange,
                  fontSize: 26, fontWeight: FontWeight.w900,
                )),
            const SizedBox(height: 8),
            Text(
              context.t.hadithQuizScoreText(_score, total, (pct * 100).round()),
              textAlign: TextAlign.center,
              style: const TextStyle(color: _kTextMid, fontSize: 14, height: 1.5),
            ),
            const SizedBox(height: 30),

            // Score bar
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: _kBeigeCard,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: _kBeigeBorder),
              ),
              child: Column(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(99),
                  child: LinearProgressIndicator(
                    value:           pct,
                    minHeight:       10,
                    backgroundColor: _kBeigeBorder,
                    valueColor:      AlwaysStoppedAnimation(passed ? _kGreenPrimary : _kOrange),
                  ),
                ),
                const SizedBox(height: 20),
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                  _stat('✅', '$_score', context.t.hadithQuizCorrects),
                  _stat('❌', '${total - _score}', context.t.hadithQuizErrors),
                  _stat('📊', '${(pct * 100).round()}%', 'Score'),
                ]),
              ]),
            ),

            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _kGreenPrimary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  padding: const EdgeInsets.symmetric(vertical: 14), elevation: 0,
                ),
                child: Text(context.t.hadithQuizBackButton,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () => setState(() {
                _done = false; _current = 0; _score = 0;
                _showFeedback = false; _selected = null;
                _questions.shuffle(Random());
              }),
              child: Text(context.t.hadithQuizRestart,
                  style: TextStyle(color: _kTextLight, fontSize: 13)),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _stat(String emoji, String val, String label) {
    return Column(children: [
      Text(emoji, style: const TextStyle(fontSize: 20)),
      const SizedBox(height: 4),
      Text(val, style: const TextStyle(color: _kTextDark, fontSize: 17, fontWeight: FontWeight.w900)),
      Text(label, style: const TextStyle(color: _kTextLight, fontSize: 10)),
    ]);
  }
}
