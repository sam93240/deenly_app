// priere_guide_screen.dart — UpYourDeen · Guide Pratique de la Prière

import 'package:flutter/material.dart';

// ── Palette ──────────────────────────────────────────────────────────────────
const _kGreenDeep    = Color(0xFF0A2018);
const _kGreenPrimary = Color(0xFF1B4D38);
const _kGreenMedium  = Color(0xFF2A7A52);
const _kGreenLight   = Color(0xFFE8F4EE);
const _kGold         = Color(0xFFC8933A);
const _kGoldLight    = Color(0xFFFFF4DC);
const _kBlue         = Color(0xFF1A5C8A);
const _kBlueLight    = Color(0xFFE3EDF7);
const _kPurple       = Color(0xFF6A3FAA);
const _kPurpleLight  = Color(0xFFF3ECFA);
const _kBeige        = Color(0xFFF6F0E3);
const _kBeigeCard    = Color(0xFFFFFFFF);
const _kBeigeBorder  = Color(0xFFD6C9AF);
const _kTextDark     = Color(0xFF1A130A);
const _kTextMid      = Color(0xFF5A4833);
const _kTextLight    = Color(0xFF8A7863);

// ══════════════════════════════════════════════════════════════════════════════
// MODÈLES DE DONNÉES
// ══════════════════════════════════════════════════════════════════════════════

enum _PositionType { qiyam, ruku, itidal, sujud, jalsa, tashahhud, none }

class _WuduStep {
  final int    stepNum;
  final String title;
  final String description;
  final String icon;
  final String? arabic;
  final String? phonetic;
  final String? translation;
  final int    times; // nombre de répétitions (0 = pas indiqué)

  const _WuduStep({
    required this.stepNum,
    required this.title,
    required this.description,
    required this.icon,
    this.arabic,
    this.phonetic,
    this.translation,
    this.times = 3,
  });
}

class _SalahStep {
  final int           stepNum;
  final String        title;
  final String        description;
  final _PositionType position;
  final String?       arabic;
  final String?       phonetic;
  final String?       translation;
  final int           times;

  const _SalahStep({
    required this.stepNum,
    required this.title,
    required this.description,
    this.position    = _PositionType.none,
    this.arabic,
    this.phonetic,
    this.translation,
    this.times = 0,
  });
}

class _DailyPrayer {
  final String name, arabicName, icon, time;
  final int    fard, sunnahBefore, sunnahAfter, nafl;
  final String note;

  const _DailyPrayer({
    required this.name,
    required this.arabicName,
    required this.icon,
    required this.time,
    required this.fard,
    this.sunnahBefore = 0,
    this.sunnahAfter  = 0,
    this.nafl         = 0,
    this.note         = '',
  });
}

class _SunnahPrayer {
  final String name, arabicName, icon, time, rakaat, merit, description;

  const _SunnahPrayer({
    required this.name,
    required this.arabicName,
    required this.icon,
    required this.time,
    required this.rakaat,
    required this.merit,
    required this.description,
  });
}

// ══════════════════════════════════════════════════════════════════════════════
// DONNÉES — ABLUTION (WUDU)
// ══════════════════════════════════════════════════════════════════════════════
const List<_WuduStep> _wuduSteps = [
  _WuduStep(
    stepNum: 1,
    icon: '🤲',
    title: 'Intention (Niyyah)',
    description: 'Formuler mentalement l\'intention de faire l\'ablution pour purifier son corps avant la prière. L\'intention n\'est pas prononcée à voix haute.',
    times: 0,
  ),
  _WuduStep(
    stepNum: 2,
    icon: '🗣️',
    title: 'Bismillah',
    description: 'Commencer par prononcer le nom d\'Allah avant de se laver.',
    arabic: 'بِسْمِ اللَّهِ',
    phonetic: 'Bismillah',
    translation: 'Au nom d\'Allah',
    times: 0,
  ),
  _WuduStep(
    stepNum: 3,
    icon: '👐',
    title: 'Mains',
    description: 'Laver les deux mains jusqu\'aux poignets en veillant à frotter entre les doigts.',
    times: 3,
  ),
  _WuduStep(
    stepNum: 4,
    icon: '💧',
    title: 'Bouche (Madmada)',
    description: 'Prendre de l\'eau dans la bouche, la faire tourner, puis la recracher.',
    times: 3,
  ),
  _WuduStep(
    stepNum: 5,
    icon: '👃',
    title: 'Nez (Istinshaq)',
    description: 'Aspirer de l\'eau dans le nez avec la main droite, puis se moucher avec la gauche.',
    times: 3,
  ),
  _WuduStep(
    stepNum: 6,
    icon: '😌',
    title: 'Visage',
    description: 'Laver tout le visage de la ligne des cheveux au menton, et d\'une oreille à l\'autre.',
    times: 3,
  ),
  _WuduStep(
    stepNum: 7,
    icon: '💪',
    title: 'Bras droit',
    description: 'Laver le bras droit depuis les doigts jusqu\'au coude inclus.',
    times: 3,
  ),
  _WuduStep(
    stepNum: 8,
    icon: '💪',
    title: 'Bras gauche',
    description: 'Laver le bras gauche depuis les doigts jusqu\'au coude inclus.',
    times: 3,
  ),
  _WuduStep(
    stepNum: 9,
    icon: '🤚',
    title: 'Tête (Masah)',
    description: 'Passer les mains humides sur toute la tête depuis le front jusqu\'à la nuque, une seule fois.',
    times: 1,
  ),
  _WuduStep(
    stepNum: 10,
    icon: '👂',
    title: 'Oreilles',
    description: 'Passer les pouces humides derrière les oreilles et les index dans les oreilles, en même temps que le masah de la tête.',
    times: 1,
  ),
  _WuduStep(
    stepNum: 11,
    icon: '🦶',
    title: 'Pied droit puis gauche',
    description: 'Laver chaque pied jusqu\'à la cheville en frottant entre les orteils. Commencer par le pied droit.',
    times: 3,
  ),
  _WuduStep(
    stepNum: 12,
    icon: '🤲',
    title: 'Dua de fin',
    description: 'Après le wudu, lever les yeux vers le ciel et réciter cette invocation.',
    arabic: 'أَشْهَدُ أَنْ لَا إِلَٰهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، وَأَشْهَدُ أَنَّ مُحَمَّدًا عَبْدُهُ وَرَسُولُهُ',
    phonetic: "Ash-hadu an lâ ilâha illallâhu wahdahu lâ sharîka lah, wa ash-hadu anna Muhammadan 'abduhu wa rasûluh",
    translation: 'Je témoigne qu\'il n\'y a de divinité qu\'Allah, Seul et sans associé, et que Muhammad est Son serviteur et Messager.',
    times: 0,
  ),
];

// ══════════════════════════════════════════════════════════════════════════════
// DONNÉES — ÉTAPES DE LA PRIÈRE
// ══════════════════════════════════════════════════════════════════════════════
const List<_SalahStep> _salahSteps = [
  _SalahStep(
    stepNum: 1,
    title: 'Intention (Niyyah)',
    description: 'Former mentalement l\'intention de prier (ex. : "Je vais prier la prière de Fajr de deux rak\'ahs pour Allah"). L\'intention n\'est pas prononcée à voix haute.',
    position: _PositionType.qiyam,
  ),
  _SalahStep(
    stepNum: 2,
    title: 'Takbirat al-Ihram',
    description: 'Se tenir debout, face à la qibla. Lever les deux mains jusqu\'aux oreilles et prononcer le takbir d\'ouverture. La prière commence à ce moment.',
    position: _PositionType.qiyam,
    arabic: 'اللَّهُ أَكْبَرُ',
    phonetic: 'Allahu Akbar',
    translation: 'Allah est le Plus Grand',
    times: 1,
  ),
  _SalahStep(
    stepNum: 3,
    title: 'Dua d\'ouverture (Istiftah)',
    description: 'Réciter discrètement cette invocation d\'ouverture après le takbir, avant de commencer la sourate.',
    position: _PositionType.qiyam,
    arabic: 'سُبْحَانَكَ اللَّهُمَّ وَبِحَمْدِكَ، وَتَبَارَكَ اسْمُكَ، وَتَعَالَى جَدُّكَ، وَلَا إِلَهَ غَيْرُكَ',
    phonetic: "Subhânakallâhumma wa bihamdik, wa tabârakasmuk, wa ta'âlâ jadduk, wa lâ ilâha ghayruk",
    translation: 'Gloire à Toi, ô Allah, et louange à Toi. Béni soit Ton nom, élevée Ta majesté. Il n\'est de divinité que Toi.',
    times: 0,
  ),
  _SalahStep(
    stepNum: 4,
    title: 'Ta\'awwudh + Al-Fatiha',
    description: 'Réciter "A\'udhu billahi min ash-shaytân ir-rajîm" (refuge en Allah contre satan), puis réciter Al-Fatiha. Cette sourate est obligatoire à chaque rak\'ah.',
    position: _PositionType.qiyam,
    arabic: 'أَعُوذُ بِاللَّهِ مِنَ الشَّيْطَانِ الرَّجِيمِ',
    phonetic: "A'ûdhu billâhi min ash-shaytânir-rajîm",
    translation: 'Je cherche refuge en Allah contre Satan le maudit.',
    times: 0,
  ),
  _SalahStep(
    stepNum: 5,
    title: 'Récitation d\'une sourate',
    description: 'Après Al-Fatiha, réciter une sourate ou quelques versets du Coran. Uniquement dans les deux premières rak\'ahs. Al-Ikhlas, Al-Falaq, An-Nas ou d\'autres sont recommandées.',
    position: _PositionType.qiyam,
    times: 0,
  ),
  _SalahStep(
    stepNum: 6,
    title: 'Ruku\' (Prosternation debout)',
    description: 'Dire "Allahu Akbar" en s\'inclinant. Le dos doit être droit et horizontal, les mains sur les genoux. Rester immobile un moment (tuma\'ninah).',
    position: _PositionType.ruku,
    arabic: 'سُبْحَانَ رَبِّيَ الْعَظِيمِ',
    phonetic: "Subhâna Rabbiyal 'Adhîm",
    translation: 'Gloire à mon Seigneur, le Très Grand.',
    times: 3,
  ),
  _SalahStep(
    stepNum: 7,
    title: 'I\'tidal (Relèvement du Ruku\')',
    description: 'Se relever en disant le premier dhikr, puis une fois debout, dire la réponse. Rester immobile un moment.',
    position: _PositionType.itidal,
    arabic: 'سَمِعَ اللَّهُ لِمَنْ حَمِدَهُ\nرَبَّنَا وَلَكَ الْحَمْدُ',
    phonetic: "Sami'a Allâhu liman hamidah\nRabbanâ wa lakal hamd",
    translation: 'Allah exauce celui qui Le loue.\nNotre Seigneur, à Toi la louange.',
    times: 0,
  ),
  _SalahStep(
    stepNum: 8,
    title: 'Premier Sujud',
    description: 'Dire "Allahu Akbar" en descendant. Se prosterner sur les 7 membres : front (avec le nez), deux mains, deux genoux, deux pieds. Ne pas plaquer les bras au sol.',
    position: _PositionType.sujud,
    arabic: 'سُبْحَانَ رَبِّيَ الْأَعْلَى',
    phonetic: "Subhâna Rabbiyal A'lâ",
    translation: 'Gloire à mon Seigneur, le Très-Haut.',
    times: 3,
  ),
  _SalahStep(
    stepNum: 9,
    title: 'Jalsa (Assise entre les deux sujud)',
    description: 'Se relever en disant "Allahu Akbar", s\'asseoir sur le pied gauche replié, le pied droit dressé. Rester immobile un moment.',
    position: _PositionType.jalsa,
    arabic: 'رَبِّ اغْفِرْ لِي',
    phonetic: 'Rabbighfir lî',
    translation: 'Seigneur, pardonne-moi.',
    times: 3,
  ),
  _SalahStep(
    stepNum: 10,
    title: 'Deuxième Sujud',
    description: 'Se prosterner à nouveau en disant "Allahu Akbar" avec le même dhikr que le premier sujud. C\'est la fin d\'une rak\'ah.',
    position: _PositionType.sujud,
    arabic: 'سُبْحَانَ رَبِّيَ الْأَعْلَى',
    phonetic: "Subhâna Rabbiyal A'lâ",
    translation: 'Gloire à mon Seigneur, le Très-Haut.',
    times: 3,
  ),
  _SalahStep(
    stepNum: 11,
    title: 'Tashahhud',
    description: 'À la fin de la 2e rak\'ah (et de la dernière), s\'asseoir et réciter le Tashahhud. Lever l\'index droit au moment de "illa Allah".',
    position: _PositionType.tashahhud,
    arabic: 'التَّحِيَّاتُ لِلَّهِ وَالصَّلَوَاتُ وَالطَّيِّبَاتُ، السَّلَامُ عَلَيْكَ أَيُّهَا النَّبِيُّ وَرَحْمَةُ اللَّهِ وَبَرَكَاتُهُ، السَّلَامُ عَلَيْنَا وَعَلَى عِبَادِ اللَّهِ الصَّالِحِينَ، أَشْهَدُ أَنْ لَا إِلَهَ إِلَّا اللَّهُ وَأَشْهَدُ أَنَّ مُحَمَّدًا عَبْدُهُ وَرَسُولُهُ',
    phonetic: "At-tahiyyâtu lillâhi was-salawâtu wat-tayyibât. As-salâmu 'alayka ayyuhan-nabiyyu wa rahmatullâhi wa barakâtuh. As-salâmu 'alaynâ wa 'alâ 'ibâdillâhis-sâlihîn. Ash-hadu an lâ ilâha illallâhu wa ash-hadu anna Muhammadan 'abduhu wa rasûluh.",
    translation: 'Les salutations, les prières et les bonnes paroles sont à Allah. Paix sur toi, ô Prophète, ainsi que la miséricorde d\'Allah et Ses bénédictions. Paix sur nous et sur les serviteurs vertueux d\'Allah. Je témoigne qu\'il n\'est de divinité qu\'Allah et que Muhammad est Son serviteur et Messager.',
    times: 0,
  ),
  _SalahStep(
    stepNum: 12,
    title: 'Salat Ibrahimiyya',
    description: 'Dans le tashahhud final uniquement, réciter après le Tashahhud cette prière sur le Prophète ﷺ.',
    position: _PositionType.tashahhud,
    arabic: 'اللَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ كَمَا صَلَّيْتَ عَلَى إِبْرَاهِيمَ وَعَلَى آلِ إِبْرَاهِيمَ',
    phonetic: "Allâhumma salli 'alâ Muhammadin wa 'alâ âli Muhammadin, kamâ sallayta 'alâ Ibrâhîma wa 'alâ âli Ibrâhîm",
    translation: 'Ô Allah, envoie Ta grâce sur Muhammad et sur la famille de Muhammad, comme Tu as envoyé Ta grâce sur Ibrahim et sur la famille d\'Ibrahim.',
    times: 0,
  ),
  _SalahStep(
    stepNum: 13,
    title: 'Tasleem (Fin de la prière)',
    description: 'Tourner la tête vers la droite en disant le salut, puis vers la gauche en répétant le même salut. La prière est terminée.',
    position: _PositionType.tashahhud,
    arabic: 'السَّلَامُ عَلَيْكُمْ وَرَحْمَةُ اللَّهِ',
    phonetic: "As-salâmu 'alaykum wa rahmatullâh",
    translation: 'Que la paix et la miséricorde d\'Allah soient sur vous.',
    times: 2,
  ),
];

// ══════════════════════════════════════════════════════════════════════════════
// DONNÉES — PRIÈRES JOURNALIÈRES
// ══════════════════════════════════════════════════════════════════════════════
const List<_DailyPrayer> _dailyPrayers = [
  _DailyPrayer(
    name: 'Fajr',      arabicName: 'الفَجْر',   icon: '🌅',
    time: 'Aube',
    fard: 2,           sunnahBefore: 2,
    note: 'Les 2 sunnah du Fajr sont les plus recommandées de toutes les sunnah.',
  ),
  _DailyPrayer(
    name: 'Dhuhr',     arabicName: 'الظُّهْر',  icon: '☀️',
    time: 'Midi',
    fard: 4,           sunnahBefore: 4,   sunnahAfter: 2,
    note: 'Le vendredi, la prière du Jumu\'ah (2 rak\'ahs) remplace le Dhuhr.',
  ),
  _DailyPrayer(
    name: 'Asr',       arabicName: 'العَصْر',   icon: '🌤️',
    time: 'Après-midi',
    fard: 4,
    note: 'Prière dite "du milieu" (As-Salat al-Wusta). Très important de ne pas la manquer.',
  ),
  _DailyPrayer(
    name: 'Maghrib',   arabicName: 'المَغْرِب', icon: '🌆',
    time: 'Coucher du soleil',
    fard: 3,           sunnahAfter: 2,
    note: 'Se presse pour prier dès l\'entrée du temps, car son temps est court.',
  ),
  _DailyPrayer(
    name: 'Isha',      arabicName: 'العِشَاء',  icon: '🌙',
    time: 'Nuit',
    fard: 4,           sunnahAfter: 2,   nafl: 3,
    note: 'Le Witr (1 ou 3 rak\'ahs) est fortement recommandé après Isha. Dernier acte avant de dormir.',
  ),
];

// ══════════════════════════════════════════════════════════════════════════════
// DONNÉES — PRIÈRES SURÉROGATOIRES (SUNNAH / NAFL)
// ══════════════════════════════════════════════════════════════════════════════
const List<_SunnahPrayer> _sunnahPrayers = [
  _SunnahPrayer(
    name: 'Prière du Tahajjud',     arabicName: 'تَهَجُّد',
    icon: '🌌',
    time: 'Dernier tiers de la nuit',
    rakaat: '2 à 8 rak\'ahs (ou plus), terminées par le Witr',
    merit: 'Le Prophète ﷺ ne l\'abandonnait jamais, en voyage comme chez lui. Allah descend au ciel de cette terre au dernier tiers de la nuit.',
    description: 'Se lever après un sommeil, faire les ablutions, et prier. C\'est la prière volontaire la plus méritoire après les prières obligatoires.',
  ),
  _SunnahPrayer(
    name: 'Prière Doha (Chaourou\')',  arabicName: 'صَلَاةُ الضُّحَى',
    icon: '☀️',
    time: 'Après le lever du soleil jusqu\'à midi',
    rakaat: '2 à 12 rak\'ahs',
    merit: 'Équivaut à une aumône pour chaque articulation du corps (360 articulations). Le Prophète ﷺ recommandait 2 rak\'ahs au minimum.',
    description: 'Se prie entre le moment où le soleil est à une lance au-dessus de l\'horizon et le Dhuhr. Idéalement vers 15-20 minutes après le lever total du soleil.',
  ),
  _SunnahPrayer(
    name: 'Witr',                    arabicName: 'الوِتْر',
    icon: '⭐',
    time: 'Après Isha jusqu\'à l\'aube',
    rakaat: '1, 3, 5, 7 ou 9 rak\'ahs (nombre impair)',
    merit: 'Le Prophète ﷺ a dit : "Allah est Impair et aime l\'impair." Fortement recommandé, certains savants le considèrent obligatoire (wâjib).',
    description: 'La dernière prière de la nuit. Dans la dernière rak\'ah, on récite le Dua al-Qunut (invocation spéciale). Terminer sa nuit par le Witr.',
  ),
  _SunnahPrayer(
    name: 'Prière de Istikhara',     arabicName: 'صَلَاةُ الاسْتِخَارَة',
    icon: '🤲',
    time: 'À tout moment (hors heures interdites)',
    rakaat: '2 rak\'ahs puis dua spécifique',
    merit: 'Guidance divine pour toute décision importante. Le Prophète ﷺ enseignait l\'Istikhara pour chaque chose comme il enseignait une sourate du Coran.',
    description: 'Prier 2 rak\'ahs, puis réciter le Dua de l\'Istikhara en demandant à Allah de choisir ce qui est meilleur pour soi dans sa décision.',
  ),
  _SunnahPrayer(
    name: 'Prière du Vendredi (Jumu\'ah)', arabicName: 'صَلَاةُ الجُمُعَة',
    icon: '🕌',
    time: 'Vendredi à l\'heure du Dhuhr',
    rakaat: '2 rak\'ahs (remplace le Dhuhr)',
    merit: 'Obligatoire pour les hommes capables. Allah efface les péchés entre deux vendredis. L\'heure de la réponse (sa\'a al-ijaba) est le vendredi.',
    description: 'Écouter le khutbah (sermon) est obligatoire. Prendre un bain (ghusl), porter de beaux vêtements et se parfumer sont recommandés. Lire Al-Kahf est sunnah.',
  ),
  _SunnahPrayer(
    name: 'Prière des 2 Aïds',       arabicName: 'صَلَاةُ العِيدَيْن',
    icon: '🎉',
    time: 'Matin de l\'Aïd al-Fitr et Aïd al-Adha',
    rakaat: '2 rak\'ahs avec takbirat supplémentaires',
    merit: 'Sunna muakkadah (sunnah fortement recommandée). Occasion de joie collective et d\'unité de la communauté musulmane.',
    description: 'Se prie en communauté dans un grand espace ouvert (musalla). Précédée de takbirat. Suivie de deux khutbahs. Il est recommandé de manger des dattes avant l\'Aïd al-Fitr.',
  ),
];

// ══════════════════════════════════════════════════════════════════════════════
// ÉCRAN PRINCIPAL
// ══════════════════════════════════════════════════════════════════════════════
class PriereGuideScreen extends StatefulWidget {
  const PriereGuideScreen({super.key});

  @override
  State<PriereGuideScreen> createState() => _PriereGuideScreenState();
}

class _PriereGuideScreenState extends State<PriereGuideScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  static const _tabs = [
    (icon: '🚿', label: 'Ablution'),
    (icon: '🕌', label: 'La Prière'),
    (icon: '📊', label: 'Les Prières'),
    (icon: '⭐', label: 'Sunnah'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBeige,
      body: Column(children: [
        _buildHeader(context),
        _buildTabBar(),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _WuduTab(),
              _SalahTab(),
              _PriereTableauTab(),
              _SunnahTab(),
            ],
          ),
        ),
      ]),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [_kGreenDeep, _kGreenPrimary],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Row(children: [
            GestureDetector(
              onTap: () => Navigator.maybePop(context),
              child: Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                ),
                child: const Icon(Icons.arrow_back_ios_new_rounded,
                    color: Colors.white, size: 15),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Guide de la Prière',
                    style: TextStyle(
                      color: Colors.white, fontSize: 20,
                      fontWeight: FontWeight.w900, letterSpacing: 0.3,
                    )),
                Text('Ablution · Positions · Prières · Sunnah',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.55), fontSize: 11)),
              ]),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
              ),
              child: const Text('🕌', style: TextStyle(fontSize: 18)),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: _kGreenPrimary,
      child: TabBar(
        controller: _tabController,
        isScrollable: false,
        indicatorColor: _kGold,
        indicatorWeight: 3,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white.withOpacity(0.45),
        labelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800),
        tabs: _tabs.map((t) => Tab(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(t.icon, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 2),
            Text(t.label),
          ]),
        )).toList(),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// ONGLET 1 — ABLUTION (WUDU)
// ══════════════════════════════════════════════════════════════════════════════
class _WuduTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
      children: [
        // Intro
        _IntroCard(
          icon: '💧',
          title: 'L\'Ablution (Al-Wudu\u02bc)',
          body:
              'La purification rituelle est une condition obligatoire (shart) de la prière. Sans wudu valide, la prière n\'est pas acceptée. Le Prophète ﷺ a dit : "Allah n\'accepte pas la prière sans purification."',
          color: _kBlue,
          bgColor: _kBlueLight,
        ),
        const SizedBox(height: 16),
        // Étapes
        ...List.generate(_wuduSteps.length, (i) => _WuduStepCard(step: _wuduSteps[i])),
        // Note de fin
        const SizedBox(height: 8),
        _NoteCard(
          icon: '💡',
          text: 'Le wudu reste valide jusqu\'à ce qu\'il soit rompu (passage de selles ou d\'urine, gaz intestinaux, sommeil profond, perte de connaissance). Il n\'est pas nécessaire de refaire le wudu pour chaque prière s\'il n\'a pas été rompu.',
        ),
      ],
    );
  }
}

class _WuduStepCard extends StatefulWidget {
  final _WuduStep step;
  const _WuduStepCard({required this.step});

  @override
  State<_WuduStepCard> createState() => _WuduStepCardState();
}

class _WuduStepCardState extends State<_WuduStepCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final s = widget.step;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: _kBeigeCard,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _kBeigeBorder, width: 1.2),
        boxShadow: const [
          BoxShadow(color: Color(0x08000000), blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => setState(() => _expanded = !_expanded),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              // Numéro de l'étape
              Container(
                width: 34, height: 34,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [_kBlue, Color(0xFF2A7AAA)]),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text('${s.stepNum}',
                      style: const TextStyle(
                          color: Colors.white, fontSize: 14,
                          fontWeight: FontWeight.w900)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Row(children: [
                  Text(s.icon, style: const TextStyle(fontSize: 20)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(s.title,
                        style: const TextStyle(
                            color: _kTextDark, fontSize: 14,
                            fontWeight: FontWeight.w800)),
                  ),
                ]),
              ),
              if (s.times > 0)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: _kBlueLight,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('× ${s.times}',
                      style: const TextStyle(
                          color: _kBlue, fontSize: 11,
                          fontWeight: FontWeight.w800)),
                ),
              const SizedBox(width: 8),
              Icon(_expanded ? Icons.expand_less_rounded : Icons.expand_more_rounded,
                  color: _kTextLight, size: 20),
            ]),

            if (_expanded) ...[
              const SizedBox(height: 12),
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                _WuduDiagram(stepNum: s.stepNum),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(s.description,
                      style: const TextStyle(
                          color: _kTextMid, fontSize: 12.5, height: 1.6)),
                ),
              ]),
              if (s.arabic != null) ...[
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F7FF),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _kBlue.withOpacity(0.2)),
                  ),
                  child: Column(children: [
                    Text(s.arabic!,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 20, color: _kTextDark, height: 1.9)),
                    if (s.phonetic != null) ...[
                      const SizedBox(height: 6),
                      Text(s.phonetic!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 12, color: _kBlue,
                              fontStyle: FontStyle.italic)),
                    ],
                    if (s.translation != null) ...[
                      const SizedBox(height: 6),
                      Text(s.translation!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 12, color: _kTextMid, height: 1.5)),
                    ],
                  ]),
                ),
              ],
            ],
          ]),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// ONGLET 2 — LA PRIÈRE (ÉTAPES)
// ══════════════════════════════════════════════════════════════════════════════
class _SalahTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
      children: [
        _IntroCard(
          icon: '🕌',
          title: 'Les Étapes de la Prière',
          body:
              'La prière (As-Salah) est le deuxième pilier de l\'islam. Chaque prière est composée d\'un nombre défini de rak\'ahs. Une rak\'ah = les étapes du Qiyam jusqu\'au Sujud et retour.',
          color: _kGreenPrimary,
          bgColor: _kGreenLight,
        ),
        const SizedBox(height: 16),
        ...List.generate(_salahSteps.length, (i) => _SalahStepCard(step: _salahSteps[i])),
        const SizedBox(height: 8),
        _NoteCard(
          icon: '📌',
          text:
              'Une rak\'ah complète : Qiyam (Fatiha + Sourate) → Ruku\' → I\'tidal → Sujud 1 → Jalsa → Sujud 2. Le Tashahhud se fait à la fin de la 2e rak\'ah (et de la dernière rak\'ah). La Salat Ibrahimiyya uniquement dans le dernier Tashahhud.',
        ),
      ],
    );
  }
}

class _SalahStepCard extends StatefulWidget {
  final _SalahStep step;
  const _SalahStepCard({required this.step});

  @override
  State<_SalahStepCard> createState() => _SalahStepCardState();
}

class _SalahStepCardState extends State<_SalahStepCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final s = widget.step;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: _kBeigeCard,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _kBeigeBorder, width: 1.2),
        boxShadow: const [
          BoxShadow(color: Color(0x08000000), blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => setState(() => _expanded = !_expanded),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              // Position visuelle
              _PositionBadge(position: s.position, stepNum: s.stepNum),
              const SizedBox(width: 12),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(s.title,
                      style: const TextStyle(
                          color: _kTextDark, fontSize: 13.5,
                          fontWeight: FontWeight.w800)),
                  if (s.times > 0)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text('× ${s.times}',
                          style: const TextStyle(
                              color: _kGreenMedium, fontSize: 11,
                              fontWeight: FontWeight.w700)),
                    ),
                ]),
              ),
              Icon(_expanded ? Icons.expand_less_rounded : Icons.expand_more_rounded,
                  color: _kTextLight, size: 20),
            ]),

            if (_expanded) ...[
              const SizedBox(height: 12),
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                _SalahImage(stepNum: s.stepNum),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(s.description,
                      style: const TextStyle(
                          color: _kTextMid, fontSize: 12.5, height: 1.6)),
                ),
              ]),
              if (s.arabic != null) ...[
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: _kGreenLight,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _kGreenMedium.withOpacity(0.25)),
                  ),
                  child: Column(children: [
                    Text(s.arabic!,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 19, color: _kTextDark, height: 2.0)),
                    if (s.phonetic != null) ...[
                      const SizedBox(height: 6),
                      Text(s.phonetic!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 11.5, color: _kGreenMedium,
                              fontStyle: FontStyle.italic, height: 1.5)),
                    ],
                    if (s.translation != null) ...[
                      const SizedBox(height: 8),
                      const Divider(height: 1, color: _kBeigeBorder),
                      const SizedBox(height: 8),
                      Text(s.translation!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 12, color: _kTextMid, height: 1.6)),
                    ],
                  ]),
                ),
              ],
            ],
          ]),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// WIDGET — BADGE POSITION
// ══════════════════════════════════════════════════════════════════════════════
class _PositionBadge extends StatelessWidget {
  final _PositionType position;
  final int           stepNum;
  const _PositionBadge({required this.position, required this.stepNum});

  static const _positionData = <_PositionType, (String, Color, Color)>{
    _PositionType.qiyam:     ('🧍', Color(0xFF1B4D38), Color(0xFFE8F4EE)),
    _PositionType.ruku:      ('🙇', Color(0xFF1A5C8A), Color(0xFFE3EDF7)),
    _PositionType.itidal:    ('🙂', Color(0xFF6A3FAA), Color(0xFFF3ECFA)),
    _PositionType.sujud:     ('🤲', Color(0xFFA85C00), Color(0xFFFAEBD7)),
    _PositionType.jalsa:     ('🧘', Color(0xFF1B4D38), Color(0xFFE8F4EE)),
    _PositionType.tashahhud: ('☝️', Color(0xFFC8933A), Color(0xFFFFF4DC)),
    _PositionType.none:      ('📿', Color(0xFF5A4833), Color(0xFFF6F0E3)),
  };

  @override
  Widget build(BuildContext context) {
    final data = _positionData[position] ??
        (_positionData[_PositionType.none]!);
    final (emoji, color, bg) = data;

    return Container(
      width: 44, height: 44,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Stack(
        children: [
          Center(child: Text(emoji, style: const TextStyle(fontSize: 20))),
          Positioned(
            bottom: 1, right: 1,
            child: Container(
              width: 16, height: 16,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text('$stepNum',
                    style: const TextStyle(
                        color: Colors.white, fontSize: 8,
                        fontWeight: FontWeight.w900)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// ONGLET 3 — TABLEAU DES PRIÈRES
// ══════════════════════════════════════════════════════════════════════════════
class _PriereTableauTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int totalFard = 0, totalSunnah = 0;
    for (final p in _dailyPrayers) {
      totalFard   += p.fard;
      totalSunnah += p.sunnahBefore + p.sunnahAfter + p.nafl;
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
      children: [
        _IntroCard(
          icon: '📊',
          title: 'Les 5 Prières Obligatoires',
          body:
              'La prière est le pilier central de l\'islam. Les 5 prières journalières sont obligatoires (fard \'ayn) pour tout musulman pubère. Le nombre total de rak\'ahs obligatoires par jour est de $totalFard.',
          color: _kGold,
          bgColor: _kGoldLight,
        ),
        const SizedBox(height: 16),

        // Totaux
        Row(children: [
          _TotalChip(value: '$totalFard', label: 'Rak\'ahs fard', color: _kGreenPrimary),
          const SizedBox(width: 10),
          _TotalChip(value: '$totalSunnah', label: 'Rak\'ahs sunnah', color: _kGold),
          const SizedBox(width: 10),
          _TotalChip(value: '${totalFard + totalSunnah}', label: 'Total/jour', color: _kPurple),
        ]),
        const SizedBox(height: 16),

        // Cartes prières
        ...List.generate(_dailyPrayers.length, (i) => _PrayerTableCard(prayer: _dailyPrayers[i])),

        const SizedBox(height: 8),
        _NoteCard(
          icon: '📖',
          text:
              'Les sunnah muakkadah (confirmées) sont celles que le Prophète ﷺ pratiquait régulièrement et n\'abandonnait que rarement. Elles complètent la prière obligatoire et compensent ses manquements.',
        ),
      ],
    );
  }
}

class _PrayerTableCard extends StatelessWidget {
  final _DailyPrayer prayer;
  const _PrayerTableCard({required this.prayer});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kBeigeCard,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _kBeigeBorder, width: 1.2),
        boxShadow: const [
          BoxShadow(color: Color(0x08000000), blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Nom + heure
        Row(children: [
          Text(prayer.icon, style: const TextStyle(fontSize: 26)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Text(prayer.name,
                    style: const TextStyle(
                        color: _kTextDark, fontSize: 16,
                        fontWeight: FontWeight.w900)),
                const SizedBox(width: 8),
                Text(prayer.arabicName,
                    style: const TextStyle(
                        color: _kGold, fontSize: 14,
                        fontWeight: FontWeight.w700)),
              ]),
              Text(prayer.time,
                  style: const TextStyle(color: _kTextLight, fontSize: 11)),
            ]),
          ),
        ]),
        const SizedBox(height: 14),

        // Rak\'ahs grid
        Row(children: [
          if (prayer.sunnahBefore > 0)
            _RakaatChip(
                label: '${prayer.sunnahBefore} Sunnah avant',
                color: _kGold,
                bg: _kGoldLight),
          if (prayer.sunnahBefore > 0) const SizedBox(width: 6),
          _RakaatChip(
              label: '${prayer.fard} Fard',
              color: _kGreenPrimary,
              bg: _kGreenLight,
              bold: true),
          if (prayer.sunnahAfter > 0) const SizedBox(width: 6),
          if (prayer.sunnahAfter > 0)
            _RakaatChip(
                label: '${prayer.sunnahAfter} Sunnah après',
                color: _kGold,
                bg: _kGoldLight),
          if (prayer.nafl > 0) const SizedBox(width: 6),
          if (prayer.nafl > 0)
            _RakaatChip(
                label: '${prayer.nafl} Witr',
                color: _kPurple,
                bg: _kPurpleLight),
        ]),

        if (prayer.note.isNotEmpty) ...[
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            decoration: BoxDecoration(
              color: _kBeige,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('💡', style: TextStyle(fontSize: 12)),
              const SizedBox(width: 6),
              Expanded(
                child: Text(prayer.note,
                    style: const TextStyle(
                        color: _kTextMid, fontSize: 11, height: 1.5)),
              ),
            ]),
          ),
        ],
      ]),
    );
  }
}

class _RakaatChip extends StatelessWidget {
  final String label;
  final Color  color, bg;
  final bool   bold;
  const _RakaatChip({
    required this.label,
    required this.color,
    required this.bg,
    this.bold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(label,
          style: TextStyle(
            color: color, fontSize: 11,
            fontWeight: bold ? FontWeight.w900 : FontWeight.w700,
          )),
    );
  }
}

class _TotalChip extends StatelessWidget {
  final String value, label;
  final Color  color;
  const _TotalChip({required this.value, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: _kBeigeCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _kBeigeBorder),
        ),
        child: Column(children: [
          Text(value,
              style: TextStyle(
                  color: color, fontSize: 22, fontWeight: FontWeight.w900)),
          const SizedBox(height: 2),
          Text(label,
              textAlign: TextAlign.center,
              style: const TextStyle(color: _kTextLight, fontSize: 9.5)),
        ]),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// ONGLET 4 — PRIÈRES SUNNAH
// ══════════════════════════════════════════════════════════════════════════════
class _SunnahTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
      children: [
        _IntroCard(
          icon: '⭐',
          title: 'Prières Surérogatoires',
          body:
              'Au-delà des 5 prières obligatoires, Allah a ouvert des portes de bienfaits supplémentaires. Ces prières volontaires rapprochent du Paradis et complètent les insuffisances des prières obligatoires.',
          color: _kPurple,
          bgColor: _kPurpleLight,
        ),
        const SizedBox(height: 16),
        ...List.generate(_sunnahPrayers.length, (i) => _SunnahCard(prayer: _sunnahPrayers[i])),
      ],
    );
  }
}

class _SunnahCard extends StatefulWidget {
  final _SunnahPrayer prayer;
  const _SunnahCard({required this.prayer});

  @override
  State<_SunnahCard> createState() => _SunnahCardState();
}

class _SunnahCardState extends State<_SunnahCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.prayer;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: _kBeigeCard,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _kBeigeBorder, width: 1.2),
        boxShadow: const [
          BoxShadow(color: Color(0x08000000), blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => setState(() => _expanded = !_expanded),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Container(
                width: 46, height: 46,
                decoration: BoxDecoration(
                  color: _kPurpleLight,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: _kPurple.withOpacity(0.2)),
                ),
                child: Center(
                    child: Text(p.icon, style: const TextStyle(fontSize: 22))),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(p.name,
                      style: const TextStyle(
                          color: _kTextDark, fontSize: 14,
                          fontWeight: FontWeight.w900)),
                  Text(p.arabicName,
                      style: const TextStyle(
                          color: _kGold, fontSize: 13,
                          fontWeight: FontWeight.w700)),
                ]),
              ),
              Icon(_expanded ? Icons.expand_less_rounded : Icons.expand_more_rounded,
                  color: _kTextLight, size: 20),
            ]),

            if (_expanded) ...[
              const SizedBox(height: 12),

              // Méta : heure + rak\'ahs
              Row(children: [
                _MetaChip(icon: '🕐', label: p.time,   color: _kBlue),
                const SizedBox(width: 8),
                _MetaChip(icon: '🔢', label: p.rakaat, color: _kPurple),
              ]),
              const SizedBox(height: 12),

              Text(p.description,
                  style: const TextStyle(
                      color: _kTextMid, fontSize: 12.5, height: 1.6)),
              const SizedBox(height: 10),

              // Mérite
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _kGoldLight,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _kGold.withOpacity(0.3)),
                ),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('✨', style: TextStyle(fontSize: 14)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(p.merit,
                        style: const TextStyle(
                            color: _kTextDark, fontSize: 11.5, height: 1.6)),
                  ),
                ]),
              ),
            ],
          ]),
        ),
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  final String icon, label;
  final Color  color;
  const _MetaChip({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: _kBeige,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _kBeigeBorder),
        ),
        child: Row(children: [
          Text(icon, style: const TextStyle(fontSize: 12)),
          const SizedBox(width: 6),
          Expanded(
            child: Text(label,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: color, fontSize: 10.5,
                    fontWeight: FontWeight.w700)),
          ),
        ]),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// WIDGETS PARTAGÉS
// ══════════════════════════════════════════════════════════════════════════════
class _IntroCard extends StatelessWidget {
  final String icon, title, body;
  final Color  color, bgColor;
  const _IntroCard({
    required this.icon,
    required this.title,
    required this.body,
    required this.color,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withOpacity(0.25), width: 1.2),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text(icon, style: const TextStyle(fontSize: 22)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(title,
                style: TextStyle(
                    color: color, fontSize: 15,
                    fontWeight: FontWeight.w900)),
          ),
        ]),
        const SizedBox(height: 10),
        Text(body,
            style: const TextStyle(
                color: _kTextMid, fontSize: 12.5, height: 1.6)),
      ]),
    );
  }
}

class _NoteCard extends StatelessWidget {
  final String icon, text;
  const _NoteCard({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kBeige,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kBeigeBorder),
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(icon, style: const TextStyle(fontSize: 16)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(text,
              style: const TextStyle(
                  color: _kTextMid, fontSize: 12, height: 1.6)),
        ),
      ]),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// VISUELS — ABLUTION & PRIÈRE
// ══════════════════════════════════════════════════════════════════════════════

/// Partie du corps à mettre en valeur dans le diagramme wudu
enum _BodyHighlight { none, hands, mouth, nose, face, rightArm, leftArm, headMasah, ears, feet }

/// Associe chaque étape d'ablution à la partie du corps correspondante
_BodyHighlight _wuduHighlightForStep(int stepNum) {
  return switch (stepNum) {
    1  => _BodyHighlight.none,
    2  => _BodyHighlight.none,
    3  => _BodyHighlight.hands,
    4  => _BodyHighlight.mouth,
    5  => _BodyHighlight.nose,
    6  => _BodyHighlight.face,
    7  => _BodyHighlight.rightArm,
    8  => _BodyHighlight.leftArm,
    9  => _BodyHighlight.headMasah,
    10 => _BodyHighlight.ears,
    11 => _BodyHighlight.feet,
    12 => _BodyHighlight.none,
    _  => _BodyHighlight.none,
  };
}

// ─── Diagramme Wudu ───────────────────────────────────────────────────────────
class _WuduDiagram extends StatelessWidget {
  final int stepNum;
  const _WuduDiagram({required this.stepNum});

  static String? _imagePath(int step) {
    const mapping = <int, String>{
      1:  'assets/wudu/wudu_01.png',
      2:  'assets/wudu/wudu_02.png',
      3:  'assets/wudu/wudu_03.png',
      4:  'assets/wudu/wudu_04.png',
      5:  'assets/wudu/wudu_05.png',
      6:  'assets/wudu/wudu_06.png',
      7:  'assets/wudu/wudu_07.png',
      8:  'assets/wudu/wudu_07.png', // bras droit + gauche sur la même image
      9:  'assets/wudu/wudu_08.png',
      10: 'assets/wudu/wudu_09.png',
      11: 'assets/wudu/wudu_10.png',
    };
    return mapping[step];
  }

  @override
  Widget build(BuildContext context) {
    final path = _imagePath(stepNum);
    if (path == null) return const SizedBox.shrink();
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        path,
        width: 110,
        height: 110,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          width: 110, height: 110,
          decoration: BoxDecoration(
            color: const Color(0xFFEEF6FF),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kBlue.withOpacity(0.2)),
          ),
          child: const Icon(Icons.image_not_supported_outlined,
              color: Color(0xFFAABBCC), size: 32),
        ),
      ),
    );
  }
}

class _WuduBodyPainter extends CustomPainter {
  final _BodyHighlight highlight;
  const _WuduBodyPainter({required this.highlight});

  @override
  void paint(Canvas canvas, Size size) {
    final sx = size.width / 100;
    final sy = size.height / 100;
    Offset o(double x, double y) => Offset(x * sx, y * sy);

    final bodyPaint = Paint()
      ..color = const Color(0xFFAABBCC)
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final hlStroke = Paint()
      ..color = const Color(0xFF2196F3)
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final hlFill = Paint()
      ..color = const Color(0xFF2196F3).withOpacity(0.3)
      ..style = PaintingStyle.fill;

    // ── Corps de base ──────────────────────────────────────────────
    canvas.drawCircle(o(50, 14), 9 * sx, bodyPaint);          // tête
    canvas.drawLine(o(50, 23), o(50, 56), bodyPaint);          // torse
    canvas.drawLine(o(28, 32), o(72, 32), bodyPaint);          // épaules
    canvas.drawLine(o(72, 32), o(80, 52), bodyPaint);          // bras droit haut
    canvas.drawLine(o(80, 52), o(74, 68), bodyPaint);          // avant-bras droit
    canvas.drawLine(o(28, 32), o(20, 52), bodyPaint);          // bras gauche haut
    canvas.drawLine(o(20, 52), o(26, 68), bodyPaint);          // avant-bras gauche
    canvas.drawLine(o(46, 56), o(40, 83), bodyPaint);          // jambe gauche
    canvas.drawLine(o(54, 56), o(60, 83), bodyPaint);          // jambe droite
    canvas.drawLine(o(40, 83), o(34, 90), bodyPaint);          // pied gauche
    canvas.drawLine(o(60, 83), o(66, 90), bodyPaint);          // pied droit

    // ── Highlight ──────────────────────────────────────────────────
    switch (highlight) {
      case _BodyHighlight.hands:
        canvas.drawCircle(o(74, 70), 4.5 * sx, hlFill);
        canvas.drawCircle(o(74, 70), 4.5 * sx, hlStroke);
        canvas.drawCircle(o(26, 70), 4.5 * sx, hlFill);
        canvas.drawCircle(o(26, 70), 4.5 * sx, hlStroke);
      case _BodyHighlight.mouth:
        final r = Rect.fromCenter(center: o(50, 17), width: 9 * sx, height: 5 * sy);
        canvas.drawArc(r, 0.15, 2.8, false, hlStroke);
      case _BodyHighlight.nose:
        final path = Path()
          ..moveTo(o(50, 10).dx, o(50, 10).dy)
          ..lineTo(o(46, 17).dx, o(46, 17).dy)
          ..lineTo(o(54, 17).dx, o(54, 17).dy)
          ..close();
        canvas.drawPath(path, hlFill);
        canvas.drawPath(path, hlStroke..strokeWidth = 1.5);
      case _BodyHighlight.face:
        canvas.drawCircle(o(50, 14), 9 * sx, hlFill);
        canvas.drawCircle(o(50, 14), 9 * sx, hlStroke..strokeWidth = 2.5);
      case _BodyHighlight.rightArm:
        canvas.drawLine(o(72, 32), o(80, 52), hlStroke..strokeWidth = 3.5);
        canvas.drawLine(o(80, 52), o(74, 68), hlStroke);
        canvas.drawCircle(o(74, 70), 4.5 * sx, hlFill);
        canvas.drawCircle(o(74, 70), 4.5 * sx, hlStroke);
      case _BodyHighlight.leftArm:
        canvas.drawLine(o(28, 32), o(20, 52), hlStroke..strokeWidth = 3.5);
        canvas.drawLine(o(20, 52), o(26, 68), hlStroke);
        canvas.drawCircle(o(26, 70), 4.5 * sx, hlFill);
        canvas.drawCircle(o(26, 70), 4.5 * sx, hlStroke);
      case _BodyHighlight.headMasah:
        final r = Rect.fromCenter(center: o(50, 14), width: 20 * sx, height: 20 * sy);
        canvas.drawArc(r, -2.5, 1.8, false, hlStroke..strokeWidth = 5.0);
      case _BodyHighlight.ears:
        canvas.drawCircle(o(41, 14), 3 * sx, hlFill);
        canvas.drawCircle(o(41, 14), 3 * sx, hlStroke..strokeWidth = 2.0);
        canvas.drawCircle(o(59, 14), 3 * sx, hlFill);
        canvas.drawCircle(o(59, 14), 3 * sx, hlStroke);
      case _BodyHighlight.feet:
        canvas.drawOval(Rect.fromCenter(center: o(35, 91), width: 11 * sx, height: 6 * sy), hlFill);
        canvas.drawOval(Rect.fromCenter(center: o(35, 91), width: 11 * sx, height: 6 * sy), hlStroke..strokeWidth = 2.5);
        canvas.drawOval(Rect.fromCenter(center: o(65, 91), width: 11 * sx, height: 6 * sy), hlFill);
        canvas.drawOval(Rect.fromCenter(center: o(65, 91), width: 11 * sx, height: 6 * sy), hlStroke);
      case _BodyHighlight.none:
        break;
    }
  }

  @override
  bool shouldRepaint(_WuduBodyPainter old) => old.highlight != highlight;
}

// ─── Image Salah (par numéro d'étape) ────────────────────────────────────────
class _SalahImage extends StatelessWidget {
  final int stepNum;
  const _SalahImage({required this.stepNum});

  static String? _imagePath(int step) {
    const mapping = <int, String>{
      1:  'assets/salah/salah_01.png', // Intention
      2:  'assets/salah/salah_02.png', // Takbir
      3:  'assets/salah/salah_03.png', // Qiyam
      4:  'assets/salah/salah_03.png', // Qiyam (Al-Fatiha)
      5:  'assets/salah/salah_03.png', // Qiyam (Sourate)
      6:  'assets/salah/salah_04.png', // Ruku
      7:  'assets/salah/salah_05.png', // I'tidal
      8:  'assets/salah/salah_06.png', // Sujud 1
      9:  'assets/salah/salah_07.png', // Jalsa
      10: 'assets/salah/salah_06.png', // Sujud 2
      11: 'assets/salah/salah_09.png', // Tashahhud
      12: 'assets/salah/salah_09.png', // Salat Ibrahimiyya
      13: 'assets/salah/salah_11.png', // Tasleem
    };
    return mapping[step];
  }

  @override
  Widget build(BuildContext context) {
    final path = _imagePath(stepNum);
    if (path == null) return const SizedBox.shrink();
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        path,
        width: 110,
        height: 110,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          width: 110, height: 110,
          decoration: BoxDecoration(
            color: _kGreenLight,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kGreenPrimary.withOpacity(0.2)),
          ),
          child: const Icon(Icons.image_not_supported_outlined,
              color: Color(0xFFAABBCC), size: 32),
        ),
      ),
    );
  }
}

// ─── Figure Position Salah (CustomPainter fallback) ───────────────────────────
class _PositionFigure extends StatelessWidget {
  final _PositionType position;
  const _PositionFigure({required this.position});

  static const _bgColors = <_PositionType, Color>{
    _PositionType.qiyam:     Color(0xFFE8F4EE),
    _PositionType.ruku:      Color(0xFFE3EDF7),
    _PositionType.itidal:    Color(0xFFF3ECFA),
    _PositionType.sujud:     Color(0xFFFAEBD7),
    _PositionType.jalsa:     Color(0xFFE8F4EE),
    _PositionType.tashahhud: Color(0xFFFFF4DC),
    _PositionType.none:      Color(0xFFF6F0E3),
  };

  @override
  Widget build(BuildContext context) {
    final bg = _bgColors[position] ?? const Color(0xFFF6F0E3);
    return Container(
      width: 90, height: 90,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF1B4D38).withOpacity(0.15)),
      ),
      child: CustomPaint(
        painter: _SalahFigurePainter(position: position),
      ),
    );
  }
}

class _SalahFigurePainter extends CustomPainter {
  final _PositionType position;
  const _SalahFigurePainter({required this.position});

  @override
  void paint(Canvas canvas, Size size) {
    final sx = size.width / 100;
    final sy = size.height / 100;
    Offset o(double x, double y) => Offset(x * sx, y * sy);

    final p = Paint()
      ..color = const Color(0xFF1B4D38)
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    switch (position) {
      case _PositionType.qiyam:
        _drawQiyam(canvas, p, o, sx);
      case _PositionType.ruku:
        _drawRuku(canvas, p, o, sx);
      case _PositionType.itidal:
        _drawItidal(canvas, p, o, sx);
      case _PositionType.sujud:
        _drawSujud(canvas, p, o, sx, sy);
      case _PositionType.jalsa:
        _drawJalsa(canvas, p, o, sx, sy);
      case _PositionType.tashahhud:
        _drawTashahhud(canvas, p, o, sx, sy);
      case _PositionType.none:
        _drawQiyam(canvas, p, o, sx);
    }
  }

  // ── Qiyam : debout, mains croisées sur la poitrine ──────────────
  void _drawQiyam(Canvas canvas, Paint p, Offset Function(double, double) o, double sx) {
    canvas.drawCircle(o(50, 12), 8 * sx, p);
    canvas.drawLine(o(50, 20), o(50, 58), p);
    canvas.drawLine(o(30, 32), o(70, 32), p);
    canvas.drawLine(o(30, 32), o(38, 44), p);
    canvas.drawLine(o(70, 32), o(62, 44), p);
    canvas.drawLine(o(38, 44), o(62, 44), p);   // mains croisées
    canvas.drawLine(o(46, 58), o(40, 85), p);
    canvas.drawLine(o(54, 58), o(60, 85), p);
    canvas.drawLine(o(40, 85), o(35, 92), p);
    canvas.drawLine(o(60, 85), o(65, 92), p);
  }

  // ── Itidal : debout, bras le long du corps ──────────────────────
  void _drawItidal(Canvas canvas, Paint p, Offset Function(double, double) o, double sx) {
    canvas.drawCircle(o(50, 12), 8 * sx, p);
    canvas.drawLine(o(50, 20), o(50, 58), p);
    canvas.drawLine(o(30, 32), o(70, 32), p);
    canvas.drawLine(o(30, 32), o(26, 58), p);
    canvas.drawLine(o(70, 32), o(74, 58), p);
    canvas.drawLine(o(46, 58), o(40, 85), p);
    canvas.drawLine(o(54, 58), o(60, 85), p);
    canvas.drawLine(o(40, 85), o(35, 92), p);
    canvas.drawLine(o(60, 85), o(65, 92), p);
  }

  // ── Ruku : incliné à 90°, mains sur les genoux ──────────────────
  void _drawRuku(Canvas canvas, Paint p, Offset Function(double, double) o, double sx) {
    canvas.drawLine(o(38, 55), o(34, 88), p);    // jambe gauche
    canvas.drawLine(o(58, 55), o(62, 88), p);    // jambe droite
    canvas.drawLine(o(34, 88), o(28, 94), p);    // pied gauche
    canvas.drawLine(o(62, 88), o(68, 94), p);    // pied droit
    canvas.drawLine(o(36, 55), o(62, 55), p);    // hanches
    canvas.drawLine(o(50, 55), o(88, 46), p);    // torse horizontal
    canvas.drawCircle(o(93, 42), 7 * sx, p);     // tête
    canvas.drawLine(o(84, 48), o(42, 62), p);    // bras gauche → genou gauche
    canvas.drawLine(o(88, 50), o(58, 62), p);    // bras droit → genou droit
  }

  // ── Sujud : prosternation ────────────────────────────────────────
  void _drawSujud(Canvas canvas, Paint p, Offset Function(double, double) o, double sx, double sy) {
    final ground = Paint()
      ..color = const Color(0xFF1B4D38).withOpacity(0.3)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    canvas.drawLine(o(8, 88), o(92, 88), ground);
    canvas.drawCircle(o(18, 82), 6 * sx, p);      // tête au sol
    canvas.drawLine(o(14, 87), o(36, 78), p);     // avant-bras gauche
    canvas.drawLine(o(22, 87), o(42, 76), p);     // avant-bras droit
    canvas.drawLine(o(34, 74), o(62, 60), p);     // torse
    canvas.drawLine(o(60, 60), o(70, 82), p);     // cuisse gauche
    canvas.drawLine(o(66, 58), o(76, 80), p);     // cuisse droite
    canvas.drawLine(o(70, 82), o(76, 88), p);     // pied gauche
    canvas.drawLine(o(76, 80), o(82, 88), p);     // pied droit
  }

  // ── Jalsa : assis entre deux prosternations ──────────────────────
  void _drawJalsa(Canvas canvas, Paint p, Offset Function(double, double) o, double sx, double sy) {
    final ground = Paint()
      ..color = const Color(0xFF1B4D38).withOpacity(0.3)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    canvas.drawLine(o(18, 88), o(82, 88), ground);
    canvas.drawCircle(o(50, 18), 8 * sx, p);
    canvas.drawLine(o(50, 26), o(50, 62), p);
    canvas.drawLine(o(32, 36), o(68, 36), p);
    canvas.drawLine(o(32, 36), o(30, 62), p);
    canvas.drawLine(o(68, 36), o(70, 62), p);
    canvas.drawLine(o(46, 62), o(28, 88), p);
    canvas.drawLine(o(54, 62), o(72, 88), p);
  }

  // ── Tashahhud : assis, index droit levé ─────────────────────────
  void _drawTashahhud(Canvas canvas, Paint p, Offset Function(double, double) o, double sx, double sy) {
    final ground = Paint()
      ..color = const Color(0xFF1B4D38).withOpacity(0.3)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    canvas.drawLine(o(18, 88), o(82, 88), ground);
    canvas.drawCircle(o(50, 18), 8 * sx, p);
    canvas.drawLine(o(50, 26), o(50, 62), p);
    canvas.drawLine(o(32, 36), o(68, 36), p);
    canvas.drawLine(o(32, 36), o(30, 62), p);     // bras gauche sur cuisse
    canvas.drawLine(o(68, 36), o(74, 18), p);     // bras droit levé
    canvas.drawLine(o(74, 18), o(72, 8), p);      // index pointé vers le haut
    canvas.drawLine(o(46, 62), o(28, 88), p);
    canvas.drawLine(o(54, 62), o(72, 88), p);
  }

  @override
  bool shouldRepaint(_SalahFigurePainter old) => old.position != position;
}
