// journal_data.dart
// Données enrichies pour le module Journal Spirituel – Application UpYourDeen

// ── Catégories d'actions quotidiennes ─────────────────────────────

class ActionCategory {
  final String id;
  final String title;
  final String emoji;
  final List<ActionItem> actions;

  const ActionCategory({
    required this.id,
    required this.title,
    required this.emoji,
    required this.actions,
  });
}

class ActionItem {
  final String id;
  final String titre;
  final String emoji;
  final int points;
  final String? detail;

  const ActionItem({
    required this.id,
    required this.titre,
    required this.emoji,
    required this.points,
    this.detail,
  });
}

const kActionCategories = <ActionCategory>[
  ActionCategory(
    id: 'obligatoires',
    title: 'Prières obligatoires',
    emoji: '🕌',
    actions: [
      ActionItem(id: 'fajr', titre: 'Fajr (Sobh)', emoji: '🌅', points: 20),
      ActionItem(id: 'dohr', titre: 'Dohr (Midi)', emoji: '☀️', points: 20),
      ActionItem(id: 'asr', titre: 'Asr (Après-midi)', emoji: '🌤️', points: 20),
      ActionItem(id: 'maghrib', titre: 'Maghrib (Coucher)', emoji: '🌇', points: 20),
      ActionItem(id: 'icha', titre: 'Icha (Nuit)', emoji: '🌙', points: 20),
    ],
  ),
  ActionCategory(
    id: 'sunna',
    title: 'Prières surérogatoires',
    emoji: '⭐',
    actions: [
      ActionItem(id: 'rawatib', titre: 'Rawâtib (Sunna régulières)', emoji: '📿', points: 15,
          detail: '12 rak\'at : 2 avant Fajr, 4 avant/2 après Dohr, 2 après Maghrib, 2 après Icha'),
      ActionItem(id: 'duha', titre: 'Prière de Duha', emoji: '🌞', points: 10,
          detail: 'Entre le lever du soleil et le zénith, 2 à 8 rak\'at'),
      ActionItem(id: 'witr', titre: 'Prière de Witr', emoji: '🌛', points: 10,
          detail: 'Après Icha, 1 à 11 rak\'at (impair)'),
      ActionItem(id: 'tahajjud', titre: 'Tahajjud (Qiyam al-Layl)', emoji: '🌌', points: 20,
          detail: 'Dernière partie de la nuit, la meilleure prière après les obligatoires'),
    ],
  ),
  ActionCategory(
    id: 'adoration',
    title: 'Adoration & Dhikr',
    emoji: '💎',
    actions: [
      ActionItem(id: 'coran', titre: 'Lecture du Coran', emoji: '📖', points: 15),
      ActionItem(id: 'dhikr_matin', titre: 'Adhkâr du matin', emoji: '🌅', points: 10),
      ActionItem(id: 'dhikr_soir', titre: 'Adhkâr du soir', emoji: '🌇', points: 10),
      ActionItem(id: 'istighfar', titre: 'Istighfâr (100x)', emoji: '🤲', points: 10,
          detail: 'Le Prophète ﷺ demandait pardon à Allah plus de 100 fois par jour'),
      ActionItem(id: 'salawat', titre: 'Salât \'ala Nabi ﷺ', emoji: '💚', points: 10,
          detail: 'Envoyer les salutations sur le Prophète ﷺ'),
    ],
  ),
  ActionCategory(
    id: 'comportement',
    title: 'Comportement & Bienfaisance',
    emoji: '🤝',
    actions: [
      ActionItem(id: 'bonne_action', titre: 'Bonne action envers autrui', emoji: '🤝', points: 15),
      ActionItem(id: 'sadaqa', titre: 'Sadaqa (aumône)', emoji: '💰', points: 15,
          detail: 'Même un sourire est une sadaqa'),
      ActionItem(id: 'parents', titre: 'Bienfaisance envers les parents', emoji: '👨‍👩‍👧', points: 15),
      ActionItem(id: 'science', titre: 'Apprentissage religieux', emoji: '📚', points: 10),
      ActionItem(id: 'gratitude', titre: 'Gratitude exprimée', emoji: '💚', points: 10),
      ActionItem(id: 'jeune', titre: 'Jeûne surérogatoire', emoji: '🍽️', points: 20,
          detail: 'Lundi, jeudi, ou jours blancs (13-14-15 du mois lunaire)'),
    ],
  ),
];

// ── Prompts de réflexion guidée ───────────────────────────────────

class ReflectionPrompt {
  final String id;
  final String question;
  final String emoji;
  final String category; // 'gratitude', 'introspection', 'coran', 'dua', 'objectif'

  const ReflectionPrompt({
    required this.id,
    required this.question,
    required this.emoji,
    required this.category,
  });
}

const kReflectionPrompts = <ReflectionPrompt>[
  // Gratitude
  ReflectionPrompt(id: 'g1', emoji: '💚', category: 'gratitude',
      question: 'Quel bienfait d\'Allah as-tu remarqué aujourd\'hui ?'),
  ReflectionPrompt(id: 'g2', emoji: '🌿', category: 'gratitude',
      question: 'Pour quelle personne dans ta vie remercies-tu Allah ?'),
  ReflectionPrompt(id: 'g3', emoji: '🌅', category: 'gratitude',
      question: 'Quel moment de ta journée t\'a rapproché d\'Allah ?'),
  ReflectionPrompt(id: 'g4', emoji: '🤲', category: 'gratitude',
      question: 'Cite 3 choses simples dont tu es reconnaissant(e) aujourd\'hui.'),
  ReflectionPrompt(id: 'g5', emoji: '🌸', category: 'gratitude',
      question: 'Comment Allah t\'a-t-Il facilité les choses récemment ?'),

  // Introspection
  ReflectionPrompt(id: 'i1', emoji: '🪞', category: 'introspection',
      question: 'Quel péché ou mauvaise habitude aimerais-tu délaisser ?'),
  ReflectionPrompt(id: 'i2', emoji: '💭', category: 'introspection',
      question: 'Comment as-tu réagi face à une difficulté aujourd\'hui ?'),
  ReflectionPrompt(id: 'i3', emoji: '⚖️', category: 'introspection',
      question: 'As-tu contrôlé ta langue et évité la médisance aujourd\'hui ?'),
  ReflectionPrompt(id: 'i4', emoji: '🔄', category: 'introspection',
      question: 'Si tu devais refaire ta journée, que changerais-tu ?'),
  ReflectionPrompt(id: 'i5', emoji: '🎯', category: 'introspection',
      question: 'Quel effort as-tu fait aujourd\'hui pour devenir meilleur(e) ?'),

  // Coran
  ReflectionPrompt(id: 'c1', emoji: '📖', category: 'coran',
      question: 'Quel verset du Coran t\'a marqué récemment et pourquoi ?'),
  ReflectionPrompt(id: 'c2', emoji: '🌟', category: 'coran',
      question: 'Qu\'as-tu appris de nouveau dans le Coran cette semaine ?'),
  ReflectionPrompt(id: 'c3', emoji: '📝', category: 'coran',
      question: 'Comment peux-tu appliquer ce que tu as lu dans le Coran aujourd\'hui ?'),

  // Du\'a
  ReflectionPrompt(id: 'd1', emoji: '🤲', category: 'dua',
      question: 'Quelle du\'a as-tu faite aujourd\'hui avec le cœur ?'),
  ReflectionPrompt(id: 'd2', emoji: '🕊️', category: 'dua',
      question: 'Pour qui as-tu invoqué Allah aujourd\'hui ?'),

  // Objectifs
  ReflectionPrompt(id: 'o1', emoji: '🎯', category: 'objectif',
      question: 'Quel petit objectif spirituel te fixes-tu pour demain ?'),
  ReflectionPrompt(id: 'o2', emoji: '📈', category: 'objectif',
      question: 'Quel progrès spirituel as-tu fait cette semaine ?'),
  ReflectionPrompt(id: 'o3', emoji: '🏔️', category: 'objectif',
      question: 'Quel est ton plus grand objectif spirituel ce mois-ci ?'),
];

// ── Humeurs spirituelles ──────────────────────────────────────────

class MoodOption {
  final String id;
  final String emoji;
  final String label;
  final String description;

  const MoodOption({
    required this.id,
    required this.emoji,
    required this.label,
    required this.description,
  });
}

const kMoodOptions = <MoodOption>[
  MoodOption(id: 'serein', emoji: '😌', label: 'Serein',
      description: 'Cœur apaisé, confiance en Allah'),
  MoodOption(id: 'motive', emoji: '🔥', label: 'Motivé',
      description: 'Élan spirituel, envie de progresser'),
  MoodOption(id: 'reconnaissant', emoji: '🤲', label: 'Reconnaissant',
      description: 'Conscient des bienfaits d\'Allah'),
  MoodOption(id: 'distrait', emoji: '😶‍🌫️', label: 'Distrait',
      description: 'Difficile de se concentrer dans l\'adoration'),
  MoodOption(id: 'triste', emoji: '😢', label: 'Éprouvé',
      description: 'Épreuve ou tristesse, besoin de patience'),
  MoodOption(id: 'coupable', emoji: '😔', label: 'Repentant',
      description: 'Conscience d\'un manquement, envie de se repentir'),
];

// ── Données Zakat ─────────────────────────────────────────────────

class ZakatType {
  final String id;
  final String title;
  final String emoji;
  final String description;
  final double nisabOr; // en grammes d'or
  final double tauxPercent;
  final List<String> details;

  const ZakatType({
    required this.id,
    required this.title,
    required this.emoji,
    required this.description,
    required this.nisabOr,
    required this.tauxPercent,
    required this.details,
  });
}

const kZakatTypes = <ZakatType>[
  ZakatType(
    id: 'mal',
    title: 'Zakât al-Mâl',
    emoji: '💰',
    description: 'Zakat sur l\'épargne et les biens monétaires',
    nisabOr: 85.0,
    tauxPercent: 2.5,
    details: [
      'S\'applique à l\'argent épargné depuis un an lunaire (hawl)',
      'Le Nisâb est l\'équivalent de 85g d\'or ou 595g d\'argent',
      'Se calcule sur le montant total au-dessus du Nisâb',
      'Inclut : comptes bancaires, espèces, placements, actions',
    ],
  ),
  ZakatType(
    id: 'or',
    title: 'Zakât sur l\'or et l\'argent',
    emoji: '🪙',
    description: 'Zakat sur les métaux précieux et bijoux (portés ou non selon les avis)',
    nisabOr: 85.0,
    tauxPercent: 2.5,
    details: [
      'Or : Nisâb de 85 grammes',
      'Argent : Nisâb de 595 grammes',
      'Les bijoux portés quotidiennement : divergence entre savants',
      'L\'avis le plus prudent : les inclure dans le calcul',
    ],
  ),
  ZakatType(
    id: 'commerce',
    title: 'Zakât sur le commerce',
    emoji: '🏪',
    description: 'Zakat sur les marchandises destinées à la vente',
    nisabOr: 85.0,
    tauxPercent: 2.5,
    details: [
      'S\'applique aux biens achetés pour être revendus',
      'Évaluation au prix du marché au jour de la Zakat',
      'Ne s\'applique pas aux biens à usage personnel',
      'Calcul : valeur marchande des stocks × 2,5%',
    ],
  ),
  ZakatType(
    id: 'fitr',
    title: 'Zakât al-Fitr',
    emoji: '🌙',
    description: 'Aumône de la rupture du jeûne de Ramadan',
    nisabOr: 0,
    tauxPercent: 0,
    details: [
      'Obligatoire pour chaque musulman, y compris les enfants',
      'Environ 1 Sâ\' de nourriture (≈ 2,5 à 3 kg)',
      'À verser avant la prière de l\'Aïd al-Fitr',
      'Peut être donnée en nourriture ou en argent (selon les avis)',
      'Le chef de famille la verse pour tous les membres du foyer',
    ],
  ),
];

const kZakatBeneficiaries = <String>[
  'Les pauvres (al-fuqarâ\')',
  'Les nécessiteux (al-masâkîn)',
  'Les collecteurs de la Zakat (al-\'âmilîn)',
  'Ceux dont les cœurs sont à rallier (al-mu\'allafa qulûbuhum)',
  'L\'affranchissement des esclaves (ar-riqâb)',
  'Les endettés (al-ghârimîn)',
  'Dans le sentier d\'Allah (fî sabîli-Llâh)',
  'Le voyageur en détresse (ibn as-sabîl)',
];

// ── Paliers de streaks ────────────────────────────────────────────

class StreakMilestone {
  final int days;
  final String emoji;
  final String title;
  final String hadith;

  const StreakMilestone({
    required this.days,
    required this.emoji,
    required this.title,
    required this.hadith,
  });
}

const kStreakMilestones = <StreakMilestone>[
  StreakMilestone(days: 3, emoji: '🌱', title: 'Graine plantée',
      hadith: 'Les actions les plus aimées d\'Allah sont les plus régulières, même si elles sont peu nombreuses.'),
  StreakMilestone(days: 7, emoji: '🌿', title: 'Première semaine',
      hadith: 'Quiconque accomplit une bonne action, Allah la lui multiplie par dix.'),
  StreakMilestone(days: 14, emoji: '🌳', title: 'Deux semaines',
      hadith: 'La patience est lumière. — Muslim'),
  StreakMilestone(days: 21, emoji: '⭐', title: 'Habitude forgée',
      hadith: 'L\'homme le plus aimé d\'Allah est celui qui est le plus utile aux gens.'),
  StreakMilestone(days: 30, emoji: '🏅', title: 'Un mois complet',
      hadith: 'Quiconque jeûne Ramadan puis le fait suivre de six jours de Shawwâl, c\'est comme s\'il avait jeûné toute l\'année.'),
  StreakMilestone(days: 40, emoji: '🏆', title: 'Quarantaine prophétique',
      hadith: 'Quiconque est sincère avec Allah pendant 40 jours, les sources de sagesse jaillissent de son cœur vers sa langue.'),
  StreakMilestone(days: 90, emoji: '👑', title: 'Trois mois de constance',
      hadith: 'Certes, après la difficulté vient la facilité. — Coran, 94:6'),
  StreakMilestone(days: 180, emoji: '💎', title: 'Six mois de lumière',
      hadith: 'Allah ne change pas l\'état d\'un peuple tant qu\'ils ne changent pas ce qui est en eux. — Coran, 13:11'),
  StreakMilestone(days: 365, emoji: '🕋', title: 'Une année complète',
      hadith: 'Le croyant fort est meilleur et plus aimé d\'Allah que le croyant faible. — Muslim'),
];

// ── Objectifs prédéfinis ──────────────────────────────────────────

class GoalTemplate {
  final String id;
  final String title;
  final String emoji;
  final String category; // 'coran', 'priere', 'comportement', 'science'

  const GoalTemplate({
    required this.id,
    required this.title,
    required this.emoji,
    required this.category,
  });
}

const kGoalTemplates = <GoalTemplate>[
  GoalTemplate(id: 'khatm', title: 'Terminer le Coran (Khatm)', emoji: '📖', category: 'coran'),
  GoalTemplate(id: 'hifz_mulk', title: 'Mémoriser Sourate Al-Mulk', emoji: '📝', category: 'coran'),
  GoalTemplate(id: 'hifz_kahf', title: 'Mémoriser Sourate Al-Kahf', emoji: '📝', category: 'coran'),
  GoalTemplate(id: 'hifz_juz', title: 'Mémoriser Juz\' Amma', emoji: '🌟', category: 'coran'),
  GoalTemplate(id: 'duha_30', title: 'Prier Duha 30 jours d\'affilée', emoji: '🌞', category: 'priere'),
  GoalTemplate(id: 'tahajjud_7', title: 'Tahajjud 7 nuits consécutives', emoji: '🌌', category: 'priere'),
  GoalTemplate(id: 'rawatib', title: 'Prier toutes les Rawâtib pendant 1 mois', emoji: '⭐', category: 'priere'),
  GoalTemplate(id: 'langue', title: 'Pas de médisance pendant 7 jours', emoji: '🤐', category: 'comportement'),
  GoalTemplate(id: 'sadaqa_7', title: 'Donner une sadaqa chaque jour pendant 7 jours', emoji: '💰', category: 'comportement'),
  GoalTemplate(id: 'parents', title: 'Appeler ses parents chaque jour', emoji: '📞', category: 'comportement'),
  GoalTemplate(id: 'hadith_30', title: 'Apprendre 1 hadith par jour pendant 30 jours', emoji: '📚', category: 'science'),
  GoalTemplate(id: 'noms_allah', title: 'Apprendre les 99 Noms d\'Allah', emoji: '💎', category: 'science'),
];

// ── Causes de dons (Sadaqa) ───────────────────────────────────────

class DonCause {
  final String id;
  final String title;
  final String emoji;
  final String description;
  final String hadith;

  const DonCause({
    required this.id,
    required this.title,
    required this.emoji,
    required this.description,
    required this.hadith,
  });
}

const kDonCauses = <DonCause>[
  DonCause(
    id: 'orphelins',
    title: 'Orphelins',
    emoji: '👶',
    description: 'Parrainer ou nourrir un orphelin',
    hadith: 'Moi et celui qui prend soin d\'un orphelin serons comme ceux-ci au Paradis — et il montra ses deux doigts. — Bukhari',
  ),
  DonCause(
    id: 'mosquee',
    title: 'Construction de mosquée',
    emoji: '🕌',
    description: 'Contribuer à la construction ou l\'entretien d\'une mosquée',
    hadith: 'Quiconque construit une mosquée pour Allah, Allah lui construira une maison au Paradis. — Muslim',
  ),
  DonCause(
    id: 'puits',
    title: 'Eau / Puits',
    emoji: '💧',
    description: 'Creuser un puits ou fournir de l\'eau potable',
    hadith: 'La meilleure aumône est de donner de l\'eau à boire. — Ahmad',
  ),
  DonCause(
    id: 'nourriture',
    title: 'Nourrir les gens',
    emoji: '🍞',
    description: 'Distribuer de la nourriture aux nécessiteux',
    hadith: 'Nourrissez celui qui a faim, visitez le malade et libérez le prisonnier. — Bukhari',
  ),
  DonCause(
    id: 'science',
    title: 'Science / Éducation',
    emoji: '📚',
    description: 'Financer l\'éducation ou la diffusion du savoir',
    hadith: 'Quiconque emprunte un chemin pour chercher la science, Allah lui facilite un chemin vers le Paradis. — Muslim',
  ),
  DonCause(
    id: 'sadaqa_jariya',
    title: 'Sadaqa Jariya',
    emoji: '♾️',
    description: 'Aumône continue dont les bénéfices perdurent',
    hadith: 'Quand le fils d\'Adam meurt, ses actions cessent sauf trois : une aumône continue, une science bénéfique, un enfant pieux qui invoque pour lui. — Muslim',
  ),
  DonCause(
    id: 'vetements',
    title: 'Vêtements',
    emoji: '👕',
    description: 'Donner des vêtements aux nécessiteux',
    hadith: 'Quiconque habille un musulman qui était nu, Allah l\'habillera des vêtements verts du Paradis. — Tirmidhi',
  ),
  DonCause(
    id: 'malades',
    title: 'Soins aux malades',
    emoji: '🏥',
    description: 'Aider à financer les soins médicaux des plus démunis',
    hadith: 'Allah dira le Jour du Jugement : J\'étais malade et tu ne M\'as pas rendu visite. — Muslim',
  ),
];

// ── Hadiths sur la générosité ─────────────────────────────────────

const kGenerosityHadiths = <String>[
  'La main qui donne est meilleure que la main qui reçoit. — Bukhari & Muslim',
  'Protégez-vous du Feu, ne serait-ce qu\'avec la moitié d\'une datte. — Bukhari',
  'L\'aumône n\'a jamais diminué une richesse. — Muslim',
  'Chaque jour, deux anges descendent et l\'un dit : Ô Allah, donne à celui qui dépense une compensation. Et l\'autre dit : Ô Allah, donne à celui qui retient la ruine. — Bukhari',
  'Le croyant est à l\'ombre de son aumône le Jour du Jugement. — Ahmad',
  'Celui qui nourrit un jeûneur aura la même récompense que lui. — Tirmidhi',
  'Souriez à votre frère, c\'est une aumône. — Tirmidhi',
  'L\'homme généreux est proche d\'Allah, proche du Paradis, proche des gens et éloigné de l\'Enfer. — Tirmidhi',
];

// ── Messages bienveillants ────────────────────────────────────────

const kWelcomeBackMessages = <String>[
  'Content de te revoir ! Le repentir efface ce qui précède. Recommence doucement, Allah est Le Tout-Miséricordieux.',
  'Tu es de retour, al-hamdulillah ! Chaque jour est une nouvelle chance offerte par Allah.',
  'Le simple fait d\'ouvrir cette application est une bonne intention. Allah voit tes efforts.',
  'Ne sois pas dur(e) avec toi-même. Le Prophète ﷺ a dit : Facilitez et ne rendez pas les choses difficiles.',
  'Bienvenue ! Souviens-toi : Allah aime les actions régulières, même petites.',
];

const kLowScoreMessages = <String>[
  'Chaque petit pas compte. Allah ne regarde pas la quantité mais la sincérité du cœur.',
  'Ne te décourage pas. Le Prophète ﷺ a dit : Les actions les plus aimées d\'Allah sont les plus régulières, même si elles sont peu nombreuses.',
  'Même un sourire est une sadaqa. Ta journée n\'est pas perdue.',
  'Certes, avec la difficulté vient la facilité. Demain sera meilleur, in sha Allah.',
  'Allah sait ce que tu traverses. Ta simple intention de vouloir faire mieux est déjà récompensée.',
];

const kHighScoreMessages = <String>[
  'ماشاءالله ! Excellente journée spirituelle ! Qu\'Allah accepte tes efforts.',
  'Bârak Allahu fîk ! Tu es un exemple de constance. Continue ainsi !',
  'Superbe journée ! Le Prophète ﷺ serait fier de ta régularité.',
  'Al-hamdulillah, quelle belle journée ! Qu\'Allah te bénisse et t\'accorde encore plus.',
  'ماشاءالله, tu rayonnes ! N\'oublie pas de remercier Allah pour cette énergie spirituelle.',
];

const kLetterReminders = <String>[
  'Tu as écrit une lettre à toi-même il y a 30 jours. Veux-tu la relire pour voir ton évolution ?',
  'Un message de ton « toi du passé » t\'attend. Prends un moment pour le relire.',
  'Il y a un mois, tu t\'es écrit une lettre. C\'est le moment de découvrir ce que tu ressentais.',
];
