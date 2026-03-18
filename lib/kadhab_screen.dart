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

// ══════════════════════════════════════════════════════════════════
// DATA — Paires de mots islamiques (vrai mot / mot imposteur)
// ══════════════════════════════════════════════════════════════════

class _WordPair {
  final String theme;
  final String trueWord;
  final String impostorWord;
  const _WordPair(this.theme, this.trueWord, this.impostorWord);
}

const List<_WordPair> _kWordPairs = [
  // Pilliers & Pratiques
  _WordPair('Pratique', 'La Salah', 'La Méditation'),
  _WordPair('Pratique', 'Le Ramadan', 'Le Carême'),
  _WordPair('Pratique', 'La Zakat', 'La Dîme'),
  _WordPair('Pratique', 'Le Hajj', 'Un pèlerinage'),
  _WordPair('Pratique', 'L\'Ablution', 'La Douche'),
  _WordPair('Pratique', 'Le Tahajjud', 'La Sieste'),
  _WordPair('Pratique', 'L\'Adhan', 'Une cloche'),
  _WordPair('Pratique', 'Le Miswak', 'La Brosse à dents'),
  _WordPair('Pratique', 'Le Sajda', 'Une révérence'),
  _WordPair('Pratique', 'La Qibla', 'Une boussole'),
  // Coran & Savoirs
  _WordPair('Coran & Science', 'La Sourate Al-Fatiha', 'La Prière du seigneur'),
  _WordPair('Coran & Science', 'L\'Ayat Al-Kursi', 'Un verset protecteur'),
  _WordPair('Coran & Science', 'Le Tafsir', 'La Traduction'),
  _WordPair('Coran & Science', 'La Sunnah', 'La Tradition'),
  _WordPair('Coran & Science', 'Le Fiqh', 'La Jurisprudence'),
  _WordPair('Coran & Science', 'La Tajwid', 'La Grammaire'),
  _WordPair('Coran & Science', 'L\'Ijaz', 'Un miracle littéraire'),
  _WordPair('Coran & Science', 'La Hafiz', 'Un mémoriseur'),
  // Prophètes & Histoire
  _WordPair('Prophètes', 'Ibrahim (AS)', 'Noé (AS)'),
  _WordPair('Prophètes', 'Moussa (AS)', 'Issa (AS)'),
  _WordPair('Prophètes', 'Youssef (AS)', 'Dawoud (AS)'),
  _WordPair('Prophètes', 'Souleymane (AS)', 'Dawoud (AS)'),
  _WordPair('Histoire', 'La Hijra', 'L\'Exil'),
  _WordPair('Histoire', 'La bataille de Badr', 'La bataille d\'Uhud'),
  _WordPair('Histoire', 'La nuit du Isra', 'Le Mi\'raj'),
  _WordPair('Histoire', 'La Kaaba', 'Al-Aqsa'),
  _WordPair('Histoire', 'Médine', 'La Mecque'),
  // Valeurs & Éthique
  _WordPair('Valeurs', 'La Sabr', 'La Résignation'),
  _WordPair('Valeurs', 'Le Tawakkul', 'La Confiance en soi'),
  _WordPair('Valeurs', 'La Shukr', 'La Gratitude'),
  _WordPair('Valeurs', 'L\'Istighfar', 'Le Repentir'),
  _WordPair('Valeurs', 'La Rahma', 'La Compassion'),
  _WordPair('Valeurs', 'L\'Adl', 'La Justice'),
  _WordPair('Valeurs', 'L\'Aman', 'La Sécurité'),
  _WordPair('Valeurs', 'Le Sidq', 'L\'Honnêteté'),
  // Lieux & Objets
  _WordPair('Lieux', 'La Mosquée', 'L\'Église'),
  _WordPair('Lieux', 'Le Minaret', 'La Tour'),
  _WordPair('Lieux', 'Le Mimbar', 'La Tribune'),
  _WordPair('Lieux', 'Le Mihrab', 'L\'Alcôve'),
  _WordPair('Objets', 'Le Tasbeeh', 'Un collier'),
  _WordPair('Objets', 'Le Tapis de prière', 'Un tapis décoratif'),
  _WordPair('Objets', 'Le Kufi', 'Un béret'),
  _WordPair('Objets', 'L\'Abaya', 'Un manteau'),
  _WordPair('Objets', 'Le Oud', 'La Guitare'),
  // Vie quotidienne
  _WordPair('Vie quotidienne', 'La Bismillah', 'Une bénédiction'),
  _WordPair('Vie quotidienne', 'L\'Alhamdulillah', 'Le Merci'),
  _WordPair('Vie quotidienne', 'L\'Inshallah', 'Le peut-être'),
  _WordPair('Vie quotidienne', 'La Baraka', 'La Chance'),
  _WordPair('Vie quotidienne', 'Le Halal', 'Le Licite'),
  _WordPair('Vie quotidienne', 'Le Haram', 'L\'Interdit'),
  _WordPair('Vie quotidienne', 'La Iftar', 'Le Dîner'),
  _WordPair('Vie quotidienne', 'Le Suhoor', 'Le Petit-déjeuner'),
];

// ══════════════════════════════════════════════════════════════════
// MODELS
// ══════════════════════════════════════════════════════════════════

class KadhabPlayer {
  final int id;
  final String name;
  bool isKadhab;
  bool isEliminated;

  KadhabPlayer({
    required this.id,
    required this.name,
    this.isKadhab = false,
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
  int _currentCardIndex = 0; // for card reveal phase
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

    // Assign Kadhab
    _kadhabId = rng.nextInt(_playerCount);
    for (final p in _players) {
      p.isKadhab = (p.id == _kadhabId);
    }

    // Pick word pair
    _currentPair = _kWordPairs[rng.nextInt(_kWordPairs.length)];
    _currentCardIndex = 0;
    _round = 1;

    setState(() => _phase = GamePhase.cardReveal);
  }

  void _startNewRound() {
    final rng = Random();
    _currentPair = _kWordPairs[rng.nextInt(_kWordPairs.length)];
    _currentCardIndex = 0;
    _votes = {};
    _round++;
    setState(() => _phase = GamePhase.cardReveal);
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
      // Kadhab survived to the end → gets to guess
      setState(() => _phase = GamePhase.kadhabGuess);
    } else {
      setState(() => _phase = GamePhase.elimination);
    }
  }

  void _kadhabGuesses(String guess) {
    final correct = guess.trim().toLowerCase() ==
        _currentPair.trueWord.toLowerCase();
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
          pair: _currentPair,
          currentIndex: _currentCardIndex,
          round: _round,
          onNext: () {
            final alive = _players.where((p) => !p.isEliminated).toList();
            if (_currentCardIndex < alive.length - 1) {
              setState(() => _currentCardIndex++);
            } else {
              _votes = {};
              setState(() => _phase = GamePhase.discussion);
            }
          },
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
          _RuleItem('🃏', 'Chaque joueur voit son mot en secret'),
          _RuleItem('😈', 'Le Kadhab reçoit un mot différent'),
          _RuleItem('🗣', 'Chacun donne un indice à tour de rôle'),
          _RuleItem('🚫', 'Le Kadhab ne parle pas en premier'),
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
// SCREEN 2 — CARD REVEAL (one card at a time, flip + shake)
// ══════════════════════════════════════════════════════════════════

class _CardRevealScreen extends StatefulWidget {
  final List<KadhabPlayer> players;
  final _WordPair pair;
  final int currentIndex;
  final int round;
  final VoidCallback onNext;

  const _CardRevealScreen({
    required this.players,
    required this.pair,
    required this.currentIndex,
    required this.round,
    required this.onNext,
  });

  @override
  State<_CardRevealScreen> createState() => _CardRevealScreenState();
}

class _CardRevealScreenState extends State<_CardRevealScreen>
    with TickerProviderStateMixin {
  bool _isFlipped = false;
  bool _wordRevealed = false;
  late AnimationController _flipController;
  late AnimationController _shakeController;
  late Animation<double> _flipAnimation;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
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
      TweenSequenceItem(tween: Tween(begin: 0, end: -12), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -12, end: 12), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 12, end: -8), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -8, end: 8), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 8, end: 0), weight: 1),
    ]).animate(CurvedAnimation(parent: _shakeController, curve: Curves.easeInOut));
  }

  @override
  void didUpdateWidget(_CardRevealScreen old) {
    super.didUpdateWidget(old);
    if (old.currentIndex != widget.currentIndex) {
      // Reset for next player
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

  void _flip() {
    if (_isFlipped) {
      // Shake if trying to tap again
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

  @override
  Widget build(BuildContext context) {
    final player = widget.players[widget.currentIndex];
    final isKadhab = player.isKadhab;
    final word = isKadhab ? widget.pair.impostorWord : widget.pair.trueWord;

    return SafeArea(
      child: Column(
        children: [
          // Progress bar
          _GameHeader(
            title: 'Manche ${widget.round}',
            subtitle:
                'Carte ${widget.currentIndex + 1} / ${widget.players.length}',
            showBack: false,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Player name
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
                      ? 'Mémorise ton mot et passe le téléphone'
                      : 'Tape la carte pour découvrir ton mot',
                  style: TextStyle(
                    color: _wordRevealed ? Colors.amber : Colors.white54,
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                // Flip card
                AnimatedBuilder(
                  animation: _flipAnimation,
                  builder: (_, child) {
                    return AnimatedBuilder(
                      animation: _shakeAnimation,
                      builder: (_, __) {
                        return Transform.translate(
                          offset: Offset(_shakeAnimation.value, 0),
                          child: GestureDetector(
                            onTap: _flip,
                            child: _buildCard(word, isKadhab),
                          ),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 48),
                // Next button (only after reveal)
                AnimatedOpacity(
                  opacity: _wordRevealed ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 400),
                  child: SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _wordRevealed ? widget.onNext : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD4AF37),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        widget.currentIndex < widget.players.length - 1
                            ? 'Joueur suivant →'
                            : 'C\'est parti ! 🎯',
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(String word, bool isKadhab) {
    final angle = _flipAnimation.value;
    final showBack = angle > pi / 2;

    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.002)
        ..rotateY(angle),
      child: showBack
          ? Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..rotateY(pi),
              child: _CardFront(word: word, isKadhab: isKadhab),
            )
          : _CardBack(),
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
  final bool isKadhab;

  const _CardFront({required this.word, required this.isKadhab});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 320,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isKadhab
              ? [const Color(0xFF2D0A0A), const Color(0xFF5A1515)]
              : [const Color(0xFF0A1A2D), const Color(0xFF0D3A5C)],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isKadhab ? const Color(0xFFFF4444) : const Color(0xFF4A90D9),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: (isKadhab ? const Color(0xFFFF4444) : const Color(0xFF4A90D9))
                .withOpacity(0.25),
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
            Text(
              isKadhab ? 'TU ES LE' : 'TON MOT',
              style: TextStyle(
                color: isKadhab
                    ? const Color(0xFFFF8888)
                    : const Color(0xFF7FC8FF),
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 2,
              ),
            ),
            if (isKadhab) ...[
              const SizedBox(height: 8),
              const Text(
                'KADHAB 😈',
                style: TextStyle(
                  color: Color(0xFFFF4444),
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 3,
                ),
              ),
            ],
            const SizedBox(height: 16),
            Text(
              isKadhab ? 'Ton mot imposteur :' : '',
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
            const SizedBox(height: 20),
            if (!isKadhab)
              const Text(
                'Ne montre à personne !',
                style: TextStyle(
                  color: Colors.white38,
                  fontSize: 11,
                  letterSpacing: 0.5,
                ),
              )
            else
              Column(
                children: const [
                  Text(
                    'Blende ! Tu ne parles pas en premier.',
                    style: TextStyle(
                      color: Color(0xFFFF8888),
                      fontSize: 11,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
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
    return SafeArea(
      child: Column(
        children: [
          _GameHeader(
            title: 'Discussion',
            subtitle: 'Thème : ${pair.theme}',
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
                        const Text(
                          '🗣 À tour de rôle',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Donnez chacun 1 ou 2 indices sur votre mot.\nLe Kadhab essaie de passer inaperçu.',
                          style: TextStyle(color: Colors.white60, fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        // Player order (Kadhab never first)
                        _DiscussionOrder(players: players),
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
                      child: const Text(
                        'Passer au vote  🗳',
                        style: TextStyle(
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

  const _DiscussionOrder({required this.players});

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
        const Text(
          'Ordre de parole suggéré',
          style: TextStyle(color: Colors.white38, fontSize: 12, letterSpacing: 1),
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
                  const Text(
                    'Qui est le plus suspect ?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Chaque joueur vote une fois.',
                    style: TextStyle(color: Colors.white54, fontSize: 13),
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
                        child: const Text(
                          'Révéler l\'éliminé  ⚡️',
                          style: TextStyle(
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
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('💨', style: TextStyle(fontSize: 80)),
            const SizedBox(height: 24),
            Text(
              '${eliminated.name} est éliminé !',
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
                  ? 'C\'était le Kadhab 😈 !'
                  : 'Ce n\'était pas le Kadhab... La partie continue !',
              style: TextStyle(
                color: eliminated.isKadhab
                    ? const Color(0xFFFF4444)
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
                child: const Text(
                  'Manche suivante →',
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
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text('😈', style: TextStyle(fontSize: 72)),
            const SizedBox(height: 20),
            Text(
              '${widget.kadhabName} a survécu !',
              style: const TextStyle(
                color: Color(0xFFFF4444),
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Text(
              'Le Kadhab peut encore gagner.\nDevine le vrai mot pour remporter la partie !',
              style: TextStyle(color: Colors.white60, fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            TextField(
              controller: _ctrl,
              onChanged: (_) => setState(() {}),
              style: const TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'Tape ton mot...',
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
                child: const Text(
                  'Soumettre ma réponse 🎯',
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
                      truthWins ? 'Le Kadhab est démasqué !' : 'Le Kadhab gagne !',
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
                          ? 'La vérité a triomphé. Alhamdulillah ! 🤲'
                          : '${kadhab.name} a trompé tout le monde...',
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
                      'Thème : ${widget.pair.theme}',
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
                            label: 'Vrai mot',
                            word: widget.pair.trueWord,
                            color: const Color(0xFF4A90D9),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _WordRevealTile(
                            label: 'Mot Kadhab',
                            word: widget.pair.impostorWord,
                            color: const Color(0xFFFF4444),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        const Icon(Icons.person, color: Colors.white38, size: 16),
                        const SizedBox(width: 6),
                        Text(
                          'Kadhab : ${kadhab.name}',
                          style: const TextStyle(
                            color: Colors.white60,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
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
                    child: const Text('Accueil'),
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
                    child: const Text(
                      'Rejouer 🎮',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
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
