// quran_screen.dart — UpYourDeen · Design premium islamique
// Nouvelles features : sauvegarde de position + taille du texte réglable

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'sourates_data.dart';

// ── Palette ────────────────────────────────────────────────────────────────
const _kGreenDeep    = Color(0xFF0A2018);
const _kGreenPrimary = Color(0xFF1B4D38);
const _kGreenMedium  = Color(0xFF2A7A52);
const _kGold         = Color(0xFFC8933A);
const _kGoldLight    = Color(0xFFE8BF6A);
const _kBeige        = Color(0xFFF6F0E3);
const _kBeigeCard    = Color(0xFFEAE0CF);
const _kBeigeBorder  = Color(0xFFD6C9AF);
const _kTextDark     = Color(0xFF1A130A);
const _kTextMid      = Color(0xFF5A4833);
const _kTextLight    = Color(0xFF8A7863);
const _kWhite        = Color(0xFFFDFAF4);

// ══════════════════════════════════════════════════════════════════════════════
// PERSISTANCE — préférences Coran
// ══════════════════════════════════════════════════════════════════════════════
class QuranPrefs {
  static const _kLastSurah      = 'deenly_quran_last_surah';
  static const _kLastVerset     = 'deenly_quran_last_verset';
  static const _kLastSurahName  = 'deenly_quran_last_surah_name';
  static const _kTextSize       = 'deenly_quran_text_size';
  static const _kShowArabe      = 'deenly_quran_show_arabe';
  static const _kShowTrad       = 'deenly_quran_show_traduction';
  static const _kShowPhon       = 'deenly_quran_show_phonetique';
  static const _kBookmarks      = 'deenly_quran_bookmarks';
  static const _kModeContinue   = 'deenly_quran_mode_continue';

  // ── Position ──────────────────────────────────────────────────
  static Future<void> saveLastPosition(int surahNum, String surahName, int versetNum) async {
    final p = await SharedPreferences.getInstance();
    await p.setInt(_kLastSurah, surahNum);
    await p.setString(_kLastSurahName, surahName);
    await p.setInt(_kLastVerset, versetNum);
  }

  static Future<({int surah, String surahName, int verset})?> loadLastPosition() async {
    try {
      final p = await SharedPreferences.getInstance();
      final s = p.getInt(_kLastSurah);
      final v = p.getInt(_kLastVerset);
      final n = p.getString(_kLastSurahName);
      if (s == null || v == null || n == null) return null;
      return (surah: s, surahName: n, verset: v);
    } catch (_) { return null; }
  }

  // ── Taille du texte ───────────────────────────────────────────
  static Future<void> saveTextSize(double size) async {
    final p = await SharedPreferences.getInstance();
    await p.setDouble(_kTextSize, size);
  }

  static Future<double> loadTextSize() async {
    try {
      final p = await SharedPreferences.getInstance();
      return p.getDouble(_kTextSize) ?? 22.0;
    } catch (_) { return 22.0; }
  }

  // ── Préférences d'affichage ───────────────────────────────────
  static Future<void> saveDisplayPrefs({
    required bool arabe,
    required bool traduction,
    required bool phonetique,
  }) async {
    final p = await SharedPreferences.getInstance();
    await p.setBool(_kShowArabe, arabe);
    await p.setBool(_kShowTrad, traduction);
    await p.setBool(_kShowPhon, phonetique);
  }

  static Future<({bool arabe, bool traduction, bool phonetique})> loadDisplayPrefs() async {
    try {
      final p = await SharedPreferences.getInstance();
      return (
        arabe:      p.getBool(_kShowArabe) ?? true,
        traduction: p.getBool(_kShowTrad)  ?? true,
        phonetique: p.getBool(_kShowPhon)  ?? true,
      );
    } catch (_) {
      return (arabe: true, traduction: true, phonetique: true);
    }
  }

  // ── Signets ───────────────────────────────────────────────────
  // Chaque signet : "surahNum_versetNum_surahName" ex: "2_145_Al-Baqara"

  // ── Mode lecture continue ─────────────────────────────────────
  static Future<void> saveModeContinue(bool value) async {
    final p = await SharedPreferences.getInstance();
    await p.setBool(_kModeContinue, value);
  }

  static Future<bool> loadModeContinue() async {
    try {
      final p = await SharedPreferences.getInstance();
      return p.getBool(_kModeContinue) ?? false;
    } catch (_) { return false; }
  }

  static Future<void> saveBookmarks(List<({int surah, String surahName, int verset})> bookmarks) async {
    final p = await SharedPreferences.getInstance();
    final list = bookmarks.map((b) => '${b.surah}_${b.verset}_${b.surahName}').toList();
    await p.setStringList(_kBookmarks, list);
  }

  static Future<List<({int surah, String surahName, int verset})>> loadBookmarks() async {
    try {
      final p    = await SharedPreferences.getInstance();
      final list = p.getStringList(_kBookmarks) ?? [];
      return list.map((s) {
        final parts = s.split('_');
        if (parts.length < 3) return null;
        final surah  = int.tryParse(parts[0]);
        final verset = int.tryParse(parts[1]);
        final name   = parts.sublist(2).join('_');
        if (surah == null || verset == null) return null;
        return (surah: surah, surahName: name, verset: verset);
      }).whereType<({int surah, String surahName, int verset})>().toList();
    } catch (_) { return []; }
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// ÉCRAN LISTE DES SOURATES
// ══════════════════════════════════════════════════════════════════════════════
class QuranScreen extends StatefulWidget {
  const QuranScreen({super.key});

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Sourate> _filteredSourates = sourates;
  String _searchQuery = '';

  // Dernière position lue
  int?    _lastSurahNum;
  int?    _lastVersetNum;
  String? _lastSurahName;

  // Signets
  List<({int surah, String surahName, int verset})> _bookmarks = [];

  @override
  void initState() {
    super.initState();
    _filteredSourates = List.from(sourates);
    _loadLastPosition();
    _loadBookmarks();
  }

  Future<void> _loadBookmarks() async {
    final bm = await QuranPrefs.loadBookmarks();
    if (mounted) setState(() => _bookmarks = bm);
  }

  Future<void> _loadLastPosition() async {
    final pos = await QuranPrefs.loadLastPosition();
    if (pos != null && mounted) {
      setState(() {
        _lastSurahNum  = pos.surah;
        _lastVersetNum = pos.verset;
        _lastSurahName = pos.surahName;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch(String query) {
    setState(() {
      _searchQuery = query.toLowerCase().trim();
      _filteredSourates = _searchQuery.isEmpty
          ? List.from(sourates)
          : sourates.where((s) {
              return s.nomFrancais.toLowerCase().contains(_searchQuery) ||
                  s.nomArabe.contains(_searchQuery) ||
                  s.numero.toString() == _searchQuery;
            }).toList();
    });
  }

  void _openSourate(Sourate sourate, {int initialVersetNum = 1}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SourateDetailScreen(
          sourate: sourate,
          initialVersetNum: initialVersetNum,
        ),
      ),
    );
    // Rafraîchir la bannière "Reprendre" et les signets au retour
    _loadLastPosition();
    _loadBookmarks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBeige,
      body: CustomScrollView(
        slivers: [
          // ── Header ──────────────────────────────────────────────────────
          SliverToBoxAdapter(child: _buildHeader(context)),

          // ── Barre de recherche ──────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: _buildSearchBar(),
            ),
          ),

          // ── Bannière "Reprendre" ─────────────────────────────────────────
          if (_lastSurahNum != null && _lastVersetNum != null && _searchQuery.isEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
                child: _ReprendreCard(
                  surahName:  _lastSurahName ?? '',
                  versetNum:  _lastVersetNum!,
                  onTap: () {
                    final s = sourates.firstWhere(
                      (s) => s.numero == _lastSurahNum,
                      orElse: () => sourates.first,
                    );
                    _openSourate(s, initialVersetNum: _lastVersetNum!);
                  },
                  onDismiss: () async {
                    setState(() {
                      _lastSurahNum  = null;
                      _lastVersetNum = null;
                      _lastSurahName = null;
                    });
                    final p = await SharedPreferences.getInstance();
                    await p.remove('deenly_quran_last_surah');
                    await p.remove('deenly_quran_last_verset');
                    await p.remove('deenly_quran_last_surah_name');
                  },
                ),
              ),
            ),

          // ── Signets ─────────────────────────────────────────────────────
          if (_bookmarks.isNotEmpty && _searchQuery.isEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
                child: _BookmarksSection(
                  bookmarks: _bookmarks,
                  onTap: (bm) {
                    final s = sourates.firstWhere(
                      (s) => s.numero == bm.surah,
                      orElse: () => sourates.first,
                    );
                    _openSourate(s, initialVersetNum: bm.verset);
                  },
                  onRemove: (bm) async {
                    final updated = List<({int surah, String surahName, int verset})>.from(_bookmarks)
                      ..removeWhere((b) => b.surah == bm.surah && b.verset == bm.verset);
                    await QuranPrefs.saveBookmarks(updated);
                    if (mounted) setState(() => _bookmarks = updated);
                  },
                ),
              ),
            ),

          // ── Liste des sourates ──────────────────────────────────────────
          _filteredSourates.isEmpty
              ? const SliverFillRemaining(child: _EmptySearchResult())
              : SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final sourate = _filteredSourates[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: _SourateListTile(
                            sourate: sourate,
                            onTap: () => _openSourate(sourate),
                          ),
                        );
                      },
                      childCount: _filteredSourates.length,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_kGreenDeep, _kGreenPrimary],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 22),
          child: Row(children: [
            GestureDetector(
              onTap: () => Navigator.maybePop(context),
              child: Container(
                width: 36, height: 36,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(11),
                  border: Border.all(color: Colors.white.withOpacity(0.18)),
                ),
                child: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.white, size: 15),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'القرآن الكريم',
                    style: TextStyle(
                      color: _kGoldLight, fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Le Saint Coran · 114 sourates',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.55),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.15)),
              ),
              child: Text(
                '${sourates.length} sourates',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 11, fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: _kWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kBeigeBorder),
        boxShadow: const [
          BoxShadow(color: Color(0x08000000), blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: TextField(
        controller: _searchController,
        onChanged: _onSearch,
        style: const TextStyle(color: _kTextDark, fontSize: 14),
        decoration: InputDecoration(
          hintText: 'Rechercher une sourate...',
          hintStyle: const TextStyle(color: _kTextLight, fontSize: 13),
          prefixIcon: const Icon(Icons.search_rounded, color: _kTextLight, size: 20),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.close_rounded, color: _kTextLight, size: 18),
                  onPressed: () {
                    _searchController.clear();
                    _onSearch('');
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}

// ── Bannière "Reprendre la lecture" ──────────────────────────────────────────
class _ReprendreCard extends StatelessWidget {
  final String surahName;
  final int    versetNum;
  final VoidCallback onTap;
  final VoidCallback onDismiss;

  const _ReprendreCard({
    required this.surahName,
    required this.versetNum,
    required this.onTap,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF122E22), Color(0xFF1B4D38)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: _kGreenPrimary.withOpacity(0.25),
                blurRadius: 12, offset: const Offset(0, 3)),
          ],
        ),
        child: Row(children: [
          Container(
            width: 38, height: 38,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.12),
              borderRadius: BorderRadius.circular(11),
            ),
            child: const Center(child: Text('📖', style: TextStyle(fontSize: 18))),
          ),
          const SizedBox(width: 12),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Reprendre la lecture',
                  style: TextStyle(color: Colors.white, fontSize: 12,
                      fontWeight: FontWeight.w800)),
              const SizedBox(height: 2),
              Text('$surahName · Verset $versetNum',
                  style: TextStyle(color: Colors.white.withOpacity(0.65), fontSize: 11)),
            ],
          )),
          Icon(Icons.arrow_forward_ios_rounded, color: _kGoldLight, size: 14),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: onDismiss,
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Icon(Icons.close_rounded,
                  color: Colors.white.withOpacity(0.45), size: 16),
            ),
          ),
        ]),
      ),
    );
  }
}

// ── Widget : Ligne de liste d'une sourate ─────────────────────────────────────
class _SourateListTile extends StatelessWidget {
  final Sourate sourate;
  final VoidCallback onTap;

  const _SourateListTile({required this.sourate, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final hasContent = sourate.versets.isNotEmpty;

    return GestureDetector(
      onTap: hasContent ? onTap : () => _showComingSoon(context, sourate.nomFrancais),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: _kWhite,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _kBeigeBorder),
          boxShadow: const [
            BoxShadow(color: Color(0x06000000), blurRadius: 6, offset: Offset(0, 2)),
          ],
        ),
        child: Row(children: [
          // Numéro
          Container(
            width: 42, height: 42,
            decoration: BoxDecoration(
              gradient: hasContent
                  ? const LinearGradient(colors: [_kGreenPrimary, _kGreenMedium])
                  : null,
              color: hasContent ? null : _kBeigeCard,
              borderRadius: BorderRadius.circular(13),
              boxShadow: hasContent
                  ? [BoxShadow(color: _kGreenPrimary.withOpacity(0.25),
                      blurRadius: 8, offset: const Offset(0, 3))]
                  : null,
            ),
            child: Center(
              child: Text(
                '${sourate.numero}',
                style: TextStyle(
                  color: hasContent ? Colors.white : _kTextLight,
                  fontWeight: FontWeight.w800, fontSize: 13,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Infos
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sourate.nomFrancais,
                  style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w700,
                    color: hasContent ? _kTextDark : _kTextLight,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                Row(children: [
                  Text(
                    '${sourate.nombreVersets} versets',
                    style: const TextStyle(fontSize: 11, color: _kTextLight),
                  ),
                  if (!hasContent) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: _kBeigeCard,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text('Bientôt',
                        style: TextStyle(
                          fontSize: 9, color: _kGold,
                          fontWeight: FontWeight.w700,
                        )),
                    ),
                  ],
                ]),
              ],
            ),
          ),

          // Nom arabe + chevron
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                sourate.nomArabe,
                style: const TextStyle(
                  fontSize: 17, color: _kGreenPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 3),
              Icon(
                hasContent
                    ? Icons.arrow_forward_ios_rounded
                    : Icons.lock_outline_rounded,
                size: 12,
                color: _kTextLight,
              ),
            ],
          ),
        ]),
      ),
    );
  }

  void _showComingSoon(BuildContext context, String nom) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Le contenu de "$nom" arrive bientôt, إن شاء الله !'),
      backgroundColor: _kGreenPrimary,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ));
  }
}

// ── Widget : Résultat de recherche vide ───────────────────────────────────────
class _EmptySearchResult extends StatelessWidget {
  const _EmptySearchResult();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 80, height: 80,
          decoration: BoxDecoration(
            color: _kBeigeCard,
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Center(child: Text('🔍', style: TextStyle(fontSize: 36))),
        ),
        const SizedBox(height: 16),
        const Text(
          'Aucune sourate trouvée',
          style: TextStyle(color: _kTextMid, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        const Text(
          'Essaie un autre mot-clé',
          style: TextStyle(color: _kTextLight, fontSize: 13),
        ),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// ÉCRAN DÉTAIL D'UNE SOURATE
// ══════════════════════════════════════════════════════════════════════════════
class SourateDetailScreen extends StatefulWidget {
  final Sourate sourate;
  final int     initialVersetNum; // 1-based, default = 1
  const SourateDetailScreen({
    super.key,
    required this.sourate,
    this.initialVersetNum = 1,
  });

  @override
  State<SourateDetailScreen> createState() => _SourateDetailScreenState();
}

class _SourateDetailScreenState extends State<SourateDetailScreen> {
  bool   _showArabe      = true;
  bool   _showTraduction = true;
  bool   _showPhonetique = true;
  double _arabicFontSize = 22.0;

  late ScrollController _scrollController;
  Timer?  _saveTimer;
  int     _currentVersetNum = 1;   // verset actuellement lisible
  bool    _prefsLoaded = false;

  // Signets de la sourate courante
  Set<int> _bookmarkedVersets = {};
  List<({int surah, String surahName, int verset})> _allBookmarks = [];

  // Mode lecture : cartes (false) ou continu (true)
  bool _modeContinue = false;

  // Hauteur estimée d'une carte (arabe + phonétique + traduction)
  static const double _kEstimatedCardHeight = 210.0;
  // Hauteur du bismillah banner
  static const double _kBismillahHeight     = 72.0;

  @override
  void initState() {
    super.initState();
    _currentVersetNum = widget.initialVersetNum;
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    final size      = await QuranPrefs.loadTextSize();
    final prefs     = await QuranPrefs.loadDisplayPrefs();
    final allBm     = await QuranPrefs.loadBookmarks();
    final modeC     = await QuranPrefs.loadModeContinue();
    if (!mounted) return;
    setState(() {
      _arabicFontSize     = size;
      _showArabe          = prefs.arabe;
      _showTraduction     = prefs.traduction;
      _showPhonetique     = prefs.phonetique;
      _prefsLoaded        = true;
      _allBookmarks       = allBm;
      _modeContinue       = modeC;
      _bookmarkedVersets  = allBm
          .where((b) => b.surah == widget.sourate.numero)
          .map((b) => b.verset)
          .toSet();
    });

    // Scroll vers la position initiale après le premier rendu
    if (widget.initialVersetNum > 1) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToVerset(widget.initialVersetNum));
    }
  }

  Future<void> _toggleBookmark(int versetNum) async {
    final surahNum  = widget.sourate.numero;
    final surahName = widget.sourate.nomFrancais;
    setState(() {
      if (_bookmarkedVersets.contains(versetNum)) {
        _bookmarkedVersets.remove(versetNum);
        _allBookmarks.removeWhere((b) => b.surah == surahNum && b.verset == versetNum);
      } else {
        _bookmarkedVersets.add(versetNum);
        _allBookmarks.add((surah: surahNum, surahName: surahName, verset: versetNum));
        // Trier par numéro de sourate puis verset
        _allBookmarks.sort((a, b) => a.surah != b.surah
            ? a.surah.compareTo(b.surah)
            : a.verset.compareTo(b.verset));
      }
    });
    await QuranPrefs.saveBookmarks(_allBookmarks);
  }

  void _scrollToVerset(int versetNum) {
    if (!_scrollController.hasClients) return;
    final index  = (versetNum - 1).clamp(0, widget.sourate.versets.length - 1);
    final hasBismillah = widget.sourate.numero != 1 && widget.sourate.numero != 9;
    final bismillahOffset = hasBismillah ? _kBismillahHeight : 0.0;
    final targetOffset = bismillahOffset + index * _kEstimatedCardHeight;
    _scrollController.animateTo(
      targetOffset.clamp(0.0, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  void _onScroll() {
    // Estimer le verset visible
    final hasBismillah = widget.sourate.numero != 1 && widget.sourate.numero != 9;
    final bismillahOffset = hasBismillah ? _kBismillahHeight : 0.0;
    final offset = (_scrollController.offset - bismillahOffset).clamp(0.0, double.infinity);
    final estimatedIndex = (offset / _kEstimatedCardHeight).floor();
    final newVersetNum = (estimatedIndex + 1).clamp(1, widget.sourate.versets.length);

    if (newVersetNum != _currentVersetNum) {
      _currentVersetNum = newVersetNum;
    }

    // Sauvegarde avec debounce 1.5s
    _saveTimer?.cancel();
    _saveTimer = Timer(const Duration(milliseconds: 1500), () {
      QuranPrefs.saveLastPosition(
        widget.sourate.numero,
        widget.sourate.nomFrancais,
        _currentVersetNum,
      );
    });
  }

  @override
  void dispose() {
    _saveTimer?.cancel();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    // Sauvegarder la position au départ de l'écran
    QuranPrefs.saveLastPosition(
      widget.sourate.numero,
      widget.sourate.nomFrancais,
      _currentVersetNum,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sourate = widget.sourate;

    if (!_prefsLoaded) {
      return const Scaffold(
        backgroundColor: _kBeige,
        body: Center(child: CircularProgressIndicator(color: _kGreenPrimary)),
      );
    }

    return Scaffold(
      backgroundColor: _kBeige,
      body: Column(children: [
        // ── Header ──────────────────────────────────────────────────────────
        _buildDetailHeader(context, sourate),

        // ── Bismillah ────────────────────────────────────────────────────────
        if (sourate.numero != 1 && sourate.numero != 9)
          _BismillahBanner(),

        // ── Versets ──────────────────────────────────────────────────────────
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
            itemCount: sourate.versets.length,
            itemBuilder: (context, index) {
              final verset = sourate.versets[index];
              if (_modeContinue) {
                return _VersetContinu(
                  verset:           verset,
                  showArabe:        _showArabe,
                  showTraduction:   _showTraduction,
                  showPhonetique:   _showPhonetique,
                  arabicFontSize:   _arabicFontSize,
                  isBookmarked:     _bookmarkedVersets.contains(verset.numero),
                  onToggleBookmark: () => _toggleBookmark(verset.numero),
                  isLast:           index == sourate.versets.length - 1,
                );
              }
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _VersetCard(
                  verset:            verset,
                  showArabe:         _showArabe,
                  showTraduction:    _showTraduction,
                  showPhonetique:    _showPhonetique,
                  arabicFontSize:    _arabicFontSize,
                  isBookmarked:      _bookmarkedVersets.contains(verset.numero),
                  onToggleBookmark:  () => _toggleBookmark(verset.numero),
                ),
              );
            },
          ),
        ),
      ]),
    );
  }

  Widget _buildDetailHeader(BuildContext context, Sourate sourate) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_kGreenDeep, _kGreenPrimary],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 18),
          child: Column(children: [
            // Top row
            Row(children: [
              GestureDetector(
                onTap: () => Navigator.maybePop(context),
                child: Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(11),
                    border: Border.all(color: Colors.white.withOpacity(0.18)),
                  ),
                  child: const Icon(Icons.arrow_back_ios_new_rounded,
                    color: Colors.white, size: 15),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(sourate.nomArabe,
                      style: const TextStyle(
                        color: _kGoldLight, fontSize: 20,
                        fontWeight: FontWeight.w700,
                      )),
                    const SizedBox(height: 2),
                    Text(sourate.nomFrancais.split('–').first.trim(),
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.55), fontSize: 12,
                      )),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => _showDisplayOptions(context),
                child: Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(11),
                    border: Border.all(color: Colors.white.withOpacity(0.18)),
                  ),
                  child: const Icon(Icons.tune_rounded, color: Colors.white, size: 17),
                ),
              ),
            ]),
            const SizedBox(height: 14),
            // Info chips + indicateur de position
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              _DetailChip(label: 'Sourate', value: '${sourate.numero}'),
              const SizedBox(width: 10),
              _DetailChip(label: 'Versets', value: '${sourate.nombreVersets}'),
              const SizedBox(width: 10),
              _DetailChip(label: 'lu', value: '$_currentVersetNum'),
            ]),
          ]),
        ),
      ),
    );
  }

  void _showDisplayOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: _kWhite,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) {

          void saveAll() {
            QuranPrefs.saveDisplayPrefs(
              arabe:      _showArabe,
              traduction: _showTraduction,
              phonetique: _showPhonetique,
            );
            QuranPrefs.saveTextSize(_arabicFontSize);
            QuranPrefs.saveModeContinue(_modeContinue);
          }

          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 6, 20, 36),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Poignée
                Container(
                  width: 40, height: 4,
                  margin: const EdgeInsets.only(top: 10, bottom: 16),
                  decoration: BoxDecoration(
                    color: _kBeigeBorder,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const Text('Options d\'affichage',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: _kTextDark)),
                const SizedBox(height: 20),

                // ── Taille du texte arabe ────────────────────────────
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: _kBeige,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: _kBeigeBorder),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        const Text('أ', style: TextStyle(fontSize: 16, color: _kTextMid)),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text('Taille du texte arabe',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700,
                                color: _kTextDark)),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: _kGreenPrimary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${_arabicFontSize.round()}',
                            style: const TextStyle(color: Colors.white, fontSize: 12,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ]),
                      const SizedBox(height: 10),
                      // Aperçu du texte
                      Center(
                        child: Text(
                          'بِسْمِ اللَّهِ',
                          style: TextStyle(
                            fontSize: _arabicFontSize,
                            color: _kTextDark,
                            height: 1.8,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      // Slider
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor:   _kGreenPrimary,
                          inactiveTrackColor: _kBeigeBorder,
                          thumbColor:         _kGreenPrimary,
                          overlayColor:       _kGreenPrimary.withOpacity(0.15),
                          trackHeight:        3,
                        ),
                        child: Slider(
                          value:    _arabicFontSize,
                          min:      16.0,
                          max:      36.0,
                          divisions: 10,
                          onChanged: (v) {
                            setModalState(() => _arabicFontSize = v);
                            setState(()  => _arabicFontSize = v);
                            saveAll();
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Petit', style: TextStyle(fontSize: 10, color: _kTextLight)),
                          Text('Normal', style: TextStyle(fontSize: 10, color: _kTextLight)),
                          Text('Grand', style: TextStyle(fontSize: 10, color: _kTextLight)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // ── Mode de lecture ──────────────────────────────────
                _ModeToggle(
                  modeContinue: _modeContinue,
                  onChanged: (v) {
                    setModalState(() => _modeContinue = v);
                    setState(() => _modeContinue = v);
                    saveAll();
                  },
                ),
                const SizedBox(height: 14),

                // ── Toggles d'affichage ──────────────────────────────
                _ToggleRow(
                  label: 'Texte arabe', icon: '🔤',
                  value: _showArabe,
                  onChanged: (v) {
                    setModalState(() => _showArabe = v);
                    setState(() => _showArabe = v);
                    saveAll();
                  },
                ),
                _ToggleRow(
                  label: 'Phonétique', icon: '🔊',
                  value: _showPhonetique,
                  onChanged: (v) {
                    setModalState(() => _showPhonetique = v);
                    setState(() => _showPhonetique = v);
                    saveAll();
                  },
                ),
                _ToggleRow(
                  label: 'Traduction française', icon: '🌍',
                  value: _showTraduction,
                  onChanged: (v) {
                    setModalState(() => _showTraduction = v);
                    setState(() => _showTraduction = v);
                    saveAll();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ── Widget : Chip info détail ─────────────────────────────────────────────────
class _DetailChip extends StatelessWidget {
  final String label, value;
  const _DetailChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.15)),
      ),
      child: Row(children: [
        Text(value,
          style: const TextStyle(
            color: _kGoldLight, fontWeight: FontWeight.w800, fontSize: 13,
          )),
        const SizedBox(width: 5),
        Text(label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.55), fontSize: 10,
          )),
      ]),
    );
  }
}

// ── Widget : Toggle row pour options ─────────────────────────────────────────
class _ToggleRow extends StatelessWidget {
  final String label, icon;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ToggleRow({
    required this.label, required this.icon,
    required this.value, required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: value ? const Color(0xFFF0F8F3) : _kBeige,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: value ? _kGreenMedium.withOpacity(0.3) : _kBeigeBorder),
      ),
      child: Row(children: [
        Text(icon, style: const TextStyle(fontSize: 16)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(label,
            style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600,
              color: value ? _kTextDark : _kTextLight,
            )),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: _kGreenPrimary,
          activeTrackColor: _kGreenMedium.withOpacity(0.3),
        ),
      ]),
    );
  }
}

// ── Widget : Bismillah ────────────────────────────────────────────────────────
class _BismillahBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      decoration: BoxDecoration(
        color: _kWhite,
        border: Border(
          bottom: BorderSide(color: _kBeigeBorder),
        ),
      ),
      child: Column(children: [
        const Text(
          'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
          style: TextStyle(
            fontSize: 22, color: _kTextDark, height: 1.8,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          'Au nom d\'Allah, le Tout Miséricordieux',
          style: const TextStyle(
            fontSize: 11, color: _kTextLight,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
      ]),
    );
  }
}

// ── Widget : Carte d'un verset ────────────────────────────────────────────────
class _VersetCard extends StatelessWidget {
  final Verset        verset;
  final bool          showArabe, showTraduction, showPhonetique;
  final double        arabicFontSize;
  final bool          isBookmarked;
  final VoidCallback? onToggleBookmark;

  const _VersetCard({
    required this.verset,
    required this.showArabe,
    required this.showTraduction,
    required this.showPhonetique,
    this.arabicFontSize   = 22.0,
    this.isBookmarked     = false,
    this.onToggleBookmark,
  });

  @override
  Widget build(BuildContext context) {
    // Tailles dérivées
    final phoneticSize    = (arabicFontSize * 0.54).clamp(11.0, 18.0);
    final translationSize = (arabicFontSize * 0.58).clamp(12.0, 20.0);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kWhite,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _kBeigeBorder),
        boxShadow: const [
          BoxShadow(color: Color(0x06000000), blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // En-tête du verset
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 32, height: 32,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [_kGreenPrimary, _kGreenMedium],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    '${verset.numero}',
                    style: const TextStyle(
                      color: Colors.white, fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: onToggleBookmark,
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Icon(
                    isBookmarked
                        ? Icons.bookmark_rounded
                        : Icons.bookmark_border_rounded,
                    color: isBookmarked ? _kGold : _kTextLight,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),

          // Texte arabe
          if (showArabe) ...[
            const SizedBox(height: 14),
            Text(
              verset.arabe,
              style: TextStyle(
                fontSize: arabicFontSize, color: _kTextDark, height: 1.9,
              ),
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
            ),
          ],

          // Phonétique
          if (showPhonetique) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F0FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                verset.phonetique,
                style: TextStyle(
                  fontSize: phoneticSize, color: const Color(0xFF2855A0),
                  fontStyle: FontStyle.italic, height: 1.5,
                ),
              ),
            ),
          ],

          // Traduction
          if (showTraduction) ...[
            if (showArabe || showPhonetique) ...[
              const SizedBox(height: 10),
              const Divider(height: 1, color: _kBeigeBorder),
            ],
            const SizedBox(height: 10),
            Text(
              verset.francais,
              style: TextStyle(
                fontSize: translationSize, color: _kTextMid, height: 1.6,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ── Widget : Section signets ──────────────────────────────────────────────────
class _BookmarksSection extends StatelessWidget {
  final List<({int surah, String surahName, int verset})>  bookmarks;
  final void Function(({int surah, String surahName, int verset})) onTap;
  final void Function(({int surah, String surahName, int verset})) onRemove;

  const _BookmarksSection({
    required this.bookmarks,
    required this.onTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8C97A), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            const Icon(Icons.bookmark_rounded, color: _kGold, size: 16),
            const SizedBox(width: 6),
            Text(
              'Mes signets (${bookmarks.length})',
              style: const TextStyle(
                color: _kGreenDeep, fontSize: 12, fontWeight: FontWeight.w800,
              ),
            ),
          ]),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: bookmarks.map((bm) => GestureDetector(
              onTap: () => onTap(bm),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: _kWhite,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE8C97A)),
                ),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Text(
                    '${bm.surahName} · V.${bm.verset}',
                    style: const TextStyle(
                      color: _kGreenPrimary, fontSize: 11, fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: () => onRemove(bm),
                    child: const Icon(Icons.close_rounded, size: 13, color: _kTextLight),
                  ),
                ]),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }
}

// ── Widget : Sélecteur de mode de lecture ─────────────────────────────────────
class _ModeToggle extends StatelessWidget {
  final bool modeContinue;
  final ValueChanged<bool> onChanged;
  const _ModeToggle({required this.modeContinue, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: _kBeige,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kBeigeBorder),
      ),
      child: Row(children: [
        _ModeBtn(icon: '▦', label: 'Cartes',   selected: !modeContinue, onTap: () => onChanged(false)),
        _ModeBtn(icon: '☷', label: 'Continu', selected:  modeContinue, onTap: () => onChanged(true)),
      ]),
    );
  }
}

class _ModeBtn extends StatelessWidget {
  final String icon, label;
  final bool selected;
  final VoidCallback onTap;
  const _ModeBtn({required this.icon, required this.label,
      required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selected ? _kGreenPrimary : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(icon, style: TextStyle(
              fontSize: 18,
              color: selected ? Colors.white : _kTextLight,
            )),
            const SizedBox(height: 3),
            Text(label, style: TextStyle(
              fontSize: 11, fontWeight: FontWeight.w700,
              color: selected ? Colors.white : _kTextLight,
            )),
          ]),
        ),
      ),
    );
  }
}

// ── Widget : Verset mode lecture continue ─────────────────────────────────────
class _VersetContinu extends StatelessWidget {
  final Verset        verset;
  final bool          showArabe, showTraduction, showPhonetique;
  final double        arabicFontSize;
  final bool          isBookmarked;
  final VoidCallback? onToggleBookmark;
  final bool          isLast;

  const _VersetContinu({
    required this.verset,
    required this.showArabe,
    required this.showTraduction,
    required this.showPhonetique,
    this.arabicFontSize   = 22.0,
    this.isBookmarked     = false,
    this.onToggleBookmark,
    this.isLast           = false,
  });

  @override
  Widget build(BuildContext context) {
    final phoneticSize    = (arabicFontSize * 0.54).clamp(11.0, 18.0);
    final translationSize = (arabicFontSize * 0.58).clamp(12.0, 20.0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Numéro du verset + bouton signet
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 26, height: 26,
                decoration: BoxDecoration(
                  color: _kGreenPrimary.withOpacity(0.08),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text('${verset.numero}',
                    style: const TextStyle(
                      color: _kGreenMedium, fontSize: 10, fontWeight: FontWeight.w800,
                    )),
                ),
              ),
              GestureDetector(
                onTap: onToggleBookmark,
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Icon(
                    isBookmarked ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                    color: isBookmarked ? _kGold : _kBeigeBorder,
                    size: 17,
                  ),
                ),
              ),
            ],
          ),

          // Texte arabe
          if (showArabe) ...[
            const SizedBox(height: 10),
            Text(
              verset.arabe,
              style: TextStyle(fontSize: arabicFontSize, color: _kTextDark, height: 2.0),
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
            ),
          ],

          // Phonétique
          if (showPhonetique) ...[
            const SizedBox(height: 6),
            Text(
              verset.phonetique,
              style: TextStyle(
                fontSize: phoneticSize, color: const Color(0xFF5577BB),
                fontStyle: FontStyle.italic, height: 1.5,
              ),
            ),
          ],

          // Traduction
          if (showTraduction) ...[
            const SizedBox(height: 6),
            Text(
              verset.francais,
              style: TextStyle(fontSize: translationSize, color: _kTextMid, height: 1.6),
            ),
          ],

          // Séparateur décoratif inter-versets (sauf le dernier)
          if (!isLast) ...[
            const SizedBox(height: 14),
            Row(children: [
              Expanded(child: Divider(height: 1, color: _kBeigeBorder.withOpacity(0.6))),
              const SizedBox(width: 10),
              Text('✦', style: TextStyle(color: _kGold.withOpacity(0.4), fontSize: 10)),
              const SizedBox(width: 10),
              Expanded(child: Divider(height: 1, color: _kBeigeBorder.withOpacity(0.6))),
            ]),
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}
