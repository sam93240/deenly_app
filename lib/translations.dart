// translations.dart
// Traductions centralisées FR / EN pour UpYourDeen
// Utiliser : context.t.settingsTitle ou T.of(context).settingsTitle

import 'package:flutter/material.dart';
import 'app_locale.dart';

class T {
  final AppLanguage _lang;
  T._(this._lang);

  factory T.of(BuildContext context) {
    return T._(AppLocaleScope.of(context).language);
  }

  bool get isFr => _lang == AppLanguage.fr;

  String _s(String fr, String en) => isFr ? fr : en;

  // ══════════════════════════════════════════════
  // APP GÉNÉRAL
  // ══════════════════════════════════════════════
  String get appName => 'UpYourDeen';
  String get appTagline => _s('Élève ta foi', 'Elevate your faith');
  String get appSlogan => _s('Lumière sur ta foi', 'Light on your faith');

  // ══════════════════════════════════════════════
  // NAVIGATION (BottomNav)
  // ══════════════════════════════════════════════
  String get navHome => _s('Accueil', 'Home');
  String get navQuran => _s('Coran', 'Quran');
  String get navLearn => _s('Apprendre', 'Learn');
  String get navHadith => _s('Hadiths', 'Hadith');
  String get navJournal => _s('Journal', 'Journal');

  // ══════════════════════════════════════════════
  // HOME SCREEN
  // ══════════════════════════════════════════════
  String get homeQuickAccess => _s('Accès rapide', 'Quick access');
  String get homeQuickAccessSub => _s('Tes outils du quotidien', 'Your daily tools');
  String get homeExplore => _s('Explorer', 'Explore');
  String get homeAllModules => _s('Tous les modules', 'All modules');

  // ══════════════════════════════════════════════
  // SETTINGS SCREEN
  // ══════════════════════════════════════════════
  String get settingsTitle => _s('Paramètres', 'Settings');
  String get settingsAppearance => _s('Apparence', 'Appearance');
  String get settingsDarkMode => _s('Mode sombre', 'Dark mode');
  String get settingsDarkModeSub => _s('Repose tes yeux la nuit', 'Rest your eyes at night');
  String get settingsLanguage => _s('Langue', 'Language');
  String get settingsLanguageSub => _s('Choisir la langue de l\'application', 'Choose app language');
  String get settingsFrench => _s('Français', 'French');
  String get settingsEnglish => _s('Anglais', 'English');
  String get settingsPrivacy => _s('Confidentialité', 'Privacy');
  String get settingsAnalytics => _s('Données d\'usage anonymes', 'Anonymous usage data');
  String get settingsAnalyticsSub => _s('Aide-nous à améliorer UpYourDeen', 'Help us improve UpYourDeen');
  String get settingsPrivacyPolicy => _s('Politique de confidentialité', 'Privacy policy');
  String get settingsPrivacyPolicySub => _s('Tes données te sont privées', 'Your data stays private');
  String get settingsAccount => _s('Compte', 'Account');
  String get settingsEditProfile => _s('Modifier mon profil', 'Edit my profile');
  String get settingsEditProfileSub => _s('Changer prénom, objectifs, niveau', 'Change name, goals, level');
  String get settingsResetProfile => _s('Réinitialiser le profil', 'Reset profile');
  String get settingsResetProfileSub => _s('Tout effacer et recommencer', 'Erase everything and start over');
  String get settingsAbout => _s('À propos', 'About');
  String get settingsAboutApp => _s('À propos de UpYourDeen', 'About UpYourDeen');
  String get settingsAboutAppSub => _s('Version, crédits et remerciements', 'Version, credits and acknowledgements');
  String get settingsCopyright => _s('© 2026 UpYourDeen. Tous droits réservés.', '© 2026 UpYourDeen. All rights reserved.');
  String get settingsResetConfirmTitle => _s('Réinitialiser le profil ?', 'Reset profile?');
  String get settingsResetConfirmMsg => _s(
    'Tu vas revenir à l\'écran de bienvenue. Ta progression (XP, série, badges) sera perdue.',
    'You will return to the welcome screen. Your progress (XP, streak, badges) will be lost.',
  );
  String get cancel => _s('Annuler', 'Cancel');
  String get reset => _s('Réinitialiser', 'Reset');
  String get settingsLastUpdated => _s('Dernière mise à jour : Mars 2026', 'Last updated: March 2026');
  String get settingsDataCollected => _s('Données collectées', 'Data collected');
  String get settingsLocalStorage => _s('Stockage local', 'Local storage');
  String get settingsDataSharing => _s('Partage de données', 'Data sharing');
  String get settingsYourRights => _s('Tes droits', 'Your rights');
  String get settingsContact => _s('Contact', 'Contact');

  // ══════════════════════════════════════════════
  // PROFILE SCREEN
  // ══════════════════════════════════════════════
  String get profileNoProfile => _s('Aucun profil', 'No profile');
  String get profileTitle => _s('Mon Profil', 'My Profile');
  String get profileStats => _s('Mes statistiques', 'My statistics');
  String get profileStreak => _s('Jours de suite', 'Day streak');
  String get profileTotalXP => _s('XP Total', 'Total XP');
  String get profileVersesRead => _s('Versets lus', 'Verses read');
  String get profileBadges => _s('Badges', 'Badges');
  String get profileMyBadges => _s('Mes badges', 'My badges');
  String get profileMyObjectives => _s('Mes objectifs', 'My objectives');
  String get profileInfo => _s('Informations', 'Information');
  String get profileMemberSince => _s('Membre depuis', 'Member since');
  String get profileLevel => _s('Niveau', 'Level');
  String get profileAge => _s('Âge', 'Age');
  String get profileYears => _s('ans', 'y/o');
  String get profileTitleLabel => _s('Titre', 'Title');
  String get levelBeginner => _s('Débutant', 'Beginner');
  String get levelIntermediate => _s('Intermédiaire', 'Intermediate');
  String get levelAdvanced => _s('Avancé', 'Advanced');
  String get profileFirstName => _s('Prénom', 'First name');
  String get profileAvatar => _s('Avatar', 'Avatar');
  String get profileEdit => _s('Modifier mon profil', 'Edit my profile');
  String get profileSave => _s('Sauvegarder', 'Save');
  String get profileResetConfirm => _s(
    'Toutes tes données (XP, badges, progression) seront perdues.',
    'All your data (XP, badges, progress) will be lost.',
  );

  // ══════════════════════════════════════════════
  // ABOUT SCREEN
  // ══════════════════════════════════════════════
  String get aboutTitle => _s('À propos', 'About');
  String get aboutMission => _s('Notre mission', 'Our mission');
  String get aboutValues => _s('Nos valeurs', 'Our values');
  String get aboutSources => _s('Sources', 'Sources');
  String get aboutContact => _s('Contact', 'Contact');
  String get aboutFooter => _s('Fait avec amour pour la Oumma.', 'Made with love for the Ummah.');

  // ══════════════════════════════════════════════
  // ONBOARDING SCREEN
  // ══════════════════════════════════════════════
  String get onboardingWelcome => _s('Bienvenue sur UpYourDeen', 'Welcome to UpYourDeen');
  String get onboardingNameQuestion => _s('Comment tu t\'appelles ?', 'What\'s your name?');
  String get onboardingNameHint => _s('Ton prénom...', 'Your first name...');
  String get onboardingAboutYou => _s('Parle-nous de toi', 'Tell us about yourself');
  String get onboardingAboutYouSub => _s('Pour adapter le contenu à ton profil', 'To personalize content for you');
  String get onboardingAge => _s('Ton âge', 'Your age');
  String get onboardingLevel => _s('Ton niveau en sciences islamiques', 'Your Islamic knowledge level');
  String get onboardingObjectives => _s('Tes objectifs', 'Your goals');
  String get onboardingObjectivesSub => _s('Choisis ce qui te motive (plusieurs possibles)', 'Choose what motivates you (multiple allowed)');
  String get onboardingAvatar => _s('Choisis ton avatar', 'Choose your avatar');
  String get onboardingAvatarSub => _s('L\'icône qui te représentera dans UpYourDeen', 'The icon that will represent you in UpYourDeen');
  String get onboardingNameRequired => _s('Entre ton prénom pour continuer', 'Enter your first name to continue');
  String get onboardingContinue => _s('Continuer', 'Continue');
  String get onboardingStart => _s('Bismillah, c\'est parti !', 'Bismillah, let\'s go!');
  String get onboardingSave => _s('Enregistrer', 'Save');

  // Âge labels
  String get ageChild => _s('Enfant', 'Child');
  String get ageTeen => _s('Adolescent', 'Teenager');
  String get ageAdult => _s('Adulte', 'Adult');
  String get ageSenior => _s('Senior', 'Senior');

  // Niveau labels
  String get levelBeginnerDesc => _s('Je découvre les bases de l\'Islam', 'I\'m discovering the basics of Islam');
  String get levelIntermediateDesc => _s('Je connais les fondements et je veux approfondir', 'I know the foundations and want to go deeper');
  String get levelAdvancedDesc => _s('Je maîtrise bien les sciences islamiques', 'I have strong knowledge of Islamic sciences');

  // ══════════════════════════════════════════════
  // CONSENT DIALOG
  // ══════════════════════════════════════════════
  String get consentTitle => _s('Ta vie privée compte', 'Your privacy matters');
  String get consentMessage => _s(
    'As-salamu alaykum !\n\nPour améliorer UpYourDeen, nous recueillons des données d\'usage anonymes (pages visitées, fonctionnalités utilisées). Aucune donnée personnelle n\'est partagée.',
    'As-salamu alaykum!\n\nTo improve UpYourDeen, we collect anonymous usage data (pages visited, features used). No personal data is shared.',
  );
  String get consentNote => _s(
    'Tu peux changer d\'avis à tout moment dans les Paramètres.',
    'You can change your mind anytime in Settings.',
  );
  String get consentAccept => _s('J\'accepte', 'I accept');
  String get consentDecline => _s('Non merci', 'No thanks');

  // ══════════════════════════════════════════════
  // PROTECTION SCREEN
  // ══════════════════════════════════════════════
  String get protectionTitle => _s('Protection', 'Protection');
  String get protectionSubtitle => _s('Roqya · Versets · Remèdes', 'Ruqyah · Verses · Remedies');
  String get protectionSOS => _s('SOS — Urgence Spirituelle', 'SOS — Spiritual Emergency');
  String get protectionSOSSub => _s('Je me sens mal, que faire maintenant ?', 'I feel bad, what should I do now?');
  String get protectionUnderstand => _s('Comprendre', 'Understand');
  String get protectionUnderstandSub => _s('Jinn, sorcellerie, mauvais oeil, waswas...', 'Jinn, sorcery, evil eye, waswas...');
  String get protectionVerses => _s('Versets de Protection', 'Protection Verses');
  String get protectionVersesSub => _s('Ayat al-Kursi, Mu\'awwidhat, versets anti-sihr...', 'Ayat al-Kursi, Mu\'awwidhat, anti-sihr verses...');
  String get protectionRoqya => _s('Programmes de Roqya', 'Ruqyah Programs');
  String get protectionRoqyaSub => _s('Générale, mauvais oeil, sorcellerie, waswas...', 'General, evil eye, sorcery, waswas...');
  String get protectionDuas => _s('Invocations de Protection', 'Protection Supplications');
  String get protectionDuasSub => _s('Du\'as pour se protéger au quotidien', 'Daily protection du\'as');
  String get protectionRemedies => _s('Remèdes Prophétiques', 'Prophetic Remedies');
  String get protectionRemediesSub => _s('Miel, eau de Zamzam, graine de nigelle...', 'Honey, Zamzam water, black seed...');
  String get protectionSosTitle => _s('Urgence Spirituelle', 'Spiritual Emergency');
  String get protectionUnderstandTitle => _s('Comprendre', 'Understand');
  String get protectionVersesTitle => _s('Versets de Protection', 'Protection Verses');
  String get protectionRepeatLabel => _s('Répéter', 'Repeat');
  String get protectionDescriptionLabel => _s('Description', 'Description');
  String get protectionUsageLabel => _s('Utilisation', 'Usage');
  String get protectionHadithLabel => _s('Hadith', 'Hadith');
  String get protectionBenefitsLabel => _s('Bienfaits', 'Benefits');

  // ══════════════════════════════════════════════
  // DISCOVER SCREEN
  // ══════════════════════════════════════════════
  String get discoverTitle => _s('Découvrir', 'Discover');
  String get discoverSubtitle => _s('Explore les trésors de l\'Islam', 'Explore the treasures of Islam');
  String get discoverQuestionOfDay => _s('Question du jour', 'Question of the day');
  String get discoverTapToReveal => _s('Appuyer pour voir la réponse →', 'Tap to reveal the answer →');
  String get discoverWisdom => _s('Sagesse du jour', 'Wisdom of the day');
  String get discoverAnswer => _s('Réponse', 'Answer');
  String get discoverVerseKey => _s('Verset clé', 'Key verse');
  String get discoverRelatedQuestions => _s('Questions liées :', 'Related questions:');
  String get discoverChooseTheme => _s('Choisis un thème :', 'Choose a theme:');
  String get discoverOrChooseTheme => _s('Ou choisis un thème :', 'Or choose a theme:');
  String discoverCorrectAnswersPercent(int pct) => _s('$pct% de bonnes réponses', '$pct% correct answers');

  // ══════════════════════════════════════════════
  // FAMILY SCREEN
  // ══════════════════════════════════════════════
  String get familyTitle => _s('Espace Familles', 'Family Space');
  String get familyProphets => _s('🕌 Prophètes', '🕌 Prophets');
  String get familyStories => _s('📖 Coran', '📖 Quran');
  String get familyTimeline => _s('🕐 Frise', '🕐 Timeline');
  String get familyEvening => _s('🌙 Bonsoir', '🌙 Goodnight');
  String get familyTracking => _s('📋 Suivi', '📋 Tracking');
  String get familyChallenges => _s('🎯 Défis', '🎯 Challenges');
  String get familyTips => _s('💡 Conseils', '💡 Tips');
  String get familyHadithStories => _s('📜 Hadiths', '📜 Hadiths');
  String get familyHisStory => _s('Son Histoire', 'His Story');
  String get familySummary => _s('Résumé', 'Summary');
  String get familyChapters => _s('Chapitres', 'Chapters');
  String get familyReadStory => _s('Lire l\'histoire', 'Read the story');
  String get familyPrevious => _s('Précédent', 'Previous');
  String get familyNext => _s('Suivant', 'Next');
  String get familyFirstName => _s('Prénom', 'First name');
  String get familyAdd => _s('Ajouter', 'Add');
  String get familyProphetQuiz => _s('Quiz du Prophète', 'Prophet Quiz');
  String get familyCompleteStory => _s('Histoire complète', 'Complete Story');
  String familyChildrenRegistered(int n) => _s('$n enfant(s) enregistré(s)', '$n child(ren) registered');
  String get familyPrayerProgram => _s('Programme Prière', 'Prayer Program');
  String familyStepsValidated(int done, int total) => _s('$done/$total étapes validées', '$done/$total steps completed');
  String get familyQuranMemorization => _s('Mémorisation Coran', 'Quran Memorization');
  String get familyAddChildDesc => _s('Ajoutez un enfant pour suivre sa progression...', 'Add a child to track their progress...');
  String get familyWeeklyChallenge => _s('Défi de la semaine', 'Weekly Challenge');
  String get familyAllChallenges => _s('Tous les défis', 'All Challenges');
  String familyProphetNumber(int n) => _s('Prophète n°$n', 'Prophet #$n');

  // ══════════════════════════════════════════════
  // SPIRITUALITY SCREEN
  // ══════════════════════════════════════════════
  String get spiritualityTitle => _s('Spiritualité', 'Spirituality');
  String get spiritualityMyFavorites => _s('Mes favoris', 'My Favorites');
  String get spiritualityNameOfDay => _s('Nom du Jour', 'Name of the Day');
  String get spiritualityToday => _s('Aujourd\'hui', 'Today');
  String get spiritualityExplanation => _s('Explication', 'Explanation');
  String get spiritualityBenefits => _s('Bienfaits', 'Benefits');

  // ══════════════════════════════════════════════
  // JOURNAL SCREEN
  // ══════════════════════════════════════════════
  String get journalTitle => _s('Journal', 'Journal');
  String get journalReflectionsTracking => _s('Réflexions, suivi & générosité', 'Reflections, tracking & generosity');
  String get journalDailyReflection => _s('Réflexion du jour', 'Daily Reflection');
  String get journalTapToAnswer => _s('Appuyer pour répondre →', 'Tap to answer →');
  String get journalYourEntries => _s('Vos entrées', 'Your entries');
  String get journalRegularityMilestones => _s('Paliers de régularité', 'Regularity Milestones');
  String get journalTotalGivenYear => _s('Total donné cette année', 'Total given this year');
  String get journal8Categories => _s('Les 8 catégories de bénéficiaires', 'The 8 categories of recipients');
  String get journalNoDonationRecord => _s('Aucun don enregistré', 'No donation recorded');
  String get journalRecentMoods => _s('Humeurs récentes', 'Recent moods');
  String get journalZakatToPay => _s('Zakat à verser', 'Zakat due');
  String journalDaysAgo(int days) => _s('Il y a $days jours, tu écrivais...', '$days days ago, you wrote...');
  String journalEntriesCount(int n) => _s('Vos entrées ($n)', 'Your entries ($n)');

  // ══════════════════════════════════════════════
  // QURAN SCREEN
  // ══════════════════════════════════════════════
  String get quranTitle => _s('Coran', 'Quran');
  String get quranSearch => _s('Rechercher une sourate...', 'Search a surah...');
  String get quranVerses => _s('versets', 'verses');
  String get quranSubtitle => _s('Le Saint Coran · 114 sourates', 'The Holy Quran · 114 surahs');
  String get quranResumeReading => _s('Reprendre la lecture', 'Resume reading');
  String get quranComingSoon => _s('Bientôt', 'Coming soon');
  String get quranContentComing => _s('Le contenu de', 'The content of');
  String get quranArrivingSoon => _s('arrive bientôt, إن شاء الله !', 'is coming soon, إن شاء الله !');
  String get quranNoResults => _s('Aucune sourate trouvée', 'No surah found');
  String get quranTryOtherKeyword => _s('Essaie un autre mot-clé', 'Try another keyword');
  String get quranSurahLabel => _s('Sourate', 'Surah');
  String get quranVersetsLabel => _s('Versets', 'Verses');
  String get quranReadingLabel => _s('lu', 'read');
  String get quranDisplayOptions => _s('Options d\'affichage', 'Display options');
  String get quranArabicTextSize => _s('Taille du texte arabe', 'Arabic text size');
  String get quranSmallSize => _s('Petit', 'Small');
  String get quranNormalSize => _s('Normal', 'Normal');
  String get quranLargeSize => _s('Grand', 'Large');
  String get quranArabicText => _s('Texte arabe', 'Arabic text');
  String get quranPhonetic => _s('Phonétique', 'Phonetic');
  String get quranFrenchTranslation => _s('Traduction française', 'French translation');
  String get quranBismillah => _s('Au nom d\'Allah, le Tout Miséricordieux', 'In the name of Allah, the Most Merciful');
  String get quranMyBookmarks => _s('Mes signets', 'My bookmarks');
  String get quranCardsMode => _s('Cartes', 'Cards');
  String get quranContinuousMode => _s('Continu', 'Continuous');

  // ══════════════════════════════════════════════
  // HADITH SCREEN
  // ══════════════════════════════════════════════
  String get hadithTitle => _s('Hadiths', 'Hadith');
  String get hadithSubtitle => _s('Sagesse du Prophète ﷺ', 'Wisdom of the Prophet ﷺ');
  String get hadithQuizButton => _s('Quiz Hadiths', 'Hadith Quiz');
  String get hadithOfTheDay => _s('Hadith du jour', 'Hadith of the day');
  String get hadithReadExplanation => _s('Lire l\'explication', 'Read explanation');
  String get hadithRandomWisdom => _s('Sagesse du Prophète ﷺ', 'Wisdom of the Prophet ﷺ');
  String get hadithDiscoverRandom => _s('Découvrir une sagesse aléatoire', 'Discover random wisdom');
  String get hadithCopiedClipboard => _s('Hadith copié dans le presse-papiers', 'Hadith copied to clipboard');
  String get hadithTranslation => _s('TRADUCTION', 'TRANSLATION');
  String get hadithSimilar => _s('Hadiths similaires', 'Similar hadiths');
  String get hadithAppName => _s('UpYourDeen', 'UpYourDeen');
  String get hadithAppSlogan => _s('UpYourDeen · Élève ta foi', 'UpYourDeen · Elevate your faith');
  String get hadithShareError => _s('Erreur lors du partage', 'Error while sharing');
  String get hadithImageShared => _s('Image partagée !', 'Image shared!');
  String get hadithSaveError => _s('Erreur lors de la sauvegarde', 'Error while saving');
  String get hadithShareTitle => _s('Partager ce hadith', 'Share this hadith');
  String get hadithShareSubtitle => _s('Génère une belle carte à partager sur les réseaux', 'Generate a beautiful card to share on social networks');
  String get hadithSaveButton => _s('Sauvegarder', 'Save');
  String get hadithShareImageButton => _s('Partager l\'image', 'Share image');
  String get hadithFavorite => _s('Favori', 'Favorite');
  String get hadithAdd => _s('Ajouter', 'Add');
  String get hadithViewExplanation => _s('Voir l\'explication', 'View explanation');
  String get hadithQuizCorrect => _s('Correct ! +1 ⚡', 'Correct! +1 ⚡');
  String get hadithQuizIncorrect => _s('Pas tout à fait...', 'Not quite...');
  String get hadithQuizGoodAnswer => _s('Bonne réponse :', 'Good answer:');
  String get hadithQuizContinue => _s('Continuer →', 'Continue →');
  String get hadithQuizBravo => _s('Bien joué !', 'Well done!');
  String get hadithQuizAlmost => _s('Encore un effort !', 'One more effort!');
  String get hadithQuizBackButton => _s('Retour aux hadiths 📖', 'Back to hadiths 📖');
  String get hadithQuizRestart => _s('Recommencer le quiz', 'Restart quiz');
  String get hadithExplication => _s('EXPLICATION', 'EXPLANATION');
  String get hadithDailyApp => _s('APPLICATION QUOTIDIENNE', 'DAILY APPLICATION');
  String get hadithShareSquare => _s('Carré', 'Square');
  String get hadithShareStory => _s('Story', 'Story');
  String get hadithQuizWhoNarrated => _s('Qui a rapporté ce hadith ?', 'Who narrated this hadith?');
  String get hadithQuizTranslationQ => _s('Quelle est la traduction de ce hadith ?', 'What is the translation of this hadith?');
  String get hadithQuizExplanationQ => _s('Quelle est la meilleure explication ?', 'What is the best explanation?');
  String hadithQuizScoreText(int score, int total, int pct) =>
      _s('Tu as obtenu $score/$total bonnes réponses ($pct%).', 'You got $score/$total correct answers ($pct%).');
  String get hadithQuizCorrects => _s('Corrects', 'Correct');
  String get hadithQuizErrors => _s('Erreurs', 'Errors');
  String translateHadithCategory(String fr) {
    if (isFr) return fr;
    switch (fr) {
      case 'Tous': return 'All';
      case 'Foi': return 'Faith';
      case 'Comportement': return 'Behavior';
      case 'Famille': return 'Family';
      case 'Commerce': return 'Commerce';
      case 'Sagesse': return 'Wisdom';
      case 'Spiritualité': return 'Spirituality';
      case 'Justice': return 'Justice';
      case 'Amour et miséricorde': return 'Love & Mercy';
      default: return fr;
    }
  }

  // ══════════════════════════════════════════════
  // CHILDREN SCREEN
  // ══════════════════════════════════════════════
  String get childrenTitle => _s('Espace Enfants', 'Kids Space');

  // ══════════════════════════════════════════════
  // LEARNING MODULE
  // ══════════════════════════════════════════════
  String get learnTitle => _s('Apprentissage', 'Learning');
  String get learnNextLesson => _s('Prochaine leçon', 'Next lesson');
  String get learnReview => _s('Réviser', 'Review');
  String get learnProgress => _s('Progression', 'Progress');
  String get learnPath => _s('Parcours', 'Learning Path');
  String get learnStart => _s('Commencer', 'Start');
  String get learnContinue => _s('Continuer', 'Continue');

  // ══════════════════════════════════════════════
  // HOME SCREEN — modules, stats, défis, versets
  // ══════════════════════════════════════════════
  String get homeSlogan => _s('Élève ta foi', 'Elevate your faith');

  // Stat chips
  String get statStreak => _s('Série', 'Streak');
  String get statXP => 'XP';
  String get statVerses => _s('Versets', 'Verses');
  String get statBadges => 'Badges';

  // Module titles
  String get moduleCoran => _s('Coran', 'Quran');
  String get moduleLearning => _s('Apprentissage', 'Learning');
  String get moduleHadith => _s('Hadiths', 'Hadith');
  String get moduleJournal => 'Journal';
  String get moduleSpirituality => _s('Spiritualité', 'Spirituality');
  String get moduleProtection => 'Protection';
  String get moduleFamily => _s('Famille', 'Family');
  String get moduleDiscover => _s('Découvrir', 'Discover');
  String get moduleShop => _s('Boutique', 'Shop');

  // Quick access
  String get quickCoran => _s('Coran', 'Quran');
  String get quickLearning => _s('Apprendre', 'Learn');
  String get quickHadith => _s('Hadiths', 'Hadith');
  String get quickSpirituality => _s('Spiritualité', 'Spirituality');
  String get quickFamily => _s('Familles', 'Families');

  // Continue card
  String get continueTitle => _s('Continuer mon parcours', 'Continue my path');
  String get continueSub => _s('Reprends là où tu t\'es arrêté', 'Pick up where you left off');

  // Daily challenge
  String get dailyChallenge => _s('Défi du jour', 'Daily challenge');
  String get dailyChallengeTag => _s('DÉFI DU JOUR', 'DAILY CHALLENGE');
  String get dailyVerseTag => _s('VERSET DU JOUR', 'VERSE OF THE DAY');

  // Continue card
  String get continueTag => _s('CONTINUER', 'CONTINUE');
  String get continueReading => _s('Commencer votre lecture', 'Start your reading');

  // Notification type labels
  String get notifMotivation => 'MOTIVATION';
  String get notifStreak => _s('SÉRIE', 'STREAK');
  String get notifWellbeing => _s('BIEN-ÊTRE', 'WELL-BEING');
  String get notifComeback => _s('BON RETOUR', 'WELCOME BACK');
  String get notifChallenge => _s('DÉFI', 'CHALLENGE');
  String get notifReminder => _s('RAPPEL', 'REMINDER');
  String get notifSadaqa => 'SADAQA JARIYA';

  // ══════════════════════════════════════════════════════════════════════════
  // JOURNAL SCREEN — ACTION CATEGORIES
  // ══════════════════════════════════════════════════════════════════════════
  String get journalObligatoryPrayers => _s('Prières obligatoires', 'Obligatory Prayers');
  String get journalSupererogatory => _s('Prières surérogatoires', 'Supererogatory Prayers');
  String get journalAdoration => _s('Adoration & Dhikr', 'Adoration & Dhikr');
  String get journalBehavior => _s('Comportement & Bienfaisance', 'Behavior & Charity');
  String get journalFajr => _s('Fajr (Sobh)', 'Fajr (Dawn)');
  String get journalDohr => _s('Dohr (Midi)', 'Dhuhr (Noon)');
  String get journalAsr => _s('Asr (Après-midi)', 'Asr (Afternoon)');
  String get journalMaghrib => _s('Maghrib (Coucher)', 'Maghrib (Sunset)');
  String get journalIcha => _s('Icha (Nuit)', 'Isha (Night)');
  String get journalRawatib => _s('Rawâtib (Sunna régulières)', 'Rawatib (Regular Sunna)');
  String get journalDuha => _s('Prière de Duha', 'Duha Prayer');
  String get journalWitr => _s('Prière de Witr', 'Witr Prayer');
  String get journalTahajjud => _s('Tahajjud (Qiyam al-Layl)', 'Tahajjud (Night Prayer)');
  String get journalQuranReading => _s('Lecture du Coran', 'Quran Reading');
  String get journalAdhkarMorning => _s('Adhkâr du matin', 'Morning Adhkar');
  String get journalAdhkarEvening => _s('Adhkâr du soir', 'Evening Adhkar');
  String get journalIstighfar => _s('Istighfâr (100x)', 'Istighfar (100x)');
  String get journalSalawat => _s('Salât \'ala Nabi ﷺ', 'Salutations on the Prophet ﷺ');
  String get journalGoodAction => _s('Bonne action envers autrui', 'Good deed towards others');
  String get journalSadaqaCharity => _s('Sadaqa (aumône)', 'Sadaqa (charity)');
  String get journalParents => _s('Bienfaisance envers les parents', 'Kindness to parents');
  String get journalLearning => _s('Apprentissage religieux', 'Religious learning');
  String get journalGratitudeExpr => _s('Gratitude exprimée', 'Expressed gratitude');
  String get journalFasting => _s('Jeûne surérogatoire', 'Supererogatory fasting');

  // ══════════════════════════════════════════════════════════════════════════
  // CHILDREN SCREEN
  // ══════════════════════════════════════════════════════════════════════════
  String get childrenNoahArc => _s('Noé et l\'Arche', 'Noah and the Ark');
  String get childrenIbrahimFire => _s('Ibrahim et le Feu', 'Ibrahim and the Fire');
  String get childrenYusufBrothers => _s('Yusuf et ses frères', 'Yusuf and his Brothers');
  String get childrenMusaPharaoh => _s('Musa et le Pharaon', 'Musa and the Pharaoh');
  String get childrenShowResult => _s('Voir le résultat 🏆', 'See result 🏆');
  String get childrenContinueLearning => _s('Continue à apprendre, إن شاء الله tu progresseras !', 'Keep learning, إن شاء الله you will progress!');

  // ══════════════════════════════════════════════════════════════════════════
  // DISCOVER SCREEN
  // ══════════════════════════════════════════════════════════════════════════
  String get discoverFacts => _s('Le Saviez-Vous ?', 'Did You Know?');
  String get discoverProphetStories => _s('Histoires des Prophètes', 'Stories of the Prophets');
  String get discoverWisdomQuotes => _s('Sagesses & Citations', 'Wisdom & Quotes');
  String get discoverQuiz => _s('Quiz Islamique', 'Islamic Quiz');
  String get discoverTestKnowledge => _s('Teste tes connaissances !', 'Test your knowledge!');
  String get discoverWaterCycle => _s('Le cycle de l\'eau dans le Coran', 'The Water Cycle in the Quran');
  String get discoverOpticsFounder => _s('Ibn al-Haytham, père de l\'optique', 'Ibn al-Haytham, Father of Optics');
  String get discoverFirstHospitals => _s('Les premiers hôpitaux', 'The First Hospitals');
  String get discoverMountainsPegs => _s('Les montagnes comme des piquets', 'Mountains Like Pegs');
  String get discoverAbbas => _s('Abbas ibn Firnas et le vol', 'Abbas ibn Firnas and Flight');
  String get discoverAlgebra => _s('Al-Khwarizmi et l\'algèbre', 'Al-Khwarizmi and Algebra');
  String get discoverEmbryology => _s('L\'embryologie dans le Coran', 'Embryology in the Quran');
  String get discoverWisdomHouse => _s('La Maison de la Sagesse', 'House of Wisdom');
  String get discoverSeaBarrier => _s('La barrière entre les mers', 'The Barrier Between Seas');
  String get discoverUniversityQarawiyyin => _s('L\'Université Al-Qarawiyyin', 'Al-Qarawiyyin University');
  String get notifCongrats => _s('FÉLICITATIONS', 'CONGRATULATIONS');

  // Daily challenges (bilingual)
  List<Map<String, String>> get dailyChallenges => [
    {'emoji': '📖', 'defi': _s('Lis 5 versets du Coran', 'Read 5 verses of the Quran'), 'xp': '+15 XP'},
    {'emoji': '🤲', 'defi': _s('Fais 33 Subhanallah après la prière', 'Say 33 Subhanallah after prayer'), 'xp': '+10 XP'},
    {'emoji': '😊', 'defi': _s('Souris à 3 personnes aujourd\'hui', 'Smile at 3 people today'), 'xp': '+10 XP'},
    {'emoji': '💧', 'defi': _s('Fais tes ablutions avec soin', 'Perform your wudu with care'), 'xp': '+10 XP'},
    {'emoji': '🕌', 'defi': _s('Prie une prière à la mosquée', 'Pray one prayer at the mosque'), 'xp': '+20 XP'},
    {'emoji': '📿', 'defi': _s('Récite Ayat al-Kursi 3 fois', 'Recite Ayat al-Kursi 3 times'), 'xp': '+15 XP'},
    {'emoji': '🤝', 'defi': _s('Rends service à quelqu\'un', 'Do a favor for someone'), 'xp': '+15 XP'},
    {'emoji': '🌙', 'defi': _s('Lis les adhkar du soir', 'Read the evening adhkar'), 'xp': '+10 XP'},
    {'emoji': '💝', 'defi': _s('Fais une Sadaqa, même petite', 'Give Sadaqa, even a small one'), 'xp': '+20 XP'},
    {'emoji': '📚', 'defi': _s('Apprends un nouveau hadith', 'Learn a new hadith'), 'xp': '+15 XP'},
    {'emoji': '🤲', 'defi': _s('Fais une du\'a pour tes parents', 'Make du\'a for your parents'), 'xp': '+10 XP'},
    {'emoji': '🌿', 'defi': _s('Dis Astaghfirullah 100 fois', 'Say Astaghfirullah 100 times'), 'xp': '+15 XP'},
  ];

  // Verse translations (bilingual)
  List<Map<String, String>> get dailyVerses => [
    {'arabe': 'إِنَّ مَعَ الْعُسْرِ يُسْرًا', 'traduction': _s('« Certes, avec la difficulté vient la facilité. »', '"Verily, with hardship comes ease."'), 'reference': 'Ash-Sharh · 94:6'},
    {'arabe': 'وَمَن يَتَوَكَّلْ عَلَى اللَّهِ فَهُوَ حَسْبُهُ', 'traduction': _s('« Quiconque place sa confiance en Allah, Il lui suffit. »', '"Whoever puts their trust in Allah, He is sufficient for them."'), 'reference': 'At-Talaq · 65:3'},
    {'arabe': 'فَاذْكُرُونِي أَذْكُرْكُمْ', 'traduction': _s('« Souvenez-vous de Moi, Je Me souviendrai de vous. »', '"Remember Me, and I will remember you."'), 'reference': 'Al-Baqara · 2:152'},
    {'arabe': 'وَلَسَوْفَ يُعْطِيكَ رَبُّكَ فَتَرْضَىٰ', 'traduction': _s('« Ton Seigneur t\'accordera tant que tu seras satisfait. »', '"Your Lord will give you until you are satisfied."'), 'reference': 'Ad-Duha · 93:5'},
    {'arabe': 'إِنَّ اللَّهَ مَعَ الصَّابِرِينَ', 'traduction': _s('« Allah est avec les patients. »', '"Allah is with the patient."'), 'reference': 'Al-Baqara · 2:153'},
    {'arabe': 'وَهُوَ مَعَكُمْ أَيْنَ مَا كُنتُمْ', 'traduction': _s('« Il est avec vous où que vous soyez. »', '"He is with you wherever you are."'), 'reference': 'Al-Hadid · 57:4'},
    {'arabe': 'رَبِّ اشْرَحْ لِي صَدْرِي', 'traduction': _s('« Seigneur, ouvre-moi ma poitrine. »', '"My Lord, expand for me my chest."'), 'reference': 'Ta-Ha · 20:25'},
  ];

  // ══════════════════════════════════════════════
  // LEARNING MODULE — Learning Home Screen
  // ══════════════════════════════════════════════
  String get learningTitle => _s('Apprentissage', 'Learning');
  String get learningSubtitle => _s('Apprends le Coran, verset par verset', 'Learn the Quran, verse by verse');
  String get learningLearningPath => _s('✦  Parcours d\'apprentissage', '✦  Learning Path');
  String get learningWeek => _s('✦  Ma semaine', '✦  My week');
  String get learningDailyGoal => _s('Objectif du jour', 'Daily goal');
  String get learningDailyGoalReached => _s('Objectif atteint !', 'Goal reached!');
  String get learningContinue => _s('Continuer', 'Continue');
  String get learningExplore => _s('Explorer', 'Explore');
  String get learningDaysStreak => _s('jours', 'days');
  String get learningLevel => _s('Niveau', 'Level');
  String get learningXP => 'XP';
  String get learningReviewVersets => _s('versets à réviser', 'verses to review');
  String get learningConsolidateMemory => _s('Consolide ta mémoire maintenant', 'Consolidate your memory now');
  String get learningReview => _s('Réviser', 'Review');
  String get learningPrayerGuide => _s('Guide de la Prière', 'Prayer Guide');
  String get learningPrayerGuideSub => _s('Ablution · Positions · Rak\'ahs · Sunnah', 'Wudu · Positions · Rak\'ahs · Sunnah');
  String get learningNew => _s('Nouveau', 'New');
  String get learningPathBeginner => _s('Débutant', 'Beginner');
  String get learningPathBeginnerSub => _s('Courtes sourates pour commencer', 'Short surahs to start');
  String get learningPathPrayer => _s('Prière', 'Prayer');
  String get learningPathPrayerSub => _s('Sourates récitées en prière', 'Surahs recited in prayer');
  String get learningPathProtection => _s('Protection', 'Protection');
  String get learningPathProtectionSub => _s('Sourates de protection & refuge', 'Protection & refuge surahs');
  String get learningPathImportant => _s('Importantes', 'Important');
  String get learningPathImportantSub => _s('Les grandes sourates du Coran', 'Major surahs of the Quran');
  String get learningPathJuzAmma => _s('Juz Amma', 'Juz Amma');
  String get learningPathJuzAmmaSub => _s('30e juz complet (sourates 78–114)', '30th juz complete (surahs 78-114)');
  String get learningPathFree => _s('Mode Libre', 'Free Mode');
  String get learningPathFreeSub => _s('Toutes les 114 sourates', 'All 114 surahs');
  String get learningVersesMastered => _s('Maîtrisés', 'Mastered');
  String get learningExercises => _s('Exercices', 'Exercises');
  String get learningAccuracy => _s('Précision', 'Accuracy');
  String get learningViewProgress => _s('Voir ma progression →', 'See my progress →');
  String get learningMyWeek => _s('Ma semaine', 'My week');

  // Learning paths subtitles
  String get learningPathBeginningSub => _s('Courtes sourates du Juz 30', 'Short surahs from Juz 30');
  String get learningPathPrayerPathSub => _s('Sourates essentielles de la prière', 'Essential surahs for prayer');
  String get learningPathProtectionPathSub => _s('Sourates de protection et de refuge', 'Protection and refuge surahs');
  String get learningPathImportantsub => _s('Les sourates les plus importantes', 'The most important surahs');
  String get learningPathJuzAmmaFullSub => _s('Le 30e juz complet · 37 sourates', 'The complete 30th juz · 37 surahs');
  String get learningPathFreeModeSub => _s('Toutes les sourates du Coran', 'All surahs of the Quran');

  // Additional learning labels
  String get lessonLessons => _s('leçons', 'lessons');
  String get lessonSourates => _s('sourates', 'surahs');
  String get learning114Surahs => _s('114 sourates', '114 surahs');
  String get learning20Lessons => _s('20 leçons', '20 lessons');
  String get learning9Lessons => _s('9 leçons', '9 lessons');
  String get learning4Lessons => _s('4 leçons', '4 lessons');
  String get learning37Lessons => _s('37 leçons', '37 lessons');
  String get lessonContinueReading => _s('Continuer la lecture', 'Continue reading');
  String get lessonStartLesson => _s('Commencer la leçon', 'Start lesson');
  String get lessonCompleted => _s('Complétée', 'Completed');
  String get lessonLocked => _s('Verrouillée', 'Locked');
  String get lessonInProgress => _s('En cours', 'In progress');
  String get lessonReorderWords => _s('Remets les mots dans le bon ordre (phonétique)', 'Put the words in the right order (phonetic)');
  String lessonSurahCompleted(String name) => _s('$name terminée !', '$name completed!');
  String get learningCompletePrevious5 => _s('Termine les 5 versets précédents d\'abord', 'Complete the 5 previous verses first');
  String get learningCompletePreviousVerse => _s('Termine le verset précédent', 'Complete the previous verse');
  String get learningCompleteToUnlock => _s('Termine le verset précédent pour débloquer', 'Complete the previous verse to unlock');
  String get childrenCorrectAnswers => _s('bonnes réponses', 'correct answers');

  // Quiz and exercises
  String get quizCorrectAnswer => _s('Bonne réponse', 'Correct answer');
  String get quizIncorrect => _s('Incorrect', 'Incorrect');
  String get quizContinueBtn => _s('Continuer', 'Continue');
  String get quizStartQuiz => _s('Commencer le quiz', 'Start quiz');
  String get quizFinalQuiz => _s('Quiz final', 'Final quiz');
  String get quizIntermediateQuiz => _s('Quiz intermédiaire', 'Intermediate quiz');
  String get quizYourScore => _s('Ton score', 'Your score');
  String get quizCorrect => _s('Correct', 'Correct');
  String get quizWrong => _s('Faux', 'Wrong');
  String get quizPhoneticQuestion => _s('Quelle est la phonétique de ce verset ?', 'What is the phonetic of this verse?');
  String get quizVerify => _s('Vérifier', 'Verify');
  String quizReviewFailed(int n) => _s('Réviser les $n versets ratés', 'Review $n missed verses');

  // Review screen
  String get reviewVerses => _s('Versets à réviser', 'Verses to review');
  String get reviewStartReview => _s('Commencer la révision', 'Start review');
  String get reviewNoVerses => _s('Aucun verset à réviser', 'No verses to review');
  String get reviewWellDone => _s('Bien joué !', 'Well done!');
  String get reviewKeepGoing => _s('Continue !', 'Keep going!');
  String get reviewSessionCompleted => _s('Session de révision terminée !', 'Review session completed!');
  String get reviewMastered => _s('Maîtrisé !', 'Mastered!');
  String get reviewTapToSeeAnswer => _s('Appuie pour voir la réponse', 'Tap to see the answer');

  // Progress screen
  String get progressVersetsMastered => _s('Versets maîtrisés', 'Verses mastered');
  String get progressAccuracy => _s('Précision', 'Accuracy');
  String get progressTotalXP => _s('XP total', 'Total XP');
  String get progressStreakDays => _s('Série', 'Streak');

  // Prayer guide
  String get prayerTitle => _s('Guide de la Prière', 'Prayer Guide');
  String get prayerSteps => _s('Étapes', 'Steps');
  String get prayerWudu => _s('Ablution (Wudu)', 'Ablution (Wudu)');
  String get prayerWuduSteps => _s('Étapes de l\'ablution', 'Wudu steps');
  String get prayerStandup => _s('Position debout (Qiyam)', 'Standing position (Qiyam)');
  String get prayerBowing => _s('Inclinaison (Ruku)', 'Bowing (Ruku)');
  String get prayerProstration => _s('Prosternation (Sujud)', 'Prostration (Sujud)');
  String get prayerSitting => _s('Position assise (Tashahhud)', 'Sitting position (Tashahhud)');
  String get prayerSalutation => _s('Salutation finale (Taslim)', 'Final greeting (Taslim)');

  // Level titles for UserStats
  String get levelBeginnerSub => _s('Débutant', 'Beginner');
  String get levelReciter => _s('Récitant', 'Reciter');
  String get levelMemoriz => _s('Mémorisateur', 'Memorizer');
  String get levelHafithJr => _s('Hafidh Junior', 'Hafidh Junior');
  String get levelHafith => _s('Hafidh', 'Hafidh');

  // ══════════════════════════════════════════════
  // LEARNING MODULE — Progress Screen
  // ══════════════════════════════════════════════
  String get progressMyProgress => _s('Ma Progression', 'My Progress');
  String get progressStayMotivated => _s('Suis tes progrès et reste motivé', 'Track your progress and stay motivated');

  // ══════════════════════════════════════════════
  // NIVEAUX (level titles based on XP)
  // ══════════════════════════════════════════════
  String levelTitle(int xpTotal) {
    if (xpTotal < 500) return _s('Chercheur de lumière', 'Seeker of Light');
    if (xpTotal < 1500) return _s('Étoile montante', 'Rising Star');
    if (xpTotal < 3000) return _s('Compagnon de savoir', 'Companion of Knowledge');
    if (xpTotal < 6000) return _s('Flambeau de la foi', 'Torch of Faith');
    return _s('Phare de guidance', 'Beacon of Guidance');
  }

  // ══════════════════════════════════════════════
  // COMMUN
  // ══════════════════════════════════════════════
  String get ok => 'OK';
  String get close => _s('Fermer', 'Close');
  String get share => _s('Partager', 'Share');
  String get copy => _s('Copier', 'Copy');
  String get delete => _s('Supprimer', 'Delete');
  String get edit => _s('Modifier', 'Edit');
  String get yes => _s('Oui', 'Yes');
  String get no => _s('Non', 'No');
  String get back => _s('Retour', 'Back');
  String get next => _s('Suivant', 'Next');
  String get loading => _s('Chargement...', 'Loading...');
  String get error => _s('Erreur', 'Error');
  String get success => _s('Succès', 'Success');
  String get search => _s('Rechercher', 'Search');
}

/// Extension pratique sur BuildContext
extension TranslationExtension on BuildContext {
  T get t => T.of(this);
}
