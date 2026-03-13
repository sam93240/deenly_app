// protection_duas_data.dart — Invocations de Protection

class DuaProtection {
  final String arabic;
  final String phonetic;
  final String translation;
  final String source;
  final int repeat;
  const DuaProtection({
    required this.arabic,
    required this.phonetic,
    required this.translation,
    required this.source,
    this.repeat = 1,
  });
}

class DuaCategory {
  final String id;
  final String title;
  final String emoji;
  final String description;
  final List<DuaProtection> duas;
  const DuaCategory({
    required this.id,
    required this.title,
    required this.emoji,
    required this.description,
    required this.duas,
  });
}

const kDuasProtection = <DuaCategory>[
  // 1 — PROTECTION DU MATIN
  DuaCategory(
    id: 'matin',
    title: 'Protection du Matin',
    emoji: '\uD83C\uDF05',
    description: 'Les invocations qui prot\u00e8gent jusqu\'au soir',
    duas: [
      DuaProtection(
        arabic: '\u0628\u0650\u0633\u0652\u0645\u0650 \u0627\u0644\u0644\u0651\u064E\u0647\u0650 \u0627\u0644\u0651\u064E\u0630\u0650\u064A \u0644\u064E\u0627 \u064A\u064E\u0636\u064F\u0631\u0651\u064F \u0645\u064E\u0639\u064E \u0627\u0633\u0652\u0645\u0650\u0647\u0650 \u0634\u064E\u064A\u0652\u0621\u064C \u0641\u0650\u064A \u0627\u0644\u0652\u0623\u064E\u0631\u0652\u0636\u0650 \u0648\u064E\u0644\u064E\u0627 \u0641\u0650\u064A \u0627\u0644\u0633\u0651\u064E\u0645\u064E\u0627\u0621\u0650 \u0648\u064E\u0647\u064F\u0648\u064E \u0627\u0644\u0633\u0651\u064E\u0645\u0650\u064A\u0639\u064F \u0627\u0644\u0652\u0639\u064E\u0644\u0650\u064A\u0645\u064F',
        phonetic: 'Bismillahil-ladhi la yadurru ma\'a ismihi shay\'un fil-ardi wa la fis-sama\'i wa Huwas-Sami\'ul-\'Alim',
        translation: 'Au nom d\'Allah, Celui avec le nom de Qui rien ne peut nuire sur terre ni dans le ciel, et Il est l\'Audient, l\'Omniscient.',
        source: 'Abu Dawud et Tirmidhi',
        repeat: 3,
      ),
      DuaProtection(
        arabic: '\u0623\u064E\u0639\u064F\u0648\u0630\u064F \u0628\u0650\u0643\u064E\u0644\u0650\u0645\u064E\u0627\u062A\u0650 \u0627\u0644\u0644\u0651\u064E\u0647\u0650 \u0627\u0644\u062A\u0651\u064E\u0627\u0645\u0651\u064E\u0627\u062A\u0650 \u0645\u0650\u0646\u0652 \u0634\u064E\u0631\u0651\u0650 \u0645\u064E\u0627 \u062E\u064E\u0644\u064E\u0642\u064E',
        phonetic: 'A\'udhu bi-kalimatillahit-tammati min sharri ma khalaq',
        translation: 'Je cherche protection dans les paroles parfaites d\'Allah contre le mal de ce qu\'Il a cr\u00e9\u00e9.',
        source: 'Muslim',
        repeat: 3,
      ),
      DuaProtection(
        arabic: '\u0627\u0644\u0644\u0651\u064E\u0647\u064F\u0645\u0651\u064E \u0625\u0650\u0646\u0651\u0650\u064A \u0623\u064E\u0639\u064F\u0648\u0630\u064F \u0628\u0650\u0643\u064E \u0645\u0650\u0646\u064E \u0627\u0644\u0652\u0647\u064E\u0645\u0651\u0650 \u0648\u064E\u0627\u0644\u0652\u062D\u064E\u0632\u064E\u0646\u0650 \u0648\u064E\u0627\u0644\u0652\u0639\u064E\u062C\u0652\u0632\u0650 \u0648\u064E\u0627\u0644\u0652\u0643\u064E\u0633\u064E\u0644\u0650 \u0648\u064E\u0627\u0644\u0652\u0628\u064F\u062E\u0652\u0644\u0650 \u0648\u064E\u0627\u0644\u0652\u062C\u064F\u0628\u0652\u0646\u0650 \u0648\u064E\u0636\u064E\u0644\u064E\u0639\u0650 \u0627\u0644\u062F\u0651\u064E\u064A\u0652\u0646\u0650 \u0648\u064E\u063A\u064E\u0644\u064E\u0628\u064E\u0629\u0650 \u0627\u0644\u0631\u0651\u0650\u062C\u064E\u0627\u0644\u0650',
        phonetic: 'Allahumma inni a\'udhu bika minal-hammi wal-hazan, wal-\'ajzi wal-kasal, wal-bukhli wal-jubn, wa dala\'id-dayni wa ghalabatir-rijal',
        translation: '\u00d4 Allah, je cherche protection aupr\u00e8s de Toi contre le souci et la tristesse, l\'incapacit\u00e9 et la paresse, l\'avarice et la l\u00e2chet\u00e9, le poids des dettes et la domination des hommes.',
        source: 'Bukhari',
      ),
    ],
  ),

  // 2 — PROTECTION AVANT DE DORMIR
  DuaCategory(
    id: 'sommeil',
    title: 'Avant de Dormir',
    emoji: '\uD83C\uDF19',
    description: 'Protection pendant la nuit',
    duas: [
      DuaProtection(
        arabic: '\u0628\u0650\u0627\u0633\u0652\u0645\u0650\u0643\u064E \u0627\u0644\u0644\u0651\u064E\u0647\u064F\u0645\u0651\u064E \u0623\u064E\u0645\u064F\u0648\u062A\u064F \u0648\u064E\u0623\u064E\u062D\u0652\u064A\u064E\u0627',
        phonetic: 'Bismika Allahumma amutu wa ahya',
        translation: 'En Ton nom, \u00f4 Allah, je meurs et je vis.',
        source: 'Bukhari',
      ),
      DuaProtection(
        arabic: '\u0627\u0644\u0644\u0651\u064E\u0647\u064F\u0645\u0651\u064E \u0642\u0650\u0646\u0650\u064A \u0639\u064E\u0630\u064E\u0627\u0628\u064E\u0643\u064E \u064A\u064E\u0648\u0652\u0645\u064E \u062A\u064E\u0628\u0652\u0639\u064E\u062B\u064F \u0639\u0650\u0628\u064E\u0627\u062F\u064E\u0643\u064E',
        phonetic: 'Allahumma qini \'adhabaka yawma tab\'athu \'ibadak',
        translation: '\u00d4 Allah, pr\u00e9serve-moi de Ton ch\u00e2timent le jour o\u00f9 Tu ressusciteras Tes serviteurs.',
        source: 'Abu Dawud et Tirmidhi',
      ),
      DuaProtection(
        arabic: '\u0627\u0644\u0644\u0651\u064E\u0647\u064F\u0645\u0651\u064E \u0628\u0650\u0627\u0633\u0652\u0645\u0650\u0643\u064E \u0623\u064E\u062D\u0652\u064A\u064E\u0627 \u0648\u064E\u0628\u0650\u0627\u0633\u0652\u0645\u0650\u0643\u064E \u0623\u064E\u0645\u064F\u0648\u062A\u064F',
        phonetic: 'Allahumma bismika ahya wa bismika amut',
        translation: '\u00d4 Allah, c\'est en Ton nom que je vis et c\'est en Ton nom que je meurs.',
        source: 'Bukhari et Muslim',
      ),
    ],
  ),

  // 3 — PROTECTION DE LA MAISON
  DuaCategory(
    id: 'maison',
    title: 'Prot\u00e9ger sa Maison',
    emoji: '\uD83C\uDFE0',
    description: 'Invocations en entrant et sortant de chez soi',
    duas: [
      DuaProtection(
        arabic: '\u0628\u0650\u0633\u0652\u0645\u0650 \u0627\u0644\u0644\u0651\u064E\u0647\u0650 \u0648\u064E\u0644\u064E\u062C\u0652\u0646\u064E\u0627 \u0648\u064E\u0628\u0650\u0633\u0652\u0645\u0650 \u0627\u0644\u0644\u0651\u064E\u0647\u0650 \u062E\u064E\u0631\u064E\u062C\u0652\u0646\u064E\u0627 \u0648\u064E\u0639\u064E\u0644\u064E\u0649 \u0627\u0644\u0644\u0651\u064E\u0647\u0650 \u0631\u064E\u0628\u0651\u0650\u0646\u064E\u0627 \u062A\u064E\u0648\u064E\u0643\u0651\u064E\u0644\u0652\u0646\u064E\u0627',
        phonetic: 'Bismillahi walajna wa bismillahi kharajna wa \'ala Allahi Rabbina tawakkalna',
        translation: 'Au nom d\'Allah nous entrons, au nom d\'Allah nous sortons, et en Allah notre Seigneur nous pla\u00e7ons notre confiance.',
        source: 'Abu Dawud',
      ),
      DuaProtection(
        arabic: '\u0628\u0650\u0633\u0652\u0645\u0650 \u0627\u0644\u0644\u0651\u064E\u0647\u0650 \u062A\u064E\u0648\u064E\u0643\u0651\u064E\u0644\u0652\u062A\u064F \u0639\u064E\u0644\u064E\u0649 \u0627\u0644\u0644\u0651\u064E\u0647\u0650 \u0648\u064E\u0644\u064E\u0627 \u062D\u064E\u0648\u0652\u0644\u064E \u0648\u064E\u0644\u064E\u0627 \u0642\u064F\u0648\u0651\u064E\u0629\u064E \u0625\u0650\u0644\u0651\u064E\u0627 \u0628\u0650\u0627\u0644\u0644\u0651\u064E\u0647\u0650',
        phonetic: 'Bismillahi tawakkaltu \'alallahi wa la hawla wa la quwwata illa billah',
        translation: 'Au nom d\'Allah, je place ma confiance en Allah. Il n\'y a de force ni de puissance qu\'en Allah.',
        source: 'Abu Dawud et Tirmidhi',
      ),
    ],
  ),

  // 4 — PROTECTION CONTRE LA COLÈRE
  DuaCategory(
    id: 'colere',
    title: 'Contre la Col\u00e8re',
    emoji: '\uD83D\uDE24',
    description: 'Rem\u00e8des proph\u00e9tiques contre la col\u00e8re',
    duas: [
      DuaProtection(
        arabic: '\u0623\u064E\u0639\u064F\u0648\u0630\u064F \u0628\u0650\u0627\u0644\u0644\u0651\u064E\u0647\u0650 \u0645\u0650\u0646\u064E \u0627\u0644\u0634\u0651\u064E\u064A\u0652\u0637\u064E\u0627\u0646\u0650 \u0627\u0644\u0631\u0651\u064E\u062C\u0650\u064A\u0645\u0650',
        phonetic: 'A\'udhu billahi minash-Shaytanir-rajim',
        translation: 'Je cherche refuge aupr\u00e8s d\'Allah contre Satan le maudit.',
        source: 'Bukhari et Muslim',
      ),
      DuaProtection(
        arabic: '\u0627\u0644\u0644\u0651\u064E\u0647\u064F\u0645\u0651\u064E \u0627\u063A\u0652\u0641\u0650\u0631\u0652 \u0644\u0650\u064A \u0630\u064E\u0646\u0652\u0628\u0650\u064A \u0648\u064E\u0623\u064E\u0630\u0652\u0647\u0650\u0628\u0652 \u063A\u064E\u064A\u0652\u0638\u064E \u0642\u064E\u0644\u0652\u0628\u0650\u064A \u0648\u064E\u0623\u064E\u062C\u0650\u0631\u0652\u0646\u0650\u064A \u0645\u0650\u0646\u0652 \u0645\u064F\u0636\u0650\u0644\u0651\u064E\u0627\u062A\u0650 \u0627\u0644\u0652\u0641\u0650\u062A\u064E\u0646\u0650',
        phonetic: 'Allahumma-ghfir li dhanbi wa adh-hib ghayza qalbi wa ajirni min mudillatil-fitan',
        translation: '\u00d4 Allah, pardonne-moi mes p\u00e9ch\u00e9s, \u00f4te la col\u00e8re de mon coeur et pr\u00e9serve-moi des \u00e9preuves \u00e9garantes.',
        source: 'Tabarani',
      ),
    ],
  ),

  // 5 — PROTECTION DU COUPLE
  DuaCategory(
    id: 'couple',
    title: 'Prot\u00e9ger son Couple',
    emoji: '\uD83D\uDC95',
    description: 'Contre les fitna de Shaytan dans le mariage',
    duas: [
      DuaProtection(
        arabic: '\u0627\u0644\u0644\u0651\u064E\u0647\u064F\u0645\u0651\u064E \u062C\u064E\u0646\u0651\u0650\u0628\u0652\u0646\u064E\u0627 \u0627\u0644\u0634\u0651\u064E\u064A\u0652\u0637\u064E\u0627\u0646\u064E \u0648\u064E\u062C\u064E\u0646\u0651\u0650\u0628\u0650 \u0627\u0644\u0634\u0651\u064E\u064A\u0652\u0637\u064E\u0627\u0646\u064E \u0645\u064E\u0627 \u0631\u064E\u0632\u064E\u0642\u0652\u062A\u064E\u0646\u064E\u0627',
        phonetic: 'Allahumma jannibna ash-Shaytana wa jannibish-Shaytana ma razaqtana',
        translation: '\u00d4 Allah, \u00e9loigne de nous le Shaytan et \u00e9loigne le Shaytan de ce dont Tu nous as gratifi\u00e9.',
        source: 'Bukhari et Muslim',
      ),
      DuaProtection(
        arabic: '\u0631\u064E\u0628\u0651\u064E\u0646\u064E\u0627 \u0647\u064E\u0628\u0652 \u0644\u064E\u0646\u064E\u0627 \u0645\u0650\u0646\u0652 \u0623\u064E\u0632\u0652\u0648\u064E\u0627\u062C\u0650\u0646\u064E\u0627 \u0648\u064E\u0630\u064F\u0631\u0651\u0650\u064A\u0651\u064E\u0627\u062A\u0650\u0646\u064E\u0627 \u0642\u064F\u0631\u0651\u064E\u0629\u064E \u0623\u064E\u0639\u0652\u064A\u064F\u0646\u064D \u0648\u064E\u0627\u062C\u0652\u0639\u064E\u0644\u0652\u0646\u064E\u0627 \u0644\u0650\u0644\u0652\u0645\u064F\u062A\u0651\u064E\u0642\u0650\u064A\u0646\u064E \u0625\u0650\u0645\u064E\u0627\u0645\u064B\u0627',
        phonetic: 'Rabbana hab lana min azwajina wa dhurriyyatina qurrata a\'yunin waj\'alna lil-muttaqina imama',
        translation: 'Seigneur, donne-nous en nos \u00e9pouses et notre descendance la joie des yeux, et fais de nous un guide pour les pieux.',
        source: 'Coran, Al-Furqan (25:74)',
      ),
    ],
  ),

  // 6 — PROTECTION DES ENFANTS
  DuaCategory(
    id: 'enfants',
    title: 'Prot\u00e9ger ses Enfants',
    emoji: '\uD83D\uDC76',
    description: 'Comme le Proph\u00e8te \u00a7 prot\u00e9geait ses petits-fils',
    duas: [
      DuaProtection(
        arabic: '\u0623\u064F\u0639\u064A\u0630\u064F\u0643\u064F\u0645\u064E\u0627 \u0628\u0650\u0643\u064E\u0644\u0650\u0645\u064E\u0627\u062A\u0650 \u0627\u0644\u0644\u0651\u064E\u0647\u0650 \u0627\u0644\u062A\u0651\u064E\u0627\u0645\u0651\u064E\u0629\u0650 \u0645\u0650\u0646\u0652 \u0643\u064F\u0644\u0651\u0650 \u0634\u064E\u064A\u0652\u0637\u064E\u0627\u0646\u064D \u0648\u064E\u0647\u064E\u0627\u0645\u0651\u064E\u0629\u064D \u0648\u064E\u0645\u0650\u0646\u0652 \u0643\u064F\u0644\u0651\u0650 \u0639\u064E\u064A\u0652\u0646\u064D \u0644\u064E\u0627\u0645\u0651\u064E\u0629\u064D',
        phonetic: 'U\'idhukuma bi-kalimatillahit-tammati min kulli shaytanin wa hammah, wa min kulli \'aynin lammah',
        translation: 'Je vous prot\u00e8ge par les paroles parfaites d\'Allah contre tout d\u00e9mon et toute b\u00eate venimeuse, et contre tout mauvais oeil.',
        source: 'Bukhari',
      ),
      DuaProtection(
        arabic: '\u0627\u0644\u0644\u0651\u064E\u0647\u064F\u0645\u0651\u064E \u0627\u062D\u0652\u0641\u064E\u0638\u0652\u0647\u064F\u0645\u0652 \u0645\u0650\u0646\u0652 \u0628\u064E\u064A\u0652\u0646\u0650 \u0623\u064E\u064A\u0652\u062F\u0650\u064A\u0647\u0650\u0645\u0652 \u0648\u064E\u0645\u0650\u0646\u0652 \u062E\u064E\u0644\u0652\u0641\u0650\u0647\u0650\u0645\u0652 \u0648\u064E\u0639\u064E\u0646\u0652 \u0623\u064E\u064A\u0652\u0645\u064E\u0627\u0646\u0650\u0647\u0650\u0645\u0652 \u0648\u064E\u0639\u064E\u0646\u0652 \u0634\u064E\u0645\u064E\u0627\u0626\u0650\u0644\u0650\u0647\u0650\u0645\u0652 \u0648\u064E\u0645\u0650\u0646\u0652 \u0641\u064E\u0648\u0652\u0642\u0650\u0647\u0650\u0645\u0652',
        phonetic: 'Allahumma-hfadh-hum min bayni aydihim wa min khalfihim wa \'an aymanihim wa \'an shama\'ilihim wa min fawqihim',
        translation: '\u00d4 Allah, pr\u00e9serve-les par devant, par derri\u00e8re, \u00e0 leur droite, \u00e0 leur gauche et au-dessus d\'eux.',
        source: 'Abu Dawud et Ibn Majah',
      ),
    ],
  ),

  // 7 — PROTECTION CONTRE LA PEUR
  DuaCategory(
    id: 'peur',
    title: 'Contre la Peur',
    emoji: '\uD83D\uDE28',
    description: 'Quand l\'angoisse ou la peur envahit',
    duas: [
      DuaProtection(
        arabic: '\u0644\u064E\u0627 \u0625\u0650\u0644\u064E\u0647\u064E \u0625\u0650\u0644\u0651\u064E\u0627 \u0627\u0644\u0644\u0651\u064E\u0647\u064F \u0627\u0644\u0652\u0639\u064E\u0638\u0650\u064A\u0645\u064F \u0627\u0644\u0652\u062D\u064E\u0644\u0650\u064A\u0645\u064F \u060C \u0644\u064E\u0627 \u0625\u0650\u0644\u064E\u0647\u064E \u0625\u0650\u0644\u0651\u064E\u0627 \u0627\u0644\u0644\u0651\u064E\u0647\u064F \u0631\u064E\u0628\u0651\u064F \u0627\u0644\u0652\u0639\u064E\u0631\u0652\u0634\u0650 \u0627\u0644\u0652\u0639\u064E\u0638\u0650\u064A\u0645\u0650 \u060C \u0644\u064E\u0627 \u0625\u0650\u0644\u064E\u0647\u064E \u0625\u0650\u0644\u0651\u064E\u0627 \u0627\u0644\u0644\u0651\u064E\u0647\u064F \u0631\u064E\u0628\u0651\u064F \u0627\u0644\u0633\u0651\u064E\u0645\u064E\u0627\u0648\u064E\u0627\u062A\u0650 \u0648\u064E\u0631\u064E\u0628\u0651\u064F \u0627\u0644\u0652\u0623\u064E\u0631\u0652\u0636\u0650 \u0648\u064E\u0631\u064E\u0628\u0651\u064F \u0627\u0644\u0652\u0639\u064E\u0631\u0652\u0634\u0650 \u0627\u0644\u0652\u0643\u064E\u0631\u0650\u064A\u0645\u0650',
        phonetic: 'La ilaha illallahul-\'Adhimul-Halim, la ilaha illallahu Rabbul-\'Arshil-\'Adhim, la ilaha illallahu Rabbus-samawati wa Rabbul-ardi wa Rabbul-\'Arshil-Karim',
        translation: 'Point de divinit\u00e9 \u00e0 part Allah, le Tr\u00e8s Grand, le Tr\u00e8s Doux. Point de divinit\u00e9 \u00e0 part Allah, le Seigneur du Tr\u00f4ne immense. Point de divinit\u00e9 \u00e0 part Allah, le Seigneur des cieux, de la terre et du Tr\u00f4ne g\u00e9n\u00e9reux.',
        source: 'Bukhari et Muslim',
      ),
      DuaProtection(
        arabic: '\u062D\u064E\u0633\u0652\u0628\u0650\u064A\u064E \u0627\u0644\u0644\u0651\u064E\u0647\u064F \u0644\u064E\u0627 \u0625\u0650\u0644\u064E\u0647\u064E \u0625\u0650\u0644\u0651\u064E\u0627 \u0647\u064F\u0648\u064E \u0639\u064E\u0644\u064E\u064A\u0652\u0647\u0650 \u062A\u064E\u0648\u064E\u0643\u0651\u064E\u0644\u0652\u062A\u064F \u0648\u064E\u0647\u064F\u0648\u064E \u0631\u064E\u0628\u0651\u064F \u0627\u0644\u0652\u0639\u064E\u0631\u0652\u0634\u0650 \u0627\u0644\u0652\u0639\u064E\u0638\u0650\u064A\u0645\u0650',
        phonetic: 'Hasbiyallahu la ilaha illa Huwa \'alayhi tawakkaltu wa Huwa Rabbul-\'Arshil-\'Adhim',
        translation: 'Allah me suffit. Point de divinit\u00e9 \u00e0 part Lui. En Lui je place ma confiance et Il est le Seigneur du Tr\u00f4ne immense.',
        source: 'Abu Dawud',
        repeat: 7,
      ),
    ],
  ),

  // 8 — PROTECTION CONTRE LES CAUCHEMARS
  DuaCategory(
    id: 'cauchemars',
    title: 'Contre les Cauchemars',
    emoji: '\uD83D\uDE34',
    description: 'Quand on se r\u00e9veille d\'un mauvais r\u00eave',
    duas: [
      DuaProtection(
        arabic: '\u0623\u064E\u0639\u064F\u0648\u0630\u064F \u0628\u0650\u0627\u0644\u0644\u0651\u064E\u0647\u0650 \u0645\u0650\u0646\u064E \u0627\u0644\u0634\u0651\u064E\u064A\u0652\u0637\u064E\u0627\u0646\u0650 \u0627\u0644\u0631\u0651\u064E\u062C\u0650\u064A\u0645\u0650',
        phonetic: 'A\'udhu billahi minash-Shaytanir-rajim',
        translation: 'Je cherche refuge aupr\u00e8s d\'Allah contre Satan le maudit. Puis cracher l\u00e9g\u00e8rement 3 fois \u00e0 gauche et changer de c\u00f4t\u00e9. Ne racontez le cauchemar \u00e0 personne.',
        source: 'Muslim',
        repeat: 3,
      ),
    ],
  ),

  // 9 — PROTECTION EN VOYAGE
  DuaCategory(
    id: 'voyage',
    title: 'Protection en Voyage',
    emoji: '\u2708\uFE0F',
    description: 'Invocations pour tout type de d\u00e9placement',
    duas: [
      DuaProtection(
        arabic: '\u0633\u064F\u0628\u0652\u062D\u064E\u0627\u0646\u064E \u0627\u0644\u0651\u064E\u0630\u0650\u064A \u0633\u064E\u062E\u0651\u064E\u0631\u064E \u0644\u064E\u0646\u064E\u0627 \u0647\u064E\u0640\u0630\u064E\u0627 \u0648\u064E\u0645\u064E\u0627 \u0643\u064F\u0646\u0651\u064E\u0627 \u0644\u064E\u0647\u064F \u0645\u064F\u0642\u0652\u0631\u0650\u0646\u0650\u064A\u0646\u064E \u0648\u064E\u0625\u0650\u0646\u0651\u064E\u0627 \u0625\u0650\u0644\u064E\u0649\u0670 \u0631\u064E\u0628\u0651\u0650\u0646\u064E\u0627 \u0644\u064E\u0645\u064F\u0646\u0642\u064E\u0644\u0650\u0628\u064F\u0648\u0646\u064E',
        phonetic: 'Subhanal-ladhi sakhkhara lana hadha wa ma kunna lahu muqrinin, wa inna ila Rabbina lamunqalibun',
        translation: 'Gloire \u00e0 Celui qui a mis ceci \u00e0 notre service alors que nous n\'\u00e9tions pas capables de le faire. Et c\'est vers notre Seigneur que nous retournerons.',
        source: 'Coran, Az-Zukhruf (43:13-14)',
      ),
      DuaProtection(
        arabic: '\u0627\u0644\u0644\u0651\u064E\u0647\u064F\u0645\u0651\u064E \u0625\u0650\u0646\u0651\u064E\u0627 \u0646\u064E\u0633\u0652\u0623\u064E\u0644\u064F\u0643\u064E \u0641\u0650\u064A \u0633\u064E\u0641\u064E\u0631\u0650\u0646\u064E\u0627 \u0647\u064E\u0640\u0630\u064E\u0627 \u0627\u0644\u0652\u0628\u0650\u0631\u0651\u064E \u0648\u064E\u0627\u0644\u062A\u0651\u064E\u0642\u0652\u0648\u064E\u0649\u0670 \u0648\u064E\u0645\u0650\u0646\u064E \u0627\u0644\u0652\u0639\u064E\u0645\u064E\u0644\u0650 \u0645\u064E\u0627 \u062A\u064E\u0631\u0652\u0636\u064E\u0649',
        phonetic: 'Allahumma inna nas\'aluka fi safarina hadhal-birra wat-taqwa wa minal-\'amali ma tarda',
        translation: '\u00d4 Allah, nous Te demandons dans ce voyage la pi\u00e9t\u00e9, la crainte et les actes qui Te satisfont.',
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
  final String instruction;
  final String? arabic;
  final String? phonetic;
  const SosStep({
    required this.emoji,
    required this.title,
    required this.instruction,
    this.arabic,
    this.phonetic,
  });
}

const kSosSteps = <SosStep>[
  SosStep(
    emoji: '\uD83D\uDCA7',
    title: 'Fais tes ablutions (wudu)',
    instruction: 'L\'eau \u00e9teint le feu de Shaytan. Le wudu est la premi\u00e8re barri\u00e8re. Si tu es en col\u00e8re, le wudu te calmera aussi.',
  ),
  SosStep(
    emoji: '\uD83E\uDEF6',
    title: 'Cherche refuge aupr\u00e8s d\'Allah',
    instruction: 'R\u00e9p\u00e8te cette formule 3 fois avec conviction :',
    arabic: '\u0623\u064E\u0639\u064F\u0648\u0630\u064F \u0628\u0650\u0627\u0644\u0644\u0651\u064E\u0647\u0650 \u0645\u0650\u0646\u064E \u0627\u0644\u0634\u0651\u064E\u064A\u0652\u0637\u064E\u0627\u0646\u0650 \u0627\u0644\u0631\u0651\u064E\u062C\u0650\u064A\u0645\u0650',
    phonetic: 'A\'udhu billahi minash-Shaytanir-rajim',
  ),
  SosStep(
    emoji: '\uD83D\uDC51',
    title: 'R\u00e9cite Ayat al-Kursi',
    instruction: 'R\u00e9cite Ayat al-Kursi 3 fois. C\'est le verset le plus puissant du Coran pour la protection. Aucun d\u00e9mon ne peut rester pr\u00e8s de celui qui le r\u00e9cite.',
  ),
  SosStep(
    emoji: '\uD83D\uDCD6',
    title: 'R\u00e9cite les 3 Qul',
    instruction: 'R\u00e9cite Al-Ikhlas, Al-Falaq et An-Nas, chacune 3 fois. Souffle dans tes mains apr\u00e8s chaque r\u00e9citation et passe-les sur ton corps.',
  ),
  SosStep(
    emoji: '\uD83E\uDD32',
    title: 'Invoque Allah avec cette du\'a',
    instruction: 'R\u00e9p\u00e8te cette invocation de protection :',
    arabic: '\u0628\u0650\u0633\u0652\u0645\u0650 \u0627\u0644\u0644\u0651\u064E\u0647\u0650 \u0627\u0644\u0651\u064E\u0630\u0650\u064A \u0644\u064E\u0627 \u064A\u064E\u0636\u064F\u0631\u0651\u064F \u0645\u064E\u0639\u064E \u0627\u0633\u0652\u0645\u0650\u0647\u0650 \u0634\u064E\u064A\u0652\u0621\u064C \u0641\u0650\u064A \u0627\u0644\u0652\u0623\u064E\u0631\u0652\u0636\u0650 \u0648\u064E\u0644\u064E\u0627 \u0641\u0650\u064A \u0627\u0644\u0633\u0651\u064E\u0645\u064E\u0627\u0621\u0650 \u0648\u064E\u0647\u064F\u0648\u064E \u0627\u0644\u0633\u0651\u064E\u0645\u0650\u064A\u0639\u064F \u0627\u0644\u0652\u0639\u064E\u0644\u0650\u064A\u0645\u064F',
    phonetic: 'Bismillahil-ladhi la yadurru ma\'a ismihi shay\'un fil-ardi wa la fis-sama\'i wa Huwas-Sami\'ul-\'Alim',
  ),
  SosStep(
    emoji: '\uD83D\uDE4F',
    title: 'Fais une pri\u00e8re de 2 rak\'at',
    instruction: 'Si possible, prie 2 rak\'at en demandant la protection d\'Allah. La pri\u00e8re est la connexion directe avec Allah et la plus forte protection.',
  ),
  SosStep(
    emoji: '\uD83C\uDF6F',
    title: 'Bois de l\'eau coranis\u00e9e',
    instruction: 'Si tu as de l\'eau coranis\u00e9e pr\u00e9par\u00e9e, bois-en. Sinon, r\u00e9cite sur un verre d\'eau (Fatiha + Ayat al-Kursi + les 3 Qul) et bois-le.',
  ),
  SosStep(
    emoji: '\uD83D\uDCAA',
    title: 'Rappelle-toi',
    instruction: 'Allah est plus grand que tout ce qui te fait peur. Le Shaytan est faible : \u00ab La ruse de Shaytan est certes faible \u00bb (An-Nisa, 4:76). Tu as les armes les plus puissantes : le Coran et l\'invocation. Sois patient et constant dans tes adhkar.',
  ),
];
