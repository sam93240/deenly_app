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
  // Coran / Quran
  _WordPair('Coran',        'Un verset',              'Une sourate',               'Quran',        'A verse',                 'A surah'),
  _WordPair('Coran',        'Le Coran',               'La Bible',                  'Quran',        'The Quran',               'The Bible'),
  _WordPair('Coran',        'La récitation',          'La lecture',                'Quran',        'The recitation',          'The reading'),
  _WordPair('Coran',        'La mémorisation',        'La traduction',             'Quran',        'Memorization',            'Translation'),
  // Vêtements / Clothing
  _WordPair('Vêtements',    'Le qamis',               'La chemise longue',         'Clothing',     'The qamis',               'The long shirt'),
  _WordPair('Vêtements',    'Le voile',               'Le foulard',                'Clothing',     'The veil',                'The headscarf'),
  _WordPair('Vêtements',    'Le qamis',               'L\'abaya',                  'Clothing',     'The qamis',               'The abaya'),
  _WordPair('Vêtements',    'Le turban',              'Le chapeau',                'Clothing',     'The turban',              'The hat'),
  _WordPair('Vêtements',    'Les sandales',           'Les chaussures',            'Clothing',     'Sandals',                 'Shoes'),
  // Nourriture / Food
  _WordPair('Nourriture',   'Les dattes',             'Les figues',                'Food',         'Dates',                   'Figs'),
  _WordPair('Nourriture',   'L\'eau de Zamzam',       'L\'eau bénite',             'Food',         'Zamzam water',            'Holy water'),
  _WordPair('Nourriture',   'Le miel',                'Le sirop',                  'Food',         'Honey',                   'Syrup'),
  _WordPair('Nourriture',   'La viande halal',        'La viande casher',          'Food',         'Halal meat',              'Kosher meat'),
  // Objets / Objects
  _WordPair('Objets',       'Le chapelet',            'Le rosaire',                'Objects',      'Prayer beads',            'The rosary'),
  _WordPair('Objets',       'La calligraphie islamique','La peinture religieuse',  'Objects',      'Islamic calligraphy',     'Religious painting'),
  _WordPair('Objets',       'La lanterne du Ramadan', 'La bougie de Noël',         'Objects',      'The Ramadan lantern',     'The Christmas candle'),
  _WordPair('Objets',       'Le croissant',           'L\'étoile',                 'Objects',      'The crescent',            'The star'),
  // Lieux / Places
  _WordPair('Lieux',        'Médine',                 'La Mecque',                 'Places',       'Madinah',                 'Mecca'),
  _WordPair('Lieux',        'Le minaret',             'Le clocher',                'Places',       'The minaret',             'The bell tower'),
  _WordPair('Lieux',        'Le dôme doré',           'La coupole',                'Places',       'The golden dome',         'The dome'),
  _WordPair('Lieux',        'La Terre sainte',        'La Terre promise',          'Places',       'The Holy Land',           'The Promised Land'),
  _WordPair('Lieux',        'Dubaï',                  'Sharjah',                   'Places',       'Dubai',                   'Sharjah'),
  // Personnages / Characters
  _WordPair('Personnages',  'Issa',                   'Ibrahim',                   'Characters',   'Issa',                    'Ibrahim'),
  _WordPair('Personnages',  'L\'imam',                'Le muezzin',                'Characters',   'The imam',                'The muezzin'),
  _WordPair('Personnages',  'Le muezzin',             'Le prédicateur',            'Characters',   'The muezzin',             'The preacher'),
  _WordPair('Personnages',  'Le prophète',            'Le messager',               'Characters',   'The prophet',             'The messenger'),
  _WordPair('Personnages',  'L\'ange',                'Le djinn',                  'Characters',   'The angel',               'The jinn'),
  _WordPair('Personnages',  'Le diable',              'Le démon',                  'Characters',   'The devil',               'The demon'),
  _WordPair('Personnages',  'Bilal',                  'Salman',                    'Characters',   'Bilal',                   'Salman'),
  _WordPair('Personnages',  'Abou Bakr',              'Omar',                      'Characters',   'Abu Bakr',                'Omar'),
  _WordPair('Personnages',  'Ali',                    'Othman',                    'Characters',   'Ali',                     'Othman'),
  _WordPair('Personnages',  'Khadija',                'Aïcha',                     'Characters',   'Khadijah',                'Aisha'),
  _WordPair('Personnages',  'Fatima',                 'Maryam',                    'Characters',   'Fatima',                  'Maryam'),
  _WordPair('Personnages',  'Adam',                   'Hawa',                      'Characters',   'Adam',                    'Hawa'),
  // Religions / Religions
  _WordPair('Religions',    'L\'Islam',               'La Bible',                  'Religions',    'Islam',                   'The Bible'),
  // Histoire / History
  _WordPair('Histoire',     'La conquête de La Mecque','La migration à Médine',    'History',      'The conquest of Mecca',   'The migration to Madinah'),
  // Fêtes / Celebrations
  _WordPair('Fêtes',        'L\'Aïd Al-Adha',         'L\'Aïd Al-Fitr',           'Celebrations', 'Eid Al-Adha',             'Eid Al-Fitr'),
  _WordPair('Fêtes',        'Le vendredi',            'Le dimanche',               'Celebrations', 'Friday',                  'Sunday'),
  _WordPair('Fêtes',        'La nuit du destin',      'La nuit du voyage nocturne','Celebrations', 'The Night of Decree',     'The Night of the Journey'),
  // Spiritualité / Spirituality
  _WordPair('Spiritualité', 'Le Paradis',             'L\'Enfer',                  'Spirituality', 'Paradise',                'Hell'),
  _WordPair('Spiritualité', 'Les anges',              'Les djinns',                'Spirituality', 'The angels',              'The jinn'),
  _WordPair('Spiritualité', 'Le Jugement dernier',    'La Résurrection',           'Spirituality', 'The Last Judgment',       'The Resurrection'),
  _WordPair('Spiritualité', 'La foi',                 'La croyance',               'Spirituality', 'Faith',                   'Belief'),
  _WordPair('Spiritualité', 'Le jeûne',               'Le régime',                 'Spirituality', 'Fasting',                 'Dieting'),
  _WordPair('Spiritualité', 'Le pèlerinage',          'Le voyage sacré',           'Spirituality', 'The pilgrimage',          'The sacred journey'),
  _WordPair('Spiritualité', 'L\'aumône',              'Le don',                    'Spirituality', 'Charity',                 'A gift'),
  _WordPair('Spiritualité', 'La paix',                'La miséricorde',            'Spirituality', 'Peace',                   'Mercy'),
  _WordPair('Spiritualité', 'Le bien',                'Le mal',                    'Spirituality', 'Good',                    'Evil'),
  _WordPair('Spiritualité', 'La prière du matin',     'La prière du soir',         'Spirituality', 'The morning prayer',      'The evening prayer'),
  _WordPair('Spiritualité', 'Le prophète Noé',        'Le prophète Abraham',       'Spirituality', 'The prophet Noah',        'The prophet Abraham'),
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

const int _kTotalGames = 5;

// ── Rôles des joueurs ─────────────────────────────────────────────
enum _PlayerRole { salihin, dall, kadhab }

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
  int _currentPickerIndex = 0;
  int _round = 1;
  GameResult? _result;
  String? _tiebreakerName;
  KadhabPlayer? _lastEliminated;

  // --- Scoring flags (reset each game) ---
  bool _kadhabWasVotedOut      = false;
  bool _dallWasVotedOut        = false;
  bool _kadhabGuessedCorrectly = false;

  // --- Série (5 parties) ---
  int _gamesPlayed = 0;
  Map<int, int> _seriesScores = {};   // playerId → cumul
  Map<int, int> _gameScores   = {};   // playerId → points cette partie

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

    // Initialiser les scores de la série
    _gamesPlayed = 0;
    _seriesScores = {for (int i = 0; i < _playerCount; i++) i: 0};

    _currentPair = _kWordPairs[rng.nextInt(_kWordPairs.length)];
    _round = 1;
    _cardSlots = _buildCardSlots(_playerCount, rng);
    _currentPickerIndex = 0;
    _kadhabId = -1;
    _dallId = -1;
    _kadhabWasVotedOut = false;
    _dallWasVotedOut = false;
    _kadhabGuessedCorrectly = false;
    _gameScores = {};

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
      ...List.filled(count - 2, _PlayerRole.salihin),
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
      // Le Kadhab est éliminé → dernière chance de deviner le mot
      _kadhabWasVotedOut = true;
      setState(() => _phase = GamePhase.kadhabGuess);
    } else {
      if (player.isDall) _dallWasVotedOut = true;
      if (alive.length <= 2) {
        final kadhabAlive = alive.any((p) => p.isKadhab);
        if (kadhabAlive) {
          setState(() => _phase = GamePhase.kadhabGuess);
        } else {
          _finishGame(GameResult.truthWins);
        }
      } else {
        setState(() => _phase = GamePhase.elimination);
      }
    }
  }

  void _kadhabGuesses(String guess) {
    final g = guess.trim().toLowerCase();
    final correct = g == _currentPair.trueWord.toLowerCase() ||
        g == _currentPair.trueWordEn.toLowerCase();
    _kadhabGuessedCorrectly = correct;
    _finishGame(correct ? GameResult.kadhabWins : GameResult.truthWins);
  }

  // ── FIN DE PARTIE & CALCUL DES SCORES ─────────────────────────
  void _finishGame(GameResult result) {
    _result = result;
    _calculateGameScores(result);
    _gamesPlayed++;
    setState(() => _phase = GamePhase.result);
  }

  void _calculateGameScores(GameResult result) {
    _gameScores = {};

    final kadhab = _players.firstWhere((p) => p.isKadhab);
    final dallList = _players.where((p) => p.isDall).toList();
    final dall = dallList.isNotEmpty ? dallList.first : null;
    final salihin = _players.where((p) => !p.isKadhab && !p.isDall).toList();

    // ── Kadhab ──────────────────────────────────────────────────
    if (!_kadhabWasVotedOut) {
      _addScore(kadhab.id, 5);         // non découvert
    } else if (_kadhabGuessedCorrectly) {
      _addScore(kadhab.id, 5);         // découvert MAIS trouve le mot
    }

    // ── Dall ────────────────────────────────────────────────────
    if (dall != null) {
      if (!_dallWasVotedOut) {
        _addScore(dall.id, 5);         // non découvert
      }
      // Survit après l'élimination du Kadhab (vérité gagne)
      if (result == GameResult.truthWins && !dall.isEliminated) {
        _addScore(dall.id, 2);
      }
    }

    // ── Salihin ─────────────────────────────────────────────────
    final kadhabFound = _kadhabWasVotedOut;
    final dallFound   = _dallWasVotedOut;

    if (kadhabFound) {
      for (final p in salihin) _addScore(p.id, 2);
    }
    if (dallFound) {
      for (final p in salihin) _addScore(p.id, 3);
    }
    if (kadhabFound && dallFound) {
      for (final p in salihin) _addScore(p.id, 1); // bonus
    }

    // Ajouter au cumul série
    for (final e in _gameScores.entries) {
      _seriesScores[e.key] = (_seriesScores[e.key] ?? 0) + e.value;
    }
  }

  void _addScore(int playerId, int pts) {
    _gameScores[playerId] = (_gameScores[playerId] ?? 0) + pts;
  }

  // ── PARTIE SUIVANTE (même joueurs, nouvelle partie) ────────────
  void _startNextGame() {
    final rng = Random();
    for (final p in _players) {
      p.isKadhab    = false;
      p.isDall      = false;
      p.isEliminated = false;
    }
    _votes     = {};
    _result    = null;
    _tiebreakerName    = null;
    _lastEliminated    = null;
    _round             = 1;
    _kadhabId          = -1;
    _dallId            = -1;
    _cardSlots         = [];
    _currentPickerIndex = 0;
    _kadhabWasVotedOut      = false;
    _dallWasVotedOut        = false;
    _kadhabGuessedCorrectly = false;
    _gameScores = {};

    _currentPair = _kWordPairs[rng.nextInt(_kWordPairs.length)];
    _cardSlots   = _buildCardSlots(_players.length, rng);

    setState(() => _phase = GamePhase.cardReveal);
  }

  // ── NOUVELLE SÉRIE (retour setup) ─────────────────────────────
  void _resetGame() {
    for (var c in _nameControllers) c.dispose();
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
    _kadhabWasVotedOut      = false;
    _dallWasVotedOut        = false;
    _kadhabGuessedCorrectly = false;
    _gamesPlayed   = 0;
    _seriesScores  = {};
    _gameScores    = {};
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
          wasVotedOut: _kadhabWasVotedOut,
          onGuess: _kadhabGuesses,
        );
      case GamePhase.result:
        return _ResultScreen(
          result: _result!,
          players: _players,
          pair: _currentPair,
          gameScores: _gameScores,
          seriesScores: _seriesScores,
          gamesPlayed: _gamesPlayed,
          onNextGame: _gamesPlayed < _kTotalGames ? _startNextGame : null,
          onNewSeries: _resetGame,
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
          _RuleItem('🟢', 'Salihin : reçoit le vrai mot'),
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
      case _PlayerRole.salihin: return widget.pair.getTrueWord(isFr);
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

    // Le Dall voit une carte IDENTIQUE au Muminun — il ne sait pas qu'il est le Dall.
    // Seul le Kadhab a une carte distincte (rouge, sans mot).
    final Color accent = isKadhab
        ? const Color(0xFFFF4444)
        : const Color(0xFF4A90D9); // Dall = même bleu que Muminun

    final List<Color> gradient = isKadhab
        ? [const Color(0xFF2D0A0A), const Color(0xFF5A1515)]
        : [const Color(0xFF0A1A2D), const Color(0xFF0D3A5C)]; // Dall = même gradient

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
            if (isKadhab) ...[
              // ── Carte Kadhab : rouge, pas de mot ──
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
                'KADHAB 😈',
                style: TextStyle(
                  color: accent,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 3,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                isFr ? 'Tu n\'as PAS de mot.' : 'You have NO word.',
                style: TextStyle(color: accent.withOpacity(0.8), fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                isFr ? 'Observe les autres et blende !' : 'Watch others and blend in!',
                style: const TextStyle(color: Colors.white38, fontSize: 12),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                isFr ? '⚠ Tu ne parles pas en premier !' : '⚠ Don\'t speak first!',
                style: TextStyle(
                  color: accent,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ] else ...[
              // ── Carte Salihin ET Dall (identiques visuellement) ──
              Text(
                isFr ? 'TON MOT' : 'YOUR WORD',
                style: const TextStyle(
                  color: Color(0xFF7FC8FF),
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                word,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Text(
                isFr ? 'Ne montre à personne !' : 'Don\'t show anyone!',
                style: const TextStyle(color: Colors.white38, fontSize: 11),
              ),
            ],
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
  final bool wasVotedOut;
  final ValueChanged<String> onGuess;

  const _KadhabGuessScreen({
    required this.kadhabName,
    required this.wasVotedOut,
    required this.onGuess,
  });

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
            Text(
              widget.wasVotedOut ? '⚔️' : '😈',
              style: const TextStyle(fontSize: 72),
            ),
            const SizedBox(height: 20),
            Text(
              widget.wasVotedOut
                  ? (isFr ? 'Dernière chance !' : 'Last chance!')
                  : (isFr
                      ? '${widget.kadhabName} a survécu !'
                      : '${widget.kadhabName} survived!'),
              style: TextStyle(
                color: widget.wasVotedOut
                    ? const Color(0xFFFF9800)
                    : const Color(0xFFFF4444),
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              widget.wasVotedOut
                  ? (isFr
                      ? '${widget.kadhabName} a été éliminé... mais peut encore gagner !\nDevine le vrai mot pour remporter 5 points !'
                      : '${widget.kadhabName} was eliminated... but can still win!\nGuess the true word to earn 5 points!')
                  : (isFr
                      ? 'Le Kadhab peut encore gagner.\nDevine le vrai mot pour remporter la partie !'
                      : 'The Kadhab can still win.\nGuess the true word to take the victory!'),
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
  final Map<int, int> gameScores;    // playerId → pts cette partie
  final Map<int, int> seriesScores;  // playerId → pts cumulés
  final int gamesPlayed;             // après cette partie (1–5)
  final VoidCallback? onNextGame;    // null si série terminée
  final VoidCallback onNewSeries;
  final VoidCallback onHome;

  const _ResultScreen({
    required this.result,
    required this.players,
    required this.pair,
    required this.gameScores,
    required this.seriesScores,
    required this.gamesPlayed,
    this.onNextGame,
    required this.onNewSeries,
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
    final seriesDone = widget.gamesPlayed >= _kTotalGames;

    // Classement série : trier par score décroissant
    final sorted = [...widget.players]
      ..sort((a, b) =>
          (widget.seriesScores[b.id] ?? 0)
              .compareTo(widget.seriesScores[a.id] ?? 0));

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // ── Résultat de la partie ──────────────────────────────
            FadeTransition(
              opacity: _fadeAnim,
              child: ScaleTransition(
                scale: _scaleAnim,
                child: Column(
                  children: [
                    Text(
                      truthWins ? '🏆' : '😈',
                      style: const TextStyle(fontSize: 72),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      truthWins
                          ? (isFr
                              ? 'Le Kadhab est démasqué !'
                              : 'The Kadhab is unmasked!')
                          : (isFr ? 'Le Kadhab gagne !' : 'The Kadhab wins!'),
                      style: TextStyle(
                        color: truthWins
                            ? const Color(0xFFD4AF37)
                            : const Color(0xFFFF4444),
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isFr
                          ? 'Partie ${widget.gamesPlayed} / $_kTotalGames'
                          : 'Game ${widget.gamesPlayed} / $_kTotalGames',
                      style: const TextStyle(
                        color: Colors.white38,
                        fontSize: 12,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // ── Révélation des mots ────────────────────────────────
            FadeTransition(
              opacity: _fadeAnim,
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E2E),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${isFr ? 'Thème' : 'Theme'} : ${widget.pair.getTheme(isFr)}',
                      style: const TextStyle(
                        color: Colors.white38,
                        fontSize: 12,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: _WordRevealTile(
                            label: isFr ? 'Vrai mot' : 'True word',
                            word: widget.pair.getTrueWord(isFr),
                            color: const Color(0xFF4A90D9),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _WordRevealTile(
                            label: isFr ? 'Mot du Dall' : "Dall's word",
                            word: widget.pair.getImpostorWord(isFr),
                            color: const Color(0xFFFF9800),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.person,
                            color: Color(0xFFFF4444), size: 14),
                        const SizedBox(width: 4),
                        Text(
                          '😈 Kadhab : ${kadhab.name}',
                          style: const TextStyle(
                              color: Color(0xFFFF8888), fontSize: 12),
                        ),
                      ],
                    ),
                    if (dall != null) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.person,
                              color: Color(0xFFFF9800), size: 14),
                          const SizedBox(width: 4),
                          Text(
                            '🌀 Dall : ${dall.name}',
                            style: const TextStyle(
                                color: Color(0xFFFFB74D), fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            // ── Points gagnés cette partie ─────────────────────────
            FadeTransition(
              opacity: _fadeAnim,
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A2E),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: const Color(0xFFD4AF37).withOpacity(0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isFr ? '⭐ Points cette partie' : '⭐ Points this game',
                      style: const TextStyle(
                        color: Color(0xFFD4AF37),
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ...widget.players.map((p) {
                      final pts = widget.gameScores[p.id] ?? 0;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                p.name,
                                style: const TextStyle(
                                    color: Colors.white70, fontSize: 13),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              decoration: BoxDecoration(
                                color: pts > 0
                                    ? const Color(0xFFD4AF37).withOpacity(0.15)
                                    : Colors.white.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                pts > 0 ? '+$pts pts' : '0 pt',
                                style: TextStyle(
                                  color: pts > 0
                                      ? const Color(0xFFD4AF37)
                                      : Colors.white38,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            // ── Classement de la série ─────────────────────────────
            FadeTransition(
              opacity: _fadeAnim,
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF0A1A2D),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: const Color(0xFF4A90D9).withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      seriesDone
                          ? (isFr
                              ? '🏅 Classement final !'
                              : '🏅 Final standings!')
                          : (isFr
                              ? '🏅 Classement série'
                              : '🏅 Series standings'),
                      style: const TextStyle(
                        color: Color(0xFF7FC8FF),
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ...sorted.asMap().entries.map((e) {
                      final rank = e.key + 1;
                      final p = e.value;
                      final total = widget.seriesScores[p.id] ?? 0;
                      final medal = rank == 1
                          ? '🥇'
                          : rank == 2
                              ? '🥈'
                              : rank == 3
                                  ? '🥉'
                                  : '  ${rank}.';
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 34,
                              child: Text(medal,
                                  style: const TextStyle(fontSize: 15)),
                            ),
                            Expanded(
                              child: Text(
                                p.name,
                                style: TextStyle(
                                  color: rank == 1
                                      ? Colors.white
                                      : Colors.white70,
                                  fontSize: 13,
                                  fontWeight: rank == 1
                                      ? FontWeight.w700
                                      : FontWeight.w400,
                                ),
                              ),
                            ),
                            Text(
                              '$total pts',
                              style: TextStyle(
                                color: rank == 1
                                    ? const Color(0xFFD4AF37)
                                    : Colors.white54,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ── Boutons ────────────────────────────────────────────
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: widget.onHome,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white60,
                      side: const BorderSide(color: Colors.white24),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(isFr ? 'Accueil' : 'Home'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed:
                        seriesDone ? widget.onNewSeries : widget.onNextGame,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: seriesDone
                          ? const Color(0xFF4A90D9)
                          : const Color(0xFFD4AF37),
                      foregroundColor:
                          seriesDone ? Colors.white : Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      seriesDone
                          ? (isFr ? 'Nouvelle série 🎮' : 'New series 🎮')
                          : (isFr
                              ? 'Partie ${widget.gamesPlayed + 1}/$_kTotalGames →'
                              : 'Game ${widget.gamesPlayed + 1}/$_kTotalGames →'),
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 14),
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
