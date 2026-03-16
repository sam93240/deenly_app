// protection_roqya_data.dart — Programmes de Roqya Shar'iyya

import 'app_locale.dart';

class RoqyaStep {
  final String instruction;
  final String instructionEn;
  final String? arabic;
  final String? phonetic;
  final String? reference;
  final int repeat;
  const RoqyaStep({
    required this.instruction,
    required this.instructionEn,
    this.arabic,
    this.phonetic,
    this.reference,
    this.repeat = 1,
  });
  String get displayInstruction => AppLocale().isFrench ? instruction : instructionEn;
}

class RoqyaProgram {
  final String id;
  final String title;
  final String titleEn;
  final String emoji;
  final String description;
  final String descriptionEn;
  final String duration;
  final String intro;
  final String introEn;
  final List<RoqyaStep> steps;
  const RoqyaProgram({
    required this.id,
    required this.title,
    required this.titleEn,
    required this.emoji,
    required this.description,
    required this.descriptionEn,
    required this.duration,
    required this.intro,
    required this.introEn,
    required this.steps,
  });
  String get displayTitle => AppLocale().isFrench ? title : titleEn;
  String get displayDescription => AppLocale().isFrench ? description : descriptionEn;
  String get displayIntro => AppLocale().isFrench ? intro : introEn;
}

const kRoqyaPrograms = <RoqyaProgram>[
  // ═══════════════════════════════════════════════════════════════════════
  // 1 — ROQYA GÉNÉRALE
  // ═══════════════════════════════════════════════════════════════════════
  RoqyaProgram(
    id: 'generale',
    title: 'Roqya G\u00e9n\u00e9rale',
    titleEn: 'General Roqya',
    emoji: '\uD83D\uDCFF',
    description: 'Programme complet de protection et gu\u00e9rison',
    descriptionEn: 'Complete program of protection and healing',
    duration: '30-45 min',
    intro: 'Ce programme est le plus complet. Il couvre la protection contre le sihr, le \'ayn, la possession et le waswas. Faites vos ablutions (wudu) avant de commencer. R\u00e9citez avec conviction et concentration, en ayant la certitude qu\'Allah est le seul Gu\u00e9risseur. Vous pouvez r\u00e9citer sur vous-m\u00eame, sur un proche, ou sur de l\'eau que vous boirez ensuite.',
    introEn: 'This program is the most comprehensive. It covers protection against sihr, evil eye, possession, and waswas. Perform wudu before starting. Recite with conviction and concentration, certain that Allah is the only Healer. You can recite over yourself, a loved one, or water that you will drink afterward.',
    steps: [
      RoqyaStep(
        instruction: 'Commencez par chercher refuge aupr\u00e8s d\'Allah et demander Sa protection.',
        instructionEn: 'Begin by seeking refuge with Allah and asking for His protection.',
        arabic: '\u0623\u064E\u0639\u064F\u0648\u0630\u064F \u0628\u0650\u0627\u0644\u0644\u0651\u064E\u0647\u0650 \u0645\u0650\u0646\u064E \u0627\u0644\u0634\u0651\u064E\u064A\u0652\u0637\u064E\u0627\u0646\u0650 \u0627\u0644\u0631\u0651\u064E\u062C\u0650\u064A\u0645\u0650',
        phonetic: 'A\'udhu billahi minash-Shaytanir-rajim',
        repeat: 3,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez Sourate Al-Fatiha en posant la main sur la zone de douleur ou sur la t\u00eate.',
        instructionEn: 'Recite Surah Al-Fatiha while placing your hand on the area of pain or on the head.',
        reference: 'Al-Fatiha (1:1-7)',
        repeat: 7,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez Ayat al-Kursi avec concentration.',
        instructionEn: 'Recite Ayat al-Kursi with concentration.',
        reference: 'Al-Baqara (2:255)',
        repeat: 3,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez les derniers versets de Sourate Al-Baqara.',
        instructionEn: 'Recite the last verses of Surah Al-Baqara.',
        reference: 'Al-Baqara (2:285-286)',
        repeat: 1,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez les versets anti-sihr de Sourate Al-A\'raf.',
        instructionEn: 'Recite the anti-sihr verses of Surah Al-Araf.',
        reference: 'Al-A\'raf (7:117-122)',
        repeat: 3,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez les versets anti-sihr de Sourate Yunus.',
        instructionEn: 'Recite the anti-sihr verses of Surah Yunus.',
        reference: 'Yunus (10:81-82)',
        repeat: 3,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez les versets anti-sihr de Sourate Ta-Ha.',
        instructionEn: 'Recite the anti-sihr verses of Surah Ta-Ha.',
        reference: 'Ta-Ha (20:68-69)',
        repeat: 3,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez le verset de la gu\u00e9rison.',
        instructionEn: 'Recite the healing verse.',
        reference: 'Al-Isra (17:82)',
        repeat: 3,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez Sourate Al-Ikhlas.',
        instructionEn: 'Recite Surah Al-Ikhlas.',
        reference: 'Al-Ikhlas (112:1-4)',
        repeat: 3,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez Sourate Al-Falaq.',
        instructionEn: 'Recite Surah Al-Falaq.',
        reference: 'Al-Falaq (113:1-5)',
        repeat: 3,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez Sourate An-Nas.',
        instructionEn: 'Recite Surah An-Nas.',
        reference: 'An-Nas (114:1-6)',
        repeat: 3,
      ),
      RoqyaStep(
        instruction: 'Soufflez dans vos mains et passez-les sur tout votre corps, de la t\u00eate aux pieds. Le Proph\u00e8te \u00a7 faisait cela chaque soir.',
        instructionEn: 'Blow gently on your hands and pass them over your entire body, from head to feet. The Prophet did this every evening.',
      ),
      RoqyaStep(
        instruction: 'Invoquez Allah avec cette du\'a de gu\u00e9rison :',
        instructionEn: 'Invoke Allah with this healing supplication:',
        arabic: '\u0628\u0650\u0633\u0652\u0645\u0650 \u0627\u0644\u0644\u0651\u064E\u0647\u0650 \u0627\u0644\u0651\u064E\u0630\u0650\u064A \u0644\u064E\u0627 \u064A\u064E\u0636\u064F\u0631\u0651\u064F \u0645\u064E\u0639\u064E \u0627\u0633\u0652\u0645\u0650\u0647\u0650 \u0634\u064E\u064A\u0652\u0621\u064C \u0641\u0650\u064A \u0627\u0644\u0652\u0623\u064E\u0631\u0652\u0636\u0650 \u0648\u064E\u0644\u064E\u0627 \u0641\u0650\u064A \u0627\u0644\u0633\u0651\u064E\u0645\u064E\u0627\u0621\u0650 \u0648\u064E\u0647\u064F\u0648\u064E \u0627\u0644\u0633\u0651\u064E\u0645\u0650\u064A\u0639\u064F \u0627\u0644\u0652\u0639\u064E\u0644\u0650\u064A\u0645\u064F',
        phonetic: 'Bismillahil-ladhi la yadurru ma\'a ismihi shay\'un fil-ardi wa la fis-sama\'i wa Huwas-Sami\'ul-\'Alim',
        repeat: 3,
      ),
    ],
  ),

  // ═══════════════════════════════════════════════════════════════════════
  // 2 — ROQYA CONTRE LE MAUVAIS OEIL
  // ═══════════════════════════════════════════════════════════════════════
  RoqyaProgram(
    id: 'ayn',
    title: 'Roqya contre le Mauvais \u0152il',
    titleEn: 'Roqya Against Evil Eye',
    emoji: '\uD83D\uDC41\uFE0F',
    description: 'Programme sp\u00e9cifique contre al-\'ayn et la jalousie',
    descriptionEn: 'Specific program against al-ayn and envy',
    duration: '15-20 min',
    intro: 'Ce programme cible sp\u00e9cifiquement le mauvais oeil (al-\'ayn). Si vous connaissez la personne qui vous a touch\u00e9 du oeil, demandez-lui de faire ses ablutions et versez cette eau sur vous. Sinon, suivez ce programme de roqya. Faites vos ablutions avant de commencer.',
    introEn: 'This program specifically targets the evil eye (al-ayn). If you know the person who gave you the evil eye, ask them to perform wudu and pour that water on you. Otherwise, follow this roqya program. Perform wudu before starting.',
    steps: [
      RoqyaStep(
        instruction: 'R\u00e9citez Sourate Al-Fatiha en posant la main sur la zone affect\u00e9e.',
        instructionEn: 'Recite Surah Al-Fatiha while placing your hand on the affected area.',
        reference: 'Al-Fatiha (1:1-7)',
        repeat: 7,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez Ayat al-Kursi.',
        instructionEn: 'Recite Ayat al-Kursi.',
        reference: 'Al-Baqara (2:255)',
        repeat: 3,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez Sourate Al-Falaq \u2014 elle contient la protection contre la jalousie (verset 5).',
        instructionEn: 'Recite Surah Al-Falaq — it contains protection against envy (verse 5).',
        reference: 'Al-Falaq (113:1-5)',
        repeat: 7,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez Sourate An-Nas.',
        instructionEn: 'Recite Surah An-Nas.',
        reference: 'An-Nas (114:1-6)',
        repeat: 7,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez la du\'a du Proph\u00e8te \u00a7 contre le mauvais oeil :',
        instructionEn: 'Recite the Prophet\'s supplication against evil eye:',
        arabic: '\u0623\u064E\u0639\u064F\u0648\u0630\u064F \u0628\u0650\u0643\u064E\u0644\u0650\u0645\u064E\u0627\u062A\u0650 \u0627\u0644\u0644\u0651\u064E\u0647\u0650 \u0627\u0644\u062A\u0651\u064E\u0627\u0645\u0651\u064E\u0629\u0650 \u0645\u0650\u0646\u0652 \u0643\u064F\u0644\u0651\u0650 \u0634\u064E\u064A\u0652\u0637\u064E\u0627\u0646\u064D \u0648\u064E\u0647\u064E\u0627\u0645\u0651\u064E\u0629\u064D \u0648\u064E\u0645\u0650\u0646\u0652 \u0643\u064F\u0644\u0651\u0650 \u0639\u064E\u064A\u0652\u0646\u064D \u0644\u064E\u0627\u0645\u0651\u064E\u0629\u064D',
        phonetic: 'A\'udhu bi-kalimatillahit-tammati min kulli shaytanin wa hammah, wa min kulli \'aynin lammah',
        repeat: 3,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez cette invocation proph\u00e9tique de gu\u00e9rison :',
        instructionEn: 'Recite this prophetic healing invocation:',
        arabic: '\u0628\u0650\u0633\u0652\u0645\u0650 \u0627\u0644\u0644\u0651\u064E\u0647\u0650 \u0623\u064E\u0631\u0652\u0642\u0650\u064A\u0643\u064E \u0645\u0650\u0646\u0652 \u0643\u064F\u0644\u0651\u0650 \u0634\u064E\u064A\u0652\u0621\u064D \u064A\u064F\u0624\u0652\u0630\u0650\u064A\u0643\u064E \u0645\u0650\u0646\u0652 \u0634\u064E\u0631\u0651\u0650 \u0643\u064F\u0644\u0651\u0650 \u0646\u064E\u0641\u0652\u0633\u064D \u0623\u064E\u0648\u0652 \u0639\u064E\u064A\u0652\u0646\u0650 \u062D\u064E\u0627\u0633\u0650\u062F\u064D \u0627\u0644\u0644\u0651\u064E\u0647\u064F \u064A\u064E\u0634\u0652\u0641\u0650\u064A\u0643\u064E',
        phonetic: 'Bismillahi arqika min kulli shay\'in yu\'dhika, min sharri kulli nafsin aw \'ayni hasidin, Allahu yashfik',
        repeat: 3,
      ),
      RoqyaStep(
        instruction: 'Soufflez dans vos mains et passez-les sur tout votre corps 3 fois.',
        instructionEn: 'Blow gently on your hands and pass them over your entire body 3 times.',
      ),
    ],
  ),

  // ═══════════════════════════════════════════════════════════════════════
  // 3 — ROQYA CONTRE LA SORCELLERIE
  // ═══════════════════════════════════════════════════════════════════════
  RoqyaProgram(
    id: 'sihr',
    title: 'Roqya contre la Sorcellerie',
    titleEn: 'Roqya Against Sorcery',
    emoji: '\u26A0\uFE0F',
    description: 'Programme intensif pour briser les effets du sihr',
    descriptionEn: 'Intensive program to break effects of sihr',
    duration: '30-40 min',
    intro: 'Ce programme cible la sorcellerie (sihr). Il utilise les versets qui ont historiquement vaincu la sorcellerie : la confrontation de Moussa (\u0639\u0644\u064A\u0647 \u0627\u0644\u0633\u0644\u0627\u0645) avec les sorciers de Pharaon. Soyez patient et r\u00e9gulier : la roqya peut n\u00e9cessiter plusieurs sessions. Compl\u00e9tez avec l\'\u00e9coute de Sourate Al-Baqara et la consommation d\'eau coranis\u00e9e.',
    introEn: 'This program targets sorcery (sihr). It uses verses that historically defeated sorcery: Moses\'s confrontation with Pharaoh\'s sorcerers. Be patient and consistent: roqya may require multiple sessions. Supplement with listening to Surah Al-Baqara and consuming Quranic water.',
    steps: [
      RoqyaStep(
        instruction: 'R\u00e9citez Sourate Al-Fatiha.',
        instructionEn: 'Recite Surah Al-Fatiha.',
        reference: 'Al-Fatiha (1:1-7)',
        repeat: 7,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez les premiers versets de Sourate Al-Baqara (1-5).',
        instructionEn: 'Recite the first verses of Surah Al-Baqara (1-5).',
        reference: 'Al-Baqara (2:1-5)',
        repeat: 1,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez Ayat al-Kursi.',
        instructionEn: 'Recite Ayat al-Kursi.',
        reference: 'Al-Baqara (2:255)',
        repeat: 7,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez les versets anti-sihr de Sourate Al-A\'raf.',
        instructionEn: 'Recite the anti-sihr verses of Surah Al-Araf.',
        reference: 'Al-A\'raf (7:117-122)',
        repeat: 7,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez les versets anti-sihr de Sourate Yunus.',
        instructionEn: 'Recite the anti-sihr verses of Surah Yunus.',
        reference: 'Yunus (10:81-82)',
        repeat: 7,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez les versets anti-sihr de Sourate Ta-Ha.',
        instructionEn: 'Recite the anti-sihr verses of Surah Ta-Ha.',
        reference: 'Ta-Ha (20:68-69)',
        repeat: 7,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez le verset de la gu\u00e9rison.',
        instructionEn: 'Recite the healing verse.',
        reference: 'Al-Isra (17:82)',
        repeat: 7,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez les 3 Qul (Al-Ikhlas, Al-Falaq, An-Nas).',
        instructionEn: 'Recite the 3 Qul (Al-Ikhlas, Al-Falaq, An-Nas).',
        reference: 'Sourates 112, 113, 114',
        repeat: 3,
      ),
      RoqyaStep(
        instruction: 'Soufflez dans de l\'eau et buvez-la. Vous pouvez aussi vous en laver.',
        instructionEn: 'Blow gently on water and drink it. You can also wash with it.',
      ),
      RoqyaStep(
        instruction: '\u00c9coutez Sourate Al-Baqara en entier dans votre maison. Le Proph\u00e8te \u00a7 a dit que le Shaytan fuit la maison o\u00f9 elle est r\u00e9cit\u00e9e.',
        instructionEn: 'Listen to the complete Surah Al-Baqara in your home. The Prophet said Satan flees the home where it is recited.',
      ),
    ],
  ),

  // ═══════════════════════════════════════════════════════════════════════
  // 4 — ROQYA CONTRE LE WASWAS
  // ═══════════════════════════════════════════════════════════════════════
  RoqyaProgram(
    id: 'waswas',
    title: 'Roqya contre le Waswas',
    titleEn: 'Roqya Against Waswas',
    emoji: '\uD83D\uDDE3\uFE0F',
    description: 'Pour combattre les chuchotements obsessionnels',
    descriptionEn: 'To fight obsessive whispers',
    duration: '15 min',
    intro: 'Le waswas (chuchotement obsessionnel) est l\'arme favorite de Shaytan. Ce programme combine la r\u00e9citation coranique avec les du\'as proph\u00e9tiques sp\u00e9cifiques au waswas. La cl\u00e9 : ne jamais suivre le waswas, l\'ignorer activement et s\'accrocher au dhikr. Le Proph\u00e8te \u00a7 a rassur\u00e9 qu\'avoir du waswas est en soi un signe de foi.',
    introEn: 'Waswas (obsessive whispering) is Satan\'s favorite weapon. This program combines Quranic recitation with prophetic supplications specific to waswas. Key: never follow waswas, actively ignore it, and hold firmly to remembrance. The Prophet assured that having waswas is itself a sign of faith.',
    steps: [
      RoqyaStep(
        instruction: 'Cherchez refuge aupr\u00e8s d\'Allah imm\u00e9diatement :',
        instructionEn: 'Seek refuge with Allah immediately:',
        arabic: '\u0623\u064E\u0639\u064F\u0648\u0630\u064F \u0628\u0650\u0627\u0644\u0644\u0651\u064E\u0647\u0650 \u0645\u0650\u0646\u064E \u0627\u0644\u0634\u0651\u064E\u064A\u0652\u0637\u064E\u0627\u0646\u0650 \u0627\u0644\u0631\u0651\u064E\u062C\u0650\u064A\u0645\u0650',
        phonetic: 'A\'udhu billahi minash-Shaytanir-rajim',
        repeat: 3,
      ),
      RoqyaStep(
        instruction: 'Affirmez votre foi :',
        instructionEn: 'Affirm your faith:',
        arabic: '\u0622\u0645\u064E\u0646\u0652\u062A\u064F \u0628\u0650\u0627\u0644\u0644\u0651\u064E\u0647\u0650 \u0648\u064E\u0631\u064F\u0633\u064F\u0644\u0650\u0647\u0650',
        phonetic: 'Amantu billahi wa rusulihi',
        repeat: 3,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez Sourate An-Nas \u2014 la sourate r\u00e9v\u00e9l\u00e9e sp\u00e9cifiquement contre le waswas.',
        instructionEn: 'Recite Surah An-Nas — the surah revealed specifically against waswas.',
        reference: 'An-Nas (114:1-6)',
        repeat: 7,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez Sourate Al-Falaq.',
        instructionEn: 'Recite Surah Al-Falaq.',
        reference: 'Al-Falaq (113:1-5)',
        repeat: 3,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez Ayat al-Kursi.',
        instructionEn: 'Recite Ayat al-Kursi.',
        reference: 'Al-Baqara (2:255)',
        repeat: 3,
      ),
      RoqyaStep(
        instruction: 'R\u00e9p\u00e9tez cette formule de rappel :',
        instructionEn: 'Repeat this formula of remembrance:',
        arabic: '\u0644\u064E\u0627 \u062D\u064E\u0648\u0652\u0644\u064E \u0648\u064E\u0644\u064E\u0627 \u0642\u064F\u0648\u0651\u064E\u0629\u064E \u0625\u0650\u0644\u0651\u064E\u0627 \u0628\u0650\u0627\u0644\u0644\u0651\u064E\u0647\u0650',
        phonetic: 'La hawla wa la quwwata illa billah',
        repeat: 10,
      ),
      RoqyaStep(
        instruction: 'Conseil essentiel : cessez d\'y penser. Shaytan veut que vous restiez obsess\u00e9 par ses chuchotements. Occupez-vous avec du dhikr, du travail, ou la compagnie de bonnes personnes. Le waswas s\'affaiblit quand on l\'ignore.',
        instructionEn: 'Essential advice: stop thinking about it. Satan wants you to remain obsessed with his whispers. Keep yourself busy with remembrance, work, or good company. Waswas weakens when ignored.',
      ),
    ],
  ),

  // ═══════════════════════════════════════════════════════════════════════
  // 5 — ROQYA POUR LES ENFANTS
  // ═══════════════════════════════════════════════════════════════════════
  RoqyaProgram(
    id: 'enfants',
    title: 'Roqya pour les Enfants',
    titleEn: 'Roqya for Children',
    emoji: '\uD83D\uDC76',
    description: 'Prot\u00e9ger ses enfants comme le faisait le Proph\u00e8te \u00a7',
    descriptionEn: 'Protect your children as the Prophet did',
    duration: '10 min',
    intro: 'Le Proph\u00e8te \u00a7 prot\u00e9geait Al-Hasan et Al-Husayn chaque soir avec des invocations sp\u00e9cifiques. Les enfants sont particuli\u00e8rement vuln\u00e9rables au mauvais oeil car les gens les admirent souvent sans dire MashaAllah. Ce programme simple peut \u00eatre fait chaque soir au coucher de l\'enfant.',
    introEn: 'The Prophet protected Al-Hasan and Al-Husayn every evening with specific invocations. Children are particularly vulnerable to the evil eye as people often admire them without saying MashaAllah. This simple program can be done every evening at bedtime.',
    steps: [
      RoqyaStep(
        instruction: 'Posez votre main sur la t\u00eate de l\'enfant et r\u00e9citez l\'invocation du Proph\u00e8te \u00a7 pour Al-Hasan et Al-Husayn :',
        instructionEn: 'Place your hand on the child\'s head and recite the Prophet\'s invocation for Al-Hasan and Al-Husayn:',
        arabic: '\u0623\u064F\u0639\u064A\u0630\u064F\u0643\u064F\u0645\u064E\u0627 \u0628\u0650\u0643\u064E\u0644\u0650\u0645\u064E\u0627\u062A\u0650 \u0627\u0644\u0644\u0651\u064E\u0647\u0650 \u0627\u0644\u062A\u0651\u064E\u0627\u0645\u0651\u064E\u0629\u0650 \u0645\u0650\u0646\u0652 \u0643\u064F\u0644\u0651\u0650 \u0634\u064E\u064A\u0652\u0637\u064E\u0627\u0646\u064D \u0648\u064E\u0647\u064E\u0627\u0645\u0651\u064E\u0629\u064D \u0648\u064E\u0645\u0650\u0646\u0652 \u0643\u064F\u0644\u0651\u0650 \u0639\u064E\u064A\u0652\u0646\u064D \u0644\u064E\u0627\u0645\u0651\u064E\u0629\u064D',
        phonetic: 'U\'idhukuma bi-kalimatillahit-tammati min kulli shaytanin wa hammah, wa min kulli \'aynin lammah',
        repeat: 1,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez Sourate Al-Fatiha.',
        instructionEn: 'Recite Surah Al-Fatiha.',
        reference: 'Al-Fatiha (1:1-7)',
        repeat: 1,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez Ayat al-Kursi.',
        instructionEn: 'Recite Ayat al-Kursi.',
        reference: 'Al-Baqara (2:255)',
        repeat: 1,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez les 3 Qul (Al-Ikhlas, Al-Falaq, An-Nas).',
        instructionEn: 'Recite the 3 Qul (Al-Ikhlas, Al-Falaq, An-Nas).',
        reference: 'Sourates 112, 113, 114',
        repeat: 3,
      ),
      RoqyaStep(
        instruction: 'Soufflez doucement dans vos mains et passez-les sur tout le corps de l\'enfant, comme le faisait le Proph\u00e8te \u00a7.',
        instructionEn: 'Blow gently on your hands and pass them over the child\'s entire body, as the Prophet did.',
      ),
    ],
  ),
];
