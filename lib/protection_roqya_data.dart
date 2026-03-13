// protection_roqya_data.dart — Programmes de Roqya Shar'iyya

class RoqyaStep {
  final String instruction;
  final String? arabic;
  final String? phonetic;
  final String? reference;
  final int repeat;
  const RoqyaStep({
    required this.instruction,
    this.arabic,
    this.phonetic,
    this.reference,
    this.repeat = 1,
  });
}

class RoqyaProgram {
  final String id;
  final String title;
  final String emoji;
  final String description;
  final String duration;
  final String intro;
  final List<RoqyaStep> steps;
  const RoqyaProgram({
    required this.id,
    required this.title,
    required this.emoji,
    required this.description,
    required this.duration,
    required this.intro,
    required this.steps,
  });
}

const kRoqyaPrograms = <RoqyaProgram>[
  // ═══════════════════════════════════════════════════════════════════════
  // 1 — ROQYA GÉNÉRALE
  // ═══════════════════════════════════════════════════════════════════════
  RoqyaProgram(
    id: 'generale',
    title: 'Roqya G\u00e9n\u00e9rale',
    emoji: '\uD83D\uDCFF',
    description: 'Programme complet de protection et gu\u00e9rison',
    duration: '30-45 min',
    intro: 'Ce programme est le plus complet. Il couvre la protection contre le sihr, le \'ayn, la possession et le waswas. Faites vos ablutions (wudu) avant de commencer. R\u00e9citez avec conviction et concentration, en ayant la certitude qu\'Allah est le seul Gu\u00e9risseur. Vous pouvez r\u00e9citer sur vous-m\u00eame, sur un proche, ou sur de l\'eau que vous boirez ensuite.',
    steps: [
      RoqyaStep(
        instruction: 'Commencez par chercher refuge aupr\u00e8s d\'Allah et demander Sa protection.',
        arabic: '\u0623\u064E\u0639\u064F\u0648\u0630\u064F \u0628\u0650\u0627\u0644\u0644\u0651\u064E\u0647\u0650 \u0645\u0650\u0646\u064E \u0627\u0644\u0634\u0651\u064E\u064A\u0652\u0637\u064E\u0627\u0646\u0650 \u0627\u0644\u0631\u0651\u064E\u062C\u0650\u064A\u0645\u0650',
        phonetic: 'A\'udhu billahi minash-Shaytanir-rajim',
        repeat: 3,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez Sourate Al-Fatiha en posant la main sur la zone de douleur ou sur la t\u00eate.',
        reference: 'Al-Fatiha (1:1-7)',
        repeat: 7,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez Ayat al-Kursi avec concentration.',
        reference: 'Al-Baqara (2:255)',
        repeat: 3,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez les derniers versets de Sourate Al-Baqara.',
        reference: 'Al-Baqara (2:285-286)',
        repeat: 1,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez les versets anti-sihr de Sourate Al-A\'raf.',
        reference: 'Al-A\'raf (7:117-122)',
        repeat: 3,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez les versets anti-sihr de Sourate Yunus.',
        reference: 'Yunus (10:81-82)',
        repeat: 3,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez les versets anti-sihr de Sourate Ta-Ha.',
        reference: 'Ta-Ha (20:68-69)',
        repeat: 3,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez le verset de la gu\u00e9rison.',
        reference: 'Al-Isra (17:82)',
        repeat: 3,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez Sourate Al-Ikhlas.',
        reference: 'Al-Ikhlas (112:1-4)',
        repeat: 3,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez Sourate Al-Falaq.',
        reference: 'Al-Falaq (113:1-5)',
        repeat: 3,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez Sourate An-Nas.',
        reference: 'An-Nas (114:1-6)',
        repeat: 3,
      ),
      RoqyaStep(
        instruction: 'Soufflez dans vos mains et passez-les sur tout votre corps, de la t\u00eate aux pieds. Le Proph\u00e8te \u00a7 faisait cela chaque soir.',
      ),
      RoqyaStep(
        instruction: 'Invoquez Allah avec cette du\'a de gu\u00e9rison :',
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
    emoji: '\uD83D\uDC41\uFE0F',
    description: 'Programme sp\u00e9cifique contre al-\'ayn et la jalousie',
    duration: '15-20 min',
    intro: 'Ce programme cible sp\u00e9cifiquement le mauvais oeil (al-\'ayn). Si vous connaissez la personne qui vous a touch\u00e9 du oeil, demandez-lui de faire ses ablutions et versez cette eau sur vous. Sinon, suivez ce programme de roqya. Faites vos ablutions avant de commencer.',
    steps: [
      RoqyaStep(
        instruction: 'R\u00e9citez Sourate Al-Fatiha en posant la main sur la zone affect\u00e9e.',
        reference: 'Al-Fatiha (1:1-7)',
        repeat: 7,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez Ayat al-Kursi.',
        reference: 'Al-Baqara (2:255)',
        repeat: 3,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez Sourate Al-Falaq \u2014 elle contient la protection contre la jalousie (verset 5).',
        reference: 'Al-Falaq (113:1-5)',
        repeat: 7,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez Sourate An-Nas.',
        reference: 'An-Nas (114:1-6)',
        repeat: 7,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez la du\'a du Proph\u00e8te \u00a7 contre le mauvais oeil :',
        arabic: '\u0623\u064E\u0639\u064F\u0648\u0630\u064F \u0628\u0650\u0643\u064E\u0644\u0650\u0645\u064E\u0627\u062A\u0650 \u0627\u0644\u0644\u0651\u064E\u0647\u0650 \u0627\u0644\u062A\u0651\u064E\u0627\u0645\u0651\u064E\u0629\u0650 \u0645\u0650\u0646\u0652 \u0643\u064F\u0644\u0651\u0650 \u0634\u064E\u064A\u0652\u0637\u064E\u0627\u0646\u064D \u0648\u064E\u0647\u064E\u0627\u0645\u0651\u064E\u0629\u064D \u0648\u064E\u0645\u0650\u0646\u0652 \u0643\u064F\u0644\u0651\u0650 \u0639\u064E\u064A\u0652\u0646\u064D \u0644\u064E\u0627\u0645\u0651\u064E\u0629\u064D',
        phonetic: 'A\'udhu bi-kalimatillahit-tammati min kulli shaytanin wa hammah, wa min kulli \'aynin lammah',
        repeat: 3,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez cette invocation proph\u00e9tique de gu\u00e9rison :',
        arabic: '\u0628\u0650\u0633\u0652\u0645\u0650 \u0627\u0644\u0644\u0651\u064E\u0647\u0650 \u0623\u064E\u0631\u0652\u0642\u0650\u064A\u0643\u064E \u0645\u0650\u0646\u0652 \u0643\u064F\u0644\u0651\u0650 \u0634\u064E\u064A\u0652\u0621\u064D \u064A\u064F\u0624\u0652\u0630\u0650\u064A\u0643\u064E \u0645\u0650\u0646\u0652 \u0634\u064E\u0631\u0651\u0650 \u0643\u064F\u0644\u0651\u0650 \u0646\u064E\u0641\u0652\u0633\u064D \u0623\u064E\u0648\u0652 \u0639\u064E\u064A\u0652\u0646\u0650 \u062D\u064E\u0627\u0633\u0650\u062F\u064D \u0627\u0644\u0644\u0651\u064E\u0647\u064F \u064A\u064E\u0634\u0652\u0641\u0650\u064A\u0643\u064E',
        phonetic: 'Bismillahi arqika min kulli shay\'in yu\'dhika, min sharri kulli nafsin aw \'ayni hasidin, Allahu yashfik',
        repeat: 3,
      ),
      RoqyaStep(
        instruction: 'Soufflez dans vos mains et passez-les sur tout votre corps 3 fois.',
      ),
    ],
  ),

  // ═══════════════════════════════════════════════════════════════════════
  // 3 — ROQYA CONTRE LA SORCELLERIE
  // ═══════════════════════════════════════════════════════════════════════
  RoqyaProgram(
    id: 'sihr',
    title: 'Roqya contre la Sorcellerie',
    emoji: '\u26A0\uFE0F',
    description: 'Programme intensif pour briser les effets du sihr',
    duration: '30-40 min',
    intro: 'Ce programme cible la sorcellerie (sihr). Il utilise les versets qui ont historiquement vaincu la sorcellerie : la confrontation de Moussa (\u0639\u0644\u064A\u0647 \u0627\u0644\u0633\u0644\u0627\u0645) avec les sorciers de Pharaon. Soyez patient et r\u00e9gulier : la roqya peut n\u00e9cessiter plusieurs sessions. Compl\u00e9tez avec l\'\u00e9coute de Sourate Al-Baqara et la consommation d\'eau coranis\u00e9e.',
    steps: [
      RoqyaStep(
        instruction: 'R\u00e9citez Sourate Al-Fatiha.',
        reference: 'Al-Fatiha (1:1-7)',
        repeat: 7,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez les premiers versets de Sourate Al-Baqara (1-5).',
        reference: 'Al-Baqara (2:1-5)',
        repeat: 1,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez Ayat al-Kursi.',
        reference: 'Al-Baqara (2:255)',
        repeat: 7,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez les versets anti-sihr de Sourate Al-A\'raf.',
        reference: 'Al-A\'raf (7:117-122)',
        repeat: 7,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez les versets anti-sihr de Sourate Yunus.',
        reference: 'Yunus (10:81-82)',
        repeat: 7,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez les versets anti-sihr de Sourate Ta-Ha.',
        reference: 'Ta-Ha (20:68-69)',
        repeat: 7,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez le verset de la gu\u00e9rison.',
        reference: 'Al-Isra (17:82)',
        repeat: 7,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez les 3 Qul (Al-Ikhlas, Al-Falaq, An-Nas).',
        reference: 'Sourates 112, 113, 114',
        repeat: 3,
      ),
      RoqyaStep(
        instruction: 'Soufflez dans de l\'eau et buvez-la. Vous pouvez aussi vous en laver.',
      ),
      RoqyaStep(
        instruction: '\u00c9coutez Sourate Al-Baqara en entier dans votre maison. Le Proph\u00e8te \u00a7 a dit que le Shaytan fuit la maison o\u00f9 elle est r\u00e9cit\u00e9e.',
      ),
    ],
  ),

  // ═══════════════════════════════════════════════════════════════════════
  // 4 — ROQYA CONTRE LE WASWAS
  // ═══════════════════════════════════════════════════════════════════════
  RoqyaProgram(
    id: 'waswas',
    title: 'Roqya contre le Waswas',
    emoji: '\uD83D\uDDE3\uFE0F',
    description: 'Pour combattre les chuchotements obsessionnels',
    duration: '15 min',
    intro: 'Le waswas (chuchotement obsessionnel) est l\'arme favorite de Shaytan. Ce programme combine la r\u00e9citation coranique avec les du\'as proph\u00e9tiques sp\u00e9cifiques au waswas. La cl\u00e9 : ne jamais suivre le waswas, l\'ignorer activement et s\'accrocher au dhikr. Le Proph\u00e8te \u00a7 a rassur\u00e9 qu\'avoir du waswas est en soi un signe de foi.',
    steps: [
      RoqyaStep(
        instruction: 'Cherchez refuge aupr\u00e8s d\'Allah imm\u00e9diatement :',
        arabic: '\u0623\u064E\u0639\u064F\u0648\u0630\u064F \u0628\u0650\u0627\u0644\u0644\u0651\u064E\u0647\u0650 \u0645\u0650\u0646\u064E \u0627\u0644\u0634\u0651\u064E\u064A\u0652\u0637\u064E\u0627\u0646\u0650 \u0627\u0644\u0631\u0651\u064E\u062C\u0650\u064A\u0645\u0650',
        phonetic: 'A\'udhu billahi minash-Shaytanir-rajim',
        repeat: 3,
      ),
      RoqyaStep(
        instruction: 'Affirmez votre foi :',
        arabic: '\u0622\u0645\u064E\u0646\u0652\u062A\u064F \u0628\u0650\u0627\u0644\u0644\u0651\u064E\u0647\u0650 \u0648\u064E\u0631\u064F\u0633\u064F\u0644\u0650\u0647\u0650',
        phonetic: 'Amantu billahi wa rusulihi',
        repeat: 3,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez Sourate An-Nas \u2014 la sourate r\u00e9v\u00e9l\u00e9e sp\u00e9cifiquement contre le waswas.',
        reference: 'An-Nas (114:1-6)',
        repeat: 7,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez Sourate Al-Falaq.',
        reference: 'Al-Falaq (113:1-5)',
        repeat: 3,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez Ayat al-Kursi.',
        reference: 'Al-Baqara (2:255)',
        repeat: 3,
      ),
      RoqyaStep(
        instruction: 'R\u00e9p\u00e9tez cette formule de rappel :',
        arabic: '\u0644\u064E\u0627 \u062D\u064E\u0648\u0652\u0644\u064E \u0648\u064E\u0644\u064E\u0627 \u0642\u064F\u0648\u0651\u064E\u0629\u064E \u0625\u0650\u0644\u0651\u064E\u0627 \u0628\u0650\u0627\u0644\u0644\u0651\u064E\u0647\u0650',
        phonetic: 'La hawla wa la quwwata illa billah',
        repeat: 10,
      ),
      RoqyaStep(
        instruction: 'Conseil essentiel : cessez d\'y penser. Shaytan veut que vous restiez obsess\u00e9 par ses chuchotements. Occupez-vous avec du dhikr, du travail, ou la compagnie de bonnes personnes. Le waswas s\'affaiblit quand on l\'ignore.',
      ),
    ],
  ),

  // ═══════════════════════════════════════════════════════════════════════
  // 5 — ROQYA POUR LES ENFANTS
  // ═══════════════════════════════════════════════════════════════════════
  RoqyaProgram(
    id: 'enfants',
    title: 'Roqya pour les Enfants',
    emoji: '\uD83D\uDC76',
    description: 'Prot\u00e9ger ses enfants comme le faisait le Proph\u00e8te \u00a7',
    duration: '10 min',
    intro: 'Le Proph\u00e8te \u00a7 prot\u00e9geait Al-Hasan et Al-Husayn chaque soir avec des invocations sp\u00e9cifiques. Les enfants sont particuli\u00e8rement vuln\u00e9rables au mauvais oeil car les gens les admirent souvent sans dire MashaAllah. Ce programme simple peut \u00eatre fait chaque soir au coucher de l\'enfant.',
    steps: [
      RoqyaStep(
        instruction: 'Posez votre main sur la t\u00eate de l\'enfant et r\u00e9citez l\'invocation du Proph\u00e8te \u00a7 pour Al-Hasan et Al-Husayn :',
        arabic: '\u0623\u064F\u0639\u064A\u0630\u064F\u0643\u064F\u0645\u064E\u0627 \u0628\u0650\u0643\u064E\u0644\u0650\u0645\u064E\u0627\u062A\u0650 \u0627\u0644\u0644\u0651\u064E\u0647\u0650 \u0627\u0644\u062A\u0651\u064E\u0627\u0645\u0651\u064E\u0629\u0650 \u0645\u0650\u0646\u0652 \u0643\u064F\u0644\u0651\u0650 \u0634\u064E\u064A\u0652\u0637\u064E\u0627\u0646\u064D \u0648\u064E\u0647\u064E\u0627\u0645\u0651\u064E\u0629\u064D \u0648\u064E\u0645\u0650\u0646\u0652 \u0643\u064F\u0644\u0651\u0650 \u0639\u064E\u064A\u0652\u0646\u064D \u0644\u064E\u0627\u0645\u0651\u064E\u0629\u064D',
        phonetic: 'U\'idhukuma bi-kalimatillahit-tammati min kulli shaytanin wa hammah, wa min kulli \'aynin lammah',
        repeat: 1,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez Sourate Al-Fatiha.',
        reference: 'Al-Fatiha (1:1-7)',
        repeat: 1,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez Ayat al-Kursi.',
        reference: 'Al-Baqara (2:255)',
        repeat: 1,
      ),
      RoqyaStep(
        instruction: 'R\u00e9citez les 3 Qul (Al-Ikhlas, Al-Falaq, An-Nas).',
        reference: 'Sourates 112, 113, 114',
        repeat: 3,
      ),
      RoqyaStep(
        instruction: 'Soufflez doucement dans vos mains et passez-les sur tout le corps de l\'enfant, comme le faisait le Proph\u00e8te \u00a7.',
      ),
    ],
  ),
];
