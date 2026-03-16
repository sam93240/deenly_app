// journal_data.dart
// Données enrichies pour le module Journal Spirituel – Application UpYourDeen

import 'app_locale.dart';

// ── Catégories d'actions quotidiennes ─────────────────────────────

class ActionCategory {
  final String id;
  final String title;
  final String titleEn;
  final String emoji;
  final List<ActionItem> actions;

  const ActionCategory({
    required this.id,
    required this.title,
    required this.titleEn,
    required this.emoji,
    required this.actions,
  });

  String get displayTitle => AppLocale().isFrench ? title : titleEn;
}

class ActionItem {
  final String id;
  final String titre;
  final String titreEn;
  final String emoji;
  final int points;
  final String? detail;
  final String? detailEn;

  const ActionItem({
    required this.id,
    required this.titre,
    required this.titreEn,
    required this.emoji,
    required this.points,
    this.detail,
    this.detailEn,
  });

  String get displayTitre => AppLocale().isFrench ? titre : titreEn;
  String? get displayDetail => AppLocale().isFrench ? detail : detailEn;
}

const kActionCategories = <ActionCategory>[
  ActionCategory(
    id: 'obligatoires',
    title: 'Prières obligatoires',
    titleEn: 'Obligatory Prayers',
    emoji: '🕌',
    actions: [
      ActionItem(id: 'fajr', titre: 'Fajr (Sobh)', titreEn: 'Fajr (Dawn)', emoji: '🌅', points: 20),
      ActionItem(id: 'dohr', titre: 'Dohr (Midi)', titreEn: 'Dohr (Noon)', emoji: '☀️', points: 20),
      ActionItem(id: 'asr', titre: 'Asr (Après-midi)', titreEn: 'Asr (Afternoon)', emoji: '🌤️', points: 20),
      ActionItem(id: 'maghrib', titre: 'Maghrib (Coucher)', titreEn: 'Maghrib (Sunset)', emoji: '🌇', points: 20),
      ActionItem(id: 'icha', titre: 'Icha (Nuit)', titreEn: 'Isha (Night)', emoji: '🌙', points: 20),
    ],
  ),
  ActionCategory(
    id: 'sunna',
    title: 'Prières surérogatoires',
    titleEn: 'Supererogatory Prayers',
    emoji: '⭐',
    actions: [
      ActionItem(id: 'rawatib', titre: 'Rawâtib (Sunna régulières)', titreEn: 'Rawatib (Regular Sunnah)', emoji: '📿', points: 15,
          detail: '12 rak\'at : 2 avant Fajr, 4 avant/2 après Dohr, 2 après Maghrib, 2 après Icha',
          detailEn: '12 rak\'ahs: 2 before Fajr, 4 before/2 after Dohr, 2 after Maghrib, 2 after Isha'),
      ActionItem(id: 'duha', titre: 'Prière de Duha', titreEn: 'Duha Prayer', emoji: '🌞', points: 10,
          detail: 'Entre le lever du soleil et le zénith, 2 à 8 rak\'at',
          detailEn: 'Between sunrise and noon, 2 to 8 rak\'ahs'),
      ActionItem(id: 'witr', titre: 'Prière de Witr', titreEn: 'Witr Prayer', emoji: '🌛', points: 10,
          detail: 'Après Icha, 1 à 11 rak\'at (impair)',
          detailEn: 'After Isha, 1 to 11 rak\'ahs (odd number)'),
      ActionItem(id: 'tahajjud', titre: 'Tahajjud (Qiyam al-Layl)', titreEn: 'Tahajjud (Night Prayer)', emoji: '🌌', points: 20,
          detail: 'Dernière partie de la nuit, la meilleure prière après les obligatoires',
          detailEn: 'Last part of the night, the best prayer after obligatory ones'),
    ],
  ),
  ActionCategory(
    id: 'adoration',
    title: 'Adoration & Dhikr',
    titleEn: 'Worship & Dhikr',
    emoji: '💎',
    actions: [
      ActionItem(id: 'coran', titre: 'Lecture du Coran', titreEn: 'Quran Recitation', emoji: '📖', points: 15),
      ActionItem(id: 'dhikr_matin', titre: 'Adhkâr du matin', titreEn: 'Morning Adhkar', emoji: '🌅', points: 10),
      ActionItem(id: 'dhikr_soir', titre: 'Adhkâr du soir', titreEn: 'Evening Adhkar', emoji: '🌇', points: 10),
      ActionItem(id: 'istighfar', titre: 'Istighfâr (100x)', titreEn: 'Istighfar (100x)', emoji: '🤲', points: 10,
          detail: 'Le Prophète ﷺ demandait pardon à Allah plus de 100 fois par jour',
          detailEn: 'The Prophet ﷺ asked forgiveness from Allah more than 100 times daily'),
      ActionItem(id: 'salawat', titre: 'Salât \'ala Nabi ﷺ', titreEn: 'Salah upon the Prophet ﷺ', emoji: '💚', points: 10,
          detail: 'Envoyer les salutations sur le Prophète ﷺ',
          detailEn: 'Send blessings upon the Prophet ﷺ'),
    ],
  ),
  ActionCategory(
    id: 'comportement',
    title: 'Comportement & Bienfaisance',
    titleEn: 'Behavior & Kindness',
    emoji: '🤝',
    actions: [
      ActionItem(id: 'bonne_action', titre: 'Bonne action envers autrui', titreEn: 'Good deed toward others', emoji: '🤝', points: 15),
      ActionItem(id: 'sadaqa', titre: 'Sadaqa (aumône)', titreEn: 'Sadaqa (charity)', emoji: '💰', points: 15,
          detail: 'Même un sourire est une sadaqa',
          detailEn: 'Even a smile is sadaqa'),
      ActionItem(id: 'parents', titre: 'Bienfaisance envers les parents', titreEn: 'Kindness to parents', emoji: '👨‍👩‍👧', points: 15),
      ActionItem(id: 'science', titre: 'Apprentissage religieux', titreEn: 'Religious learning', emoji: '📚', points: 10),
      ActionItem(id: 'gratitude', titre: 'Gratitude exprimée', titreEn: 'Expressed gratitude', emoji: '💚', points: 10),
      ActionItem(id: 'jeune', titre: 'Jeûne surérogatoire', titreEn: 'Supererogatory fasting', emoji: '🍽️', points: 20,
          detail: 'Lundi, jeudi, ou jours blancs (13-14-15 du mois lunaire)',
          detailEn: 'Monday, Thursday, or white days (13-14-15 of lunar month)'),
    ],
  ),
];

// ── Prompts de réflexion guidée ───────────────────────────────────

class ReflectionPrompt {
  final String id;
  final String question;
  final String questionEn;
  final String emoji;
  final String category; // 'gratitude', 'introspection', 'coran', 'dua', 'objectif'

  const ReflectionPrompt({
    required this.id,
    required this.question,
    required this.questionEn,
    required this.emoji,
    required this.category,
  });

  String get displayQuestion => AppLocale().isFrench ? question : questionEn;
}

const kReflectionPrompts = <ReflectionPrompt>[
  // Gratitude
  ReflectionPrompt(id: 'g1', emoji: '💚', category: 'gratitude',
      question: 'Quel bienfait d\'Allah as-tu remarqué aujourd\'hui ?',
      questionEn: 'What blessing from Allah did you notice today?'),
  ReflectionPrompt(id: 'g2', emoji: '🌿', category: 'gratitude',
      question: 'Pour quelle personne dans ta vie remercies-tu Allah ?',
      questionEn: 'For whom in your life do you thank Allah?'),
  ReflectionPrompt(id: 'g3', emoji: '🌅', category: 'gratitude',
      question: 'Quel moment de ta journée t\'a rapproché d\'Allah ?',
      questionEn: 'Which moment of your day brought you closer to Allah?'),
  ReflectionPrompt(id: 'g4', emoji: '🤲', category: 'gratitude',
      question: 'Cite 3 choses simples dont tu es reconnaissant(e) aujourd\'hui.',
      questionEn: 'Name 3 simple things you are grateful for today.'),
  ReflectionPrompt(id: 'g5', emoji: '🌸', category: 'gratitude',
      question: 'Comment Allah t\'a-t-Il facilité les choses récemment ?',
      questionEn: 'How has Allah made things easy for you recently?'),

  // Introspection
  ReflectionPrompt(id: 'i1', emoji: '🪞', category: 'introspection',
      question: 'Quel péché ou mauvaise habitude aimerais-tu délaisser ?',
      questionEn: 'What sin or bad habit would you like to leave behind?'),
  ReflectionPrompt(id: 'i2', emoji: '💭', category: 'introspection',
      question: 'Comment as-tu réagi face à une difficulté aujourd\'hui ?',
      questionEn: 'How did you react to a difficulty today?'),
  ReflectionPrompt(id: 'i3', emoji: '⚖️', category: 'introspection',
      question: 'As-tu contrôlé ta langue et évité la médisance aujourd\'hui ?',
      questionEn: 'Did you control your tongue and avoid backbiting today?'),
  ReflectionPrompt(id: 'i4', emoji: '🔄', category: 'introspection',
      question: 'Si tu devais refaire ta journée, que changerais-tu ?',
      questionEn: 'If you could redo your day, what would you change?'),
  ReflectionPrompt(id: 'i5', emoji: '🎯', category: 'introspection',
      question: 'Quel effort as-tu fait aujourd\'hui pour devenir meilleur(e) ?',
      questionEn: 'What effort did you make today to become better?'),

  // Coran
  ReflectionPrompt(id: 'c1', emoji: '📖', category: 'coran',
      question: 'Quel verset du Coran t\'a marqué récemment et pourquoi ?',
      questionEn: 'What Quranic verse has touched you recently and why?'),
  ReflectionPrompt(id: 'c2', emoji: '🌟', category: 'coran',
      question: 'Qu\'as-tu appris de nouveau dans le Coran cette semaine ?',
      questionEn: 'What new thing did you learn from the Quran this week?'),
  ReflectionPrompt(id: 'c3', emoji: '📝', category: 'coran',
      question: 'Comment peux-tu appliquer ce que tu as lu dans le Coran aujourd\'hui ?',
      questionEn: 'How can you apply what you read in the Quran today?'),

  // Du'a
  ReflectionPrompt(id: 'd1', emoji: '🤲', category: 'dua',
      question: 'Quelle du\'a as-tu faite aujourd\'hui avec le cœur ?',
      questionEn: 'What du\'a did you make today with your heart?'),
  ReflectionPrompt(id: 'd2', emoji: '🕊️', category: 'dua',
      question: 'Pour qui as-tu invoqué Allah aujourd\'hui ?',
      questionEn: 'For whom did you invoke Allah today?'),

  // Objectives
  ReflectionPrompt(id: 'o1', emoji: '🎯', category: 'objectif',
      question: 'Quel petit objectif spirituel te fixes-tu pour demain ?',
      questionEn: 'What small spiritual goal do you set for tomorrow?'),
  ReflectionPrompt(id: 'o2', emoji: '📈', category: 'objectif',
      question: 'Quel progrès spirituel as-tu fait cette semaine ?',
      questionEn: 'What spiritual progress have you made this week?'),
  ReflectionPrompt(id: 'o3', emoji: '🏔️', category: 'objectif',
      question: 'Quel est ton plus grand objectif spirituel ce mois-ci ?',
      questionEn: 'What is your biggest spiritual goal this month?'),
];

// ── Humeurs spirituelles ──────────────────────────────────────────

class MoodOption {
  final String id;
  final String emoji;
  final String label;
  final String labelEn;
  final String description;
  final String descriptionEn;

  const MoodOption({
    required this.id,
    required this.emoji,
    required this.label,
    required this.labelEn,
    required this.description,
    required this.descriptionEn,
  });

  String get displayLabel => AppLocale().isFrench ? label : labelEn;
  String get displayDescription => AppLocale().isFrench ? description : descriptionEn;
}

const kMoodOptions = <MoodOption>[
  MoodOption(id: 'serein', emoji: '😌', label: 'Serein', labelEn: 'Peaceful',
      description: 'Cœur apaisé, confiance en Allah', descriptionEn: 'Peaceful heart, trust in Allah'),
  MoodOption(id: 'motive', emoji: '🔥', label: 'Motivé', labelEn: 'Motivated',
      description: 'Élan spirituel, envie de progresser', descriptionEn: 'Spiritual drive, eager to progress'),
  MoodOption(id: 'reconnaissant', emoji: '🤲', label: 'Reconnaissant', labelEn: 'Grateful',
      description: 'Conscient des bienfaits d\'Allah', descriptionEn: 'Aware of Allah\'s blessings'),
  MoodOption(id: 'distrait', emoji: '😶‍🌫️', label: 'Distrait', labelEn: 'Distracted',
      description: 'Difficile de se concentrer dans l\'adoration', descriptionEn: 'Struggling to focus in worship'),
  MoodOption(id: 'triste', emoji: '😢', label: 'Éprouvé', labelEn: 'Tested',
      description: 'Épreuve ou tristesse, besoin de patience', descriptionEn: 'Trial or sadness, need patience'),
  MoodOption(id: 'coupable', emoji: '😔', label: 'Repentant', labelEn: 'Repentant',
      description: 'Conscience d\'un manquement, envie de se repentir', descriptionEn: 'Aware of shortcoming, wanting to repent'),
];

// ── Données Zakat ─────────────────────────────────────────────────

class ZakatType {
  final String id;
  final String title;
  final String titleEn;
  final String emoji;
  final String description;
  final String descriptionEn;
  final double nisabOr; // en grammes d'or
  final double tauxPercent;
  final List<String> details;
  final List<String> detailsEn;

  const ZakatType({
    required this.id,
    required this.title,
    required this.titleEn,
    required this.emoji,
    required this.description,
    required this.descriptionEn,
    required this.nisabOr,
    required this.tauxPercent,
    required this.details,
    required this.detailsEn,
  });

  String get displayTitle => AppLocale().isFrench ? title : titleEn;
  String get displayDescription => AppLocale().isFrench ? description : descriptionEn;
  List<String> get displayDetails => AppLocale().isFrench ? details : detailsEn;
}

const kZakatTypes = <ZakatType>[
  ZakatType(
    id: 'mal',
    title: 'Zakât al-Mâl',
    titleEn: 'Zakat al-Maal',
    emoji: '💰',
    description: 'Zakat sur l\'épargne et les biens monétaires',
    descriptionEn: 'Zakat on savings and monetary wealth',
    nisabOr: 85.0,
    tauxPercent: 2.5,
    details: [
      'S\'applique à l\'argent épargné depuis un an lunaire (hawl)',
      'Le Nisâb est l\'équivalent de 85g d\'or ou 595g d\'argent',
      'Se calcule sur le montant total au-dessus du Nisâb',
      'Inclut : comptes bancaires, espèces, placements, actions',
    ],
    detailsEn: [
      'Applies to money saved for one lunar year (hawl)',
      'The Nisab is equivalent to 85g of gold or 595g of silver',
      'Calculated on the total amount above the Nisab',
      'Includes: bank accounts, cash, investments, stocks',
    ],
  ),
  ZakatType(
    id: 'or',
    title: 'Zakât sur l\'or et l\'argent',
    titleEn: 'Zakat on Gold and Silver',
    emoji: '🪙',
    description: 'Zakat sur les métaux précieux et bijoux (portés ou non selon les avis)',
    descriptionEn: 'Zakat on precious metals and jewelry (worn or not according to scholarly views)',
    nisabOr: 85.0,
    tauxPercent: 2.5,
    details: [
      'Or : Nisâb de 85 grammes',
      'Argent : Nisâb de 595 grammes',
      'Les bijoux portés quotidiennement : divergence entre savants',
      'L\'avis le plus prudent : les inclure dans le calcul',
    ],
    detailsEn: [
      'Gold: Nisab of 85 grams',
      'Silver: Nisab of 595 grams',
      'Daily worn jewelry: scholars differ on this',
      'The most prudent view: include them in calculation',
    ],
  ),
  ZakatType(
    id: 'commerce',
    title: 'Zakât sur le commerce',
    titleEn: 'Zakat on Commerce',
    emoji: '🏪',
    description: 'Zakat sur les marchandises destinées à la vente',
    descriptionEn: 'Zakat on merchandise intended for sale',
    nisabOr: 85.0,
    tauxPercent: 2.5,
    details: [
      'S\'applique aux biens achetés pour être revendus',
      'Évaluation au prix du marché au jour de la Zakat',
      'Ne s\'applique pas aux biens à usage personnel',
      'Calcul : valeur marchande des stocks × 2,5%',
    ],
    detailsEn: [
      'Applies to goods purchased for resale',
      'Evaluation at market price on zakat day',
      'Does not apply to goods for personal use',
      'Calculation: market value of inventory × 2.5%',
    ],
  ),
  ZakatType(
    id: 'fitr',
    title: 'Zakât al-Fitr',
    titleEn: 'Zakat al-Fitr',
    emoji: '🌙',
    description: 'Aumône de la rupture du jeûne de Ramadan',
    descriptionEn: 'Charity at the end of Ramadan fast',
    nisabOr: 0,
    tauxPercent: 0,
    details: [
      'Obligatoire pour chaque musulman, y compris les enfants',
      'Environ 1 Sâ\' de nourriture (≈ 2,5 à 3 kg)',
      'À verser avant la prière de l\'Aïd al-Fitr',
      'Peut être donnée en nourriture ou en argent (selon les avis)',
      'Le chef de famille la verse pour tous les membres du foyer',
    ],
    detailsEn: [
      'Mandatory for every Muslim, including children',
      'Approximately 1 Sa\' of food (≈ 2.5 to 3 kg)',
      'Must be given before Eid al-Fitr prayer',
      'Can be given in food or money (according to scholarly views)',
      'The head of household gives it for all family members',
    ],
  ),
];

class ZakatBeneficiary {
  final String nameFr;
  final String nameEn;

  const ZakatBeneficiary({required this.nameFr, required this.nameEn});

  String get displayName => AppLocale().isFrench ? nameFr : nameEn;
}

const kZakatBeneficiaries = <ZakatBeneficiary>[
  ZakatBeneficiary(nameFr: 'Les pauvres (al-fuqarâ\')', nameEn: 'The poor (al-fuqara)'),
  ZakatBeneficiary(nameFr: 'Les nécessiteux (al-masâkîn)', nameEn: 'The needy (al-masakin)'),
  ZakatBeneficiary(nameFr: 'Les collecteurs de la Zakat (al-\'âmilîn)', nameEn: 'Zakat collectors (al-amilin)'),
  ZakatBeneficiary(nameFr: 'Ceux dont les cœurs sont à rallier (al-mu\'allafa qulûbuhum)', nameEn: 'Those whose hearts are to be reconciled (al-muallafa qulubuhum)'),
  ZakatBeneficiary(nameFr: 'L\'affranchissement des esclaves (ar-riqâb)', nameEn: 'Freeing of slaves (ar-riqab)'),
  ZakatBeneficiary(nameFr: 'Les endettés (al-ghârimîn)', nameEn: 'The debtors (al-gharimin)'),
  ZakatBeneficiary(nameFr: 'Dans le sentier d\'Allah (fî sabîli-Llâh)', nameEn: 'In the path of Allah (fi sabilillah)'),
  ZakatBeneficiary(nameFr: 'Le voyageur en détresse (ibn as-sabîl)', nameEn: 'The wayfarer (ibn al-sabil)'),
];

// ── Paliers de streaks ────────────────────────────────────────────

class StreakMilestone {
  final int days;
  final String emoji;
  final String title;
  final String titleEn;
  final String hadith;
  final String hadithEn;

  const StreakMilestone({
    required this.days,
    required this.emoji,
    required this.title,
    required this.titleEn,
    required this.hadith,
    required this.hadithEn,
  });

  String get displayTitle => AppLocale().isFrench ? title : titleEn;
  String get displayHadith => AppLocale().isFrench ? hadith : hadithEn;
}

const kStreakMilestones = <StreakMilestone>[
  StreakMilestone(days: 3, emoji: '🌱', title: 'Graine plantée', titleEn: 'Seed Planted',
      hadith: 'Les actions les plus aimées d\'Allah sont les plus régulières, même si elles sont peu nombreuses.',
      hadithEn: 'The most beloved deeds to Allah are the most consistent, even if they are few.'),
  StreakMilestone(days: 7, emoji: '🌿', title: 'Première semaine', titleEn: 'First Week',
      hadith: 'Quiconque accomplit une bonne action, Allah la lui multiplie par dix.',
      hadithEn: 'Whoever does a good deed, Allah multiplies it for them tenfold.'),
  StreakMilestone(days: 14, emoji: '🌳', title: 'Deux semaines', titleEn: 'Two Weeks',
      hadith: 'La patience est lumière. — Muslim',
      hadithEn: 'Patience is light. — Muslim'),
  StreakMilestone(days: 21, emoji: '⭐', title: 'Habitude forgée', titleEn: 'Habit Forged',
      hadith: 'L\'homme le plus aimé d\'Allah est celui qui est le plus utile aux gens.',
      hadithEn: 'The person most beloved to Allah is the one most beneficial to others.'),
  StreakMilestone(days: 30, emoji: '🏅', title: 'Un mois complet', titleEn: 'Full Month',
      hadith: 'Quiconque jeûne Ramadan puis le fait suivre de six jours de Shawwâl, c\'est comme s\'il avait jeûné toute l\'année.',
      hadithEn: 'Whoever fasts Ramadan and then six days of Shawwal, it is as if they fasted the whole year.'),
  StreakMilestone(days: 40, emoji: '🏆', title: 'Quarantaine prophétique', titleEn: 'Prophetic Forty',
      hadith: 'Quiconque est sincère avec Allah pendant 40 jours, les sources de sagesse jaillissent de son cœur vers sa langue.',
      hadithEn: 'Whoever is sincere with Allah for 40 days, the springs of wisdom flow from their heart to their tongue.'),
  StreakMilestone(days: 90, emoji: '👑', title: 'Trois mois de constance', titleEn: 'Three Months Strong',
      hadith: 'Certes, après la difficulté vient la facilité. — Coran, 94:6',
      hadithEn: 'Indeed, with hardship comes ease. — Quran, 94:5'),
  StreakMilestone(days: 180, emoji: '💎', title: 'Six mois de lumière', titleEn: 'Six Months of Light',
      hadith: 'Allah ne change pas l\'état d\'un peuple tant qu\'ils ne changent pas ce qui est en eux. — Coran, 13:11',
      hadithEn: 'Allah does not change the condition of a people until they change what is in themselves. — Quran, 13:11'),
  StreakMilestone(days: 365, emoji: '🕋', title: 'Une année complète', titleEn: 'One Year Complete',
      hadith: 'Le croyant fort est meilleur et plus aimé d\'Allah que le croyant faible. — Muslim',
      hadithEn: 'The strong believer is better and more beloved to Allah than the weak believer. — Muslim'),
];

// ── Objectifs prédéfinis ──────────────────────────────────────────

class GoalTemplate {
  final String id;
  final String title;
  final String titleEn;
  final String emoji;
  final String category; // 'coran', 'priere', 'comportement', 'science'

  const GoalTemplate({
    required this.id,
    required this.title,
    required this.titleEn,
    required this.emoji,
    required this.category,
  });

  String get displayTitle => AppLocale().isFrench ? title : titleEn;
}

const kGoalTemplates = <GoalTemplate>[
  GoalTemplate(id: 'khatm', title: 'Terminer le Coran (Khatm)', titleEn: 'Complete the Quran (Khatm)', emoji: '📖', category: 'coran'),
  GoalTemplate(id: 'hifz_mulk', title: 'Mémoriser Sourate Al-Mulk', titleEn: 'Memorize Surah Al-Mulk', emoji: '📝', category: 'coran'),
  GoalTemplate(id: 'hifz_kahf', title: 'Mémoriser Sourate Al-Kahf', titleEn: 'Memorize Surah Al-Kahf', emoji: '📝', category: 'coran'),
  GoalTemplate(id: 'hifz_juz', title: 'Mémoriser Juz\' Amma', titleEn: 'Memorize Juz\' Amma', emoji: '🌟', category: 'coran'),
  GoalTemplate(id: 'duha_30', title: 'Prier Duha 30 jours d\'affilée', titleEn: 'Pray Duha for 30 consecutive days', emoji: '🌞', category: 'priere'),
  GoalTemplate(id: 'tahajjud_7', title: 'Tahajjud 7 nuits consécutives', titleEn: 'Tahajjud for 7 consecutive nights', emoji: '🌌', category: 'priere'),
  GoalTemplate(id: 'rawatib', title: 'Prier toutes les Rawâtib pendant 1 mois', titleEn: 'Pray all Rawatib for 1 month', emoji: '⭐', category: 'priere'),
  GoalTemplate(id: 'langue', title: 'Pas de médisance pendant 7 jours', titleEn: 'No backbiting for 7 days', emoji: '🤐', category: 'comportement'),
  GoalTemplate(id: 'sadaqa_7', title: 'Donner une sadaqa chaque jour pendant 7 jours', titleEn: 'Give sadaqa every day for 7 days', emoji: '💰', category: 'comportement'),
  GoalTemplate(id: 'parents', title: 'Appeler ses parents chaque jour', titleEn: 'Call your parents every day', emoji: '📞', category: 'comportement'),
  GoalTemplate(id: 'hadith_30', title: 'Apprendre 1 hadith par jour pendant 30 jours', titleEn: 'Learn 1 hadith per day for 30 days', emoji: '📚', category: 'science'),
  GoalTemplate(id: 'noms_allah', title: 'Apprendre les 99 Noms d\'Allah', titleEn: 'Learn the 99 Names of Allah', emoji: '💎', category: 'science'),
];

// ── Causes de dons (Sadaqa) ───────────────────────────────────────

class DonCause {
  final String id;
  final String title;
  final String titleEn;
  final String emoji;
  final String description;
  final String descriptionEn;
  final String hadith;
  final String hadithEn;

  const DonCause({
    required this.id,
    required this.title,
    required this.titleEn,
    required this.emoji,
    required this.description,
    required this.descriptionEn,
    required this.hadith,
    required this.hadithEn,
  });

  String get displayTitle => AppLocale().isFrench ? title : titleEn;
  String get displayDescription => AppLocale().isFrench ? description : descriptionEn;
  String get displayHadith => AppLocale().isFrench ? hadith : hadithEn;
}

const kDonCauses = <DonCause>[
  DonCause(
    id: 'orphelins',
    title: 'Orphelins',
    titleEn: 'Orphans',
    emoji: '👶',
    description: 'Parrainer ou nourrir un orphelin',
    descriptionEn: 'Sponsor or feed an orphan',
    hadith: 'Moi et celui qui prend soin d\'un orphelin serons comme ceux-ci au Paradis — et il montra ses deux doigts. — Bukhari',
    hadithEn: 'I and the guardian of an orphan will be like these two in Paradise — and he pointed his two fingers. — Bukhari',
  ),
  DonCause(
    id: 'mosquee',
    title: 'Construction de mosquée',
    titleEn: 'Building a Mosque',
    emoji: '🕌',
    description: 'Contribuer à la construction ou l\'entretien d\'une mosquée',
    descriptionEn: 'Contribute to the construction or maintenance of a mosque',
    hadith: 'Quiconque construit une mosquée pour Allah, Allah lui construira une maison au Paradis. — Muslim',
    hadithEn: 'Whoever builds a mosque for Allah, Allah will build for him a house in Paradise. — Muslim',
  ),
  DonCause(
    id: 'puits',
    title: 'Eau / Puits',
    titleEn: 'Water / Well',
    emoji: '💧',
    description: 'Creuser un puits ou fournir de l\'eau potable',
    descriptionEn: 'Dig a well or provide clean drinking water',
    hadith: 'La meilleure aumône est de donner de l\'eau à boire. — Ahmad',
    hadithEn: 'The best charity is to provide water to drink. — Ahmad',
  ),
  DonCause(
    id: 'nourriture',
    title: 'Nourrir les gens',
    titleEn: 'Feed People',
    emoji: '🍞',
    description: 'Distribuer de la nourriture aux nécessiteux',
    descriptionEn: 'Distribute food to the needy',
    hadith: 'Nourrissez celui qui a faim, visitez le malade et libérez le prisonnier. — Bukhari',
    hadithEn: 'Feed the hungry, visit the sick, and free the captive. — Bukhari',
  ),
  DonCause(
    id: 'science',
    title: 'Science / Éducation',
    titleEn: 'Knowledge / Education',
    emoji: '📚',
    description: 'Financer l\'éducation ou la diffusion du savoir',
    descriptionEn: 'Finance education or spread knowledge',
    hadith: 'Quiconque emprunte un chemin pour chercher la science, Allah lui facilite un chemin vers le Paradis. — Muslim',
    hadithEn: 'Whoever takes a path seeking knowledge, Allah will ease a path to Paradise for them. — Muslim',
  ),
  DonCause(
    id: 'sadaqa_jariya',
    title: 'Sadaqa Jariya',
    titleEn: 'Sadaqa Jariya',
    emoji: '♾️',
    description: 'Aumône continue dont les bénéfices perdurent',
    descriptionEn: 'Ongoing charity whose benefits continue',
    hadith: 'Quand le fils d\'Adam meurt, ses actions cessent sauf trois : une aumône continue, une science bénéfique, un enfant pieux qui invoque pour lui. — Muslim',
    hadithEn: 'When the son of Adam dies, his deeds cease except three: ongoing charity, beneficial knowledge, and a righteous child who prays for him. — Muslim',
  ),
  DonCause(
    id: 'vetements',
    title: 'Vêtements',
    titleEn: 'Clothing',
    emoji: '👕',
    description: 'Donner des vêtements aux nécessiteux',
    descriptionEn: 'Give clothing to the needy',
    hadith: 'Quiconque habille un musulman qui était nu, Allah l\'habillera des vêtements verts du Paradis. — Tirmidhi',
    hadithEn: 'Whoever clothes a Muslim who was naked, Allah will clothe him with the green garments of Paradise. — Tirmidhi',
  ),
  DonCause(
    id: 'malades',
    title: 'Soins aux malades',
    titleEn: 'Healthcare',
    emoji: '🏥',
    description: 'Aider à financer les soins médicaux des plus démunis',
    descriptionEn: 'Help fund medical care for the most vulnerable',
    hadith: 'Allah dira le Jour du Jugement : J\'étais malade et tu ne M\'as pas rendu visite. — Muslim',
    hadithEn: 'Allah will say on the Day of Judgment: I was sick and you did not visit Me. — Muslim',
  ),
];

// ── Hadiths sur la générosité ─────────────────────────────────────

class GenerosityHadith {
  final String textFr;
  final String textEn;

  const GenerosityHadith({required this.textFr, required this.textEn});

  String get displayText => AppLocale().isFrench ? textFr : textEn;
}

const kGenerosityHadiths = <GenerosityHadith>[
  GenerosityHadith(
    textFr: 'La main qui donne est meilleure que la main qui reçoit. — Bukhari & Muslim',
    textEn: 'The giving hand is better than the receiving hand. — Bukhari & Muslim',
  ),
  GenerosityHadith(
    textFr: 'Protégez-vous du Feu, ne serait-ce qu\'avec la moitié d\'une datte. — Bukhari',
    textEn: 'Protect yourself from the Fire, even with half a date. — Bukhari',
  ),
  GenerosityHadith(
    textFr: 'L\'aumône n\'a jamais diminué une richesse. — Muslim',
    textEn: 'Charity never decreases wealth. — Muslim',
  ),
  GenerosityHadith(
    textFr: 'Chaque jour, deux anges descendent et l\'un dit : Ô Allah, donne à celui qui dépense une compensation. Et l\'autre dit : Ô Allah, donne à celui qui retient la ruine. — Bukhari',
    textEn: 'Every day two angels descend, one says: O Allah, give to the one who spends. The other says: O Allah, give destruction to the one who withholds. — Bukhari',
  ),
  GenerosityHadith(
    textFr: 'Le croyant est à l\'ombre de son aumône le Jour du Jugement. — Ahmad',
    textEn: 'The believer is in the shade of his charity on the Day of Judgment. — Ahmad',
  ),
  GenerosityHadith(
    textFr: 'Celui qui nourrit un jeûneur aura la même récompense que lui. — Tirmidhi',
    textEn: 'Whoever feeds a fasting person will have the same reward as them. — Tirmidhi',
  ),
  GenerosityHadith(
    textFr: 'Souriez à votre frère, c\'est une aumône. — Tirmidhi',
    textEn: 'Smile at your brother, for that is charity. — Tirmidhi',
  ),
  GenerosityHadith(
    textFr: 'L\'homme généreux est proche d\'Allah, proche du Paradis, proche des gens et éloigné de l\'Enfer. — Tirmidhi',
    textEn: 'The generous person is close to Allah, close to Paradise, close to people, and far from the Fire. — Tirmidhi',
  ),
];

// ── Messages bienveillants ────────────────────────────────────────

class WelcomeBackMessage {
  final String messageFr;
  final String messageEn;

  const WelcomeBackMessage({required this.messageFr, required this.messageEn});

  String get displayMessage => AppLocale().isFrench ? messageFr : messageEn;
}

const kWelcomeBackMessages = <WelcomeBackMessage>[
  WelcomeBackMessage(
    messageFr: 'Content de te revoir ! Le repentir efface ce qui précède. Recommence doucement, Allah est Le Tout-Miséricordieux.',
    messageEn: 'Glad to see you again! Repentance wipes away the past. Start gently, Allah is the Most Merciful.',
  ),
  WelcomeBackMessage(
    messageFr: 'Tu es de retour, al-hamdulillah ! Chaque jour est une nouvelle chance offerte par Allah.',
    messageEn: 'Welcome back, alhamdulillah! Every day is a new chance given by Allah.',
  ),
  WelcomeBackMessage(
    messageFr: 'Le simple fait d\'ouvrir cette application est une bonne intention. Allah voit tes efforts.',
    messageEn: 'Simply opening this app is a good intention. Allah sees your efforts.',
  ),
  WelcomeBackMessage(
    messageFr: 'Ne sois pas dur(e) avec toi-même. Le Prophète ﷺ a dit : Facilitez et ne rendez pas les choses difficiles.',
    messageEn: 'Do not be hard on yourself. The Prophet ﷺ said: Make things easy and do not make them difficult.',
  ),
  WelcomeBackMessage(
    messageFr: 'Bienvenue ! Souviens-toi : Allah aime les actions régulières, même petites.',
    messageEn: 'Welcome! Remember: Allah loves consistent actions, even if small.',
  ),
];

class EncouragingMessage {
  final String messageFr;
  final String messageEn;

  const EncouragingMessage({required this.messageFr, required this.messageEn});

  String get displayMessage => AppLocale().isFrench ? messageFr : messageEn;
}

const kLowScoreMessages = <EncouragingMessage>[
  EncouragingMessage(
    messageFr: 'Chaque petit pas compte. Allah ne regarde pas la quantité mais la sincérité du cœur.',
    messageEn: 'Every small step counts. Allah looks not at quantity but at sincerity of the heart.',
  ),
  EncouragingMessage(
    messageFr: 'Ne te décourage pas. Le Prophète ﷺ a dit : Les actions les plus aimées d\'Allah sont les plus régulières, même si elles sont peu nombreuses.',
    messageEn: 'Do not despair. The Prophet ﷺ said: The deeds most beloved to Allah are the most consistent, even if few.',
  ),
  EncouragingMessage(
    messageFr: 'Même un sourire est une sadaqa. Ta journée n\'est pas perdue.',
    messageEn: 'Even a smile is sadaqa. Your day is not lost.',
  ),
  EncouragingMessage(
    messageFr: 'Certes, avec la difficulté vient la facilité. Demain sera meilleur, in sha Allah.',
    messageEn: 'Indeed, with hardship comes ease. Tomorrow will be better, insha\'Allah.',
  ),
  EncouragingMessage(
    messageFr: 'Allah sait ce que tu traverses. Ta simple intention de vouloir faire mieux est déjà récompensée.',
    messageEn: 'Allah knows what you are going through. Your intention to do better is already rewarded.',
  ),
];

const kHighScoreMessages = <EncouragingMessage>[
  EncouragingMessage(
    messageFr: 'Mashaa\'Allah ! Excellente journée spirituelle ! Qu\'Allah accepte tes efforts.',
    messageEn: 'Mashaa\'Allah! Excellent spiritual day! May Allah accept your efforts.',
  ),
  EncouragingMessage(
    messageFr: 'Bârak Allahu fîk ! Tu es un exemple de constance. Continue ainsi !',
    messageEn: 'Barak Allahu feek! You are an example of consistency. Keep going!',
  ),
  EncouragingMessage(
    messageFr: 'Superbe journée ! Le Prophète ﷺ serait fier de ta régularité.',
    messageEn: 'Amazing day! The Prophet ﷺ would be proud of your consistency.',
  ),
  EncouragingMessage(
    messageFr: 'Al-hamdulillah, quelle belle journée ! Qu\'Allah te bénisse et t\'accorde encore plus.',
    messageEn: 'Alhamdulillah, what a beautiful day! May Allah bless you and grant you more.',
  ),
  EncouragingMessage(
    messageFr: 'Mashaa\'Allah, tu rayonnes ! N\'oublie pas de remercier Allah pour cette énergie spirituelle.',
    messageEn: 'Mashaa\'Allah, you are glowing! Do not forget to thank Allah for this spiritual energy.',
  ),
];

class LetterReminder {
  final String messageFr;
  final String messageEn;

  const LetterReminder({required this.messageFr, required this.messageEn});

  String get displayMessage => AppLocale().isFrench ? messageFr : messageEn;
}

const kLetterReminders = <LetterReminder>[
  LetterReminder(
    messageFr: 'Tu as écrit une lettre à toi-même il y a 30 jours. Veux-tu la relire pour voir ton évolution ?',
    messageEn: 'You wrote yourself a letter 30 days ago. Would you like to reread it to see your progress?',
  ),
  LetterReminder(
    messageFr: 'Un message de ton « toi du passé » t\'attend. Prends un moment pour le relire.',
    messageEn: 'A message from your "past self" awaits you. Take a moment to reread it.',
  ),
  LetterReminder(
    messageFr: 'Il y a un mois, tu t\'es écrit une lettre. C\'est le moment de découvrir ce que tu ressentais.',
    messageEn: 'A month ago, you wrote yourself a letter. It is time to discover what you felt.',
  ),
];
