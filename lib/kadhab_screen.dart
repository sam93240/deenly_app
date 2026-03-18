// kadhab_screen.dart
// "Qui est le Kadhab?" — jeu de société islamique façon Undercover
// ─────────────────────────────────────────────────────────────────
// RÈGLES :
//  • 3–10 joueurs. Parmi eux, 1 Kadhab (le menteur).
//  • Chaque tour : un thème + 2 mots tirés aléatoirement.
//    - Tout le monde reçoit le vrai mot SAUF le Kadhab
//      qui reçoit le mot imposteur (proche mais différent).
//  • Le Kadhab ne parle JAMAIS en premier.
//  • Chaque joueur donne un indice (1–2 mots) à tour de rôle.
//  • Vote : le joueur le plus suspect est éliminé.
//    - Si c'est le Kadhab → équipe vérité gagne.
//    - Sinon → Kadhab continue. En cas d'égalité : vote de départage aléatoire.
//  • Si le Kadhab survit jusqu'au dernier joueur : il peut deviner
//    le vrai mot. Bonne réponse → Kadhab gagne !
// ─────────────────────────────────────────────────────────────────

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'translations.dart';

// ══════════════════════════════════════════════════════════════════
// DATA — Paires de mots islamiques (vrai mot / mot imposteur)
// ══════════════════════════════════════════════════════════════════

class _WordPair {
  final String theme;
  final String themeEn;
  final String trueWord;
  final String trueWordEn;
  final String impostorWord;
  final String impostorWordEn;

  const _WordPair(
    this.theme,
    this.trueWord,
    this.impostorWord,
    this.themeEn,
    this.trueWordEn,
    this.impostorWordEn,
  );

  String getTheme(bool isFr) => isFr ? theme : themeEn;
  String getTrueWord(bool isFr) => isFr ? trueWord : trueWordEn;
  String getImpostorWord(bool isFr) => isFr ? impostorWord : impostorWordEn;
}

const List<_WordPair> _kWordPairs = [
  // Pratique / Practice
  _WordPair('Pratique', 'La Salah', 'La Méditation',          'Practice',       'The Salah',      'Meditation'),
  _WordPair('Pratique', 'Le Ramadan', 'Le Carême',             'Practice',       'Ramadan',        'Lent'),
  _WordPair('Pratique', 'La Zakat', 'La Dîme',                 'Practice',       'Zakat',          'The Tithe'),
  _WordPair('Pratique', 'Le Hajj', 'Un pèlerinage',            'Practice',       'The Hajj',       'A Pilgrimage'),
  _WordPair('Pratique', 'L\'Ablution', 'La Douche',            'Practice',       'Ablution (Wudu)','The Shower'),
  _WordPair('Pratique', 'Le Tahajjud', 'La Sieste',            'Practice',       'The Tahajjud',   'A Nap'),
  _WordPair('Pratique', 'L\'Adhan', 'Une cloche',              'Practice',       'The Adhan',      'A Bell'),
  _WordPair('Pratique', 'Le Miswak', 'La Brosse à dents',      'Practice',       'The Miswak',     'The Toothbrush'),
  _WordPair('Pratique', 'Le Sajda', 'Une révérence',           'Practice',       'The Sajda',      'A Bow'),
  _WordPair('Pratique', 'La Qibla', 'Une boussole',            'Practice',       'The Qibla',      'A Compass'),
  // Coran & Science / Quran & Knowledge
  _WordPair('Coran & Science', 'La Sourate Al-Fatiha', 'La Prière du seigneur',  'Quran & Knowledge', 'Surah Al-Fatiha',   'The Lord\'s Prayer'),
  _WordPair('Coran & Science', 'L\'Ayat Al-Kursi', 'Un verset protecteur',       'Quran & Knowledge', 'Ayat Al-Kursi',     'A Protective Verse'),
  _WordPair('Coran & Science', 'Le Tafsir', 'La Traduction',                     'Quran & Knowledge', 'The Tafsir',        'The Translation'),
  _WordPair('Coran & Science', 'La Sunnah', 'La Tradition',                      'Quran & Knowledge', 'The Sunnah',        'The Tradition'),
  _WordPair('Coran & Science', 'Le Fiqh', 'La Jurisprudence',                    'Quran & Knowledge', 'Fiqh',              'Jurisprudence'),
  _WordPair('Coran & Science', 'La Tajwid', 'La Grammaire',                      'Quran & Knowledge', 'Tajweed',           'Grammar'),
  _WordPair('Coran & Science', 'L\'Ijaz', 'Un miracle littéraire',               'Quran & Knowledge', 'The Ijaz',          'A Literary Miracle'),
  _WordPair('Coran & Science', 'Un Hafiz', 'Un mémoriseur',                      'Quran & Knowledge', 'A Hafiz',           'A Memorizer'),
  // Prophètes / Prophets
  _WordPair('Prophètes', 'Ibrahim (AS)', 'Noé (AS)',            'Prophets',       'Ibrahim (AS)',   'Nuh (AS)'),
  _WordPair('Prophètes', 'Moussa (AS)', 'Issa (AS)',            'Prophets',       'Musa (AS)',      'Isa (AS)'),
  _WordPair('Prophètes', 'Youssef (AS)', 'Dawoud (AS)',         'Prophets',       'Yusuf (AS)',     'Dawud (AS)'),
  _WordPair('Prophètes', 'Souleymane (AS)', 'Dawoud (AS)',      'Prophets',       'Sulayman (AS)',  'Dawud (AS)'),
  // Histoire / History
  _WordPair('Histoire', 'La Hijra', 'L\'Exil',                         'History', 'The Hijra',            'The Exile'),
  _WordPair('Histoire', 'La bataille de Badr', 'La bataille d\'Uhud',  'History', 'The Battle of Badr',   'The Battle of Uhud'),
  _WordPair('Histoire', 'La nuit du Isra', 'Le Mi\'raj',               'History', 'The Night of Isra',    'The Mi\'raj'),
  _WordPair('Histoire', 'La Kaaba', 'Al-Aqsa',                         'History', 'The Kaaba',            'Al-Aqsa'),
  _WordPair('Histoire', 'Médine', 'La Mecque',                         'History', 'Madinah',              'Mecca'),
  // Valeurs / Values
  _WordPair('Valeurs', 'La Sabr', 'La Résignation',         'Values', 'Sabr (Patience)',    'Resignation'),
  _WordPair('Valeurs', 'Le Tawakkul', 'La Confiance en soi','Values', 'Tawakkul',           'Self-confidence'),
  _WordPair('Valeurs', 'La Shukr', 'La Gratitude',          'Values', 'Shukr',              'Thankfulness'),
  _WordPair('Valeurs', 'L\'Istighfar', 'Le Repentir',       'Values', 'Istighfar',          'Repentance'),
  _WordPair('Valeurs', 'La Rahma', 'La Compassion',         'Values', 'Rahma (Mercy)',      'Compassion'),
  _WordPair('Valeurs', 'L\'Adl', 'La Justice',              'Values', 'Al-Adl',             'Fairness'),
  _WordPair('Valeurs', 'L\'Aman', 'La Sécurité',            'Values', 'Al-Aman',            'Security'),
  _WordPair('Valeurs', 'Le Sidq', 'L\'Honnêteté',           'Values', 'Al-Sidq',            'Honesty'),
  // Lieux / Places
  _WordPair('Lieux', 'La Mosquée', 'L\'Église',   'Places', 'The Mosque',  'The Church'),
  _WordPair('Lieux', 'Le Minaret', 'La Tour',      'Places', 'The Minaret', 'The Tower'),
  _WordPair('Lieux', 'Le Mimbar', 'La Tribune',    'Places', 'The Minbar',  'The Podium'),
  _WordPair('Lieux', 'Le Mihrab', 'L\'Alcôve',     'Places', 'The Mihrab',  'The Alcove'),
  // Objets / Objects
  _WordPair('Objets', 'Le Tasbeeh', 'Un collier',              'Objects', 'The Tasbeeh',       'A Necklace'),
  _WordPair('Objets', 'Le Tapis de prière', 'Un tapis décoratif','Objects','The Prayer Rug',   'A Decorative Rug'),
  _WordPair('Objets', 'Le Kufi', 'Un béret',                   'Objects', 'The Kufi',          'A Beret'),
  _WordPair('Objets', 'L\'Abaya', 'Un manteau',                'Objects', 'The Abaya',         'A Coat'),
  _WordPair('Objets', 'Le Oud', 'La Guitare',                  'Objects', 'The Oud',           'The Guitar'),
  // Vie quotidienne / Daily Life
  _WordPair('Vie quotidienne', 'La Bismillah', 'Une bénédiction', 'Daily Life', 'Bismillah',      'A Blessing'),
  _WordPair('Vie quotidienne', 'L\'Alhamdulillah', 'Le Merci',    'Daily Life', 'Alhamdulillah',  'A Thank You'),
  _WordPair('Vie quotidienne', 'L\'Inshallah', 'Le peut-être',    'Daily Life', 'Inshallah',      'Maybe'),
  _WordPair('Vie quotidienne', 'La Baraka', 'La Chance',          'Daily Life', 'Baraka',         'Luck'),
  _WordPair('Vie quotidienne', 'Le Halal', 'Le Licite',           'Daily Life', 'Halal',          'The Permissible'),
  _WordPair('Vie quotidienne', 'Le Haram', 'L\'Interdit',         'Daily Life', 'Haram',          'The Forbidden'),
  _WordPair('Vie quotidienne', 'La Iftar', 'Le Dîner',            'Daily Life', 'Iftar',          'Dinner'),
  _WordPair('Vie quotidienne', 'Le Suhoor', 'Le Petit-déjeuner',  'Daily Life', 'Suhoor',         'Breakfast'),
];

// ══════════════════════════════════════════════════════════════════
// MODELS
// ══════════════════════════════════════════════════════════════════

class KadhabPlayer {
  final int id;
  final String name;
  bool isKadhab;
  bool isDall;
  bool isEliminated;

  KadhabPlayer({
    required this.id,
    required this.name,
    this.isKadhab = false,
    this.isDall = false,
    this.isEliminated = false,
  });
}

enum GamePhase {
  setup,
  cardReveal,
  discussion,
  vote,
  tiebreaker,
  elimination,
  kadhabGuess,
  result,
}

enum GameResult { truthWins, kadhabWins }

// ── Rôles des joueurs ─────────────────────────────────────────────
enum _PlayerRole { muminun, dall, kadhab }

// ── Slot de carte (rôle pré-assigné, tiré aléatoirement) ─────────
class _CardSlot {
  final _PlayerRole role;
  bool isPicked;
  _CardSlot(this.role) : isPicked = false;
}

// ══════════════════════════════════════════════════════════════════
// MAIN SCREEN
// ══════════════════════════════════════════════════════════════════

class KadhabScreen extends StatefulWidget {
  const KadhabScreen({super.key});

  @override
  State<KadhabScreen> createState() => _KadhabScreenState();
}

class _KadhabScreenState extends State<KadhabScreen> {
  // --- Game state ---
  GamePhase _phase = GamePhase.setup;
  List<KadhabPlayer> _players = [];
  late _WordPair _currentPair;
  int _kadhabId = -1;
  int _dallId = -1;
  List<_CardSlot> _cardSlots = [];
  int _currentPickerIndex = 0; // which alive player is currently picking
  int _round = 1;
  GameResult? _result;
  String? _tiebreakerName;
  KadhabPlayer? _lastEliminated;

  // --- Setup state ---
  int _playerCount = 4;
  final List<TextEditingController> _nameControllers = [];

  // ── SETUP HELPERS ──────────────────────────────────────────────
  void _initControllers(int count) {
    for (var c in _nameControllers) {
      c.dispose();
    }
    _nameControllers.clear();
    for (int i = 0; i < count; i++) {
      _nameControllers.add(TextEditingController(text: 'Joueur ${i + 1}'));
    }
  }

  void _startGame() {
    final rng = Random();

    // Build players
    _players = List.generate(
      _playerCount,
      (i) => KadhabPlayer(
        id: i,
        name: _nameControllers[i].text.trim().isEmpty
            ? 'Joueur ${i + 1}'
            : _nameControllers[i].text.trim(),
      ),
    );

    // Pick word pair
    _currentPair = _kWordPairs[rng.nextInt(_kWordPairs.length)];
    _round = 1;

    // Créer les slots de cartes (rôles mélangés)
    _cardSlots = _buildCardSlots(_playerCount, rng);
    _currentPickerIndex = 0;
    _kadhabId = -1;
    _dallId = -1;

    setState(() => _phase = GamePhase.cardReveal);
  }

  void _startNewRound() {
    final rng = Random();
    final alive = _players.where((p) => !p.isEliminated).toList();

    // Nouveau mot
    _currentPair = _kWordPairs[rng.nextInt(_kWordPairs.length)];
    _votes = {};
    _round++;

    // Réinitialiser les rôles (changent à chaque manche)
    for (final p in alive) {
      p.isKadhab = false;
      p.isDall = false;
    }
    _kadhabId = -1;
    _dallId = -1;

    // Nouveaux slots pour les joueurs encore en vie
    _cardSlots = _buildCardSlots(alive.length, rng);
    _currentPickerIndex = 0;

    setState(() => _phase = GamePhase.cardReveal);
  }

  // Crée une liste de slots mélangés : 1 Kadhab + 1 Dall + (n-2) Muminun
  List<_CardSlot> _buildCardSlots(int count, Random rng) {
    final roles = <_PlayerRole>[
      _PlayerRole.kadhab,
      _PlayerRole.dall,
      ...List.filled(count - 2, _PlayerRole.muminun),
    ]..shuffle(rng);
    return roles.map((r) => _CardSlot(r)).toList();
  }

  // Appelé quand le joueur courant a choisi et confirmé sa carte
  void _onCardPicked(int slotIndex) {
    final alive = _players.where((p) => !p.isEliminated).toList();
    final currentPlayer = alive[_currentPickerIndex];
    final slot = _cardSlots[slotIndex];

    slot.isPicked = true;
    currentPlayer.isKadhab = false;
    currentPlayer.isDall = false;

    if (slot.role == _PlayerRole.kadhab) {
      currentPlayer.isKadhab = true;
      _kadhabId = currentPlayer.id;
    } else if (slot.role == _PlayerRole.dall) {
      currentPlayer.isDall = true;
      _dallId = currentPlayer.id;
    }

    setState(() {
      if (_currentPickerIndex < alive.length - 1) {
        _currentPickerIndex++;
      } else {
        _votes = {};
        _phase = GamePhase.discussion;
      }
    });
  }

  // ── VOTE HELPERS ───────────────────────────────────────────────
  Map<int, int> _votes = {}; // playerId → vote count

  void _castVote(int targetId) {
    setState(() {
      _votes[targetId] = (_votes[targetId] ?? 0) + 1;
    });
  }

  void _resolveVotes() {
    final alive = _players.where((p) => !p.isEliminated).toList();
    int maxVotes = 0;
    for (final p in alive) {
      final v = _votes[p.id] ?? 0;
      if (v > maxVotes) maxVotes = v;
    }
    final leaders = alive.where((p) => (_votes[p.id] ?? 0) == maxVotes).toList();

    if (leaders.length == 1) {
      _eliminatePlayer(leaders.first.id);
    } else {
      // Tie → pick one random player (not among tied) to break tie
      final nonTied = alive.where((p) => !leaders.contains(p)).toList();
      if (nonTied.isNotEmpty) {
        final tiebreaker = nonTied[Random().nextInt(nonTied.length)];
        _tiebreakerName = tiebreaker.name;
        setState(() => _phase = GamePhase.tiebreaker);
      } else {
        // All tied → random elimination
        final victim = leaders[Random().nextInt(leaders.length)];
        _eliminatePlayer(victim.id);
      }
    }
  }

  void _eliminatePlayer(int id) {
    final player = _players.firstWhere((p) => p.id == id);
    player.isEliminated = true;
    _lastEliminated = player;

    final alive = _players.where((p) => !p.isEliminated).toList();

    if (player.isKadhab) {
      _result = GameResult.truthWins;
      setState(() => _phase = GamePhase.result);
    } else if (alive.length <= 2) {
      // Vérifie que le Kadhab est encore en vie
      final kadhabAlive = alive.any((p) => p.isKadhab);
      if (kadhabAlive) {
        setState(() => _phase = GamePhase.kadhabGuess);
      } else {
        _result = GameResult.truthWins;
        setState(() => _phase = GamePhase.result);
      }
    } else {
      setState(() => _phase = GamePhase.elimination);
    }
  }

  void _kadhabGuesses(String guess) {
    final g = guess.trim().toLowerCase();
    final correct = g == _currentPair.trueWord.toLowerCase() ||
        g == _currentPair.trueWordEn.toLowerCase();
    _result = correct ? GameResult.kadhabWins : GameResult.truthWins;
    setState(() => _phase = GamePhase.result);
  }

  void _resetGame() {
    for (var c in _nameControllers) {
      c.dispose();
    }
    _nameControllers.clear();
    _votes = {};
    _result = null;
    _tiebreakerName = null;
    _lastEliminated = null;
    _round = 1;
    _kadhabId = -1;
    _dallId = -1;
    _cardSlots = [];
    _currentPickerIndex = 0;
    setState(() => _phase = GamePhase.setup);
  }

  // ── BUILD ──────────────────────────────────────────────────────
  @override
  void dispose() {
    for (var c in _nameControllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: const Color(0xFF0D0D1A),
        body: _buildPhase(),
      ),
    );
  }

  Widget _buildPhase() {
    switch (_phase) {
      case GamePhase.setup:
        return _SetupScreen(
          playerCount: _playerCount,
          controllers: _nameControllers,
          onCountChanged: (v) {
            setState(() {
              _playerCount = v;
              _initControllers(v);
            });
          },
          onStart: () {
            if (_nameControllers.isEmpty) _initControllers(_playerCount);
            _startGame();
          },
          onInit: () => _initControllers(_playerCount),
        );
      case GamePhase.cardReveal:
        return _CardRevealScreen(
          players: _players.where((p) => !p.isEliminated).toList(),
          cardSlots: _cardSlots,
          currentPickerIndex: _currentPickerIndex,
          pair: _currentPair,
          round: _round,
          onCardPicked: _onCardPicked,
        );
      case GamePhase.discussion:
        return _DiscussionScreen(
          players: _players.where((p) => !p.isEliminated).toList(),
          pair: _currentPair,
          round: _round,
          onVote: () => setState(() => _phase = GamePhase.vote),
        );
      case GamePhase.vote:
        return _VoteScreen(
          players: _players.where((p) => !p.isEliminated).toList(),
          votes: _votes,
          onVote: _castVote,
          onResolve: _resolveVotes,
        );
      case GamePhase.tiebreaker:
        return _TiebreakerScreen(
          players: _players.where((p) => !p.isEliminated).toList(),
          tiebreakerName: _tiebreakerName ?? '',
          votes: _votes,
          onEliminate: _eliminatePlayer,
        );
      case GamePhase.elimination:
        return _EliminationScreen(
          eliminated: _lastEliminated!,
          onContinue: _startNewRound,
        );
      case GamePhase.kadhabGuess:
        return _KadhabGuessScreen(
          kadhabName: _players.firstWhere((p) => p.isKadhab).name,
          onGuess: _kadhabGuesses,
        );
      case GamePhase.result:
        return _ResultScreen(
          result: _result!,
          players: _players,
          pair: _currentPair,
          onPlayAgain: _resetGame,
          onHome: () => Navigator.of(context).pop(),
        );
    }
  }
}

// ══════════════════════════════════════════════════════════════════
// SCREEN 1 — SETUP
// ══════════════════════════════════════════════════════════════════

class _SetupScreen extends StatefulWidget {
  final int playerCount;
  final List<TextEditingController> controllers;
  final ValueChanged<int> onCountChanged;
  final VoidCallback onStart;
  final VoidCallback onInit;

  const _SetupScreen({
    required this.playerCount,
    required this.controllers,
    required this.onCountChanged,
    required this.onStart,
    required this.onInit,
  });

  @override
  State<_SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<_SetupScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.controllers.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onInit();
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // ── Header ──
          Container(
            height: 220,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/modules/module_kadhab.jpg',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: const Color(0xFF1A0A2E),
                      child: const Icon(Icons.games, size: 80, color: Colors.white24),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Color(0xCC0D0D1A),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    left: 12,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.arrow_back_ios_new,
                            color: Colors.white, size: 18),
                      ),
                    ),
                  ),
                  const Positioned(
                    bottom: 16,
                    left: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Qui est le Kadhab ? 🔍',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: -0.5,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Le jeu du menteur islamique',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white60,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // ── Body ──
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Player count picker
                  _SectionLabel('Nombre de joueurs'),
                  const SizedBox(height: 12),
                  _PlayerCountPicker(
                    count: widget.playerCount,
                    onChanged: widget.onCountChanged,
                  ),
                  const SizedBox(height: 24),
                  // Player names
                  _SectionLabel('Noms des joueurs'),
                  const SizedBox(height: 12),
                  if (widget.controllers.isNotEmpty)
                    ...List.generate(widget.controllers.length, (i) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: _NameField(
                          controller: widget.controllers[i],
                          index: i,
                        ),
                      );
                    }),
                  const SizedBox(height: 28),
                  // Start button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: widget.onStart,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD4AF37),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Lancer la partie  🎮',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Rules summary
                  _RulesSummary(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayerCountPicker extends StatelessWidget {
  final int count;
  final ValueChanged<int> onChanged;

  const _PlayerCountPicker({required this.count, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _CountButton(
          icon: Icons.remove,
          onTap: count > 3 ? () => onChanged(count - 1) : null,
        ),
        const SizedBox(width: 24),
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E2E),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFD4AF37), width: 2),
          ),
          child: Center(
            child: Text(
              '$count',
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w800,
                color: Color(0xFFD4AF37),
              ),
            ),
          ),
        ),
        const SizedBox(width: 24),
        _CountButton(
          icon: Icons.add,
          onTap: count < 10 ? () => onChanged(count + 1) : null,
        ),
      ],
    );
  }
}

class _CountButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _CountButton({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: onTap != null
              ? const Color(0xFF1E1E2E)
              : const Color(0xFF141420),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: onTap != null
                ? const Color(0xFFD4AF37).withOpacity(0.5)
                : Colors.white12,
          ),
        ),
        child: Icon(
          icon,
          color: onTap != null ? const Color(0xFFD4AF37) : Colors.white24,
          size: 22,
        ),
      ),
    );
  }
}

class _NameField extends StatelessWidget {
  final TextEditingController controller;
  final int index;

  const _NameField({required this.controller, required this.index});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white, fontSize: 15),
      decoration: InputDecoration(
        prefixIcon: Container(
          width: 36,
          alignment: Alignment.center,
          child: Text(
            '${index + 1}',
            style: const TextStyle(
              color: Color(0xFFD4AF37),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        hintText: 'Joueur ${index + 1}',
        hintStyle: const TextStyle(color: Colors.white38),
        filled: true,
        fillColor: const Color(0xFF1E1E2E),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFD4AF37), width: 1.5),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white70,
        fontSize: 13,
        fontWeight: FontWeight.w600,
        letterSpacing: 1,
      ),
    );
  }
}

class _RulesSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A0A2E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.purple.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            '📜 Règles rapides',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 10),
          _RuleItem('🃏', 'Chaque joueur choisit sa carte parmi les disponibles'),
          _RuleItem('🟢', 'Muminun : reçoit le vrai mot'),
          _RuleItem('🟠', 'Dall : reçoit un mot différent'),
          _RuleItem('😈', 'Kadhab : aucun mot — doit bluffer !'),
          _RuleItem('🚫', 'Le Kadhab ne parle jamais en premier'),
          _RuleItem('🗳', 'Vote : le plus suspect est éliminé'),
          _RuleItem('🏆', 'Trouvez le Kadhab avant qu\'il gagne !'),
        ],
      ),
    );
  }
}

class _RuleItem extends StatelessWidget {
  final String emoji;
  final String text;
  const _RuleItem(this.emoji, this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white70, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════
// SCREEN 2 — CARD REVEAL
// Phase A : grille de cartes face cachée → joueur choisit la sienne
// Phase B : grande carte animée → retournement → révèle rôle/mot
// ══════════════════════════════════════════════════════════════════

enum _RevealStep { picking, revealing }

class _CardRevealScreen extends StatefulWidget {
  final List<KadhabPlayer> players;      // joueurs encore en vie
  final List<_CardSlot> cardSlots;       // tous les slots (picked + unpicked)
  final int currentPickerIndex;          // index dans players
  final _WordPair pair;
  final int round;
  final void Function(int slotIndex) onCardPicked;

  const _CardRevealScreen({
    required this.players,
    required this.cardSlots,
    required this.currentPickerIndex,
    required this.pair,
    required this.round,
    required this.onCardPicked,
  });

  @override
  State<_CardRevealScreen> createState() => _CardRevealScreenState();
}

class _CardRevealScreenState extends State<_CardRevealScreen>
    with TickerProviderStateMixin {
  _RevealStep _step = _RevealStep.picking;
  int _selectedSlot = -1;
  bool _isFlipped = false;
  bool _wordRevealed = false;
  late AnimationController _flipController;
  late AnimationController _shakeController;
  late Animation<double> _flipAnimation;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _initAnimations();
  }

  void _initAnimations() {
    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _flipAnimation = Tween<double>(begin: 0, end: pi).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.easeInOutCubic),
    );
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _shakeAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -12.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -12.0, end: 12.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 12.0, end: -8.0),  weight: 2),
      TweenSequenceItem(tween: Tween(begin: -8.0, end: 8.0),   weight: 2),
      TweenSequenceItem(tween: Tween(begin: 8.0, end: 0.0),    weight: 1),
    ]).animate(CurvedAnimation(parent: _shakeController, curve: Curves.easeInOut));
  }

  @override
  void didUpdateWidget(_CardRevealScreen old) {
    super.didUpdateWidget(old);
    if (old.currentPickerIndex != widget.currentPickerIndex) {
      // Nouveau joueur → reset
      _step = _RevealStep.picking;
      _selectedSlot = -1;
      _isFlipped = false;
      _wordRevealed = false;
      _flipController.reset();
    }
  }

  @override
  void dispose() {
    _flipController.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  // Joueur choisit une carte dans la grille
  void _pickCard(int slotIndex) {
    setState(() {
      _selectedSlot = slotIndex;
      _step = _RevealStep.revealing;
    });
  }

  // Retournement de la grande carte
  void _flip() {
    if (_isFlipped) {
      _shakeController.forward(from: 0);
      return;
    }
    _flipController.forward().then((_) {
      setState(() {
        _isFlipped = true;
        _wordRevealed = true;
      });
    });
    setState(() {});
  }

  // Mot à afficher selon le rôle du slot
  String _wordForSlot(int slotIndex, bool isFr) {
    switch (widget.cardSlots[slotIndex].role) {
      case _PlayerRole.muminun: return widget.pair.getTrueWord(isFr);
      case _PlayerRole.dall:    return widget.pair.getImpostorWord(isFr);
      case _PlayerRole.kadhab:  return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isFr = T.of(context).isFr;
    final currentPlayer = widget.players[widget.currentPickerIndex];
    return SafeArea(
      child: Column(
        children: [
          _GameHeader(
            title: '${isFr ? 'Manche' : 'Round'} ${widget.round}',
            subtitle:
                '${widget.currentPickerIndex + 1} / ${widget.players.length}',
            showBack: false,
          ),
          Expanded(
            child: _step == _RevealStep.picking
                ? _buildPickingStep(currentPlayer, isFr)
                : _buildRevealingStep(currentPlayer, isFr),
          ),
        ],
      ),
    );
  }

  // ── Phase A : grille de sélection ────────────────────────────────
  Widget _buildPickingStep(KadhabPlayer player, bool isFr) {
    final unpicked = widget.cardSlots.asMap().entries
        .where((e) => !e.value.isPicked)
        .toList();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '👤 ${player.name}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          isFr
              ? 'Choisis ta carte parmi les ${unpicked.length} disponibles'
              : 'Pick your card from ${unpicked.length} available',
          style: const TextStyle(color: Colors.white54, fontSize: 13),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        // Grille de mini cartes face cachée
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 14,
          runSpacing: 14,
          children: unpicked.map((entry) {
            return GestureDetector(
              onTap: () => _pickCard(entry.key),
              child: _MiniCardBack(),
            );
          }).toList(),
        ),
        const SizedBox(height: 32),
        Text(
          isFr ? 'Ne montre ta carte à personne !' : 'Don\'t show your card to anyone!',
          style: const TextStyle(
            color: Color(0xFFD4AF37),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // ── Phase B : grande carte à retourner ───────────────────────────
  Widget _buildRevealingStep(KadhabPlayer player, bool isFr) {
    final role = widget.cardSlots[_selectedSlot].role;
    final word = _wordForSlot(_selectedSlot, isFr);
    final isLastPlayer =
        widget.currentPickerIndex == widget.players.length - 1;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '👤 ${player.name}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          _wordRevealed
              ? (isFr
                  ? 'Mémorise et passe le téléphone'
                  : 'Memorize and pass the phone')
              : (isFr
                  ? 'Tape la carte pour découvrir ton rôle'
                  : 'Tap the card to reveal your role'),
          style: TextStyle(
            color: _wordRevealed ? Colors.amber : Colors.white54,
            fontSize: 13,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        // Grande carte animée
        AnimatedBuilder(
          animation: _flipAnimation,
          builder: (_, __) => AnimatedBuilder(
            animation: _shakeAnimation,
            builder: (_, __) => Transform.translate(
              offset: Offset(_shakeAnimation.value, 0),
              child: GestureDetector(
                onTap: _flip,
                child: _buildFlipCard(word, role),
              ),
            ),
          ),
        ),
        const SizedBox(height: 48),
        AnimatedOpacity(
          opacity: _wordRevealed ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 400),
          child: SizedBox(
            width: 200,
            height: 50,
            child: ElevatedButton(
              onPressed: _wordRevealed
                  ? () => widget.onCardPicked(_selectedSlot)
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD4AF37),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(
                isLastPlayer
                    ? (isFr ? 'C\'est parti ! 🎯' : 'Let\'s go! 🎯')
                    : (isFr ? 'Joueur suivant →' : 'Next player →'),
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFlipCard(String word, _PlayerRole role) {
    final angle = _flipAnimation.value;
    final showFront = angle > pi / 2;
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.002)
        ..rotateY(angle),
      child: showFront
          ? Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..rotateY(pi),
              child: _CardFront(word: word, role: role),
            )
          : _CardBack(),
    );
  }
}

// Mini carte face cachée (dans la grille de sélection)
class _MiniCardBack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 82,
      height: 118,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD4AF37).withOpacity(0.25),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Image.asset(
          'assets/kadhab_card.jpg',
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF1A0A2E), Color(0xFF2D1B4E)],
              ),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFD4AF37), width: 1.5),
            ),
            child: const Center(
              child: Text('👑', style: TextStyle(fontSize: 30)),
            ),
          ),
        ),
      ),
    );
  }
}

class _CardBack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 320,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD4AF37).withOpacity(0.3),
            blurRadius: 24,
            spreadRadius: 4,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Image.asset(
          'assets/kadhab_card.jpg',
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF1A0A2E), Color(0xFF2D1B4E)],
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFFD4AF37), width: 2),
            ),
            child: const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('👑', style: TextStyle(fontSize: 60)),
                  SizedBox(height: 12),
                  Text(
                    'KADHAB',
                    style: TextStyle(
                      color: Color(0xFFD4AF37),
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CardFront extends StatelessWidget {
  final String word;
  final _PlayerRole role;

  const _CardFront({required this.word, required this.role});

  @override
  Widget build(BuildContext context) {
    final isFr = T.of(context).isFr;
    final isKadhab = role == _PlayerRole.kadhab;
    final isDall   = role == _PlayerRole.dall;

    final Color accent = isKadhab
        ? const Color(0xFFFF4444)
        : isDall
            ? const Color(0xFFFF9800)
            : const Color(0xFF4A90D9);

    final List<Color> gradient = isKadhab
        ? [const Color(0xFF2D0A0A), const Color(0xFF5A1515)]
        : isDall
            ? [const Color(0xFF2D1500), const Color(0xFF5A3200)]
            : [const Color(0xFF0A1A2D), const Color(0xFF0D3A5C)];

    return Container(
      width: 220,
      height: 320,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: accent, width: 2),
        boxShadow: [
          BoxShadow(
            color: accent.withOpacity(0.3),
            blurRadius: 24,
            spreadRadius: 4,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Label rôle
            Text(
              isFr ? 'TU ES LE' : 'YOU ARE THE',
              style: TextStyle(
                color: accent,
                fontSize: 11,
                fontWeight: FontWeight.w600,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isKadhab ? 'KADHAB 😈' : isDall ? 'DALL 🌀' : (isFr ? 'MUMINUN 🟢' : 'BELIEVER 🟢'),
              style: TextStyle(
                color: accent,
                fontSize: 20,
                fontWeight: FontWeight.w900,
                letterSpacing: 3,
              ),
            ),
            const SizedBox(height: 20),

            // Mot ou absence de mot
            if (isKadhab) ...[
              Text(
                isFr ? 'Tu n\'as PAS de mot.' : 'You have NO word.',
                style: TextStyle(color: accent.withOpacity(0.8), fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                isFr
                    ? 'Observe les autres et blende !'
                    : 'Watch others and blend in!',
                style: const TextStyle(color: Colors.white38, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ] else ...[
              Text(
                isDall
                    ? (isFr ? 'Ton mot (différent) :' : 'Your (different) word:')
                    : (isFr ? 'Ton mot :' : 'Your word:'),
                style: const TextStyle(color: Colors.white38, fontSize: 12),
              ),
              const SizedBox(height: 8),
              Text(
                word,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 20),

            // Conseil
            Text(
              isKadhab
                  ? (isFr ? '⚠ Tu ne parles pas en premier !' : '⚠ Don\'t speak first!')
                  : isDall
                      ? (isFr ? '⚠ Ton mot est DIFFÉRENT des autres !' : '⚠ Your word is DIFFERENT!')
                      : (isFr ? 'Ne montre à personne !' : 'Don\'t show anyone!'),
              style: TextStyle(
                color: isKadhab || isDall ? accent : Colors.white38,
                fontSize: 11,
                fontWeight: isKadhab || isDall ? FontWeight.w700 : FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════
// SCREEN 3 — DISCUSSION
// ══════════════════════════════════════════════════════════════════

class _DiscussionScreen extends StatelessWidget {
  final List<KadhabPlayer> players;
  final _WordPair pair;
  final int round;
  final VoidCallback onVote;

  const _DiscussionScreen({
    required this.players,
    required this.pair,
    required this.round,
    required this.onVote,
  });

  @override
  Widget build(BuildContext context) {
    final t = T.of(context);
    return SafeArea(
      child: Column(
        children: [
          _GameHeader(
            title: t.isFr ? 'Discussion' : 'Discussion',
            subtitle: '${t.isFr ? 'Thème' : 'Theme'} : ${pair.getTheme(t.isFr)}',
            showBack: false,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1A2E),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white12),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '🗣 ${t.isFr ? 'À tour de rôle' : 'Take turns'}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          t.isFr
                              ? 'Donnez chacun 1 ou 2 indices sur votre mot.\nLe Kadhab essaie de passer inaperçu.'
                              : 'Each player gives 1–2 clues about their word.\nThe Kadhab tries to blend in.',
                          style: const TextStyle(color: Colors.white60, fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        // Player order (Kadhab never first)
                        _DiscussionOrder(players: players, isFr: t.isFr),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: onVote,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD4AF37),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        t.isFr ? 'Passer au vote  🗳' : 'Go to vote  🗳',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
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

class _DiscussionOrder extends StatelessWidget {
  final List<KadhabPlayer> players;
  final bool isFr;

  const _DiscussionOrder({required this.players, required this.isFr});

  @override
  Widget build(BuildContext context) {
    // Kadhab never first → random order but ensure Kadhab is not at index 0
    final rng = Random();
    final shuffled = [...players]..shuffle(rng);
    // Move Kadhab away from first if present
    if (shuffled.first.isKadhab && shuffled.length > 1) {
      final swapIndex = 1 + rng.nextInt(shuffled.length - 1);
      final temp = shuffled[0];
      shuffled[0] = shuffled[swapIndex];
      shuffled[swapIndex] = temp;
    }

    return Column(
      children: [
        Text(
          isFr ? 'Ordre de parole suggéré' : 'Suggested speaking order',
          style: const TextStyle(color: Colors.white38, fontSize: 12, letterSpacing: 1),
        ),
        const SizedBox(height: 10),
        ...shuffled.asMap().entries.map((e) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD4AF37).withOpacity(0.15),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFD4AF37).withOpacity(0.4),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '${e.key + 1}',
                      style: const TextStyle(
                        color: Color(0xFFD4AF37),
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  e.value.name,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════════════
// SCREEN 4 — VOTE
// ══════════════════════════════════════════════════════════════════

class _VoteScreen extends StatefulWidget {
  final List<KadhabPlayer> players;
  final Map<int, int> votes;
  final ValueChanged<int> onVote;
  final VoidCallback onResolve;

  const _VoteScreen({
    required this.players,
    required this.votes,
    required this.onVote,
    required this.onResolve,
  });

  @override
  State<_VoteScreen> createState() => _VoteScreenState();
}

class _VoteScreenState extends State<_VoteScreen> {
  int _votedCount = 0;

  @override
  Widget build(BuildContext context) {
    final totalVoters = widget.players.length;
    final allVoted = _votedCount >= totalVoters;
    final isFr = T.of(context).isFr;

    return SafeArea(
      child: Column(
        children: [
          _GameHeader(
            title: 'Vote 🗳',
            subtitle: '$_votedCount / $totalVoters votes',
            showBack: false,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    isFr ? 'Qui est le plus suspect ?' : 'Who is most suspicious?',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isFr ? 'Chaque joueur vote une fois.' : 'Each player votes once.',
                    style: const TextStyle(color: Colors.white54, fontSize: 13),
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: ListView.separated(
                      itemCount: widget.players.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (_, i) {
                        final p = widget.players[i];
                        final voteCount = widget.votes[p.id] ?? 0;
                        return _VoteCard(
                          player: p,
                          voteCount: voteCount,
                          onVote: () {
                            if (!allVoted) {
                              widget.onVote(p.id);
                              setState(() => _votedCount++);
                            }
                          },
                          enabled: !allVoted,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (allVoted)
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: widget.onResolve,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD4AF37),
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          isFr ? 'Révéler l\'éliminé  ⚡️' : 'Reveal eliminated  ⚡️',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
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

class _VoteCard extends StatefulWidget {
  final KadhabPlayer player;
  final int voteCount;
  final VoidCallback onVote;
  final bool enabled;

  const _VoteCard({
    required this.player,
    required this.voteCount,
    required this.onVote,
    required this.enabled,
  });

  @override
  State<_VoteCard> createState() => _VoteCardState();
}

class _VoteCardState extends State<_VoteCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _tapController;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _tapController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnim = Tween<double>(begin: 1, end: 0.94).animate(
      CurvedAnimation(parent: _tapController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _tapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.enabled ? (_) => _tapController.forward() : null,
      onTapUp: widget.enabled
          ? (_) {
              _tapController.reverse();
              widget.onVote();
            }
          : null,
      onTapCancel: () => _tapController.reverse(),
      child: ScaleTransition(
        scale: _scaleAnim,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E2E),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: widget.voteCount > 0
                  ? const Color(0xFFD4AF37).withOpacity(0.5)
                  : Colors.white12,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2A3E),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    widget.player.name[0].toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  widget.player.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (widget.voteCount > 0)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD4AF37).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFFD4AF37).withOpacity(0.4),
                    ),
                  ),
                  child: Text(
                    '${widget.voteCount} vote${widget.voteCount > 1 ? 's' : ''}',
                    style: const TextStyle(
                      color: Color(0xFFD4AF37),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              if (widget.enabled) ...[
                const SizedBox(width: 10),
                const Icon(Icons.how_to_vote_outlined,
                    color: Colors.white38, size: 20),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════
// SCREEN 5 — TIEBREAKER
// ══════════════════════════════════════════════════════════════════

class _TiebreakerScreen extends StatefulWidget {
  final List<KadhabPlayer> players;
  final String tiebreakerName;
  final Map<int, int> votes;
  final ValueChanged<int> onEliminate;

  const _TiebreakerScreen({
    required this.players,
    required this.tiebreakerName,
    required this.votes,
    required this.onEliminate,
  });

  @override
  State<_TiebreakerScreen> createState() => _TiebreakerScreenState();
}

class _TiebreakerScreenState extends State<_TiebreakerScreen> {
  int? _selected;

  @override
  Widget build(BuildContext context) {
    final maxVotes = widget.votes.values.fold(0, max);
    final tied = widget.players
        .where((p) => (widget.votes[p.id] ?? 0) == maxVotes)
        .toList();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _GameHeader(
              title: 'Égalité ! ⚖️',
              subtitle: 'Départage',
              showBack: false,
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E2E),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFD4AF37).withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  Text(
                    '${widget.tiebreakerName} doit choisir\nqui éliminer parmi les égaux.',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ...tied.map(
                    (p) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: GestureDetector(
                        onTap: () => setState(() => _selected = p.id),
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: _selected == p.id
                                ? const Color(0xFFD4AF37).withOpacity(0.15)
                                : const Color(0xFF2A2A3E),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: _selected == p.id
                                  ? const Color(0xFFD4AF37)
                                  : Colors.white12,
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.person_outline,
                                  color: Colors.white54, size: 18),
                              const SizedBox(width: 10),
                              Text(
                                p.name,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                              const Spacer(),
                              if (_selected == p.id)
                                const Icon(Icons.check_circle,
                                    color: Color(0xFFD4AF37), size: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            if (_selected != null)
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => widget.onEliminate(_selected!),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD4AF37),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Confirmer l\'élimination',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════
// SCREEN 6 — ELIMINATION
// ══════════════════════════════════════════════════════════════════

class _EliminationScreen extends StatelessWidget {
  final KadhabPlayer eliminated;
  final VoidCallback onContinue;

  const _EliminationScreen({
    required this.eliminated,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    final isFr = T.of(context).isFr;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('💨', style: TextStyle(fontSize: 80)),
            const SizedBox(height: 24),
            Text(
              isFr
                  ? '${eliminated.name} est éliminé !'
                  : '${eliminated.name} is eliminated!',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              eliminated.isKadhab
                  ? (isFr ? 'C\'était le Kadhab 😈 !' : 'That was the Kadhab 😈!')
                  : eliminated.isDall
                      ? (isFr
                          ? 'C\'était le Dall 🌀 — le jeu continue !'
                          : 'That was the Dall 🌀 — game goes on!')
                      : (isFr
                          ? 'Ce n\'était pas le Kadhab... La partie continue !'
                          : 'Not the Kadhab... The game goes on!'),
              style: TextStyle(
                color: eliminated.isKadhab
                    ? const Color(0xFFFF4444)
                    : eliminated.isDall
                        ? const Color(0xFFFF9800)
                        : const Color(0xFF4A90D9),
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            SizedBox(
              width: 240,
              height: 54,
              child: ElevatedButton(
                onPressed: onContinue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD4AF37),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  isFr ? 'Manche suivante →' : 'Next round →',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════
// SCREEN 7 — KADHAB GUESS
// ══════════════════════════════════════════════════════════════════

class _KadhabGuessScreen extends StatefulWidget {
  final String kadhabName;
  final ValueChanged<String> onGuess;

  const _KadhabGuessScreen({required this.kadhabName, required this.onGuess});

  @override
  State<_KadhabGuessScreen> createState() => _KadhabGuessScreenState();
}

class _KadhabGuessScreenState extends State<_KadhabGuessScreen> {
  final _ctrl = TextEditingController();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isFr = T.of(context).isFr;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text('😈', style: TextStyle(fontSize: 72)),
            const SizedBox(height: 20),
            Text(
              isFr ? '${widget.kadhabName} a survécu !' : '${widget.kadhabName} survived!',
              style: const TextStyle(
                color: Color(0xFFFF4444),
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              isFr
                  ? 'Le Kadhab peut encore gagner.\nDevine le vrai mot pour remporter la partie !'
                  : 'The Kadhab can still win.\nGuess the true word to take the victory!',
              style: const TextStyle(color: Colors.white60, fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            TextField(
              controller: _ctrl,
              onChanged: (_) => setState(() {}),
              style: const TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: isFr ? 'Tape ton mot...' : 'Type your word...',
                hintStyle: const TextStyle(color: Colors.white38),
                filled: true,
                fillColor: const Color(0xFF1E1E2E),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                      color: Color(0xFFFF4444), width: 2),
                ),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _ctrl.text.isNotEmpty
                    ? () => widget.onGuess(_ctrl.text)
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF4444),
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.white12,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  isFr ? 'Soumettre ma réponse 🎯' : 'Submit my answer 🎯',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════
// SCREEN 8 — RESULT
// ══════════════════════════════════════════════════════════════════

class _ResultScreen extends StatefulWidget {
  final GameResult result;
  final List<KadhabPlayer> players;
  final _WordPair pair;
  final VoidCallback onPlayAgain;
  final VoidCallback onHome;

  const _ResultScreen({
    required this.result,
    required this.players,
    required this.pair,
    required this.onPlayAgain,
    required this.onHome,
  });

  @override
  State<_ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<_ResultScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _scaleAnim = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final truthWins = widget.result == GameResult.truthWins;
    final kadhab = widget.players.firstWhere((p) => p.isKadhab);
    final dallList = widget.players.where((p) => p.isDall).toList();
    final dall = dallList.isNotEmpty ? dallList.first : null;
    final isFr = T.of(context).isFr;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: _fadeAnim,
              child: ScaleTransition(
                scale: _scaleAnim,
                child: Column(
                  children: [
                    Text(
                      truthWins ? '🏆' : '😈',
                      style: const TextStyle(fontSize: 90),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      truthWins
                          ? (isFr ? 'Le Kadhab est démasqué !' : 'The Kadhab is unmasked!')
                          : (isFr ? 'Le Kadhab gagne !' : 'The Kadhab wins!'),
                      style: TextStyle(
                        color: truthWins
                            ? const Color(0xFFD4AF37)
                            : const Color(0xFFFF4444),
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      truthWins
                          ? (isFr
                              ? 'La vérité a triomphé. Alhamdulillah ! 🤲'
                              : 'Truth has prevailed. Alhamdulillah! 🤲')
                          : (isFr
                              ? '${kadhab.name} a trompé tout le monde...'
                              : '${kadhab.name} fooled everyone...'),
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Reveal word pair
            FadeTransition(
              opacity: _fadeAnim,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E2E),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white12),
                ),
                child: Column(
                  children: [
                    Text(
                      '${isFr ? 'Thème' : 'Theme'} : ${widget.pair.getTheme(isFr)}',
                      style: const TextStyle(
                        color: Colors.white38,
                        fontSize: 13,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: _WordRevealTile(
                            label: isFr ? 'Vrai mot' : 'True word',
                            word: widget.pair.getTrueWord(isFr),
                            color: const Color(0xFF4A90D9),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _WordRevealTile(
                            label: isFr ? 'Mot du Dall' : 'Dall\'s word',
                            word: widget.pair.getImpostorWord(isFr),
                            color: const Color(0xFFFF9800),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        const Icon(Icons.person, color: Color(0xFFFF4444), size: 16),
                        const SizedBox(width: 6),
                        Text(
                          '😈 Kadhab : ${kadhab.name}',
                          style: const TextStyle(color: Color(0xFFFF8888), fontSize: 13),
                        ),
                      ],
                    ),
                    if (dall != null) ...[
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.person, color: Color(0xFFFF9800), size: 16),
                          const SizedBox(width: 6),
                          Text(
                            '🌀 Dall : ${dall.name}',
                            style: const TextStyle(color: Color(0xFFFFB74D), fontSize: 13),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 36),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: widget.onHome,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white60,
                      side: const BorderSide(color: Colors.white24),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(isFr ? 'Accueil' : 'Home'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: widget.onPlayAgain,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD4AF37),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      isFr ? 'Rejouer 🎮' : 'Play again 🎮',
                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _WordRevealTile extends StatelessWidget {
  final String label;
  final String word;
  final Color color;

  const _WordRevealTile({
    required this.label,
    required this.word,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            word,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════
// SHARED WIDGETS
// ══════════════════════════════════════════════════════════════════

class _GameHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool showBack;

  const _GameHeader({
    required this.title,
    required this.subtitle,
    this.showBack = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white12),
        ),
      ),
      child: Row(
        children: [
          if (showBack)
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(Icons.arrow_back_ios_new,
                  color: Colors.white60, size: 18),
            ),
          if (showBack) const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white38,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
