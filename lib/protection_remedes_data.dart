// protection_remedes_data.dart — Remèdes Prophétiques (At-Tibb An-Nabawi)

class RemedeProphetique {
  final String id;
  final String name;
  final String emoji;
  final String arabicName;
  final String description;
  final String hadith;
  final String hadithSource;
  final String utilisation;
  final List<String> bienfaits;
  const RemedeProphetique({
    required this.id,
    required this.name,
    required this.emoji,
    required this.arabicName,
    required this.description,
    required this.hadith,
    required this.hadithSource,
    required this.utilisation,
    required this.bienfaits,
  });
}

const kRemedesProphetiques = <RemedeProphetique>[
  // 1 — MIEL
  RemedeProphetique(
    id: 'miel',
    name: 'Le Miel',
    emoji: '\uD83C\uDF6F',
    arabicName: '\u0627\u0644\u0639\u0633\u0644',
    description: 'Le miel est mentionn\u00e9 dans le Coran comme une gu\u00e9rison pour les hommes. Allah dit : \u00ab De leurs ventres sort une boisson aux couleurs vari\u00e9es, dans laquelle il y a une gu\u00e9rison pour les gens \u00bb (An-Nahl, 16:69). Le Proph\u00e8te \u00a7 consommait r\u00e9guli\u00e8rement du miel et le recommandait comme rem\u00e8de.',
    hadith: 'Un homme vint voir le Proph\u00e8te \u00a7 et lui dit : \u00ab Mon fr\u00e8re a mal au ventre. \u00bb Le Proph\u00e8te \u00a7 dit : \u00ab Donne-lui du miel \u00e0 boire. \u00bb',
    hadithSource: 'Bukhari et Muslim',
    utilisation: 'Prendre une cuill\u00e8re de miel pur le matin \u00e0 jeun avec de l\'eau ti\u00e8de. Peut aussi \u00eatre m\u00e9lang\u00e9 \u00e0 l\'eau coranis\u00e9e ou avec de la graine de nigelle. \u00c9viter de le chauffer au-dessus de 40\u00b0C pour pr\u00e9server ses propri\u00e9t\u00e9s.',
    bienfaits: [
      'Gu\u00e9rison g\u00e9n\u00e9rale mentionn\u00e9e dans le Coran',
      'Renforce le syst\u00e8me immunitaire',
      'Antiseptique et antibact\u00e9rien naturel',
      'Apaise les maux d\'estomac et de gorge',
      'Aide \u00e0 la cicatrisation des blessures',
    ],
  ),

  // 2 — GRAINE DE NIGELLE (Habba Sawda)
  RemedeProphetique(
    id: 'nigelle',
    name: 'La Graine de Nigelle',
    emoji: '\u26AB',
    arabicName: '\u0627\u0644\u062D\u0628\u0629 \u0627\u0644\u0633\u0648\u062F\u0627\u0621',
    description: 'La graine de nigelle (habba sawda ou cumin noir) est consid\u00e9r\u00e9e comme l\'un des rem\u00e8des les plus puissants de la m\u00e9decine proph\u00e9tique. Le Proph\u00e8te \u00a7 a affirm\u00e9 qu\'elle gu\u00e9rit de toute maladie sauf la mort.',
    hadith: 'Le Proph\u00e8te \u00a7 a dit : \u00ab Utilisez la graine noire car elle contient un rem\u00e8de pour toute maladie, sauf la mort (as-sam). \u00bb',
    hadithSource: 'Bukhari et Muslim',
    utilisation: 'Prendre une cuill\u00e8re \u00e0 caf\u00e9 de graines de nigelle moul\u00e9es chaque matin \u00e0 jeun, m\u00e9lang\u00e9e \u00e0 du miel ou de l\'eau ti\u00e8de. L\'huile de nigelle peut \u00eatre appliqu\u00e9e en massage sur les zones douloureuses ou utilis\u00e9e en inhalation.',
    bienfaits: [
      'Rem\u00e8de universel selon le hadith du Proph\u00e8te \u00a7',
      'Renforce les d\u00e9fenses immunitaires',
      'Propri\u00e9t\u00e9s anti-inflammatoires',
      'Aide \u00e0 la digestion',
      'Assainit les voies respiratoires',
      'Utile dans le traitement du sihr et du \'ayn (avec roqya)',
    ],
  ),

  // 3 — HIJAMA (Ventouses)
  RemedeProphetique(
    id: 'hijama',
    name: 'La Hijama',
    emoji: '\uD83E\uDE78',
    arabicName: '\u0627\u0644\u062D\u062C\u0627\u0645\u0629',
    description: 'La hijama (th\u00e9rapie par ventouses) est l\'un des rem\u00e8des les plus recommand\u00e9s par le Proph\u00e8te \u00a7. Elle consiste \u00e0 extraire du sang \u00ab mauvais \u00bb de zones sp\u00e9cifiques du corps \u00e0 l\'aide de ventouses. Le Proph\u00e8te \u00a7 l\'a pratiqu\u00e9e r\u00e9guli\u00e8rement.',
    hadith: 'Le Proph\u00e8te \u00a7 a dit : \u00ab Le meilleur des rem\u00e8des que vous puissiez utiliser est la hijama. \u00bb',
    hadithSource: 'Bukhari et Muslim',
    utilisation: 'Doit \u00eatre pratiqu\u00e9e par un professionnel qualifi\u00e9 dans des conditions d\'hygi\u00e8ne strictes. Les jours recommand\u00e9s sont les 17, 19 et 21 du mois lunaire. Se fait \u00e0 jeun ou au moins 2h apr\u00e8s un repas. Particuli\u00e8rement recommand\u00e9e en cas de sihr ou de \'ayn, en compl\u00e9ment de la roqya.',
    bienfaits: [
      'Meilleur rem\u00e8de selon le Proph\u00e8te \u00a7',
      'Purifie le sang des toxines',
      'Soulage les douleurs chroniques',
      'Am\u00e9liore la circulation sanguine',
      'Utile contre les effets du sihr (sorcellerie)',
      'Renforce le syst\u00e8me immunitaire',
    ],
  ),

  // 4 — EAU DE ZAMZAM
  RemedeProphetique(
    id: 'zamzam',
    name: 'L\'Eau de Zamzam',
    emoji: '\uD83D\uDCA7',
    arabicName: '\u0645\u0627\u0621 \u0632\u0645\u0632\u0645',
    description: 'L\'eau de Zamzam est l\'eau la plus sacr\u00e9e en Islam. Elle jaillit d\'un puits pr\u00e8s de la Ka\'ba \u00e0 la Mecque depuis l\'\u00e9poque d\'Isma\'il (\u0639\u0644\u064A\u0647 \u0627\u0644\u0633\u0644\u0627\u0645) et sa m\u00e8re Hajar. Le Proph\u00e8te \u00a7 l\'a d\u00e9crite comme une eau b\u00e9nie et une nourriture.',
    hadith: 'Le Proph\u00e8te \u00a7 a dit : \u00ab L\'eau de Zamzam est pour ce pour quoi elle est bue. \u00bb',
    hadithSource: 'Ahmad et Ibn Majah',
    utilisation: 'Boire avec l\'intention de gu\u00e9rison, en invoquant Allah. On peut r\u00e9citer le Coran dessus (eau coranis\u00e9e de Zamzam) pour un effet d\u00e9cupl\u00e9. Le Proph\u00e8te \u00a7 en buvait et s\'en aspergeait. Se boit face \u00e0 la Qibla en invoquant Allah.',
    bienfaits: [
      'Gu\u00e9rison li\u00e9e \u00e0 l\'intention de celui qui la boit',
      'Nourriture et sati\u00e9t\u00e9',
      'Eau b\u00e9nie par Allah depuis des mill\u00e9naires',
      'Utilis\u00e9e dans le traitement du sihr et du \'ayn',
      'Propri\u00e9t\u00e9s min\u00e9rales uniques',
    ],
  ),

  // 5 — HUILE D'OLIVE
  RemedeProphetique(
    id: 'olive',
    name: 'L\'Huile d\'Olive',
    emoji: '\uD83E\uDED2',
    arabicName: '\u0632\u064A\u062A \u0627\u0644\u0632\u064A\u062A\u0648\u0646',
    description: 'L\'olivier est un arbre b\u00e9ni mentionn\u00e9 dans le Coran. Allah jure par lui : \u00ab Par le figuier et l\'olivier \u00bb (At-Tin, 95:1). Le Proph\u00e8te \u00a7 a recommand\u00e9 de consommer l\'huile d\'olive et de s\'en enduire.',
    hadith: 'Le Proph\u00e8te \u00a7 a dit : \u00ab Mangez de l\'huile d\'olive et enduisez-vous en, car elle provient d\'un arbre b\u00e9ni. \u00bb',
    hadithSource: 'Tirmidhi et Ibn Majah',
    utilisation: 'Consommer 1 \u00e0 2 cuill\u00e8res \u00e0 soupe par jour, de pr\u00e9f\u00e9rence extra-vierge et press\u00e9e \u00e0 froid. Peut \u00eatre utilis\u00e9e en massage sur la peau et les cheveux. On peut r\u00e9citer le Coran sur l\'huile et s\'en enduire comme compl\u00e9ment de la roqya.',
    bienfaits: [
      'Arbre b\u00e9ni mentionn\u00e9 dans le Coran',
      'Prot\u00e8ge le coeur et les art\u00e8res',
      'Riche en antioxydants',
      'Nourrit la peau et les cheveux',
      'Propri\u00e9t\u00e9s anti-inflammatoires',
    ],
  ),

  // 6 — DATTES AJWA
  RemedeProphetique(
    id: 'ajwa',
    name: 'Les Dattes Ajwa',
    emoji: '\uD83C\uDF34',
    arabicName: '\u062A\u0645\u0631 \u0627\u0644\u0639\u062C\u0648\u0629',
    description: 'Les dattes Ajwa sont des dattes sp\u00e9cifiques de M\u00e9dine. Le Proph\u00e8te \u00a7 leur a accord\u00e9 un statut particulier comme protection contre le poison et la sorcellerie. Elles sont consid\u00e9r\u00e9es comme un aliment du Paradis.',
    hadith: 'Le Proph\u00e8te \u00a7 a dit : \u00ab Celui qui mange le matin sept dattes Ajwa ne sera touch\u00e9 ni par le poison ni par la sorcellerie ce jour-l\u00e0. \u00bb',
    hadithSource: 'Bukhari et Muslim',
    utilisation: 'Manger 7 dattes Ajwa chaque matin \u00e0 jeun. Elles doivent provenir de M\u00e9dine pour b\u00e9n\u00e9ficier de la protection mentionn\u00e9e dans le hadith. Si les Ajwa ne sont pas disponibles, certains savants recommandent les dattes de M\u00e9dine en g\u00e9n\u00e9ral.',
    bienfaits: [
      'Protection contre le poison et la sorcellerie',
      'Riches en nutriments essentiels',
      '\u00c9nergie naturelle et saine',
      'Renforcent le syst\u00e8me immunitaire',
      'Recommandation directe du Proph\u00e8te \u00a7',
    ],
  ),

  // 7 — SIDR (Jujubier)
  RemedeProphetique(
    id: 'sidr',
    name: 'Le Sidr (Jujubier)',
    emoji: '\uD83C\uDF3F',
    arabicName: '\u0627\u0644\u0633\u062F\u0631',
    description: 'Le sidr (jujubier) est un arbre mentionn\u00e9 dans le Coran (Sidrat al-Muntaha, le Lotus de la limite). Ses feuilles sont utilis\u00e9es dans le traitement de la sorcellerie et la purification spirituelle.',
    hadith: 'Le Proph\u00e8te \u00a7 a prescrit le bain avec les feuilles de sidr pour le d\u00e9funt et pour la purification. Les savants l\'ont recommand\u00e9 pour le traitement du sihr.',
    hadithSource: 'Bukhari et Muslim (pour la toilette du d\u00e9funt)',
    utilisation: 'Piler 7 feuilles de sidr vertes, les mettre dans de l\'eau, r\u00e9citer dessus les versets de roqya (Fatiha, Ayat al-Kursi, Mu\'awwidhat, versets anti-sihr), puis boire une partie de l\'eau et se laver avec le reste. R\u00e9p\u00e9ter pendant 7 jours pour le traitement du sihr.',
    bienfaits: [
      'Arbre b\u00e9ni mentionn\u00e9 dans le Coran',
      'Puissant contre la sorcellerie',
      'Purification spirituelle et physique',
      'Utilis\u00e9 pour le bain de roqya',
      'Propri\u00e9t\u00e9s antiseptiques naturelles',
    ],
  ),

  // 8 — EAU CORANISÉE
  RemedeProphetique(
    id: 'eau_coranisee',
    name: 'L\'Eau Coranis\u00e9e',
    emoji: '\uD83C\uDFFA',
    arabicName: '\u0627\u0644\u0645\u0627\u0621 \u0627\u0644\u0645\u0642\u0631\u0648\u0621 \u0639\u0644\u064A\u0647',
    description: 'L\'eau coranis\u00e9e est de l\'eau sur laquelle on a r\u00e9cit\u00e9 le Coran. Cette pratique est attest\u00e9e par la Sunna et recommand\u00e9e par les savants de l\'Islam pour la gu\u00e9rison. L\'eau capte la baraka de la r\u00e9citation coranique.',
    hadith: 'Le Proph\u00e8te \u00a7 soufflait dans l\'eau apr\u00e8s avoir r\u00e9cit\u00e9 et la donnait \u00e0 boire au malade. Ibn al-Qayyim a valid\u00e9 cette pratique comme faisant partie de la m\u00e9decine proph\u00e9tique.',
    hadithSource: 'Rapport\u00e9 dans plusieurs recueils',
    utilisation: 'Prendre de l\'eau propre (id\u00e9alement de Zamzam), r\u00e9citer dessus les versets de roqya (Fatiha, Ayat al-Kursi, les 3 Qul, versets anti-sihr), souffler l\u00e9g\u00e8rement dans l\'eau, puis la boire ou s\'en laver. Peut \u00eatre conserv\u00e9e et bue progressivement.',
    bienfaits: [
      'Gu\u00e9rison par la Parole d\'Allah',
      'Facile \u00e0 pr\u00e9parer soi-m\u00eame',
      'Boire et se laver pour double effet',
      'Compl\u00e9ment essentiel de la roqya',
      'Peut \u00eatre combin\u00e9e avec le miel ou le sidr',
    ],
  ),

  // 9 — TALBINA
  RemedeProphetique(
    id: 'talbina',
    name: 'La Talbina',
    emoji: '\uD83E\uDD63',
    arabicName: '\u0627\u0644\u062A\u0644\u0628\u064A\u0646\u0629',
    description: 'La talbina est une bouillie d\'orge m\u00e9lang\u00e9e \u00e0 du miel. Le Proph\u00e8te \u00a7 la recommandait particuli\u00e8rement pour les personnes en deuil ou tristes. Elle a un effet apaisant sur le coeur.',
    hadith: 'Aisha (qu\'Allah soit satisfait d\'elle) rapporte que le Proph\u00e8te \u00a7 a dit : \u00ab La talbina apaise le coeur du malade et dissipe une partie du chagrin. \u00bb',
    hadithSource: 'Bukhari et Muslim',
    utilisation: 'M\u00e9langer de la farine d\'orge avec de l\'eau, cuire \u00e0 feu doux jusqu\'\u00e0 obtenir une bouillie onctueuse, puis ajouter du miel et \u00e9ventuellement du lait. Consommer ti\u00e8de, particuli\u00e8rement en p\u00e9riode de tristesse, d\'anxi\u00e9t\u00e9 ou de maladie.',
    bienfaits: [
      'Apaise le coeur et dissipe le chagrin',
      'Recommand\u00e9e par le Proph\u00e8te \u00a7 pour les malades',
      'Riche en fibres et nutriments',
      'Facile \u00e0 dig\u00e9rer',
      'Effet r\u00e9confortant et nourrissant',
    ],
  ),

  // 10 — COSTUS MARIN (Qist al-Hindi)
  RemedeProphetique(
    id: 'costus',
    name: 'Le Costus Marin',
    emoji: '\uD83C\uDF3E',
    arabicName: '\u0627\u0644\u0642\u0633\u0637 \u0627\u0644\u0647\u0646\u062F\u064A',
    description: 'Le costus marin (Qist al-Hindi) est une plante dont la racine est utilis\u00e9e en m\u00e9decine proph\u00e9tique. Le Proph\u00e8te \u00a7 l\'a recommand\u00e9 comme rem\u00e8de contenant sept gu\u00e9risons.',
    hadith: 'Le Proph\u00e8te \u00a7 a dit : \u00ab Utilisez ce bois indien (costus) car il contient sept gu\u00e9risons. On l\'inhale par le nez pour la pleur\u00e9sie et on le met dans la bouche pour l\'amygdalite. \u00bb',
    hadithSource: 'Bukhari',
    utilisation: 'En inhalation nasale : m\u00e9langer la poudre de costus avec de l\'huile d\'olive et instiller dans le nez. En boisson : infuser la poudre dans de l\'eau chaude. En application locale : m\u00e9langer avec du miel. Peut aussi \u00eatre utilis\u00e9 en fumigation.',
    bienfaits: [
      'Sept gu\u00e9risons selon le Proph\u00e8te \u00a7',
      'Traite les infections respiratoires',
      'Renforce le syst\u00e8me immunitaire',
      'Propri\u00e9t\u00e9s anti-inflammatoires puissantes',
      'Utilis\u00e9 en compl\u00e9ment de la roqya',
    ],
  ),
];
