// priere_guide_screen.dart — UpYourDeen · Guide Pratique de la Prière

import 'package:flutter/material.dart';
import '../translations.dart';
import '../app_locale.dart';

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

// Inline translation helper
String _s(String fr, String en) => AppLocale().isFrench ? fr : en;

// ══════════════════════════════════════════════════════════════════════════════
// MODÈLES DE DONNÉES
// ══════════════════════════════════════════════════════════════════════════════

enum _PositionType { qiyam, ruku, itidal, sujud, jalsa, tashahhud, none }

class _WuduStep {
  final int    stepNum;
  final String title;
  final String titleEn;
  final String description;
  final String descriptionEn;
  final String icon;
  final String? arabic;
  final String? phonetic;
  final String? translation;
  final String? translationEn;
  final int    times; // nombre de répétitions (0 = pas indiqué)

  const _WuduStep({
    required this.stepNum,
    required this.title,
    this.titleEn = '',
    required this.description,
    this.descriptionEn = '',
    required this.icon,
    this.arabic,
    this.phonetic,
    this.translation,
    this.translationEn,
    this.times = 3,
  });

  String getTitle() => _s(title, titleEn.isEmpty ? title : titleEn);
  String getDescription() => _s(description, descriptionEn.isEmpty ? description : descriptionEn);
  String? getTranslation() => _s(translation ?? '', translationEn ?? '').isEmpty ? null : _s(translation ?? '', translationEn ?? '');
}

class _SalahStep {
  final int           stepNum;
  final String        title;
  final String        titleEn;
  final String        description;
  final String        descriptionEn;
  final _PositionType position;
  final String?       arabic;
  final String?       phonetic;
  final String?       translation;
  final String?       translationEn;
  final int           times;

  const _SalahStep({
    required this.stepNum,
    required this.title,
    this.titleEn = '',
    required this.description,
    this.descriptionEn = '',
    this.position    = _PositionType.none,
    this.arabic,
    this.phonetic,
    this.translation,
    this.translationEn,
    this.times = 0,
  });

  String getTitle() => _s(title, titleEn.isEmpty ? title : titleEn);
  String getDescription() => _s(description, descriptionEn.isEmpty ? description : descriptionEn);
  String? getTranslation() => _s(translation ?? '', translationEn ?? '').isEmpty ? null : _s(translation ?? '', translationEn ?? '');
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
  final String name, nameEn, arabicName, icon, time, rakaat, merit, meritEn, description, descriptionEn;

  const _SunnahPrayer({
    required this.name,
    required this.arabicName,
    required this.icon,
    required this.time,
    required this.rakaat,
    required this.merit,
    required this.description,
  }) : nameEn = '', meritEn = '', descriptionEn = '';

  String getName() => _s(name, nameEn.isEmpty ? name : nameEn);
  String getMerit() => _s(merit, meritEn.isEmpty ? merit : meritEn);
  String getDescription() => _s(description, descriptionEn.isEmpty ? description : descriptionEn);
}

// ══════════════════════════════════════════════════════════════════════════════
// DONNÉES — ABLUTION (WUDU)
// ══════════════════════════════════════════════════════════════════════════════
const List<_WuduStep> _wuduSteps = [
  _WuduStep(
    stepNum: 1,
    icon: '🤲',
    title: 'Intention (Niyyah)',
    titleEn: 'Intention (Niyyah)',
    description: 'Formuler mentalement l\'intention de faire l\'ablution pour purifier son corps avant la prière. L\'intention n\'est pas prononcée à voix haute.',
    descriptionEn: 'Form the intention in your heart to perform wudu to purify your body before prayer. The intention is not pronounced aloud.',
    times: 0,
  ),
  _WuduStep(
    stepNum: 2,
    icon: '🗣️',
    title: 'Bismillah',
    titleEn: 'Bismillah',
    description: 'Commencer par prononcer le nom d\'Allah avant de se laver.',
    descriptionEn: 'Begin by pronouncing the name of Allah before washing.',
    arabic: 'بِسْمِ اللَّهِ',
    phonetic: 'Bismillah',
    translation: 'Au nom d\'Allah',
    translationEn: 'In the name of Allah',
    times: 0,
  ),
  _WuduStep(
    stepNum: 3,
    icon: '👐',
    title: 'Mains',
    titleEn: 'Hands',
    description: 'Laver les deux mains jusqu\'aux poignets en veillant à frotter entre les doigts.',
    descriptionEn: 'Wash both hands up to the wrists, making sure to rub between the fingers.',
    times: 3,
  ),
  _WuduStep(
    stepNum: 4,
    icon: '💧',
    title: 'Bouche (Madmada)',
    titleEn: 'Mouth (Madmada)',
    description: 'Prendre de l\'eau dans la bouche, la faire tourner, puis la recracher.',
    descriptionEn: 'Take water in your mouth, swish it around, then spit it out.',
    times: 3,
  ),
  _WuduStep(
    stepNum: 5,
    icon: '👃',
    title: 'Nez (Istinshaq)',
    titleEn: 'Nose (Istinshaq)',
    description: 'Aspirer de l\'eau dans le nez avec la main droite, puis se moucher avec la gauche.',
    descriptionEn: 'Inhale water into your nose with your right hand, then blow it out with your left.',
    times: 3,
  ),
  _WuduStep(
    stepNum: 6,
    icon: '😌',
    title: 'Visage',
    titleEn: 'Face',
    description: 'Laver tout le visage de la ligne des cheveux au menton, et d\'une oreille à l\'autre.',
    descriptionEn: 'Wash the entire face from the hairline to the chin, and from ear to ear.',
    times: 3,
  ),
  _WuduStep(
    stepNum: 7,
    icon: '💪',
    title: 'Bras droit',
    titleEn: 'Right arm',
    description: 'Laver le bras droit depuis les doigts jusqu\'au coude inclus.',
    descriptionEn: 'Wash the right arm from the fingers to the elbow, inclusive.',
    times: 3,
  ),
  _WuduStep(
    stepNum: 8,
    icon: '💪',
    title: 'Bras gauche',
    titleEn: 'Left arm',
    description: 'Laver le bras gauche depuis les doigts jusqu\'au coude inclus.',
    descriptionEn: 'Wash the left arm from the fingers to the elbow, inclusive.',
    times: 3,
  ),
  _WuduStep(
    stepNum: 9,
    icon: '🤚',
    title: 'Tête (Masah)',
    titleEn: 'Head (Masah)',
    description: 'Passer les mains humides sur toute la tête depuis le front jusqu\'à la nuque, une seule fois.',
    descriptionEn: 'Wipe your wet hands over the entire head from the forehead to the back of the neck, one time.',
    times: 1,
  ),
  _WuduStep(
    stepNum: 10,
    icon: '👂',
    title: 'Oreilles',
    titleEn: 'Ears',
    description: 'Passer les pouces humides derrière les oreilles et les index dans les oreilles, en même temps que le masah de la tête.',
    descriptionEn: 'Wipe the insides and backs of your ears with your wet fingers and thumbs at the same time as wiping your head.',
    times: 1,
  ),
  _WuduStep(
    stepNum: 11,
    icon: '🦶',
    title: 'Pied droit puis gauche',
    titleEn: 'Right foot then left',
    description: 'Laver chaque pied jusqu\'à la cheville en frottant entre les orteils. Commencer par le pied droit.',
    descriptionEn: 'Wash each foot up to the ankle, rubbing between the toes. Start with the right foot.',
    times: 3,
  ),
  _WuduStep(
    stepNum: 12,
    icon: '🤲',
    title: 'Dua de fin',
    titleEn: 'Closing supplication',
    description: 'Après le wudu, lever les yeux vers le ciel et réciter cette invocation.',
    descriptionEn: 'After wudu, look up to the sky and recite this supplication.',
    arabic: 'أَشْهَدُ أَنْ لَا إِلَٰهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، وَأَشْهَدُ أَنَّ مُحَمَّدًا عَبْدُهُ وَرَسُولُهُ',
    phonetic: "Ash-hadu an lâ ilâha illallâhu wahdahu lâ sharîka lah, wa ash-hadu anna Muhammadan 'abduhu wa rasûluh",
    translation: 'Je témoigne qu\'il n\'y a de divinité qu\'Allah, Seul et sans associé, et que Muhammad est Son serviteur et Messager.',
    translationEn: 'I testify that there is no deity except Allah alone, without partner, and I testify that Muhammad is His servant and Messenger.',
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
    titleEn: 'Intention (Niyyah)',
    description: 'Former mentalement l\'intention de prier (ex. : "Je vais prier la prière de Fajr de deux rak\'ahs pour Allah"). L\'intention n\'est pas prononcée à voix haute.',
    descriptionEn: 'Form the intention in your heart to pray (e.g., "I intend to pray the Fajr prayer of two rak\'ahs for Allah"). The intention is not pronounced aloud.',
    position: _PositionType.qiyam,
  ),
  _SalahStep(
    stepNum: 2,
    title: 'Takbirat al-Ihram',
    titleEn: 'Takbirat al-Ihram (Opening Takbir)',
    description: 'Se tenir debout, face à la qibla. Lever les deux mains jusqu\'aux oreilles et prononcer le takbir d\'ouverture. La prière commence à ce moment.',
    descriptionEn: 'Stand facing the qibla. Raise both hands to ear level and pronounce the opening takbir. Prayer begins at this moment.',
    position: _PositionType.qiyam,
    arabic: 'اللَّهُ أَكْبَرُ',
    phonetic: 'Allahu Akbar',
    translation: 'Allah est le Plus Grand',
    translationEn: 'Allah is the Greatest',
    times: 1,
  ),
  _SalahStep(
    stepNum: 3,
    title: 'Dua d\'ouverture (Istiftah)',
    titleEn: 'Opening Supplication (Istiftah)',
    description: 'Réciter discrètement cette invocation d\'ouverture après le takbir, avant de commencer la sourate.',
    descriptionEn: 'Recite this opening supplication quietly after the takbir, before starting the surah.',
    position: _PositionType.qiyam,
    arabic: 'سُبْحَانَكَ اللَّهُمَّ وَبِحَمْدِكَ، وَتَبَارَكَ اسْمُكَ، وَتَعَالَى جَدُّكَ، وَلَا إِلَهَ غَيْرُكَ',
    phonetic: "Subhânakallâhumma wa bihamdik, wa tabârakasmuk, wa ta'âlâ jadduk, wa lâ ilâha ghayruk",
    translation: 'Gloire à Toi, ô Allah, et louange à Toi. Béni soit Ton nom, élevée Ta majesté. Il n\'est de divinité que Toi.',
    translationEn: 'Glory be to You, O Allah, and to You belongs all praise. Blessed is Your name, exalted is Your majesty. There is no deity but You.',
    times: 0,
  ),
  _SalahStep(
    stepNum: 4,
    title: 'Ta\'awwudh + Al-Fatiha',
    titleEn: 'Ta\'awwudh + Al-Fatiha',
    description: 'Réciter "A\'udhu billahi min ash-shaytân ir-rajîm" (refuge en Allah contre satan), puis réciter Al-Fatiha. Cette sourate est obligatoire à chaque rak\'ah.',
    descriptionEn: 'Recite "A\'udhu billahi min ash-shaytân ir-rajîm" (seeking refuge in Allah from Satan), then recite Al-Fatiha. This surah is obligatory in every rak\'ah.',
    position: _PositionType.qiyam,
    arabic: 'أَعُوذُ بِاللَّهِ مِنَ الشَّيْطَانِ الرَّجِيمِ',
    phonetic: "A'ûdhu billâhi min ash-shaytânir-rajîm",
    translation: 'Je cherche refuge en Allah contre Satan le maudit.',
    translationEn: 'I seek refuge in Allah from Satan the accursed.',
    times: 0,
  ),
  _SalahStep(
    stepNum: 5,
    title: 'Récitation d\'une sourate',
    titleEn: 'Recitation of a surah',
    description: 'Après Al-Fatiha, réciter une sourate ou quelques versets du Coran. Uniquement dans les deux premières rak\'ahs. Al-Ikhlas, Al-Falaq, An-Nas ou d\'autres sont recommandées.',
    descriptionEn: 'After Al-Fatiha, recite a surah or verses from the Quran. Only in the first two rak\'ahs. Al-Ikhlas, Al-Falaq, An-Nas or others are recommended.',
    position: _PositionType.qiyam,
    times: 0,
  ),
  _SalahStep(
    stepNum: 6,
    title: 'Ruku\' (Inclinaison)',
    titleEn: 'Ruku\' (Bowing)',
    description: 'Dire "Allahu Akbar" en s\'inclinant. Le dos doit être droit et horizontal, les mains sur les genoux. Rester immobile un moment (tuma\'ninah).',
    descriptionEn: 'Say "Allahu Akbar" while bowing. Your back should be straight and horizontal, hands on knees. Remain still for a moment (tumainah).',
    position: _PositionType.ruku,
    arabic: 'سُبْحَانَ رَبِّيَ الْعَظِيمِ',
    phonetic: "Subhâna Rabbiyal 'Adhîm",
    translation: 'Gloire à mon Seigneur, le Très Grand.',
    translationEn: 'Glory be to my Lord, the Mighty.',
    times: 3,
  ),
  _SalahStep(
    stepNum: 7,
    title: 'I\'tidal (Relèvement du Ruku\')',
    titleEn: 'I\'tidal (Rising from bowing)',
    description: 'Se relever en disant le premier dhikr, puis une fois debout, dire la réponse. Rester immobile un moment.',
    descriptionEn: 'Rise up saying the first dhikr, and when fully standing, say the response. Remain still for a moment.',
    position: _PositionType.itidal,
    arabic: 'سَمِعَ اللَّهُ لِمَنْ حَمِدَهُ\nرَبَّنَا وَلَكَ الْحَمْدُ',
    phonetic: "Sami'a Allâhu liman hamidah\nRabbanâ wa lakal hamd",
    translation: 'Allah exauce celui qui Le loue.\nNotre Seigneur, à Toi la louange.',
    translationEn: 'Allah hears those who praise Him.\nOur Lord, to You belongs all praise.',
    times: 0,
  ),
  _SalahStep(
    stepNum: 8,
    title: 'Premier Sujud',
    titleEn: 'First Prostration',
    description: 'Dire "Allahu Akbar" en descendant. Se prosterner sur les 7 membres : front (avec le nez), deux mains, deux genoux, deux pieds. Ne pas plaquer les bras au sol.',
    descriptionEn: 'Say "Allahu Akbar" while descending. Prostrate on the 7 limbs: forehead (with nose), two hands, two knees, two feet. Do not flatten your arms to the ground.',
    position: _PositionType.sujud,
    arabic: 'سُبْحَانَ رَبِّيَ الْأَعْلَى',
    phonetic: "Subhâna Rabbiyal A'lâ",
    translation: 'Gloire à mon Seigneur, le Très-Haut.',
    translationEn: 'Glory be to my Lord, the Most High.',
    times: 3,
  ),
  _SalahStep(
    stepNum: 9,
    title: 'Jalsa (Assise entre les deux sujud)',
    titleEn: 'Jalsa (Sitting between prostrations)',
    description: 'Se relever en disant "Allahu Akbar", s\'asseoir sur le pied gauche replié, le pied droit dressé. Rester immobile un moment.',
    descriptionEn: 'Rise saying "Allahu Akbar", sit on your left foot folded underneath you with your right foot raised. Remain still for a moment.',
    position: _PositionType.jalsa,
    arabic: 'رَبِّ اغْفِرْ لِي',
    phonetic: 'Rabbighfir lî',
    translation: 'Seigneur, pardonne-moi.',
    translationEn: 'My Lord, forgive me.',
    times: 3,
  ),
  _SalahStep(
    stepNum: 10,
    title: 'Deuxième Sujud',
    titleEn: 'Second Prostration',
    description: 'Se prosterner à nouveau en disant "Allahu Akbar" avec le même dhikr que le premier sujud. C\'est la fin d\'une rak\'ah.',
    descriptionEn: 'Prostrate again saying "Allahu Akbar" with the same dhikr as the first prostration. This marks the end of one rak\'ah.',
    position: _PositionType.sujud,
    arabic: 'سُبْحَانَ رَبِّيَ الْأَعْلَى',
    phonetic: "Subhâna Rabbiyal A'lâ",
    translation: 'Gloire à mon Seigneur, le Très-Haut.',
    translationEn: 'Glory be to my Lord, the Most High.',
    times: 3,
  ),
  _SalahStep(
    stepNum: 11,
    title: 'Tashahhud',
    titleEn: 'Tashahhud',
    description: 'À la fin de la 2e rak\'ah (et de la dernière), s\'asseoir et réciter le Tashahhud. Lever l\'index droit au moment de "illa Allah".',
    descriptionEn: 'At the end of the 2nd rak\'ah (and the last), sit and recite the Tashahhud. Raise your right index finger when saying "illa Allah".',
    position: _PositionType.tashahhud,
    arabic: 'التَّحِيَّاتُ لِلَّهِ وَالصَّلَوَاتُ وَالطَّيِّبَاتُ، السَّلَامُ عَلَيْكَ أَيُّهَا النَّبِيُّ وَرَحْمَةُ اللَّهِ وَبَرَكَاتُهُ، السَّلَامُ عَلَيْنَا وَعَلَى عِبَادِ اللَّهِ الصَّالِحِينَ، أَشْهَدُ أَنْ لَا إِلَهَ إِلَّا اللَّهُ وَأَشْهَدُ أَنَّ مُحَمَّدًا عَبْدُهُ وَرَسُولُهُ',
    phonetic: "At-tahiyyâtu lillâhi was-salawâtu wat-tayyibât. As-salâmu 'alayka ayyuhan-nabiyyu wa rahmatullâhi wa barakâtuh. As-salâmu 'alaynâ wa 'alâ 'ibâdillâhis-sâlihîn. Ash-hadu an lâ ilâha illallâhu wa ash-hadu anna Muhammadan 'abduhu wa rasûluh.",
    translation: 'Les salutations, les prières et les bonnes paroles sont à Allah. Paix sur toi, ô Prophète, ainsi que la miséricorde d\'Allah et Ses bénédictions. Paix sur nous et sur les serviteurs vertueux d\'Allah. Je témoigne qu\'il n\'est de divinité qu\'Allah et que Muhammad est Son serviteur et Messager.',
    translationEn: 'All greetings, prayers and good deeds are for Allah. Peace be upon you, O Prophet, and the mercy of Allah and His blessings. Peace be upon us and upon the righteous servants of Allah. I testify that there is no deity except Allah and I testify that Muhammad is His servant and Messenger.',
    times: 0,
  ),
  _SalahStep(
    stepNum: 12,
    title: 'Salat Ibrahimiyya',
    titleEn: 'Salat Ibrahimiyya (Prayer on the Prophet)',
    description: 'Dans le tashahhud final uniquement, réciter après le Tashahhud cette prière sur le Prophète ﷺ.',
    descriptionEn: 'In the final tashahhud only, recite this prayer on the Prophet ﷺ after the Tashahhud.',
    position: _PositionType.tashahhud,
    arabic: 'اللَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ كَمَا صَلَّيْتَ عَلَى إِبْرَاهِيمَ وَعَلَى آلِ إِبْرَاهِيمَ',
    phonetic: "Allâhumma salli 'alâ Muhammadin wa 'alâ âli Muhammadin, kamâ sallayta 'alâ Ibrâhîma wa 'alâ âli Ibrâhîm",
    translation: 'Ô Allah, envoie Ta grâce sur Muhammad et sur la famille de Muhammad, comme Tu as envoyé Ta grâce sur Ibrahim et sur la famille d\'Ibrahim.',
    translationEn: 'O Allah, send your grace upon Muhammad and upon the family of Muhammad, as You sent Your grace upon Ibrahim and upon the family of Ibrahim.',
    times: 0,
  ),
  _SalahStep(
    stepNum: 13,
    title: 'Tasleem (Fin de la prière)',
    titleEn: 'Tasleem (Ending the prayer)',
    description: 'Tourner la tête vers la droite en disant le salut, puis vers la gauche en répétant le même salut. La prière est terminée.',
    descriptionEn: 'Turn your head to the right saying the greeting, then to the left saying the same greeting. Prayer is now complete.',
    position: _PositionType.tashahhud,
    arabic: 'السَّلَامُ عَلَيْكُمْ وَرَحْمَةُ اللَّهِ',
    phonetic: "As-salâmu 'alaykum wa rahmatullâh",
    translation: 'Que la paix et la miséricorde d\'Allah soient sur vous.',
    translationEn: 'May the peace and mercy of Allah be upon you.',
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
                  color: Colors.white.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                ),
                child: const Icon(Icons.arrow_back_ios_new_rounded,
                    color: Colors.white, size: 15),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(context.t.learningPrayerGuide,
                    style: const TextStyle(
                      color: Colors.white, fontSize: 20,
                      fontWeight: FontWeight.w900, letterSpacing: 0.3,
                    )),
                Text(_s('Ablution · Positions · Prières · Sunnah', 'Wudu · Positions · Prayers · Sunnah'),
                    style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.55), fontSize: 11)),
              ]),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
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
        unselectedLabelColor: Colors.white.withValues(alpha: 0.45),
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
                    child: Text(s.getTitle(),
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
                  child: Text(s.getDescription(),
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
                    border: Border.all(color: _kBlue.withValues(alpha: 0.2)),
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
                    if (s.getTranslation() != null) ...[
                      const SizedBox(height: 6),
                      Text(s.getTranslation()!,
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
                  Text(s.getTitle(),
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
                  child: Text(s.getDescription(),
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
                    border: Border.all(color: _kGreenMedium.withValues(alpha: 0.25)),
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
                    if (s.getTranslation() != null) ...[
                      const SizedBox(height: 8),
                      const Divider(height: 1, color: _kBeigeBorder),
                      const SizedBox(height: 8),
                      Text(s.getTranslation()!,
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
        border: Border.all(color: color.withValues(alpha: 0.25)),
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
          _TotalChip(value: (totalFard + totalSunnah).toString(), label: 'Total/jour', color: _kPurple),
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
        border: Border.all(color: color.withValues(alpha: 0.3)),
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
                  border: Border.all(color: _kPurple.withValues(alpha: 0.2)),
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
                  border: Border.all(color: _kGold.withValues(alpha: 0.3)),
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
        border: Border.all(color: color.withValues(alpha: 0.25), width: 1.2),
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
        errorBuilder: (_, _, _) => Container(
          width: 110, height: 110,
          decoration: BoxDecoration(
            color: const Color(0xFFEEF6FF),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kBlue.withValues(alpha: 0.2)),
          ),
          child: const Icon(Icons.image_not_supported_outlined,
              color: Color(0xFFAABBCC), size: 32),
        ),
      ),
    );
  }
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
        errorBuilder: (_, _, _) => Container(
          width: 110, height: 110,
          decoration: BoxDecoration(
            color: _kGreenLight,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kGreenPrimary.withValues(alpha: 0.2)),
          ),
          child: const Icon(Icons.image_not_supported_outlined,
              color: Color(0xFFAABBCC), size: 32),
        ),
      ),
    );
  }
}

// ─── Figure Position Salah (CustomPainter fallback) ───────────────────────────
