// spiritualite_screen.dart — Module Spiritualité · Application UpYourDeen
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'adhkar_data.dart';
import 'invocations_data.dart';
import 'noms_allah_data.dart';

// ── Palette ───────────────────────────────────────────────────────────────
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

// ══════════════════════════════════════════════════════════════════════════
// ÉCRAN PRINCIPAL
// ══════════════════════════════════════════════════════════════════════════
class SpiritualiteScreen extends StatefulWidget {
  const SpiritualiteScreen({super.key});
  @override
  State<SpiritualiteScreen> createState() => _SpiritualiteScreenState();
}

class _SpiritualiteScreenState extends State<SpiritualiteScreen>
    with TickerProviderStateMixin {
  late final TabController _tab;

  // ── Shared state ──────────────────────────────────────────────────────
  // Adhkar progression: categoryId → set of completed dhikr indices
  final Map<String, Set<int>> _adhkarProgress = {};

  // Invocations favorites: set of "categoryId:invocationIndex"
  final Set<String> _favoriteInvocations = {};

  // Tasbih history: list of completed sessions
  final List<_TasbihSession> _tasbihHistory = [];

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  void _toggleDhikr(String categoryId, int index) {
    setState(() {
      _adhkarProgress.putIfAbsent(categoryId, () => {});
      final set = _adhkarProgress[categoryId]!;
      if (set.contains(index)) {
        set.remove(index);
      } else {
        set.add(index);
      }
    });
  }

  void _toggleFavorite(String categoryId, int invocationIndex) {
    setState(() {
      final key = '$categoryId:$invocationIndex';
      if (_favoriteInvocations.contains(key)) {
        _favoriteInvocations.remove(key);
      } else {
        _favoriteInvocations.add(key);
      }
    });
  }

  bool _isFavorite(String categoryId, int invocationIndex) {
    return _favoriteInvocations.contains('$categoryId:$invocationIndex');
  }

  void _addTasbihSession(_TasbihSession session) {
    setState(() {
      _tasbihHistory.insert(0, session);
    });
  }

  int _adhkarDone(String categoryId) {
    return _adhkarProgress[categoryId]?.length ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBeige,
      body: NestedScrollView(
        headerSliverBuilder: (_, __) => [
          SliverAppBar(
            expandedHeight: 130,
            pinned: true,
            backgroundColor: _kGreenDeep,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [_kGreenDeep, _kGreenPrimary],
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
                            Text('✨', style: const TextStyle(fontSize: 28)),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('Spiritualité',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
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
            bottom: TabBar(
              controller: _tab,
              indicatorColor: _kGold,
              indicatorWeight: 3,
              labelColor: _kGold,
              unselectedLabelColor: const Color(0xFF8AB8A0),
              labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              isScrollable: true,
              tabs: const [
                Tab(text: '🤲 Adhkar'),
                Tab(text: '📿 Invocations'),
                Tab(text: '✨ 99 Noms'),
                Tab(text: '📿 Tasbih'),
              ],
            ),
          ),
        ],
        body: TabBarView(
          controller: _tab,
          children: [
            _AdhkarTab(
              progress: _adhkarProgress,
              onToggle: _toggleDhikr,
            ),
            _InvocationsTab(
              favorites: _favoriteInvocations,
              onToggleFavorite: _toggleFavorite,
              isFavorite: _isFavorite,
            ),
            const _NomsTab(),
            _TasbihTab(
              history: _tasbihHistory,
              onSessionComplete: _addTasbihSession,
            ),
          ],
        ),
      ),
    );
  }
}

// ── Tasbih session model ────────────────────────────────────────────────
class _TasbihSession {
  final String label;
  final int count;
  final DateTime time;
  const _TasbihSession({required this.label, required this.count, required this.time});
}

// ══════════════════════════════════════════════════════════════════════════
// TAB 1 — ADHKAR (with progression tracking)
// ══════════════════════════════════════════════════════════════════════════
class _AdhkarTab extends StatelessWidget {
  final Map<String, Set<int>> progress;
  final void Function(String categoryId, int index) onToggle;

  const _AdhkarTab({required this.progress, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(14),
      itemCount: kAdhkar.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (ctx, i) {
        final cat = kAdhkar[i];
        final done = progress[cat.id]?.length ?? 0;
        return _AdhkarCategoryCard(
          category: cat,
          doneCount: done,
          progress: progress,
          onToggle: onToggle,
        );
      },
    );
  }
}

class _AdhkarCategoryCard extends StatelessWidget {
  final DhikrCategory category;
  final int doneCount;
  final Map<String, Set<int>> progress;
  final void Function(String categoryId, int index) onToggle;

  const _AdhkarCategoryCard({
    required this.category,
    required this.doneCount,
    required this.progress,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final total = category.adhkar.length;
    final ratio = total > 0 ? doneCount / total : 0.0;
    final isComplete = doneCount >= total;

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => _AdhkarDetailScreen(
            category: category,
            progress: progress,
            onToggle: onToggle,
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _kBeigeCard,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: isComplete ? _kGold : _kBeigeBorder),
          boxShadow: const [
            BoxShadow(color: Color(0x10000000), blurRadius: 5, offset: Offset(0, 2)),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isComplete
                          ? [_kGold, const Color(0xFFE0AD50)]
                          : [_kGreenPrimary, _kGreenMedium],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: isComplete
                        ? const Icon(Icons.check_circle, color: Colors.white, size: 28)
                        : Text(category.emoji, style: const TextStyle(fontSize: 28)),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(category.title,
                          style: const TextStyle(
                            color: _kTextDark,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          )),
                      const SizedBox(height: 3),
                      Text(category.description,
                          style: const TextStyle(color: _kTextLight, fontSize: 12.5),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
                // Progress badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: isComplete ? _kGoldLight : _kBeige,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '$doneCount/$total',
                    style: TextStyle(
                      color: isComplete ? _kGold : _kTextLight,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.chevron_right, color: _kTextLight),
              ],
            ),
            // Progress bar
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: ratio,
                minHeight: 4,
                backgroundColor: _kBeige,
                valueColor: AlwaysStoppedAnimation<Color>(
                  isComplete ? _kGold : _kGreenMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AdhkarDetailScreen extends StatelessWidget {
  final DhikrCategory category;
  final Map<String, Set<int>> progress;
  final void Function(String categoryId, int index) onToggle;

  const _AdhkarDetailScreen({
    required this.category,
    required this.progress,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final done = progress[category.id]?.length ?? 0;
    final total = category.adhkar.length;

    return Scaffold(
      backgroundColor: _kBeige,
      appBar: AppBar(
        backgroundColor: _kGreenDeep,
        foregroundColor: Colors.white,
        title: Text('${category.emoji} ${category.title}'),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$done/$total',
                  style: const TextStyle(
                    color: _kGold,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(14),
        itemCount: category.adhkar.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (ctx, i) {
          final checked = progress[category.id]?.contains(i) ?? false;
          return _DhikrCard(
            dhikr: category.adhkar[i],
            checked: checked,
            onToggle: () => onToggle(category.id, i),
          );
        },
      ),
    );
  }
}

class _DhikrCard extends StatelessWidget {
  final Dhikr dhikr;
  final bool checked;
  final VoidCallback onToggle;
  const _DhikrCard({required this.dhikr, required this.checked, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: checked ? _kGoldLight.withOpacity(0.5) : _kBeigeCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: checked ? _kGold.withOpacity(0.5) : _kBeigeBorder),
        boxShadow: const [
          BoxShadow(color: Color(0x10000000), blurRadius: 5, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Arabic Text
          Text(
            dhikr.arabic,
            style: const TextStyle(
              color: _kTextDark,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              height: 1.8,
            ),
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 8),
          // Phonetic
          Text(
            dhikr.phonetic,
            style: const TextStyle(
              color: _kGold,
              fontSize: 13,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 6),
          // Translation
          Text(
            dhikr.translation,
            style: const TextStyle(
              color: _kTextMid,
              fontSize: 12.5,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 8),
          // Source, Repeat and Checkmark
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                dhikr.source,
                style: const TextStyle(
                  color: _kTextLight,
                  fontSize: 11,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: _kGoldLight,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '\u00d7${dhikr.repeat}',
                      style: const TextStyle(
                        color: _kGold,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: onToggle,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: checked ? _kGreenMedium : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: checked ? _kGreenMedium : _kBeigeBorder,
                          width: 2,
                        ),
                      ),
                      child: checked
                          ? const Icon(Icons.check, color: Colors.white, size: 18)
                          : null,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
// TAB 2 — INVOCATIONS (with favorites)
// ══════════════════════════════════════════════════════════════════════════
class _InvocationsTab extends StatelessWidget {
  final Set<String> favorites;
  final void Function(String categoryId, int index) onToggleFavorite;
  final bool Function(String categoryId, int index) isFavorite;

  const _InvocationsTab({
    required this.favorites,
    required this.onToggleFavorite,
    required this.isFavorite,
  });

  static const _catColors = <int, List<Color>>{
    0:  [Color(0xFF1B7A4D), Color(0xFFE8F4EE)], // Quotidien
    1:  [Color(0xFF1A5C8A), Color(0xFFE3EDF7)], // Voyage
    2:  [Color(0xFFA02020), Color(0xFFFDE8E8)], // Maladie
    3:  [Color(0xFFA85C00), Color(0xFFFAEBD7)], // Argent
    4:  [Color(0xFF6A3FAA), Color(0xFFF3ECFA)], // Famille
    5:  [Color(0xFFB8336A), Color(0xFFFDE8F0)], // Mariage
    6:  [Color(0xFF2A6478), Color(0xFFE0F0F5)], // Protection
    7:  [Color(0xFFC8933A), Color(0xFFFFF4DC)], // Souhait
    8:  [Color(0xFF3A7A3A), Color(0xFFE6F5E6)], // Repentir
    9:  [Color(0xFF4A4A5A), Color(0xFFEAEAEF)], // Deuil
    10: [Color(0xFF5A3A1A), Color(0xFFF5EDE0)], // Travail
    11: [Color(0xFF306090), Color(0xFFE0ECF5)], // Pluie
  };

  // Collect all favorites into a flat list
  List<_FavoriteEntry> _collectFavorites() {
    final result = <_FavoriteEntry>[];
    for (var ci = 0; ci < kInvocations.length; ci++) {
      final cat = kInvocations[ci];
      for (var ii = 0; ii < cat.invocations.length; ii++) {
        if (isFavorite(cat.id, ii)) {
          result.add(_FavoriteEntry(
            categoryIndex: ci,
            invocationIndex: ii,
            category: cat,
            invocation: cat.invocations[ii],
          ));
        }
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final favs = _collectFavorites();

    return ListView(
      padding: const EdgeInsets.all(14),
      children: [
        // Favorites section
        if (favs.isNotEmpty) ...[
          Row(
            children: const [
              Icon(Icons.favorite, color: Color(0xFFE04050), size: 18),
              SizedBox(width: 6),
              Text('Mes favoris',
                  style: TextStyle(
                    color: _kTextDark,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  )),
            ],
          ),
          const SizedBox(height: 10),
          ...favs.map((fav) {
            final colors = _catColors[fav.categoryIndex] ?? const [Color(0xFF1B4D38), Color(0xFFE8F4EE)];
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _FavoriteRow(
                fav: fav,
                primary: colors[0],
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => _InvocationDetailScreen(
                      category: fav.category,
                      favorites: favorites,
                      onToggleFavorite: onToggleFavorite,
                      isFavorite: isFavorite,
                    ),
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 16),
          Container(height: 1, color: _kBeigeBorder),
          const SizedBox(height: 16),
        ],

        // Categories list
        ...List.generate(kInvocations.length, (i) {
          final cat = kInvocations[i];
          final colors = _catColors[i] ?? const [Color(0xFF1B4D38), Color(0xFFE8F4EE)];
          final primary = colors[0];
          final bg = colors[1];
          return Padding(
            padding: EdgeInsets.only(bottom: i < kInvocations.length - 1 ? 10 : 0),
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => _InvocationDetailScreen(
                    category: cat,
                    favorites: favorites,
                    onToggleFavorite: onToggleFavorite,
                    isFavorite: isFavorite,
                  ),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: _kBeigeCard,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: _kBeigeBorder, width: 1.2),
                  boxShadow: const [
                    BoxShadow(color: Color(0x0E000000), blurRadius: 8, offset: Offset(0, 2)),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48, height: 48,
                      decoration: BoxDecoration(
                        color: bg,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: primary.withOpacity(0.2)),
                      ),
                      alignment: Alignment.center,
                      child: Text(cat.emoji, style: const TextStyle(fontSize: 22)),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cat.title,
                            style: TextStyle(
                              color: primary,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            cat.description,
                            style: const TextStyle(color: _kTextLight, fontSize: 11),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: bg,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${cat.invocations.length}',
                        style: TextStyle(
                          color: primary,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(Icons.chevron_right_rounded, color: _kTextLight.withOpacity(0.6), size: 20),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}

class _FavoriteEntry {
  final int categoryIndex;
  final int invocationIndex;
  final InvocationCategory category;
  final Invocation invocation;
  const _FavoriteEntry({
    required this.categoryIndex,
    required this.invocationIndex,
    required this.category,
    required this.invocation,
  });
}

class _FavoriteRow extends StatelessWidget {
  final _FavoriteEntry fav;
  final Color primary;
  final VoidCallback onTap;
  const _FavoriteRow({required this.fav, required this.primary, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: _kBeigeCard,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE04050).withOpacity(0.2)),
        ),
        child: Row(
          children: [
            const Icon(Icons.favorite, color: Color(0xFFE04050), size: 16),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fav.invocation.phonetic,
                    style: TextStyle(
                      color: primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    fav.category.title,
                    style: const TextStyle(color: _kTextLight, fontSize: 10),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: _kTextLight.withOpacity(0.5), size: 18),
          ],
        ),
      ),
    );
  }
}

class _InvocationDetailScreen extends StatelessWidget {
  final InvocationCategory category;
  final Set<String> favorites;
  final void Function(String categoryId, int index) onToggleFavorite;
  final bool Function(String categoryId, int index) isFavorite;

  const _InvocationDetailScreen({
    required this.category,
    required this.favorites,
    required this.onToggleFavorite,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBeige,
      appBar: AppBar(
        backgroundColor: _kGreenDeep,
        foregroundColor: Colors.white,
        title: Text('${category.emoji} ${category.title}'),
        elevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(14),
        itemCount: category.invocations.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (ctx, i) => _InvocationCard(
          invocation: category.invocations[i],
          isFavorite: isFavorite(category.id, i),
          onToggleFavorite: () => onToggleFavorite(category.id, i),
        ),
      ),
    );
  }
}

class _InvocationCard extends StatelessWidget {
  final Invocation invocation;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;
  const _InvocationCard({
    required this.invocation,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kBeigeCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kBeigeBorder),
        boxShadow: const [
          BoxShadow(color: Color(0x10000000), blurRadius: 5, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Favorite button at top right
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: onToggleFavorite,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    key: ValueKey(isFavorite),
                    color: isFavorite ? const Color(0xFFE04050) : _kTextLight.withOpacity(0.4),
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
          // Arabic Text
          Text(
            invocation.arabic,
            style: const TextStyle(
              color: _kTextDark,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              height: 1.8,
            ),
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 8),
          // Phonetic
          Text(
            invocation.phonetic,
            style: const TextStyle(
              color: _kGold,
              fontSize: 13,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 6),
          // Translation
          Text(
            invocation.translation,
            style: const TextStyle(
              color: _kTextMid,
              fontSize: 12.5,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 8),
          // Source
          Text(
            invocation.source,
            style: const TextStyle(
              color: _kTextLight,
              fontSize: 11,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
// TAB 3 — 99 NOMS D ALLAH (with Nom du Jour)
// ══════════════════════════════════════════════════════════════════════════
class _NomsTab extends StatelessWidget {
  const _NomsTab();

  int _nomDuJourIndex() {
    final now = DateTime.now();
    final startOfYear = DateTime(now.year, 1, 1);
    final dayOfYear = now.difference(startOfYear).inDays;
    return dayOfYear % kNomsAllah.length;
  }

  @override
  Widget build(BuildContext context) {
    final nomIndex = _nomDuJourIndex();
    final nomDuJour = kNomsAllah[nomIndex];

    return ListView.builder(
      padding: const EdgeInsets.all(14),
      itemCount: kNomsAllah.length + 1, // +1 for the Nom du Jour header
      itemBuilder: (ctx, i) {
        if (i == 0) {
          return _NomDuJourCard(nom: nomDuJour);
        }
        final realIndex = i - 1;
        return Padding(
          padding: const EdgeInsets.only(top: 10),
          child: _NomCard(
            nom: kNomsAllah[realIndex],
            isNomDuJour: realIndex == nomIndex,
          ),
        );
      },
    );
  }
}

class _NomDuJourCard extends StatelessWidget {
  final NomAllah nom;
  const _NomDuJourCard({required this.nom});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_kGreenDeep, _kGreenPrimary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: _kGreenDeep.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.auto_awesome, color: _kGold, size: 18),
              const SizedBox(width: 8),
              const Text(
                'Nom du Jour',
                style: TextStyle(
                  color: _kGold,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.auto_awesome, color: _kGold, size: 18),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            nom.arabic,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 8),
          Text(
            nom.phonetic,
            style: const TextStyle(
              color: _kGold,
              fontSize: 16,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            nom.meaning,
            style: TextStyle(
              color: Colors.white.withOpacity(0.85),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              nom.explanation,
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 12.5,
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: _kGold.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              nom.bienfait,
              style: const TextStyle(
                color: _kGold,
                fontSize: 11.5,
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _NomCard extends StatefulWidget {
  final NomAllah nom;
  final bool isNomDuJour;
  const _NomCard({required this.nom, this.isNomDuJour = false});

  @override
  State<_NomCard> createState() => _NomCardState();
}

class _NomCardState extends State<_NomCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _expanded = !_expanded),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: widget.isNomDuJour ? _kGoldLight : _kBeigeCard,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: widget.isNomDuJour ? _kGold : _kBeigeBorder,
            width: widget.isNomDuJour ? 1.5 : 1,
          ),
          boxShadow: const [
            BoxShadow(color: Color(0x10000000), blurRadius: 5, offset: Offset(0, 2)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: widget.isNomDuJour ? _kGold : _kGold,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${widget.nom.number}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (widget.isNomDuJour)
                            Container(
                              margin: const EdgeInsets.only(right: 8),
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: _kGold,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text(
                                'Aujourd\'hui',
                                style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w600),
                              ),
                            ),
                          Text(
                            widget.nom.arabic,
                            style: const TextStyle(
                              color: _kTextDark,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.nom.phonetic,
                        style: const TextStyle(
                          color: _kGold,
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        widget.nom.meaning,
                        style: const TextStyle(
                          color: _kTextMid,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (_expanded) ...[
              const SizedBox(height: 12),
              Container(height: 1, color: _kBeigeBorder),
              const SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Explication',
                    style: TextStyle(
                      color: _kGold,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.nom.explanation,
                    style: const TextStyle(
                      color: _kTextMid,
                      fontSize: 12.5,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Bienfaits',
                    style: TextStyle(
                      color: _kGold,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.nom.bienfait,
                    style: const TextStyle(
                      color: _kTextMid,
                      fontSize: 12.5,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
// TAB 4 — TASBIH COUNTER (with history)
// ══════════════════════════════════════════════════════════════════════════
class _TasbihTab extends StatefulWidget {
  final List<_TasbihSession> history;
  final void Function(_TasbihSession session) onSessionComplete;
  const _TasbihTab({required this.history, required this.onSessionComplete});

  @override
  State<_TasbihTab> createState() => _TasbihTabState();
}

class _TasbihTabState extends State<_TasbihTab> {
  int _count = 0;
  String? _selectedPreset;

  final Map<String, int> _presetTargets = {
    'subhanallah': 33,
    'alhamdulillah': 33,
    'allahu_akbar': 34,
  };

  final Map<String, String> _presetLabels = {
    'subhanallah': 'SubhanAllah',
    'alhamdulillah': 'Alhamdulillah',
    'allahu_akbar': 'Allahu Akbar',
    'libre': 'Libre',
  };

  int get _targetCount {
    if (_selectedPreset == null || _selectedPreset == 'libre') return 0;
    return _presetTargets[_selectedPreset] ?? 0;
  }

  bool get _isComplete {
    if (_targetCount == 0) return false;
    return _count >= _targetCount;
  }

  void _increment() {
    setState(() {
      if (_isComplete) {
        // Save session before resetting
        _saveSession();
        _count = 0;
      } else {
        _count++;
        // Auto-save when target is reached
        if (_isComplete) {
          _saveSession();
        }
      }
    });
  }

  void _saveSession() {
    if (_count == 0) return;
    final label = _presetLabels[_selectedPreset] ?? 'Libre';
    widget.onSessionComplete(_TasbihSession(
      label: label,
      count: _count,
      time: DateTime.now(),
    ));
  }

  void _reset() {
    // Save current session if any count
    if (_count > 0) {
      _saveSession();
    }
    setState(() {
      _count = 0;
      _selectedPreset = null;
    });
  }

  void _selectPreset(String preset) {
    // Save current session if switching presets
    if (_count > 0 && _selectedPreset != null) {
      _saveSession();
    }
    setState(() {
      _selectedPreset = preset;
      _count = 0;
    });
  }

  String _formatTime(DateTime time) {
    final h = time.hour.toString().padLeft(2, '0');
    final m = time.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),

          // Presets
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: [
              _PresetButton(
                label: 'SubhanAllah\n\u00d733',
                emoji: '\uD83C\uDF19',
                isSelected: _selectedPreset == 'subhanallah',
                onTap: () => _selectPreset('subhanallah'),
              ),
              _PresetButton(
                label: 'Alhamdulillah\n\u00d733',
                emoji: '\uD83D\uDC4F',
                isSelected: _selectedPreset == 'alhamdulillah',
                onTap: () => _selectPreset('alhamdulillah'),
              ),
              _PresetButton(
                label: 'Allahu Akbar\n\u00d734',
                emoji: '\uD83D\uDE4C',
                isSelected: _selectedPreset == 'allahu_akbar',
                onTap: () => _selectPreset('allahu_akbar'),
              ),
              _PresetButton(
                label: 'Libre',
                emoji: '\uD83D\uDCFF',
                isSelected: _selectedPreset == 'libre',
                onTap: () => _selectPreset('libre'),
              ),
            ],
          ),

          const SizedBox(height: 40),

          // Main Counter Display
          if (_selectedPreset != null) ...[
            Text(
              _selectedPreset == 'libre'
                  ? 'Comptage libre'
                  : '$_count/${_targetCount}',
              style: const TextStyle(
                color: _kGold,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 30),

            // Large circular button
            GestureDetector(
              onTap: _increment,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: _isComplete
                        ? [_kGold, const Color(0xFFE0AD50)]
                        : [_kGreenPrimary, _kGreenMedium],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: (_isComplete ? _kGold : _kGreenDeep).withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$_count',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 72,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (_isComplete)
                        const Text(
                          'Tap pour recommencer',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 10,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            if (_isComplete)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: _kGoldLight,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '\u2713 Compl\u00e9t\u00e9 !',
                  style: TextStyle(
                    color: _kGold,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            const SizedBox(height: 20),

            GestureDetector(
              onTap: _reset,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: _kBeigeCard,
                  border: Border.all(color: _kBeigeBorder),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'R\u00e9initialiser',
                  style: TextStyle(
                    color: _kTextMid,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ] else
            Column(
              children: const [
                Text('\uD83D\uDCFF', style: TextStyle(fontSize: 64)),
                SizedBox(height: 20),
                Text(
                  'Choisissez un mode ci-dessus\npour commencer',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: _kTextMid, fontSize: 14),
                ),
              ],
            ),

          // ── Today's History ──────────────────────────────────────────
          if (widget.history.isNotEmpty) ...[
            const SizedBox(height: 40),
            Container(height: 1, color: _kBeigeBorder),
            const SizedBox(height: 20),
            Row(
              children: const [
                Icon(Icons.history, color: _kGold, size: 18),
                SizedBox(width: 8),
                Text(
                  'Historique du jour',
                  style: TextStyle(
                    color: _kTextDark,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Summary totals
            _TasbihSummary(history: widget.history),
            const SizedBox(height: 12),

            // Session list
            ...widget.history.map((session) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: _kBeigeCard,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _kBeigeBorder),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: _kGoldLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          '\uD83D\uDCFF',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            session.label,
                            style: const TextStyle(
                              color: _kTextDark,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '\u00d7${session.count}',
                            style: const TextStyle(
                              color: _kGold,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      _formatTime(session.time),
                      style: const TextStyle(
                        color: _kTextLight,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            )),
          ],
        ],
      ),
    );
  }
}

class _TasbihSummary extends StatelessWidget {
  final List<_TasbihSession> history;
  const _TasbihSummary({required this.history});

  @override
  Widget build(BuildContext context) {
    // Aggregate totals by label
    final totals = <String, int>{};
    for (final s in history) {
      totals[s.label] = (totals[s.label] ?? 0) + s.count;
    }
    final totalAll = totals.values.fold(0, (a, b) => a + b);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_kGreenDeep, _kGreenPrimary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(
            'Total : \u00d7$totalAll',
            style: const TextStyle(
              color: _kGold,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 12,
            runSpacing: 6,
            alignment: WrapAlignment.center,
            children: totals.entries.map((e) => Text(
              '${e.key} \u00d7${e.value}',
              style: TextStyle(
                color: Colors.white.withOpacity(0.85),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }
}

class _PresetButton extends StatelessWidget {
  final String label;
  final String emoji;
  final bool isSelected;
  final VoidCallback onTap;

  const _PresetButton({
    required this.label,
    required this.emoji,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? _kGoldLight : _kBeigeCard,
          border: Border.all(
            color: isSelected ? _kGold : _kBeigeBorder,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 28)),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? _kGold : _kTextMid,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
