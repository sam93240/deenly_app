// protection_duas_data.dart — Invocations de Protection

import 'app_locale.dart';


class DuaProtection {
  final String arabic;
  final String phonetic;
  final String translation;
  final String translationEn;
  final String source;
  final int repeat;
  const DuaProtection({
    required this.arabic,
    required this.phonetic,
    required this.translation,
    this.translationEn = '',
    required this.source,
    this.repeat = 1,
  });
  String get displayTranslation => AppLocale().isFrench ? translation : (translationEn.isNotEmpty ? translationEn : translation);
}

class DuaCategory {
  final String id;
  final String title;
  final String titleEn;
  final String emoji;
  final String description;
  final String descriptionEn;
  final List<DuaProtection> duas;
  const DuaCategory({
    required this.id,
    required this.title,
    required this.titleEn,
    required this.emoji,
    required this.description,
    required this.descriptionEn,
    required this.duas,
  });
  String get displayTitle => AppLocale().isFrench ? title : titleEn;
  String get displayDescription => AppLocale().isFrench ? description : descriptionEn;
}

const kDuasProtection = <DuaCategory>[
  // 1 — PROTECTION DU MATIN
  DuaCategory(
    id: 'matin',
    title: 'Protection du Matin',
    titleEn: 'Morning Protection',
    emoji: '\uD83C\uDF05',
    description: 'Les invocations qui prot\u00e8gent jusqu\'au soir',
    descriptionEn: 'Invocations that protect until evening',
    duas: [
      DuaProtection(
        arabic: '\u0628\u0650\u0633\u0652\u0645\u0650 \u0627\u0644\u0644\u0651\u064E\u0647\u0650 \u0627\u0644\u0651\u064E\u0630\u0650\u064A \u0644\u064E\u0627 \u064A\u064E\u0636\u064F\u0631\u0651\u064F \u0645\u064E\u0639\u064E \u0627\u0633\u0652\u0645\u0650\u0647\u0650 \u0634\u064E\u064A\u0652\u0621\u064C \u0641\u0650\u064A \u0627\u0644\u0652\u0623\u064E\u0631\u0652\u0636\u0650 \u0648\u064E\u0644\u064E\u0627 \u0641\u0650\u064A \u0627\u0644\u0633\u0651\u064E\u0645\u064E\u0627\u0621\u0650 \u0648\u064E\u0647\u064F\u0648\u064E \u0627\u0644\u0633\u0651\u064E\u0645\u0650\u064A\u0639\u064F \u0627\u0644\u0652\u0639\u064E\u0644\u0650\u064A\u0645\u064F',
        phonetic: 'Bismillahil-ladhi la yadurru ma\'a ismihi shay\'un fil-ardi wa la fis-sama\'i wa Huwas-Sami\'ul-\'Alim',
        translation: 'Au nom d\'Allah, Celui avec le nom de Qui rien ne peut nuire sur terre ni dans le ciel, et Il est l\'Audient, l\'Omniscient.',
        translationEn: 'In the name of Allah, with whose name nothing on earth or in the sky can cause harm, and He is the All-Hearing, the All-Knowing.',
        source: 'Abu Dawud et Tirmidhi',
        repeat: 3,
      ),
      DuaProtection(
        arabic: '\u0623\u064E\u0639\u064F\u0648\u0630\u064F \u0628\u0650\u0643\u064E\u0644\u0650\u0645\u064E\u0627\u062A\u0650 \u0627\u0644\u0644\u0651\u064E\u0647\u0650 \u0627\u0644\u062A\u0651\u064E\u0627\u0645\u0651\u064E\u0627\u062A\u0650 \u0645\u0650\u0646\u0652 \u0634\u064E\u0631\u0651\u0650 \u0645\u064E\u0627 \u062E\u064E\u0644\u064E\u0642\u064E',
        phonetic: 'A\'udhu bi-kalimatillahit-tammati min sharri ma khalaq',
        translation: 'Je cherche protection dans les paroles parfaites d\'Allah contre le mal de ce qu\'Il a cr\u00e9\u00e9.',
        translationEn: 'I seek protection in the perfect words of Allah against the evil of what He has created.',
        source: 'Muslim',
        repeat: 3,
      ),
      DuaProtection(
        arabic: '\u0627\u0644\u0644\u0651\u064E\u0647\u064F\u0645\u0651\u064E \u0625\u0650\u0646\u0651\u0650\u064A \u0623\u064E\u0639\u064F\u0648\u0630\u064F \u0628\u0650\u0643\u064E \u0645\u0650\u0646\u064E \u0627\u0644\u0652\u0647\u064E\u0645\u0651\u0650 \u0648\u064E\u0627\u0644\u0652\u062D\u064E\u0632\u064E\u0646\u0650 \u0648\u064E\u0627\u0644\u0652\u0639\u064E\u062C\u0652\u0632\u0650 \u0648\u064E\u0627\u0644\u0652\u0643\u064E\u0633\u064E\u0644\u0650 \u0648\u064E\u0627\u0644\u0652\u0628\u064F\u062E\u0652\u0644\u0650 \u0648\u064E\u0627\u0644\u0652\u062C\u064F\u0628\u0652\u0646\u0650 \u0648\u064E\u0636\u064E\u0644\u064E\u0639\u0650 \u0627\u0644\u062F\u0651\u064E\u064A\u0652\u0646\u0650 \u0648\u064E\u063A\u064E\u0644\u064E\u0628\u064E\u0629\u0650 \u0627\u0644\u0631\u0651\u0650\u062C\u064E\u0627\u0644\u0650',
        phonetic: 'Allahumma inni a\'udhu bika minal-hammi wal-hazan, wal-\'ajzi wal-kasal, wal-bukhli wal-jubn, wa dala\'id-dayni wa ghalabatir-rijal',
        translation: '\u00d4 Allah, je cherche protection aupr\u00e8s de Toi contre le souci et la tristesse, l\'incapacit\u00e9 et la paresse, l\'avarice et la l\u00e2chet\u00e9, le poids des dettes et la domination des hommes.',
        translationEn: 'O Allah, I seek refuge in You from worry and grief, from incapacity and laziness, from miserliness and cowardice, from the burden of debt and from the domination of men.',
        source: 'Bukhari',
      ),
    ],
  ),

  // 2 — PROTECTION AVANT DE DORMIR
  DuaCategory(
    id: 'sommeil',
    title: 'Avant de Dormir',
    titleEn: 'Before Sleep',
    emoji: '\uD83C\uDF19',
    description: 'Protection pendant la nuit',
    descriptionEn: 'Protection during the night',
    duas: [
      DuaProtection(
        arabic: '\u0628\u0650\u0627\u0633\u0652\u0645\u0650\u0643\u064E \u0627\u0644\u0644\u0651\u064E\u0647\u064F\u0645\u0651\u064E \u0623\u064E\u0645\u064F\u0648\u062A\u064F \u0648\u064E\u0623\u064E\u062D\u0652\u064A\u064E\u0627',
        phonetic: 'Bismika Allahumma amutu wa ahya',
        translation: 'En Ton nom, \u00f4 Allah, je meurs et je vis.',
        translationEn: 'In Your name, O Allah, I die and I live.',
        source: 'Bukhari',
      ),
      DuaProtection(
        arabic: '\u0627\u0644\u0644\u0651\u064E\u0647\u064F\u0645\u0651\u064E \u0642\u0650\u0646\u0650\u064A \u0639\u064E\u0630\u064E\u0627\u0628\u064E\u0643\u064E \u064A\u064E\u0648\u0652\u0645\u064E \u062A\u064E\u0628\u0652\u0639\u064E\u062B\u064F \u0639\u0650\u0628\u064E\u0627\u062F\u064E\u0643\u064E',
        phonetic: 'Allahumma qini \'adhabaka yawma tab\'athu \'ibadak',
        translation: '\u00d4 Allah, pr\u00e9serve-moi de Ton ch\u00e2timent le jour o\u00f9 Tu ressusciteras Tes serviteurs.',
        translationEn: 'O Allah, protect me from Your punishment on the day You resurrect Your servants.',
        source: 'Abu Dawud et Tirmidhi',
      ),
      DuaProtection(
        arabic: '\u0627\u0644\u0644\u0651\u064E\u0647\u064F\u0645\u0651\u064E \u0628\u0650\u0627\u0633\u0652\u0645\u0650\u0643\u064E \u0623\u064E\u062D\u0652\u064A\u064E\u0627 \u0648\u064E\u0628\u0650\u0627\u0633\u0652\u0645\u0650\u0643\u064E \u0623\u064E\u0645\u064F\u0648\u062A\u064F',
        phonetic: 'Allahumma bismika ahya wa bismika amut',
        translation: '\u00d4 Allah, c\'est en Ton nom que je vis et c\'est en Ton nom que je meurs.',
        translationEn: 'O Allah, it is in Your name that I live and it is in Your name that I die.',
        source: 'Bukhari et Muslim',
      ),
    ],
  ),

  // 3 — PROTECTION DE LA MAISON
  DuaCategory(
    id: 'maison',
    title: 'Prot\u00e9ger sa Maison',
    titleEn: 'Protect Your Home',
    emoji: '\uD83C\uDFE0',
    description: 'Invocations en entrant et sortant de chez soi',
    descriptionEn: 'Invocations when entering and leaving home',
    duas: [
      DuaProtection(
        arabic: '\u0628\u0650\u0633\u0652\u0645\u0650 \u0627\u0644\u0644\u0651\u064E\u0647\u0650 \u0648\u064E\u0644\u064E\u062C\u0652\u0646\u064E\u0627 \u0648\u064E\u0628\u0650\u0633\u0652\u0645\u0650 \u0627\u0644\u0644\u0651\u064E\u0647\u0650 \u062E\u064E\u0631\u064E\u062C\u0652\u0646\u064E\u0627 \u0648\u064E\u0639\u064E\u0644\u064E\u0649 \u0627\u0644\u0644\u0651\u064E\u0647\u0650 \u0631\u064E\u0628\u0651\u0650\u0646\u064E\u0627 \u062A\u064E\u0648\u064E\u0643\u0651\u064E\u0644\u0652\u0646\u064E\u0627',
        phonetic: 'Bismillahi walajna wa bismillahi kharajna wa \'ala Allahi Rabbina tawakkalna',
        translation: 'Au nom d\'Allah nous entrons, au nom d\'Allah nous sortons, et en Allah notre Seigneur nous pla\u00e7ons notre confiance.',
        translationEn: 'In the name of Allah we enter, in the name of Allah we leave, and in Allah our Lord we place our trust.',
        source: 'Abu Dawud',
      ),
      DuaProtection(
        arabic: '\u0628\u0650\u0633\u0652\u0645\u0650 \u0627\u0644\u0644\u0651\u064E\u0647\u0650 \u062A\u064E\u0648\u064E\u0643\u0651\u064E\u0644\u0652\u062A\u064F \u0639\u064E\u0644\u064E\u0649 \u0627\u0644\u0644\u0651\u064E\u0647\u0650 \u0648\u064E\u0644\u064E\u0627 \u062D\u064E\u0648\u0652\u0644\u064E \u0648\u064E\u0644\u064E\u0627 \u0642\u064F\u0648\u0651\u064E\u0629\u064E \u0625\u0650\u0644\u0651\u064E\u0627 \u0628\u0650\u0627\u0644\u0644\u0651\u064E\u0647\u0650',
        phonetic: 'Bismillahi tawakkaltu \'alallahi wa la hawla wa la quwwata illa billah',
        translation: 'Au nom d\'Allah, je place ma confiance en Allah. Il n\'y a de force ni de puissance qu\'en Allah.',
        translationEn: 'In the name of Allah, I place my trust in Allah. There is no power or strength except with Allah.',
        source: 'Abu Dawud et Tirmidhi',
      ),
    ],
  ),

  // 4 — PROTECTION CONTRE LA COLÈRE
  DuaCategory(
    id: 'colere',
    title: 'Contre la Col\u00e8re',
    titleEn: 'Against Anger',
    emoji: '\uD83D\uDE24',
    description: 'Rem\u00e8des proph\u00e9tiques contre la col\u00e8re',
    descriptionEn: 'Prophetic remedies against anger',
    duas: [
      DuaProtection(
        arabic: '\u0623\u064E\u0639\u064F\u0648\u0630\u064F \u0628\u0650\u0627\u0644\u0644\u0651\u064E\u0647\u0650 \u0645\u0650\u0646\u064E \u0627\u0644\u0634\u0651\u064E\u064A\u0652\u0637\u064E\u0627\u0646\u0650 \u0627\u0644\u0631\u0651\u064E\u062C\u0650\u064A\u0645\u0650',
        phonetic: 'A\'udhu billahi minash-Shaytanir-rajim',
        translation: 'Je cherche refuge aupr\u00e8s d\'Allah contre Satan le maudit.',
        translationEn: 'I seek refuge with Allah from Satan the accursed.',
        source: 'Bukhari et Muslim',
      ),
      DuaProtection(
        arabic: '\u0627\u0644\u0644\u0651\u064E\u0647\u064F\u0645\u0651\u064E \u0627\u063A\u0652\u0641\u0650\u0631\u0652 \u0644\u0650\u064A \u0630\u064E\u0646\u0652\u0628\u0650\u064A \u0648\u064E\u0623\u064E\u0630\u0652\u0647\u0650\u0628\u0652 \u063A\u064E\u064A\u0652\u0638\u064E \u0642\u064E\u0644\u0652\u0628\u0650\u064A \u0648\u064E\u0623\u064E\u062C\u0650\u0631\u0652\u0646\u0650\u064A \u0645\u0650\u0646\u0652 \u0645\u064F\u0636\u0650\u0644\u0651\u064E\u0627\u062A\u0650 \u0627\u0644\u0652\u0641\u0650\u062A\u064E\u0646\u0650',
        phonetic: 'Allahumma-ghfir li dhanbi wa adh-hib ghayza qalbi wa ajirni min mudillatil-fitan',
        translation: '\u00d4 Allah, pardonne-moi mes p\u00e9ch\u00e9s, \u00f4te la col\u00e8re de mon coeur et pr\u00e9serve-moi des \u00e9preuves \u00e9garantes.',
        translationEn: 'O Allah, forgive my sins, remove the anger from my heart, and protect me from misleading trials.',
        source: 'Tabarani',
      ),
    ],
  ),

  // 5 — PROTECTION DU COUPLE
  DuaCategory(
    id: 'couple',
    title: 'Prot\u00e9ger son Couple',
    titleEn: 'Protect Your Marriage',
    emoji: '\uD83D\uDC95',
    description: 'Contre les fitna de Shaytan dans le mariage',
    descriptionEn: "Against Satan's trials in marriage",
    duas: [
      DuaProtection(
        arabic: '\u0627\u0644\u0644\u0651\u064E\u0647\u064F\u0645\u0651\u064E \u062C\u064E\u0646\u0651\u0650\u0628\u0652\u0646\u064E\u0627 \u0627\u0644\u0634\u0651\u064E\u064A\u0652\u0637\u064E\u0627\u0646\u064E \u0648\u064E\u062C\u064E\u0646\u0651\u0650\u0628\u0650 \u0627\u0644\u0634\u0651\u064E\u064A\u0652\u0637\u064E\u0627\u0646\u064E \u0645\u064E\u0627 \u0631\u064E\u0632\u064E\u0642\u0652\u062A\u064E\u0646\u064E\u0627',
        phonetic: 'Allahumma jannibna ash-Shaytana wa jannibish-Shaytana ma razaqtana',
        translation: '\u00d4 Allah, \u00e9loigne de nous le Shaytan et \u00e9loigne le Shaytan de ce dont Tu nous as gratifi\u00e9.',
        translationEn: 'O Allah, keep us away from Satan and keep Satan away from what You have bestowed upon us.',
        source: 'Bukhari et Muslim',
      ),
      DuaProtection(
        arabic: '\u0631\u064E\u0628\u0651\u064E\u0646\u064E\u0627 \u0647\u064E\u0628\u0652 \u0644\u064E\u0646\u064E\u0627 \u0645\u0650\u0646\u0652 \u0623\u064E\u0632\u0652\u0648\u064E\u0627\u062C\u0650\u0646\u064E\u0627 \u0648\u064E\u0630\u064F\u0631\u0651\u0650\u064A\u0651\u064E\u0627\u062A\u0650\u0646\u064E\u0627 \u0642\u064F\u0631\u0651\u064E\u0629\u064E \u0623\u064E\u0639\u0652\u064A\u064F\u0646\u064D \u0648\u064E\u0627\u062C\u0652\u0639\u064E\u0644\u0652\u0646\u064E\u0627 \u0644\u0650\u0644\u0652\u0645\u064F\u062A\u0651\u064E\u0642\u0650\u064A\u0646\u064E \u0625\u0650\u0645\u064E\u0627\u0645\u064B\u0627',
        phonetic: 'Rabbana hab lana min azwajina wa dhurriyyatina qurrata a\'yunin waj\'alna lil-muttaqina imama',
        translation: 'Seigneur, donne-nous en nos \u00e9pouses et notre descendance la joie des yeux, et fais de nous un guide pour les pieux.',
        translationEn: 'Our Lord, grant us from among our spouses and offspring comfort to our eyes, and make us an example for the righteous.',
        source: 'Coran, Al-Furqan (25:74)',
      ),
    ],
  ),

  // 6 — PROTECTION DES ENFANTS
  DuaCategory(
    id: 'enfants',
    title: 'Prot\u00e9ger ses Enfants',
    titleEn: 'Protect Your Children',
    emoji: '\uD83D\uDC76',
    description: 'Comme le Proph\u00e8te \u00a7 prot\u00e9geait ses petits-fils',
    descriptionEn: 'As the Prophet protected his grandchildren',
    duas: [
      DuaProtection(
        arabic: '\u0623\u064F\u0639\u064A\u0630\u064F\u0643\u064F\u0645\u064E\u0627 \u0628\u0650\u0643\u064E\u0644\u0650\u0645\u064E\u0627\u062A\u0650 \u0627\u0644\u0644\u0651\u064E\u0647\u0650 \u0627\u0644\u062A\u0651\u064E\u0627\u0645\u0651\u064E\u0629\u0650 \u0645\u0650\u0646\u0652 \u0643\u064F\u0644\u0651\u0650 \u0634\u064E\u064A\u0652\u0637\u064E\u0627\u0646\u064D \u0648\u064E\u0647\u064E\u0627\u0645\u0651\u064E\u0629\u064D \u0648\u064E\u0645\u0650\u0646\u0652 \u0643\u064F\u0644\u0651\u0650 \u0639\u064E\u064A\u0652\u0646\u064D \u0644\u064E\u0627\u0645\u0651\u064E\u0629\u064D',
        phonetic: 'U\'idhukuma bi-kalimatillahit-tammati min kulli shaytanin wa hammah, wa min kulli \'aynin lammah',
        translation: 'Je vous prot\u00e8ge par les paroles parfaites d\'Allah contre tout d\u00e9mon et toute b\u00eate venimeuse, et contre tout mauvais oeil.',
        translationEn: 'I protect you with the perfect words of Allah from every devil and every venomous creature, and from every evil eye.',
        source: 'Bukhari',
      ),
      DuaProtection(
        arabic: '\u0627\u0644\u0644\u0651\u064E\u0647\u064F\u0645\u0651\u064E \u0627\u062D\u0652\u0641\u064E\u0638\u0652\u0647\u064F\u0645\u0652 \u0645\u0650\u0646\u0652 \u0628\u064E\u064A\u0652\u0646\u0650 \u0623\u064E\u064A\u0652\u062F\u0650\u064A\u0647\u0650\u0645\u0652 \u0648\u064E\u0645\u0650\u0646\u0652 \u062E\u064E\u0644\u0652\u0641\u0650\u0647\u0650\u0645\u0652 \u0648\u064E\u0639\u064E\u0646\u0652 \u0623\u064E\u064A\u0652\u0645\u064E\u0627\u0646\u0650\u0647\u0650\u0645\u0652 \u0648\u064E\u0639\u064E\u0646\u0652 \u0634\u064E\u0645\u064E\u0627\u0626\u0650\u0644\u0650\u0647\u0650\u0645\u0652 \u0648\u064E\u0645\u0650\u0646\u0652 \u0641\u064E\u0648\u0652\u0642\u0650\u0647\u0650\u0645\u0652',
        phonetic: 'Allahumma-hfadh-hum min bayni aydihim wa min khalfihim wa \'an aymanihim wa \'an shama\'ilihim wa min fawqihim',
        translation: '\u00d4 Allah, pr\u00e9serve-les par devant, par derri\u00e8re, \u00e0 leur droite, \u00e0 leur gauche et au-dessus d\'eux.',
        translationEn: 'O Allah, preserve them from before and behind, to their right and to their left, and from above.',
        source: 'Abu Dawud et Ibn Majah',
      ),
    ],
  ),

  // 7 — PROTECTION CONTRE LA PEUR
  DuaCategory(
    id: 'peur',
    title: 'Contre la Peur',
    titleEn: 'Against Fear',
    emoji: '\uD83D\uDE28',
    description: 'Quand l\'angoisse ou la peur envahit',
    descriptionEn: 'When anxiety or fear overwhelms',
    duas: [
      DuaProtection(
        arabic: '\u0644\u064E\u0627 \u0625\u0650\u0644\u064E\u0647\u064E \u0625\u0650\u0644\u0651\u064E\u0627 \u0627\u0644\u0644\u0651\u064E\u0647\u064F \u0627\u0644\u0652\u0639\u064E\u0638\u0650\u064A\u0645\u064F \u0627\u0644\u0652\u062D\u064E\u0644\u0650\u064A\u0645\u064F \u060C \u0644\u064E\u0627 \u0625\u0650\u0644\u064E\u0647\u064E \u0625\u0650\u0644\u0651\u064E\u0627 \u0627\u0644\u0644\u0651\u064E\u0647\u064F \u0631\u064E\u0628\u0651\u064F \u0627\u0644\u0652\u0639\u064E\u0631\u0652\u0634\u0650 \u0627\u0644\u0652\u0639\u064E\u0638\u0650\u064A\u0645\u0650 \u060C \u0644\u064E\u0627 \u0625\u0650\u0644\u064E\u0647\u064E \u0625\u0650\u0644\u0651\u064E\u0627 \u0627\u0644\u0644\u0651\u064E\u0647\u064F \u0631\u064E\u0628\u0651\u064F \u0627\u0644\u0633\u0651\u064E\u0645\u064E\u0627\u0648\u064E\u0627\u062A\u0650 \u0648\u064E\u0631\u064E\u0628\u0651\u064F \u0627\u0644\u0652\u0623\u064E\u0631\u0652\u0636\u0650 \u0648\u064E\u0631\u064E\u0628\u0651\u064F \u0627\u0644\u0652\u0639\u064E\u0631\u0652\u0634\u0650 \u0627\u0644\u0652\u0643\u064E\u0631\u0650\u064A\u0645\u0650',
        phonetic: 'La ilaha illallahul-\'Adhimul-Halim, la ilaha illallahu Rabbul-\'Arshil-\'Adhim, la ilaha illallahu Rabbus-samawati wa Rabbul-ardi wa Rabbul-\'Arshil-Karim',
        translation: 'Point de divinit\u00e9 \u00e0 part Allah, le Tr\u00e8s Grand, le Tr\u00e8s Doux. Point de divinit\u00e9 \u00e0 part Allah, le Seigneur du Tr\u00f4ne immense. Point de divinit\u00e9 \u00e0 part Allah, le Seigneur des cieux, de la terre et du Tr\u00f4ne g\u00e9n\u00e9reux.',
        translationEn: 'There is no deity but Allah, the Almighty, the Forbearing. There is no deity but Allah, Lord of the Magnificent Throne. There is no deity but Allah, Lord of the heavens, the earth, and the Noble Throne.',
        source: 'Bukhari et Muslim',
      ),
      DuaProtection(
        arabic: '\u062D\u064E\u0633\u0652\u0628\u0650\u064A\u064E \u0627\u0644\u0644\u0651\u064E\u0647\u064F \u0644\u064E\u0627 \u0625\u0650\u0644\u064E\u0647\u064E \u0625\u0650\u0644\u0651\u064E\u0627 \u0647\u064F\u0648\u064E \u0639\u064E\u0644\u064E\u064A\u0652\u0647\u0650 \u062A\u064E\u0648\u064E\u0643\u0651\u064E\u0644\u0652\u062A\u064F \u0648\u064E\u0647\u064F\u0648\u064E \u0631\u064E\u0628\u0651\u064F \u0627\u0644\u0652\u0639\u064E\u0631\u0652\u0634\u0650 \u0627\u0644\u0652\u0639\u064E\u0638\u0650\u064A\u0645\u0650',
        phonetic: 'Hasbiyallahu la ilaha illa Huwa \'alayhi tawakkaltu wa Huwa Rabbul-\'Arshil-\'Adhim',
        translation: 'Allah me suffit. Point de divinit\u00e9 \u00e0 part Lui. En Lui je place ma confiance et Il est le Seigneur du Tr\u00f4ne immense.',
        translationEn: 'Allah is sufficient for me. There is no deity but Him. In Him I place my trust and He is the Lord of the Magnificent Throne.',
        source: 'Abu Dawud',
        repeat: 7,
      ),
    ],
  ),

  // 8 — PROTECTION CONTRE LES CAUCHEMARS
  DuaCategory(
    id: 'cauchemars',
    title: 'Contre les Cauchemars',
    titleEn: 'Against Nightmares',
    emoji: '\uD83D\uDE34',
    description: 'Quand on se r\u00e9veille d\'un mauvais r\u00eave',
    descriptionEn: 'When you wake up from a bad dream',
    duas: [
      DuaProtection(
        arabic: '\u0623\u064E\u0639\u064F\u0648\u0630\u064F \u0628\u0650\u0627\u0644\u0644\u0651\u064E\u0647\u0650 \u0645\u0650\u0646\u064E \u0627\u0644\u0634\u0651\u064E\u064A\u0652\u0637\u064E\u0627\u0646\u0650 \u0627\u0644\u0631\u0651\u064E\u062C\u0650\u064A\u0645\u0650',
        phonetic: 'A\'udhu billahi minash-Shaytanir-rajim',
        translation: 'Je cherche refuge aupr\u00e8s d\'Allah contre Satan le maudit. Puis cracher l\u00e9g\u00e8rement 3 fois \u00e0 gauche et changer de c\u00f4t\u00e9. Ne racontez le cauchemar \u00e0 personne.',
        translationEn: 'I seek refuge with Allah from Satan the accursed. Then spit lightly 3 times to the left and change sides. Do not tell anyone about the nightmare.',
        source: 'Muslim',
        repeat: 3,
      ),
    ],
  ),

  // 9 — PROTECTION EN VOYAGE
  DuaCategory(
    id: 'voyage',
    title: 'Protection en Voyage',
    titleEn: 'Protection on Journey',
    emoji: '\u2708\uFE0F',
    description: 'Invocations pour tout type de d\u00e9placement',
    descriptionEn: 'Invocations for all types of travel',
    duas: [
      DuaProtection(
        arabic: '\u0633\u064F\u0628\u0652\u062D\u064E\u0627\u0646\u064E \u0627\u0644\u0651\u064E\u0630\u0650\u064A \u0633\u064E\u062E\u0651\u064E\u0631\u064E \u0644\u064E\u0646\u064E\u0627 \u0647\u064E\u0640\u0630\u064E\u0627 \u0648\u064E\u0645\u064E\u0627 \u0643\u064F\u0646\u0651\u064E\u0627 \u0644\u064E\u0647\u064F \u0645\u064F\u0642\u0652\u0631\u0650\u0646\u0650\u064A\u0646\u064E \u0648\u064E\u0625\u0650\u0646\u0651\u064E\u0627 \u0625\u0650\u0644\u064E\u0649\u0670 \u0631\u064E\u0628\u0651\u0650\u0646\u064E\u0627 \u0644\u064E\u0645\u064F\u0646\u0642\u064E\u0644\u0650\u0628\u064F\u0648\u0646\u064E',
        phonetic: 'Subhanal-ladhi sakhkhara lana hadha wa ma kunna lahu muqrinin, wa inna ila Rabbina lamunqalibun',
        translation: 'Gloire \u00e0 Celui qui a mis ceci \u00e0 notre service alors que nous n\'\u00e9tions pas capables de le faire. Et c\'est vers notre Seigneur que nous retournerons.',
        translationEn: 'Glory be to Him who has subjected this for us, as we would not have been able to. And indeed we will return to our Lord.',
        source: 'Coran, Az-Zukhruf (43:13-14)',
      ),
      DuaProtection(
        arabic: '\u0627\u0644\u0644\u0651\u064E\u0647\u064F\u0645\u0651\u064E \u0625\u0650\u0646\u0651\u064E\u0627 \u0646\u064E\u0633\u0652\u0623\u064E\u0644\u064F\u0643\u064E \u0641\u0650\u064A \u0633\u064E\u0641\u064E\u0631\u0650\u0646\u064E\u0627 \u0647\u064E\u0640\u0630\u064E\u0627 \u0627\u0644\u0652\u0628\u0650\u0631\u0651\u064E \u0648\u064E\u0627\u0644\u062A\u0651\u064E\u0642\u0652\u0648\u064E\u0649\u0670 \u0648\u064E\u0645\u0650\u0646\u064E \u0627\u0644\u0652\u0639\u064E\u0645\u064E\u0644\u0650 \u0645\u064E\u0627 \u062A\u064E\u0631\u0652\u0636\u064E\u0649',
        phonetic: 'Allahumma inna nas\'aluka fi safarina hadhal-birra wat-taqwa wa minal-\'amali ma tarda',
        translation: '\u00d4 Allah, nous Te demandons dans ce voyage la pi\u00e9t\u00e9, la crainte et les actes qui Te satisfont.',
        translationEn: 'O Allah, we ask You in this journey for righteousness, piety, and deeds that please You.',
        source: 'Muslim',
      ),
    ],
  ),
];

// ══════════════════════════════════════════════════════════════════════════
// SOS — Programme d'urgence
// ══════════════════════════════════════════════════════════════════════════
class SosStep {
  final String emoji;
  final String title;
  final String titleEn;
  final String instruction;
  final String instructionEn;
  final String? arabic;
  final String? phonetic;
  const SosStep({
    required this.emoji,
    required this.title,
    required this.titleEn,
    required this.instruction,
    required this.instructionEn,
    this.arabic,
    this.phonetic,
  });
  String get displayTitle => AppLocale().isFrench ? title : titleEn;
  String get displayInstruction => AppLocale().isFrench ? instruction : instructionEn;
}

const kSosSteps = <SosStep>[
  SosStep(
    emoji: '\uD83D\uDCA7',
    title: 'Fais tes ablutions (wudu)',
    titleEn: 'Perform Wudu',
    instruction: 'L\'eau \u00e9teint le feu de Shaytan. Le wudu est la premi\u00e8re barri\u00e8re. Si tu es en col\u00e8re, le wudu te calmera aussi.',
    instructionEn: 'Water extinguishes Satan\'s fire. Wudu is the first barrier. If you\'re angry, wudu will also calm you.',
  ),
  SosStep(
    emoji: '\uD83E\uDEF6',
    title: 'Cherche refuge aupr\u00e8s d\'Allah',
    titleEn: 'Seek Refuge with Allah',
    instruction: 'R\u00e9p\u00e8te cette formule 3 fois avec conviction :',
    instructionEn: 'Repeat this formula 3 times with conviction:',
    arabic: '\u0623\u064E\u0639\u064F\u0648\u0630\u064F \u0628\u0650\u0627\u0644\u0644\u0651\u064E\u0647\u0650 \u0645\u0650\u0646\u064E \u0627\u0644\u0634\u0651\u064E\u064A\u0652\u0637\u064E\u0627\u0646\u0650 \u0627\u0644\u0631\u0651\u064E\u062C\u0650\u064A\u0645\u0650',
    phonetic: 'A\'udhu billahi minash-Shaytanir-rajim',
  ),
  SosStep(
    emoji: '\uD83D\uDC51',
    title: 'R\u00e9cite Ayat al-Kursi',
    titleEn: 'Recite Ayat al-Kursi',
    instruction: 'R\u00e9cite Ayat al-Kursi 3 fois. C\'est le verset le plus puissant du Coran pour la protection. Aucun d\u00e9mon ne peut rester pr\u00e8s de celui qui le r\u00e9cite.',
    instructionEn: 'Recite Ayat al-Kursi 3 times. It is the most powerful verse in the Quran for protection. No demon can remain near one who recites it.',
  ),
  SosStep(
    emoji: '\uD83D\uDCD6',
    title: 'R\u00e9cite les 3 Qul',
    titleEn: 'Recite the 3 Qul',
    instruction: 'R\u00e9cite Al-Ikhlas, Al-Falaq et An-Nas, chacune 3 fois. Souffle dans tes mains apr\u00e8s chaque r\u00e9citation et passe-les sur ton corps.',
    instructionEn: 'Recite Al-Ikhlas, Al-Falaq, and An-Nas, each 3 times. Blow gently on your hands after each recitation and pass them over your body.',
  ),
  SosStep(
    emoji: '\uD83E\uDD32',
    title: 'Invoque Allah avec cette du\'a',
    titleEn: 'Invoke Allah with This Supplication',
    instruction: 'R\u00e9p\u00e8te cette invocation de protection :',
    instructionEn: 'Repeat this protective invocation:',
    arabic: '\u0628\u0650\u0633\u0652\u0645\u0650 \u0627\u0644\u0644\u0651\u064E\u0647\u0650 \u0627\u0644\u0651\u064E\u0630\u0650\u064A \u0644\u064E\u0627 \u064A\u064E\u0636\u064F\u0631\u0651\u064F \u0645\u064E\u0639\u064E \u0627\u0633\u0652\u0645\u0650\u0647\u0650 \u0634\u064E\u064A\u0652\u0621\u064C \u0641\u0650\u064A \u0627\u0644\u0652\u0623\u064E\u0631\u0652\u0636\u0650 \u0648\u064E\u0644\u064E\u0627 \u0641\u0650\u064A \u0627\u0644\u0633\u0651\u064E\u0645\u064E\u0627\u0621\u0650 \u0648\u064E\u0647\u064F\u0648\u064E \u0627\u0644\u0633\u0651\u064E\u0645\u0650\u064A\u0639\u064F \u0627\u0644\u0652\u0639\u064E\u0644\u0650\u064A\u0645\u064F',
    phonetic: 'Bismillahil-ladhi la yadurru ma\'a ismihi shay\'un fil-ardi wa la fis-sama\'i wa Huwas-Sami\'ul-\'Alim',
  ),
  SosStep(
    emoji: '\uD83D\uDE4F',
    title: 'Fais une pri\u00e8re de 2 rak\'at',
    titleEn: 'Pray 2 Units',
    instruction: 'Si possible, prie 2 rak\'at en demandant la protection d\'Allah. La pri\u00e8re est la connexion directe avec Allah et la plus forte protection.',
    instructionEn: 'If possible, pray 2 units asking for Allah\'s protection. Prayer is direct connection with Allah and the strongest protection.',
  ),
  SosStep(
    emoji: '\uD83C\uDF6F',
    title: 'Bois de l\'eau coranis\u00e9e',
    titleEn: 'Drink Quranic Water',
    instruction: 'Si tu as de l\'eau coranis\u00e9e pr\u00e9par\u00e9e, bois-en. Sinon, r\u00e9cite sur un verre d\'eau (Fatiha + Ayat al-Kursi + les 3 Qul) et bois-le.',
    instructionEn: 'If you have prepared Quranic water, drink it. Otherwise, recite over a glass of water (Fatiha + Ayat al-Kursi + the 3 Qul) and drink it.',
  ),
  SosStep(
    emoji: '\uD83D\uDCAA',
    title: 'Rappelle-toi',
    titleEn: 'Remember',
    instruction: 'Allah est plus grand que tout ce qui te fait peur. Le Shaytan est faible : \u00ab La ruse de Shaytan est certes faible \u00bb (An-Nisa, 4:76). Tu as les armes les plus puissantes : le Coran et l\'invocation. Sois patient et constant dans tes adhkar.',
    instructionEn: 'Allah is greater than everything that frightens you. Satan is weak: "Indeed, the plot of Satan has ever been weak" (An-Nisa, 4:76). You have the most powerful weapons: the Quran and supplication. Be patient and consistent in your remembrances.',
  ),
];
