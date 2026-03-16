import 'app_locale.dart';

// assistant_data.dart
// Base de connaissances pour l'assistant islamique – Application UpYourDeen

// ── Structure ─────────────────────────────────────────────────────

class AssistantTopic {
  final String id;
  final String titleFr;
  final String titleEn;
  final String emoji;
  final String descriptionFr;
  final String descriptionEn;
  final List<AssistantQA> questions;

  const AssistantTopic({
    required this.id,
    required this.titleFr,
    required this.titleEn,
    required this.emoji,
    required this.descriptionFr,
    required this.descriptionEn,
    required this.questions,
  });

  String get title => AppLocale().isFrench ? titleFr : titleEn;
  String get description => AppLocale().isFrench ? descriptionFr : descriptionEn;
}

class AssistantQA {
  final String id;
  final String questionFr;
  final String questionEn;
  final String reponseFr;
  final String reponseEn;
  final String? source;
  final List<String> keywords;

  const AssistantQA({
    required this.id,
    required this.questionFr,
    required this.questionEn,
    required this.reponseFr,
    required this.reponseEn,
    this.source,
    required this.keywords,
  });

  String get question => AppLocale().isFrench ? questionFr : questionEn;
  String get reponse => AppLocale().isFrench ? reponseFr : reponseEn;
}

// ── Suggestions rapides ───────────────────────────────────────────

const kQuickSuggestionsFr = <String>[
  'Comment faire la prière ?',
  'Qu\'est-ce qui annule le jeûne ?',
  'Les étapes du Hajj',
  'Le mariage en Islam',
  'Comment éduquer ses enfants ?',
  'C\'est quoi la Omra ?',
  'Le divorce en Islam',
  'Comment faire le wudu ?',
  'Qu\'est-ce que la Zakat ?',
  'Quels sont les 99 Noms d\'Allah ?',
  'Que se passe-t-il après la mort ?',
  'Comment faire la Tawba ?',
  'Les invocations du voyage',
  'Les 6 jours de Shawwal',
];

const kQuickSuggestionsEn = <String>[
  'How to pray?',
  'What breaks the fast?',
  'The stages of Hajj',
  'Marriage in Islam',
  'How to educate your children?',
  'What is Umrah?',
  'Divorce in Islam',
  'How to perform wudu?',
  'What is Zakat?',
  'What are the 99 Names of Allah?',
  'What happens after death?',
  'How to make Tawbah?',
  'Invocations for travel',
  'The 6 days of Shawwal',
];

List<String> get kQuickSuggestions => AppLocale().isFrench ? kQuickSuggestionsFr : kQuickSuggestionsEn;

// ── Topics ────────────────────────────────────────────────────────

const kAssistantTopics = <AssistantTopic>[

  // ══════════════════════════════════════════════════════════════
  // RAMADAN
  // ══════════════════════════════════════════════════════════════
  AssistantTopic(
    id: 'ramadan',
    titleFr: 'Ramadan',

    titleEn: 'Ramadan',
    emoji: '🌙',
    descriptionFr: 'Le jeûne, ses règles et ses mérites',

    descriptionEn: 'Fasting, its rules and merits',
    questions: [
      AssistantQA(
        id: 'ram1',
        questionFr: 'Qu\'est-ce que le Ramadan ?',

        questionEn: 'What is Ramadan?',
        keywords: ['ramadan', 'jeune', 'mois', 'siyam'],
        reponseFr: 'Le Ramadan est le 9e mois du calendrier islamique. C\'est le mois durant lequel le Coran a été révélé. Le jeûne (Siyam) y est obligatoire pour tout musulman pubère, sain d\'esprit et en bonne santé. On s\'abstient de manger, boire et d\'avoir des rapports intimes du lever du soleil (Fajr) au coucher (Maghrib). C\'est un mois de piété, de générosité, de lecture du Coran et de rapprochement d\'Allah.',

        reponseEn: 'Ramadan is the 9th month of the Islamic calendar. It is the month in which the Qur\'an was revealed. Fasting (Siyam) is obligatory for every adult, sane and healthy Muslim. One abstains from eating, drinking and intimate relations from sunrise (Fajr) to sunset (Maghrib). It is a month of piety, generosity, Qur\'an recitation and drawing closer to Allah.',
        source: 'Coran, Al-Baqara 2:183-185',
      ),
      AssistantQA(
        id: 'ram2',
        questionFr: 'Qu\'est-ce qui annule le jeûne ?',

        questionEn: 'What invalidates the fast?',
        keywords: ['annule', 'jeune', 'invalide', 'rompt', 'casse'],
        reponseFr: 'Ce qui annule le jeûne :\n\n1. Manger ou boire volontairement\n2. Les rapports intimes\n3. Le vomissement volontaire\n4. Les menstrues ou les lochies (saignements post-accouchement)\n5. L\'injection nutritive (perfusion alimentaire)\n\nCe qui N\'annule PAS le jeûne : manger ou boire par oubli (on continue son jeûne), se rincer la bouche, utiliser le siwak, avaler sa salive, faire une prise de sang, vomir involontairement, utiliser du parfum, ou se baigner.',

        reponseEn: 'What invalidates the fast:\n\n1. Eating or drinking intentionally\n2. Intimate relations\n3. Intentional vomiting\n4. Menstruation or postpartum bleeding (lochia)\n5. Nutritional injection (intravenous feeding)\n\nWhat does NOT invalidate the fast: eating or drinking by forgetfulness (one continues the fast), rinsing the mouth, using a toothstick (siwak), swallowing saliva, blood draw, involuntary vomiting, using perfume, or bathing.',
        source: 'Fiqh as-Sunna ; Fatawa Ibn Baz',
      ),
      AssistantQA(
        id: 'ram3',
        questionFr: 'Qui est dispensé du jeûne ?',

        questionEn: 'Who is exempt from fasting?',
        keywords: ['dispense', 'exempt', 'pas jeuner', 'malade', 'enceinte', 'voyage'],
        reponseFr: 'Sont dispensés du jeûne :\n\n1. Le voyageur — il peut reporter les jours\n2. Le malade — s\'il craint que le jeûne aggrave sa maladie, il reporte\n3. La femme enceinte ou allaitante — si elle craint pour elle ou son enfant\n4. La femme en période de menstrues ou de lochies — elle reporte\n5. La personne âgée ou le malade chronique — ils donnent la fidya (nourrir un pauvre par jour manqué)\n6. L\'enfant pré-pubère — pas obligatoire mais encouragé progressivement\n\nLes jours manqués doivent être rattrapés avant le Ramadan suivant (sauf pour la fidya).',

        reponseEn: 'Those exempt from fasting:\n\n1. The traveller — may postpone the days\n2. The sick — if they fear the fast will worsen their illness, they postpone\n3. The pregnant or nursing woman — if she fears for herself or her child\n4. The menstruating woman or woman with postpartum bleeding — she postpones\n5. The elderly or chronically ill — they give fidya (feed a poor person per day missed)\n6. The pre-pubescent child — not obligatory but encouraged gradually\n\nThe missed days must be made up before the next Ramadan (except for fidya).',
        source: 'Coran, Al-Baqara 2:184-185',
      ),
      AssistantQA(
        id: 'ram4',
        questionFr: 'Quelles sont les sunna du Ramadan ?',

        questionEn: 'What are the Sunna practices of Ramadan?',
        keywords: ['sunna', 'ramadan', 'recommande', 'meilleur', 'tarawih'],
        reponseFr: 'Les sunna du Ramadan :\n\n1. Le Suhur (repas avant l\'aube) — le prendre même légèrement, c\'est une bénédiction\n2. Se hâter de rompre le jeûne au Maghrib — avec des dattes ou de l\'eau\n3. La du\'a de la rupture : « Dhahaba adh-dhama\'u wa abtallat al-\'uruq wa thabata al-ajru in sha Allah »\n4. Les prières de Tarawih — 8 ou 20 rak\'at après Icha\n5. La lecture du Coran — le terminer au moins une fois dans le mois\n6. La générosité — le Prophète ﷺ était le plus généreux en Ramadan\n7. L\'I\'tikaf — la retraite spirituelle dans les 10 derniers jours\n8. Rechercher Laylat al-Qadr dans les nuits impaires des 10 derniers jours',

        reponseEn: 'The Sunna of Ramadan:\n\n1. Suhur (pre-dawn meal) — eating it even lightly is a blessing\n2. Hastening to break the fast at Maghrib — with dates or water\n3. The supplication of breaking the fast: "Dhahaba al-dhama\'u wa abtallat al-\'uruq wa thabata al-ajru in sha Allah"\n4. Tarawih prayers — 8 or 20 rak\'at after Isha\n5. Qur\'an recitation — completing it at least once in the month\n6. Generosity — the Prophet was most generous during Ramadan\n7. I\'tikaf — spiritual retreat during the last 10 days\n8. Seeking Laylat al-Qadr on the odd nights of the last 10 days',
        source: 'Bukhari, Muslim',
      ),
      AssistantQA(
        id: 'ram5',
        questionFr: 'Qu\'est-ce que Laylat al-Qadr ?',

        questionEn: 'What is Laylat al-Qadr?',
        keywords: ['laylat', 'qadr', 'nuit', 'destin', 'meilleure'],
        reponseFr: 'Laylat al-Qadr (la Nuit du Destin) est la nuit où le Coran a été révélé. Elle est meilleure que 1000 mois, soit plus de 83 ans d\'adoration. Elle se trouve dans les 10 dernières nuits de Ramadan, probablement les nuits impaires (21, 23, 25, 27, 29).\n\nLe Prophète ﷺ a enseigné cette du\'a pour cette nuit : « Allahumma innaka \'afuwwun tuhibbu al-\'afwa fa\'fu \'anni » (Ô Allah, Tu es Le Pardonnant, Tu aimes le pardon, alors pardonne-moi).\n\nSignes possibles : nuit calme, ni trop chaude ni trop froide, le soleil se lève le matin sans rayons apparents.',

        reponseEn: 'Laylat al-Qadr (the Night of Power) is the night the Qur\'an was revealed. It is better than a thousand months, over 83 years of worship. It occurs in the last 10 nights of Ramadan, probably on the odd nights (21st, 23rd, 25th, 27th, 29th).\n\nThe Prophet taught this supplication for this night: "Allahumma innaka \'afuwwun tuhibbu al-\'afwa fa\'fu \'anni" (O Allah, You are the Pardoner, You love pardon, so pardon me).\n\nPossible signs: calm night, neither too hot nor too cold, the sun rises in the morning without apparent rays.',
        source: 'Coran, Al-Qadr 97:1-5 ; Tirmidhi',
      ),
      AssistantQA(
        id: 'ram6',
        questionFr: 'Qu\'est-ce que la Kaffarah et la Fidya ?',

        questionEn: 'What are Kaffarah and Fidya?',
        keywords: ['kaffarah', 'fidya', 'expiation', 'compensation', 'ramadan'],
        reponseFr: 'La Kaffarah et la Fidya sont deux compensations liées au jeûne :\n\nLa Fidya (compensation) :\n• Pour ceux qui ne PEUVENT PAS jeûner (maladie chronique, vieillesse)\n• Montant : nourrir un pauvre par jour manqué (environ un repas complet)\n• Elle remplace le jeûne quand le rattrapage est impossible\n\nLa Kaffarah (expiation) :\n• Pour ceux qui rompent VOLONTAIREMENT le jeûne sans excuse valide\n• Trois options dans cet ordre : libérer un esclave (obsolète), jeûner 60 jours consécutifs, ou nourrir 60 pauvres\n• Elle est beaucoup plus lourde que la fidya car il s\'agit d\'une transgression volontaire\n\nRattrapage simple :\n• Pour ceux qui ont manqué des jours pour une raison valide (voyage, maladie temporaire, menstrues)\n• Rattraper un jour pour chaque jour manqué, avant le Ramadan suivant',

        reponseEn: 'Kaffarah and Fidya are two compensations related to fasting:\n\nFidya (compensation):\n• For those who CANNOT fast (chronic illness, old age)\n• Amount: feed one poor person per day missed (approximately one full meal)\n• It replaces the fast when making up is impossible\n\nKaffarah (expiation):\n• For those who INTENTIONALLY break the fast without valid excuse\n• Three options in order: free a slave (obsolete), fast 60 consecutive days, or feed 60 poor people\n• It is much heavier than fidya as it is intentional transgression\n\nSimple make-up:\n• For those who missed days for valid reason (travel, temporary illness, menstruation)\n• Make up one day for each day missed, before next Ramadan',
        source: 'Coran, Al-Baqara 2:184 ; Bukhari',
      ),
      AssistantQA(
        id: 'ram7',
        questionFr: 'Comment organiser ses journées pendant le Ramadan ?',

        questionEn: 'How to organize your days during Ramadan?',
        keywords: ['organiser', 'ramadan', 'journee', 'programme', 'routine', 'conseil'],
        reponseFr: 'Programme type d\'une journée de Ramadan :\n\nAvant Fajr (Suhur) :\n• Se lever 30-45 min avant l\'aube\n• Manger un repas équilibré (dattes, eau, protéines, fibres)\n• Prier le Fajr en groupe si possible\n\nMatinée :\n• Lire du Coran (objectif : 1 juz par jour = terminer le Coran en 30 jours)\n• Adhkar du matin\n\nJournée :\n• Travailler normalement — le Ramadan n\'est pas un mois de paresse\n• Éviter la médisance, la colère, les futilités\n• Multiplier le dhikr et les du\'as\n\nAvant Maghrib :\n• Moment privilégié pour les du\'as — l\'invocation du jeûneur est exaucée\n\nIftar (rupture) :\n• Rompre avec des dattes et de l\'eau\n• Ne pas trop manger — « le pire récipient qu\'un homme puisse remplir est son ventre »\n\nSoirée :\n• Prière de Tarawih à la mosquée\n• Lecture du Coran\n• Les 10 dernières nuits : veiller, chercher Laylat al-Qadr',

        reponseEn: 'Typical Ramadan day program:\n\nBefore Fajr (Suhur):\n• Wake 30-45 minutes before dawn\n• Eat a balanced meal (dates, water, protein, fiber)\n• Pray Fajr in congregation if possible\n\nMorning:\n• Qur\'an recitation (goal: 1 juz per day = complete Qur\'an in 30 days)\n• Morning remembrances (adhkar)\n\nDay:\n• Work normally — Ramadan is not a month of laziness\n• Avoid slander, anger, frivolities\n• Increase dhikr and supplications\n\nBefore Maghrib:\n• Blessed time for supplications — the fasting person\'s supplication is answered\n\nIftar (breaking the fast):\n• Break with dates and water\n• Do not overeat — "the worst vessel a person fills is their stomach"\n\nEvening:\n• Tarawih prayer at the mosque\n• Qur\'an recitation\n• Last 10 nights: stay awake, seek Laylat al-Qadr',
        source: 'Conseils basés sur la Sunna',
      ),
    ],
  ),

  // ══════════════════════════════════════════════════════════════
  // HAJJ
  // ══════════════════════════════════════════════════════════════
  AssistantTopic(
    id: 'hajj',
    titleFr: 'Le Hajj',

    titleEn: 'Hajj',
    emoji: '🕋',
    descriptionFr: 'Le pèlerinage à La Mecque',

    descriptionEn: 'The pilgrimage to Mecca',
    questions: [
      AssistantQA(
        id: 'haj1',
        questionFr: 'Qu\'est-ce que le Hajj ?',

        questionEn: 'What is Hajj?',
        keywords: ['hajj', 'pelerinage', 'mecque', 'pilier'],
        reponseFr: 'Le Hajj est le 5e pilier de l\'Islam. C\'est le pèlerinage à La Mecque, obligatoire une fois dans la vie pour tout musulman qui en a la capacité physique et financière. Il se déroule du 8 au 13 Dhul Hijja (12e mois lunaire).\n\nLe Prophète ﷺ a dit : « Quiconque accomplit le Hajj sans commettre de péché ni d\'acte de désobéissance reviendra comme le jour où sa mère l\'a mis au monde » — c\'est-à-dire purifié de tous ses péchés.',

        reponseEn: 'Hajj is the 5th pillar of Islam. It is the pilgrimage to Mecca, obligatory once in a lifetime for every Muslim who has the physical and financial capacity. It takes place from the 8th to 13th of Dhul-Hijjah (12th lunar month).\n\nThe Prophet said: "Whoever performs Hajj without committing sin or disobedience will return as the day his mother gave birth to him" — meaning purified from all sins.',
        source: 'Coran, Al-Imran 3:97 ; Bukhari',
      ),
      AssistantQA(
        id: 'haj2',
        questionFr: 'Quelles sont les étapes du Hajj ?',

        questionEn: 'What are the stages of Hajj?',
        keywords: ['etapes', 'hajj', 'comment', 'deroulement', 'rites'],
        reponseFr: 'Les étapes du Hajj :\n\n1. Ihram — sacralisation à partir du Miqat (vêtements blancs pour les hommes, tenues modestes pour les femmes). Intention et Talbiya : « Labbayk Allahumma labbayk »\n\n2. 8 Dhul Hijja (Yawm at-Tarwiya) — se rendre à Mina, y prier les 5 prières\n\n3. 9 Dhul Hijja (Yawm \'Arafa) — station à \'Arafa, le pilier essentiel du Hajj. Du\'a intensive du Dhuhr au Maghrib\n\n4. Nuit à Muzdalifa — après le coucher du soleil, se rendre à Muzdalifa pour la nuit. Ramasser les cailloux\n\n5. 10 Dhul Hijja (Yawm an-Nahr) — lapidation de Jamrat al-\'Aqaba, sacrifice, rasage/coupe de cheveux, Tawaf al-Ifada, Sa\'i\n\n6. 11-13 Dhul Hijja (Ayyam at-Tashriq) — lapidation des 3 Jamarat chaque jour\n\n7. Tawaf al-Wada\' — circumambulation d\'adieu avant de quitter La Mecque',

        reponseEn: 'The stages of Hajj:\n\n1. Ihram — consecration from the Miqat (white clothes for men, modest dress for women). Intention and Talbiya: "Labbayk Allahumma labbayk"\n\n2. 8th Dhul-Hijjah (Yawm at-Tarwiya) — proceed to Mina, pray the 5 prayers there\n\n3. 9th Dhul-Hijjah (Yawm \'Arafah) — standing at \'Arafah, the essential pillar of Hajj. Intensive supplication from Dhuhr to Maghrib\n\n4. Night at Muzdalifah — after sunset, proceed to Muzdalifah for the night. Collect pebbles\n\n5. 10th Dhul-Hijjah (Yawm an-Nahr) — stoning of Jamrat al-\'Aqaba, sacrifice, shaving/cutting hair, Tawaf al-Ifada, Sa\'i\n\n6. 11th-13th Dhul-Hijjah (Ayyam at-Tashriq) — stone the 3 Jamarat each day\n\n7. Tawaf al-Wada\' — farewell circumambulation before leaving Mecca',
        source: 'Fiqh as-Sunna ; guides du Hajj',
      ),
      AssistantQA(
        id: 'haj3',
        questionFr: 'Quelles sont les conditions du Hajj ?',

        questionEn: 'What are the conditions for Hajj?',
        keywords: ['conditions', 'hajj', 'obligatoire', 'qui', 'capable'],
        reponseFr: 'Les conditions pour que le Hajj soit obligatoire :\n\n1. Être musulman\n2. Être pubère (majeur)\n3. Être sain d\'esprit\n4. Être libre (pas prisonnier)\n5. Avoir la capacité physique (santé)\n6. Avoir la capacité financière (voyage + dépenses + laisser de quoi vivre à sa famille)\n7. La sécurité du chemin\n8. Pour la femme : avoir un Mahram (accompagnateur masculin légitime) — selon la majorité des savants\n\nSi une personne meurt avant d\'avoir pu accomplir le Hajj alors qu\'elle en avait les moyens, quelqu\'un peut l\'accomplir à sa place.',

        reponseEn: 'Conditions for Hajj to be obligatory:\n\n1. Be Muslim\n2. Be of age (mature)\n3. Be of sound mind\n4. Be free (not imprisoned)\n5. Have physical capacity (health)\n6. Have financial capacity (travel + expenses + provisions for family)\n7. Safe passage to Hajj\n8. For women: have a Mahram (legitimate male companion) — according to the majority of scholars\n\nIf a person dies before being able to perform Hajj when they had the means, someone can perform it on their behalf.',
        source: 'Consensus des juristes',
      ),
    ],
  ),

  // ══════════════════════════════════════════════════════════════
  // OMRA
  // ══════════════════════════════════════════════════════════════
  AssistantTopic(
    id: 'omra',
    titleFr: 'La Omra',

    titleEn: 'Umrah',
    emoji: '🕌',
    descriptionFr: 'Le petit pèlerinage',

    descriptionEn: 'The lesser pilgrimage',
    questions: [
      AssistantQA(
        id: 'omr1',
        questionFr: 'Qu\'est-ce que la Omra ?',

        questionEn: 'What is Umrah?',
        keywords: ['omra', 'petit', 'pelerinage', 'difference', 'hajj'],
        reponseFr: 'La Omra est le « petit pèlerinage ». Contrairement au Hajj qui a des dates fixes, la Omra peut être accomplie à tout moment de l\'année. Selon la majorité des savants, elle est fortement recommandée (sunna mu\'akkada), et obligatoire une fois dans la vie selon l\'école Hanbalite.\n\nLe Prophète ﷺ a dit : « La Omra efface les péchés commis entre elle et la Omra précédente. »\n\nDifférence avec le Hajj : la Omra ne comprend pas la station à \'Arafa, Mina, Muzdalifa, ni la lapidation. Elle est beaucoup plus courte (quelques heures).',

        reponseEn: 'Umrah is the "lesser pilgrimage". Unlike Hajj which has fixed dates, Umrah can be performed any time of the year. According to the majority of scholars, it is strongly recommended (Sunna mu\'akkada), and obligatory once in a lifetime according to the Hanbali school.\n\nThe Prophet said: "Umrah wipes out sins committed between it and the previous Umrah."\n\nDifference with Hajj: Umrah does not include standing at \'Arafah, Mina, Muzdalifah, or stoning. It is much shorter (a few hours).',
        source: 'Bukhari, Muslim',
      ),
      AssistantQA(
        id: 'omr2',
        questionFr: 'Comment faire la Omra ?',

        questionEn: 'How to perform Umrah?',
        keywords: ['comment', 'omra', 'etapes', 'faire', 'rites'],
        reponseFr: 'Les étapes de la Omra :\n\n1. Ihram — sacralisation au Miqat. Ghusl (ablution majeure), vêtements d\'Ihram (2 draps blancs pour les hommes), intention et Talbiya : « Labbayk Allahumma labbayk, labbayka la sharika laka labbayk. Inna al-hamda wa an-ni\'mata laka wal-mulk, la sharika lak. »\n\n2. Tawaf — 7 tours autour de la Ka\'ba dans le sens inverse des aiguilles d\'une montre, en commençant par la Pierre Noire. Du\'a libre pendant le Tawaf. Finir par 2 rak\'at derrière le Maqam Ibrahim.\n\n3. Sa\'i — 7 allers-retours entre les monts Safa et Marwa, en commençant par Safa.\n\n4. Halq ou Taqsir — se raser la tête (halq, recommandé pour les hommes) ou se couper les cheveux (taqsir). Pour les femmes : couper la longueur d\'un doigt.\n\nAprès cela, la Omra est complète et on sort de l\'état d\'Ihram.',

        reponseEn: 'The steps of Umrah:\n\n1. Ihram — consecration at the Miqat. Ghusl (major ablution), Ihram clothes (2 white sheets for men), intention and Talbiya: "Labbayk Allahumma labbayk, labbayka la sharika laka labbayk. Inna al-hamda wa an-ni\'mata laka wal-mulk, la sharika lak."\n\n2. Tawaf — 7 circuits around the Ka\'ba counter-clockwise, starting from the Black Stone. Free supplication during Tawaf. Finish with 2 rak\'at behind Maqam Ibrahim.\n\n3. Sa\'i — 7 back-and-forth journeys between Safa and Marwa, starting from Safa.\n\n4. Halq or Taqsir — shaving the head (halq, recommended for men) or cutting hair (taqsir). For women: cut the length of a finger.\n\nAfter this, Umrah is complete and one exits the state of Ihram.',
        source: 'Fiqh as-Sunna',
      ),
    ],
  ),

  // ══════════════════════════════════════════════════════════════
  // PRIÈRE
  // ══════════════════════════════════════════════════════════════
  AssistantTopic(
    id: 'salat',
    titleFr: 'La Prière (Salat)',

    titleEn: 'Prayer (Salat)',
    emoji: '🤲',
    descriptionFr: 'Comment prier et les règles de la prière',

    descriptionEn: 'How to pray and the rules of prayer',
    questions: [
      AssistantQA(
        id: 'sal1',
        questionFr: 'Comment faire la prière ?',

        questionEn: 'How to pray?',
        keywords: ['comment', 'prier', 'priere', 'salat', 'apprendre'],
        reponseFr: 'Les étapes de la prière :\n\n1. Avoir le wudu (ablutions), être face à la Qibla, couvrir sa \'awra\n\n2. Takbirat al-Ihram — lever les mains et dire « Allahu Akbar »\n\n3. Du\'a d\'ouverture (Istiftah) — « Subhanaka Allahumma wa bihamdika... »\n\n4. Réciter Al-Fatiha (obligatoire à chaque rak\'a)\n\n5. Réciter une sourate ou des versets (1ère et 2ème rak\'a)\n\n6. Ruku\' — inclinaison en disant « Subhana Rabbiyal-\'Adhim » (3x)\n\n7. Se relever : « Sami\'a Allahu liman hamidah, Rabbana wa lakal-hamd »\n\n8. Sujud — prosternation en disant « Subhana Rabbiyal-A\'la » (3x)\n\n9. S\'asseoir entre les 2 sujud : « Rabbi ighfir li » (2x)\n\n10. 2ème sujud\n\n11. Tashahhud (assis) — « At-tahiyyatu lillahi... »\n\n12. Salat \'ala Nabi ﷺ (dans le dernier tashahhud)\n\n13. Taslim — tourner la tête à droite puis à gauche : « As-salamu \'alaykum wa rahmatullah »',

        reponseEn: 'The steps of prayer:\n\n1. Have wudu (ablutions), face the Qibla, cover your \'awra (private parts)\n\n2. Takbirat al-Ihram — raise hands and say "Allahu Akbar"\n\n3. Opening supplication (Istiftah) — "Subhanaka Allahumma wa bihamdika..."\n\n4. Recite Al-Fatiha (obligatory in each rak\'a)\n\n5. Recite a chapter or verses (1st and 2nd rak\'a)\n\n6. Ruku\' — bowing saying "Subhana Rabbiyal-\'Adhim" (3x)\n\n7. Stand up: "Sami\'a Allahu liman hamidah, Rabbana wa lakal-hamd"\n\n8. Sujud — prostration saying "Subhana Rabbiyal-A\'la" (3x)\n\n9. Sit between the 2 prostrations: "Rabbi ighfir li" (2x)\n\n10. 2nd prostration\n\n11. Tashahhud (sitting) — "At-tahiyyatu lillahi..."\n\n12. Prayer upon the Prophet in the final tashahhud\n\n13. Taslim — turn head right then left: "As-salamu \'alaykum wa rahmatullah"',
        source: 'Bukhari, Muslim',
      ),
      AssistantQA(
        id: 'sal2',
        questionFr: 'Combien de rak\'at pour chaque prière ?',

        questionEn: 'How many rak\'at for each prayer?',
        keywords: ['rakat', 'nombre', 'combien', 'prieres'],
        reponseFr: 'Nombre de rak\'at par prière obligatoire :\n\n• Fajr (Sobh) : 2 rak\'at\n• Dhuhr (Dohr) : 4 rak\'at\n• \'Asr : 4 rak\'at\n• Maghrib : 3 rak\'at\n• \'Isha (Icha) : 4 rak\'at\n\nPrières sunna (Rawatib) :\n• 2 avant Fajr (très recommandées)\n• 4 avant Dhuhr + 2 après\n• 2 après Maghrib\n• 2 après \'Isha\n\nAutres sunna :\n• Witr : 1, 3, 5, 7, 9 ou 11 rak\'at (après \'Isha)\n• Duha : 2 à 8 rak\'at (entre le lever du soleil et le zénith)\n• Tahajjud : 2 par 2, autant qu\'on veut (dernière partie de la nuit)',

        reponseEn: 'Number of rak\'at for obligatory prayers:\n\n• Fajr (dawn): 2 rak\'at\n• Dhuhr (midday): 4 rak\'at\n• \'Asr (afternoon): 4 rak\'at\n• Maghrib (sunset): 3 rak\'at\n• \'Isha (night): 4 rak\'at\n\nRecommended Sunna prayers (Rawatib):\n• 2 before Fajr (highly recommended)\n• 4 before Dhuhr + 2 after\n• 2 after Maghrib\n• 2 after \'Isha\n\nOther Sunna:\n• Witr: 1, 3, 5, 7, 9 or 11 rak\'at (after \'Isha)\n• Duha: 2 to 8 rak\'at (between sunrise and noon)\n• Tahajjud: 2 by 2, as many as desired (last part of night)',
        source: 'Muslim, Abu Dawud',
      ),
      AssistantQA(
        id: 'sal3',
        questionFr: 'Qu\'est-ce qui annule la prière ?',

        questionEn: 'What invalidates prayer?',
        keywords: ['annule', 'priere', 'invalide', 'coupe'],
        reponseFr: 'Ce qui annule la prière :\n\n1. Parler volontairement (autre que le dhikr de la prière)\n2. Manger ou boire\n3. Rire aux éclats (le sourire ne l\'annule pas)\n4. Tourner le dos à la Qibla\n5. Faire des mouvements excessifs et continus sans rapport avec la prière\n6. Perdre son wudu (gaz, saignement selon les écoles)\n7. Découvrir sa \'awra volontairement\n8. Ajouter volontairement un pilier (ex: un ruku\' en plus en sachant)\n\nCe qui N\'annule PAS : pleurer, tousser, éternuer, mouvement léger (gratter, ajuster un vêtement), tuer un scorpion ou un serpent.',

        reponseEn: 'What invalidates prayer:\n\n1. Speaking intentionally (other than prayer remembrances)\n2. Eating or drinking\n3. Laughing loudly (smiling does not invalidate)\n4. Turning away from the Qibla\n5. Excessive continuous movements unrelated to prayer\n6. Breaking wudu (wind, bleeding according to schools)\n7. Intentionally uncovering \'awra\n8. Intentionally adding a pillar (e.g. an extra ruku\' knowingly)\n\nWhat does NOT invalidate: crying, coughing, sneezing, slight movement (scratching, adjusting clothes), killing a scorpion or snake.',
        source: 'Fiqh as-Sunna',
      ),
      AssistantQA(
        id: 'sal4',
        questionFr: 'Comment faire la prière du vendredi (Jumu\'a) ?',

        questionEn: 'How to pray Friday prayer (Jumu\'ah)?',
        keywords: ['vendredi', 'jumua', 'jumu\'a', 'priere', 'khutba', 'sermon'],
        reponseFr: 'La prière du Vendredi (Salat al-Jumu\'a) est obligatoire pour tout homme musulman, libre, résident et en bonne santé :\n\nSunna avant Jumu\'a :\n• Le Ghusl (bain rituel) — fortement recommandé\n• Se parfumer et porter de beaux vêtements\n• Arriver tôt à la mosquée — plus on arrive tôt, plus la récompense est grande\n• Réciter sourate Al-Kahf — « Celui qui récite Al-Kahf le vendredi, une lumière l\'éclairera jusqu\'au vendredi suivant »\n\nDéroulement :\n1. Le Muezzin fait l\'Adhan\n2. L\'Imam monte sur le minbar et prononce 2 Khutba (sermons) séparées par une courte pause\n3. Pendant le sermon : écouter en silence, ne pas parler ni toucher les cailloux\n4. Prière de 2 rak\'at en commun (à voix haute)\n\nHeure exaucée : il y a une heure le vendredi où toute du\'a est acceptée. Le Prophète ﷺ a indiqué qu\'elle se trouve entre l\'assise de l\'Imam et la fin de la prière.',

        reponseEn: 'Friday prayer (Salat al-Jumu\'ah) is obligatory for every free, resident Muslim man in good health:\n\nSunna before Jumu\'ah:\n• Ghusl (ritual bath) — strongly recommended\n• Perfume and wear good clothes\n• Arrive early at the mosque — the earlier you arrive, the greater the reward\n• Recite Surah Al-Kahf — "Whoever recites Al-Kahf on Friday, a light will illuminate him until the next Friday"\n\nProcedure:\n1. The Muezzin gives the Adhan\n2. The Imam ascends the minbar and delivers 2 Khutbas (sermons) separated by a brief pause\n3. During the sermon: listen silently, do not speak or play with pebbles\n4. Prayer of 2 rak\'at in congregation (aloud)\n\nAnswered hour: There is an hour on Friday when every supplication is accepted. The Prophet indicated it is between the Imam\'s sitting down and the end of prayer.',
        source: 'Bukhari, Muslim',
      ),
      AssistantQA(
        id: 'sal5',
        questionFr: 'Qu\'est-ce que la prière de nuit (Tahajjud) ?',

        questionEn: 'What is the night prayer (Tahajjud)?',
        keywords: ['tahajjud', 'nuit', 'qiyam', 'layl', 'nocturne', 'tard'],
        reponseFr: 'Le Tahajjud (Qiyam al-Layl) est la prière nocturne, la meilleure prière après les 5 obligatoires :\n\nQuand ? Dans le dernier tiers de la nuit (environ 1h30-2h avant le Fajr). C\'est le moment où Allah descend au ciel le plus bas et dit : « Y a-t-il quelqu\'un qui M\'invoque pour que Je l\'exauce ? Qui Me demande pour que Je lui donne ? Qui Me demande pardon pour que Je lui pardonne ? »\n\nComment ?\n• Se lever, faire le wudu\n• Prier 2 rak\'at par 2 rak\'at (pas de nombre fixe)\n• Le Prophète ﷺ priait 11 rak\'at (8 de Tahajjud + 3 de Witr)\n• Réciter longuement si possible\n• Terminer par le Witr (1, 3, 5 ou plus de rak\'at, nombre impair)\n\nMérites : « La meilleure prière après l\'obligatoire est la prière de nuit. » (Muslim)\nLe Tahajjud est la marque des pieux : « Ils arrachaient leurs flancs de leurs lits pour invoquer leur Seigneur. » (As-Sajda 32:16)',

        reponseEn: 'Tahajjud (Qiyam al-Layl) is the night prayer, the best prayer after the 5 obligatory ones:\n\nWhen? In the last third of the night (approximately 1.5-2 hours before Fajr). It is when Allah descends to the lowest heaven and says: "Is there anyone who calls upon Me so I may answer? Who asks Me so I may give? Who seeks forgiveness so I may forgive?"\n\nHow?\n• Wake up and perform wudu\n• Pray 2 rak\'at by 2 rak\'at (no fixed number)\n• The Prophet prayed 11 rak\'at (8 of Tahajjud + 3 of Witr)\n• Recite at length if possible\n• End with Witr (1, 3, 5 or more rak\'at, odd numbers)\n\nMerits: "The best prayer after the obligatory is the night prayer." (Muslim)\nTahajjud is the mark of the pious: "They would pull themselves away from their beds to invoke their Lord." (As-Sajdah 32:16)',
        source: 'Bukhari, Muslim ; Coran, As-Sajda 32:16',
      ),
    ],
  ),

  // ══════════════════════════════════════════════════════════════
  // PURIFICATION
  // ══════════════════════════════════════════════════════════════
  AssistantTopic(
    id: 'purification',
    titleFr: 'Purification (Tahara)',

    titleEn: 'Purification (Tahara)',
    emoji: '💧',
    descriptionFr: 'Wudu, Ghusl, Tayammum',

    descriptionEn: 'Wudu, Ghusl, Tayammum',
    questions: [
      AssistantQA(
        id: 'pur1',
        questionFr: 'Comment faire le wudu (ablutions) ?',

        questionEn: 'How to perform wudu (ablution)?',
        keywords: ['wudu', 'ablution', 'comment', 'faire'],
        reponseFr: 'Les étapes du Wudu :\n\n1. Intention dans le cœur + dire « Bismillah »\n2. Laver les mains 3 fois\n3. Se rincer la bouche 3 fois (Madmada)\n4. Se rincer le nez 3 fois (Istinshaq)\n5. Laver le visage 3 fois (du front au menton, d\'une oreille à l\'autre)\n6. Laver les bras jusqu\'aux coudes 3 fois (en commençant par le droit)\n7. Essuyer la tête avec les mains mouillées (une fois, d\'avant en arrière et retour)\n8. Essuyer les oreilles (intérieur et extérieur)\n9. Laver les pieds jusqu\'aux chevilles 3 fois (en commençant par le droit)\n\nDu\'a après le wudu : « Ash-hadu an la ilaha illallah wahdahu la sharika lah, wa ash-hadu anna Muhammadan \'abduhu wa rasuluh. Allahumma ij\'alni min at-tawwabin wa ij\'alni min al-mutatahhirin. »',

        reponseEn: 'The steps of Wudu:\n\n1. Intention in the heart + say "Bismillah"\n2. Wash hands 3 times\n3. Rinse mouth 3 times (Madmada)\n4. Rinse nose 3 times (Istinshaq)\n5. Wash face 3 times (from forehead to chin, ear to ear)\n6. Wash arms to elbows 3 times (starting with right)\n7. Wipe the head with wet hands (once, from front to back and back)\n8. Wipe ears (inside and outside)\n9. Wash feet to ankles 3 times (starting with right)\n\nSupplication after wudu: "I testify that there is no god but Allah alone, without partners, and I testify that Muhammad is His servant and messenger. O Allah, make me among the repentant and among the purified."',
        source: 'Bukhari, Muslim',
      ),
      AssistantQA(
        id: 'pur2',
        questionFr: 'Qu\'est-ce qui annule le wudu ?',

        questionEn: 'What invalidates wudu?',
        keywords: ['annule', 'wudu', 'casse', 'ablution', 'perd'],
        reponseFr: 'Ce qui annule le wudu :\n\n1. Tout ce qui sort des voies naturelles (urine, selles, gaz, sang selon certaines écoles)\n2. Le sommeil profond (allongé ou incliné)\n3. La perte de conscience (évanouissement)\n4. Toucher les parties intimes directement sans barrière (selon certaines écoles)\n5. Manger de la viande de chameau (selon l\'école Hanbalite)\n\nCe qui N\'annule PAS le wudu : le doute (on reste sur la certitude), le saignement léger d\'une blessure (selon les Shafi\'ites et Malikites), le vomissement (divergence), toucher une femme (divergence entre les écoles).',

        reponseEn: 'What invalidates wudu:\n\n1. Anything exiting the natural passages (urine, stool, gas, blood according to some schools)\n2. Deep sleep (lying down or reclining)\n3. Loss of consciousness (fainting)\n4. Touching private parts directly without barrier (according to some schools)\n5. Eating camel meat (according to the Hanbali school)\n\nWhat does NOT invalidate wudu: doubt (remain on certainty), light bleeding from a wound (according to Shafi\'i and Maliki schools), vomiting (disagreement), touching a woman (disagreement between schools).',
        source: 'Fiqh comparé',
      ),
      AssistantQA(
        id: 'pur3',
        questionFr: 'Quand le Ghusl est-il obligatoire ?',

        questionEn: 'When is Ghusl obligatory?',
        keywords: ['ghusl', 'obligatoire', 'grande', 'ablution', 'douche'],
        reponseFr: 'Le Ghusl (ablution majeure) est obligatoire dans ces cas :\n\n1. Après les rapports intimes (même sans éjaculation)\n2. Après l\'éjaculation (même pendant le sommeil — rêve)\n3. Après les menstrues\n4. Après les lochies (saignements post-accouchement)\n5. En embrassant l\'Islam (pour le nouveau musulman)\n6. Après la mort (Ghusl du défunt)\n\nGhusl recommandé (sunna) : le vendredi, les deux \'Aïd, avant l\'Ihram, après avoir lavé un mort.\n\nComment faire le Ghusl : intention, Bismillah, laver les parties intimes, faire le wudu complet, verser l\'eau sur la tête 3 fois, puis laver tout le corps en commençant par le côté droit.',

        reponseEn: 'Ghusl (major ablution) is obligatory in these cases:\n\n1. After intimate relations (even without ejaculation)\n2. After ejaculation (even during sleep — wet dreams)\n3. After menstruation\n4. After postpartum bleeding (lochia)\n5. Upon entering Islam (for converts)\n6. After death (washing the deceased)\n\nRecommended Ghusl (Sunna): on Friday, both \'Eids, before Ihram, after washing the deceased.\n\nHow to perform Ghusl: intention, Bismillah, wash private parts, perform complete wudu, pour water over the head 3 times, then wash the entire body starting with the right side.',
        source: 'Bukhari, Muslim',
      ),
      AssistantQA(
        id: 'pur4',
        questionFr: 'Comment faire le Tayammum ?',

        questionEn: 'How to perform Tayammum?',
        keywords: ['tayammum', 'ablution', 'seche', 'sable', 'terre', 'eau'],
        reponseFr: 'Le Tayammum est l\'ablution sèche, une facilité d\'Allah quand l\'eau est indisponible ou nuisible :\n\nQuand le faire ?\n• Absence d\'eau (voyage, désert)\n• Eau insuffisante (juste assez pour boire)\n• Maladie ou blessure où l\'eau aggraverait l\'état\n• Eau extrêmement froide sans moyen de la chauffer et risque pour la santé\n\nComment faire ?\n1. Intention dans le cœur\n2. Dire « Bismillah »\n3. Frapper la terre propre (sable, pierre, sol) avec les deux paumes une fois\n4. Essuyer le visage avec les paumes\n5. Essuyer les mains et avant-bras (main droite puis gauche)\n\nRègles :\n• Le Tayammum remplace le Wudu ET le Ghusl\n• Il est annulé par les mêmes choses que le Wudu + la présence d\'eau\n• On peut prier autant qu\'on veut avec un seul Tayammum tant qu\'il n\'est pas annulé\n\nAllah dit : « Si vous ne trouvez pas d\'eau, alors recourez à une terre pure. » (An-Nisa 4:43)',

        reponseEn: 'Tayammum is dry ablution, an ease from Allah when water is unavailable or harmful:\n\nWhen to perform:\n• Absence of water (travel, desert)\n• Insufficient water (just enough to drink)\n• Illness or wound where water would worsen the condition\n• Extremely cold water with no means to heat it and risk to health\n\nHow to perform:\n1. Intention in the heart\n2. Say "Bismillah"\n3. Strike clean earth (sand, stone, soil) with both palms once\n4. Wipe the face with the palms\n5. Wipe the hands and forearms (right hand then left)\n\nRules:\n• Tayammum replaces both Wudu AND Ghusl\n• It is nullified by the same things as Wudu + presence of water\n• One can pray as many times as desired with one Tayammum as long as it is not nullified\n\nAllah says: "If you do not find water, then use pure earth." (An-Nisa 4:43)',
        source: 'Coran, An-Nisa 4:43 ; Al-Ma\'ida 5:6',
      ),
    ],
  ),

  // ══════════════════════════════════════════════════════════════
  // MARIAGE
  // ══════════════════════════════════════════════════════════════
  AssistantTopic(
    id: 'mariage',
    titleFr: 'Le Mariage',

    titleEn: 'Marriage',
    emoji: '💍',
    descriptionFr: 'Le mariage islamique, droits et devoirs',

    descriptionEn: 'Islamic marriage, rights and duties',
    questions: [
      AssistantQA(
        id: 'mar1',
        questionFr: 'Comment se déroule un mariage islamique ?',

        questionEn: 'What is Ramadan?',
        keywords: ['mariage', 'comment', 'nikah', 'islamique', 'ceremonie'],
        reponseFr: 'Le mariage islamique (Nikah) comporte ces éléments essentiels :\n\n1. Le consentement des deux époux — la femme a le droit absolu de refuser\n2. Le Wali (tuteur) de la femme — généralement son père\n3. Deux témoins musulmans\n4. Le Mahr (dot) — un cadeau du mari à la femme, qui lui appartient entièrement\n5. L\'offre et l\'acceptation (Ijab wa Qabul)\n\nSunna du mariage : un Khutba (sermon) avant le contrat, annoncer le mariage publiquement, organiser une Walima (repas de noces), invoquer Allah pour les mariés : « Barakallahu lakuma wa baraka \'alaykuma wa jama\'a baynakuma fi khayr. »\n\nLe mariage en Islam est un contrat civil et religieux, pas un sacrement. Il peut inclure des conditions acceptées par les deux parties.',

        reponseEn: 'Ramadan is the 9th month of the Islamic calendar. It is the month in which the Qur\'an was revealed. Fasting (Siyam) is obligatory for every adult, sane and healthy Muslim. One abstains from eating, drinking and intimate relations from sunrise (Fajr) to sunset (Maghrib). It is a month of piety, generosity, Qur\'an recitation and drawing closer to Allah.',
        source: 'Bukhari, Muslim, Abu Dawud',
      ),
      AssistantQA(
        id: 'mar2',
        questionFr: 'Quels sont les droits de la femme dans le mariage ?',

        questionEn: 'What invalidates the fast?',
        keywords: ['droits', 'femme', 'epouse', 'mariage', 'mari'],
        reponseFr: 'Les droits de l\'épouse en Islam :\n\n1. Le Mahr — la dot lui appartient entièrement, le mari ne peut pas la reprendre\n2. L\'entretien (Nafaqa) — le mari doit pourvoir au logement, à la nourriture, aux vêtements et aux soins, selon ses moyens\n3. Le bon traitement — « Le meilleur d\'entre vous est celui qui est le meilleur envers sa femme » — Tirmidhi\n4. Le respect et la dignité — interdiction de l\'humilier, de la rabaisser ou de la frapper\n5. Le droit à l\'intimité et à la vie conjugale\n6. Le droit à l\'éducation et au travail — avec concertation\n7. Le droit de garder son nom de famille\n8. Le droit de posséder ses propres biens — indépendance financière totale\n9. Le droit de demander le divorce (Khul\') si nécessaire\n10. Le droit à la justice en cas de polygamie',

        reponseEn: 'What invalidates the fast:\n\n1. Eating or drinking intentionally\n2. Intimate relations\n3. Intentional vomiting\n4. Menstruation or postpartum bleeding (lochia)\n5. Nutritional injection (intravenous feeding)\n\nWhat does NOT invalidate the fast: eating or drinking by forgetfulness (one continues the fast), rinsing the mouth, using a toothstick (siwak), swallowing saliva, blood draw, involuntary vomiting, using perfume, or bathing.',
        source: 'Coran, An-Nisa 4:19 ; Tirmidhi',
      ),
      AssistantQA(
        id: 'mar3',
        questionFr: 'Quels sont les droits du mari dans le mariage ?',

        questionEn: 'Who is exempt from fasting?',
        keywords: ['droits', 'mari', 'epoux', 'homme', 'mariage'],
        reponseFr: 'Les droits de l\'époux en Islam :\n\n1. Le respect et la bienveillance mutuels\n2. La gestion du foyer — le mari est responsable (Qawwam) de l\'entretien financier et de la protection de la famille\n3. La loyauté et la fidélité réciproques\n4. La préservation de l\'honneur et des biens du foyer en son absence\n5. L\'obéissance dans le bien (Ma\'ruf) — pas dans la désobéissance à Allah\n6. La concertation (Shura) dans les décisions familiales\n\nImportant : le concept de Qawwama (responsabilité de l\'homme) signifie protéger, subvenir et guider, PAS dominer ou opprimer. Le Prophète ﷺ aidait à la maison, raccommodait ses vêtements et servait sa famille. Le couple est basé sur la complémentarité, pas la hiérarchie.',

        reponseEn: 'Those exempt from fasting:\n\n1. The traveller — may postpone the days\n2. The sick — if they fear the fast will worsen their illness, they postpone\n3. The pregnant or nursing woman — if she fears for herself or her child\n4. The menstruating woman or woman with postpartum bleeding — she postpones\n5. The elderly or chronically ill — they give fidya (feed a poor person per day missed)\n6. The pre-pubescent child — not obligatory but encouraged gradually\n\nThe missed days must be made up before the next Ramadan (except for fidya).',
        source: 'Coran, An-Nisa 4:34 ; Al-Baqara 2:228 ; Bukhari',
      ),
      AssistantQA(
        id: 'mar4',
        questionFr: 'Qu\'est-ce que la polygamie en Islam ?',

        questionEn: 'What are the Sunna practices of Ramadan?',
        keywords: ['polygamie', 'plusieurs', 'femmes', 'epouses', 'quatre', 'conditions'],
        reponseFr: 'La polygamie en Islam est une permission conditionnelle, pas une obligation ni un encouragement :\n\nLe Coran dit : « Épousez ce qui vous plaît parmi les femmes, deux, trois ou quatre. Mais si vous craignez de ne pas être justes, alors une seule. » (An-Nisa 4:3)\n\nConditions strictes :\n1. La justice absolue — traiter toutes les épouses de manière équitable en nourriture, logement, vêtements et temps passé\n2. La capacité financière — pouvoir entretenir dignement chaque foyer\n3. La capacité physique et émotionnelle\n4. Ne pas dépasser 4 épouses simultanément\n\nRéalités :\n• Allah dit : « Vous ne pourrez jamais être justes envers vos femmes, même si vous le désirez » (An-Nisa 4:129) — montrant la difficulté extrême de cette justice\n• La grande majorité des musulmans sont monogames\n• La première épouse a le droit d\'inscrire une clause d\'exclusivité dans le contrat de mariage\n• Le consentement de la première épouse n\'est pas une condition juridique mais est recommandé\n\nContexte historique : cette permission a été révélée après la bataille d\'Uhud pour prendre en charge les veuves et orphelins.',

        reponseEn: 'The Sunna of Ramadan:\n\n1. Suhur (pre-dawn meal) — eating it even lightly is a blessing\n2. Hastening to break the fast at Maghrib — with dates or water\n3. The supplication of breaking the fast: "Dhahaba al-dhama\'u wa abtallat al-\'uruq wa thabata al-ajru in sha Allah"\n4. Tarawih prayers — 8 or 20 rak\'at after Isha\n5. Qur\'an recitation — completing it at least once in the month\n6. Generosity — the Prophet was most generous during Ramadan\n7. I\'tikaf — spiritual retreat during the last 10 days\n8. Seeking Laylat al-Qadr on the odd nights of the last 10 days',
        source: 'Coran, An-Nisa 4:3, 4:129',
      ),
    ],
  ),

  // ══════════════════════════════════════════════════════════════
  // RÔLES HOMME / FEMME
  // ══════════════════════════════════════════════════════════════
  AssistantTopic(
    id: 'roles',
    titleFr: 'Homme et Femme en Islam',

    titleEn: 'Men and Women in Islam',
    emoji: '⚖️',
    descriptionFr: 'Complémentarité et dignité',

    descriptionEn: 'Complementarity and dignity',
    questions: [
      AssistantQA(
        id: 'rol1',
        questionFr: 'Quel est le rôle de l\'homme en Islam ?',

        questionEn: 'What is Laylat al-Qadr?',
        keywords: ['role', 'homme', 'responsabilite', 'pere', 'mari'],
        reponseFr: 'Le rôle de l\'homme en Islam :\n\nEnvers sa famille : il est le protecteur et le pourvoyeur (Qawwam). Il doit subvenir aux besoins de sa femme et de ses enfants, les protéger physiquement et moralement, et les guider dans la foi.\n\nEnvers sa femme : la traiter avec douceur, miséricorde et respect. Le Prophète ﷺ a dit : « Le croyant qui a la foi la plus complète est celui qui a le meilleur caractère, et les meilleurs d\'entre vous sont les meilleurs envers leurs femmes. »\n\nEnvers ses enfants : leur donner une éducation religieuse et mondaine, passer du temps avec eux, jouer avec eux (le Prophète ﷺ portait ses petits-enfants sur ses épaules).\n\nEnvers la société : être juste, travailler, contribuer au bien commun, commander le bien et interdire le mal.\n\nL\'homme en Islam n\'est PAS un tyran — il est un berger responsable de son troupeau.',

        reponseEn: 'Laylat al-Qadr (the Night of Power) is the night the Qur\'an was revealed. It is better than a thousand months, over 83 years of worship. It occurs in the last 10 nights of Ramadan, probably on the odd nights (21st, 23rd, 25th, 27th, 29th).\n\nThe Prophet taught this supplication for this night: "Allahumma innaka \'afuwwun tuhibbu al-\'afwa fa\'fu \'anni" (O Allah, You are the Pardoner, You love pardon, so pardon me).\n\nPossible signs: calm night, neither too hot nor too cold, the sun rises in the morning without apparent rays.',
        source: 'Tirmidhi ; Bukhari',
      ),
      AssistantQA(
        id: 'rol2',
        questionFr: 'Quel est le rôle de la femme en Islam ?',

        questionEn: 'What are Kaffarah and Fidya?',
        keywords: ['role', 'femme', 'mere', 'epouse', 'islam'],
        reponseFr: 'La femme en Islam a une place d\'honneur :\n\nEn tant que mère : « Le Paradis est sous les pieds des mères. » La mère a 3 fois plus de droit à la bonne compagnie que le père (hadith).\n\nEn tant qu\'épouse : elle est la partenaire de vie, la confidente. Le Coran dit qu\'hommes et femmes sont « un vêtement l\'un pour l\'autre » (Al-Baqara 2:187).\n\nEn tant que membre de la société : la femme peut travailler, étudier, faire du commerce, posséder des biens, et donner son avis. Khadija était une grande commerçante. Aïcha était une grande savante qui enseignait aux compagnons.\n\nL\'Islam a donné à la femme le droit à l\'héritage, à la propriété, au divorce, au consentement dans le mariage — 1400 ans avant les lois occidentales.\n\nLa modestie (Hijab) est un acte d\'adoration et de dignité, pas de soumission à l\'homme.',

        reponseEn: 'Kaffarah and Fidya are two compensations related to fasting:\n\nFidya (compensation):\n• For those who CANNOT fast (chronic illness, old age)\n• Amount: feed one poor person per day missed (approximately one full meal)\n• It replaces the fast when making up is impossible\n\nKaffarah (expiation):\n• For those who INTENTIONALLY break the fast without valid excuse\n• Three options in order: free a slave (obsolete), fast 60 consecutive days, or feed 60 poor people\n• It is much heavier than fidya as it is intentional transgression\n\nSimple make-up:\n• For those who missed days for valid reason (travel, temporary illness, menstruation)\n• Make up one day for each day missed, before next Ramadan',
        source: 'Coran, An-Nisa 4:1 ; Ahmad ; Bukhari',
      ),
    ],
  ),

  // ══════════════════════════════════════════════════════════════
  // DIVORCE
  // ══════════════════════════════════════════════════════════════
  AssistantTopic(
    id: 'divorce',
    titleFr: 'Le Divorce',

    titleEn: 'Divorce',
    emoji: '💔',
    descriptionFr: 'Les règles du divorce en Islam',

    descriptionEn: 'The rules of divorce in Islam',
    questions: [
      AssistantQA(
        id: 'div1',
        questionFr: 'Comment se passe le divorce en Islam ?',

        questionEn: 'How to organize your days during Ramadan?',
        keywords: ['divorce', 'talaq', 'comment', 'separation', 'islam'],
        reponseFr: 'Le divorce (Talaq) en Islam est permis mais c\'est l\'acte licite le plus détesté par Allah. Il est le dernier recours après avoir épuisé toutes les tentatives de réconciliation.\n\nTypes de divorce :\n\n1. Talaq (initiative du mari) — il prononce le divorce une fois. Suit une période d\'attente (\'Iddah) de 3 cycles menstruels. Pendant ce temps, la femme reste au domicile et le couple peut se réconcilier.\n\n2. Khul\' (initiative de la femme) — elle demande le divorce en restituant le mahr ou une compensation.\n\n3. Faskh (annulation judiciaire) — par un juge, en cas de préjudice grave.\n\nRègles importantes :\n• Le divorce ne se prononce PAS pendant les menstrues\n• Il ne se prononce PAS sous la colère extrême\n• Après 3 divorces, le couple ne peut se remarier qu\'après que la femme ait épousé quelqu\'un d\'autre (mariage réel, pas simulé)\n• Le mari doit continuer à entretenir la femme pendant la \'Iddah',

        reponseEn: 'Typical Ramadan day program:\n\nBefore Fajr (Suhur):\n• Wake 30-45 minutes before dawn\n• Eat a balanced meal (dates, water, protein, fiber)\n• Pray Fajr in congregation if possible\n\nMorning:\n• Qur\'an recitation (goal: 1 juz per day = complete Qur\'an in 30 days)\n• Morning remembrances (adhkar)\n\nDay:\n• Work normally — Ramadan is not a month of laziness\n• Avoid slander, anger, frivolities\n• Increase dhikr and supplications\n\nBefore Maghrib:\n• Blessed time for supplications — the fasting person\'s supplication is answered\n\nIftar (breaking the fast):\n• Break with dates and water\n• Do not overeat — "the worst vessel a person fills is their stomach"\n\nEvening:\n• Tarawih prayer at the mosque\n• Qur\'an recitation\n• Last 10 nights: stay awake, seek Laylat al-Qadr',
        source: 'Coran, Al-Baqara 2:229-230 ; At-Talaq 65:1-2',
      ),
      AssistantQA(
        id: 'div2',
        questionFr: 'Quels sont les droits de la femme après le divorce ?',

        questionEn: 'What is Hajj?',
        keywords: ['droits', 'femme', 'apres', 'divorce', 'garde'],
        reponseFr: 'Les droits de la femme après le divorce :\n\n1. L\'entretien pendant la \'Iddah — logement, nourriture, vêtements\n2. Le Mahr différé — si une partie du mahr n\'a pas été versée\n3. La Mut\'ah (cadeau de consolation) — recommandée\n4. La garde des enfants (Hadana) — la mère a la priorité pour les jeunes enfants (jusqu\'à 7 ans environ selon les écoles)\n5. La pension alimentaire des enfants — à la charge du père\n6. Le droit de se remarier après la \'Iddah\n\nImportant : les enfants ne sont la « propriété » d\'aucun des parents. L\'intérêt de l\'enfant prime. Le père reste responsable financièrement même s\'il n\'a pas la garde. Les deux parents gardent un droit de visite.',

        reponseEn: 'Hajj is the 5th pillar of Islam. It is the pilgrimage to Mecca, obligatory once in a lifetime for every Muslim who has the physical and financial capacity. It takes place from the 8th to 13th of Dhul-Hijjah (12th lunar month).\n\nThe Prophet said: "Whoever performs Hajj without committing sin or disobedience will return as the day his mother gave birth to him" — meaning purified from all sins.',
        source: 'Coran, Al-Baqara 2:233, 2:241 ; At-Talaq 65:6',
      ),
    ],
  ),

  // ══════════════════════════════════════════════════════════════
  // ÉDUCATION DES ENFANTS
  // ══════════════════════════════════════════════════════════════
  AssistantTopic(
    id: 'education',
    titleFr: 'Éducation des Enfants',

    titleEn: 'Children\'s Education',
    emoji: '👶',
    descriptionFr: 'La méthode prophétique d\'éducation',
    descriptionEn: 'The prophetic method of upbringing',
    questions: [
      AssistantQA(
        id: 'edu1',
        questionFr: 'Comment éduquer ses enfants en Islam ?',

        questionEn: 'What are the stages of Hajj?',
        keywords: ['eduquer', 'enfants', 'education', 'elever', 'methode'],
        reponseFr: 'La méthode prophétique d\'éducation :\n\n1. L\'amour et la tendresse — le Prophète ﷺ embrassait ses petits-enfants et jouait avec eux. Quand un bédouin dit qu\'il n\'embrassait jamais ses enfants, le Prophète ﷺ répondit : « Que puis-je pour toi si Allah a retiré la miséricorde de ton cœur ? »\n\n2. Le bon exemple (Qudwa) — les enfants imitent, pas les discours. Soyez ce que vous voulez que vos enfants deviennent.\n\n3. La douceur avant la fermeté — « Allah est doux et aime la douceur en toute chose. »\n\n4. L\'équité entre les enfants — ne pas favoriser un enfant sur un autre\n\n5. L\'encouragement et la valorisation — féliciter les bons comportements\n\n6. Le dialogue — expliquer le pourquoi des règles, pas juste imposer\n\n7. La patience — l\'éducation est un investissement à long terme\n\n8. La du\'a — invoquer Allah pour la guidance de ses enfants',

        reponseEn: 'The stages of Hajj:\n\n1. Ihram — consecration from the Miqat (white clothes for men, modest dress for women). Intention and Talbiya: "Labbayk Allahumma labbayk"\n\n2. 8th Dhul-Hijjah (Yawm at-Tarwiya) — proceed to Mina, pray the 5 prayers there\n\n3. 9th Dhul-Hijjah (Yawm \'Arafah) — standing at \'Arafah, the essential pillar of Hajj. Intensive supplication from Dhuhr to Maghrib\n\n4. Night at Muzdalifah — after sunset, proceed to Muzdalifah for the night. Collect pebbles\n\n5. 10th Dhul-Hijjah (Yawm an-Nahr) — stoning of Jamrat al-\'Aqaba, sacrifice, shaving/cutting hair, Tawaf al-Ifada, Sa\'i\n\n6. 11th-13th Dhul-Hijjah (Ayyam at-Tashriq) — stone the 3 Jamarat each day\n\n7. Tawaf al-Wada\' — farewell circumambulation before leaving Mecca',
        source: 'Bukhari, Muslim',
      ),
      AssistantQA(
        id: 'edu2',
        questionFr: 'À quel âge apprendre la prière aux enfants ?',

        questionEn: 'What are the conditions for Hajj?',
        keywords: ['age', 'priere', 'enfant', 'apprendre', 'quand', 'commencer'],
        reponseFr: 'Le Prophète ﷺ a dit : « Ordonnez la prière à vos enfants à 7 ans, et corrigez-les (légèrement) s\'ils ne la font pas à 10 ans. »\n\nProgression recommandée :\n\n• 3-4 ans : l\'enfant voit ses parents prier, il imite naturellement\n• 5-6 ans : lui apprendre Al-Fatiha et de petites sourates\n• 7 ans : lui enseigner la prière complète et l\'encourager à prier régulièrement\n• 10 ans : la prière devient une habitude établie\n• Puberté : la prière devient obligatoire\n\nConseils : rendre la prière agréable (pas une punition), prier en famille, féliciter l\'enfant quand il prie, lui offrir un tapis de prière qui lui plaît, ne jamais associer la prière à la douleur ou la punition.',

        reponseEn: 'Conditions for Hajj to be obligatory:\n\n1. Be Muslim\n2. Be of age (mature)\n3. Be of sound mind\n4. Be free (not imprisoned)\n5. Have physical capacity (health)\n6. Have financial capacity (travel + expenses + provisions for family)\n7. Safe passage to Hajj\n8. For women: have a Mahram (legitimate male companion) — according to the majority of scholars\n\nIf a person dies before being able to perform Hajj when they had the means, someone can perform it on their behalf.',
        source: 'Abu Dawud',
      ),
      AssistantQA(
        id: 'edu3',
        questionFr: 'Comment apprendre le Coran aux enfants ?',

        questionEn: 'What is Umrah?',
        keywords: ['coran', 'enfant', 'apprendre', 'memoriser', 'hifz'],
        reponseFr: 'Méthode pour enseigner le Coran aux enfants :\n\n1. Commencer tôt — dès 3-4 ans avec l\'écoute. Le cerveau de l\'enfant est une éponge.\n\n2. La répétition douce — réciter souvent les sourates courtes (Juz\' Amma) en voiture, avant le dodo, etc.\n\n3. Commencer par les sourates courtes — An-Nas, Al-Falaq, Al-Ikhlas, Al-Masad... en remontant.\n\n4. L\'audio — écouter un récitateur avec une belle voix (Mishary, Husary, Minshawi pour enfants)\n\n5. La compréhension — expliquer le sens simplement. L\'enfant retient mieux ce qu\'il comprend.\n\n6. La régularité — 10-15 min par jour valent mieux qu\'une heure par semaine\n\n7. La récompense — féliciter, encourager, petits cadeaux pour les étapes franchies\n\n8. L\'école coranique (Maktab/Dar al-Quran) — l\'apprentissage en groupe motive\n\n9. La patience — chaque enfant a son rythme. Ne jamais comparer.',

        reponseEn: 'Umrah is the "lesser pilgrimage". Unlike Hajj which has fixed dates, Umrah can be performed any time of the year. According to the majority of scholars, it is strongly recommended (Sunna mu\'akkada), and obligatory once in a lifetime according to the Hanbali school.\n\nThe Prophet said: "Umrah wipes out sins committed between it and the previous Umrah."\n\nDifference with Hajj: Umrah does not include standing at \'Arafah, Mina, Muzdalifah, or stoning. It is much shorter (a few hours).',
        source: 'Conseils pédagogiques islamiques',
      ),
    ],
  ),

  // ══════════════════════════════════════════════════════════════
  // ALIMENTATION
  // ══════════════════════════════════════════════════════════════
  AssistantTopic(
    id: 'alimentation',
    titleFr: 'Alimentation Halal',

    titleEn: 'Halal Food',
    emoji: '🍖',
    descriptionFr: 'Ce qui est licite et illicite',

    descriptionEn: 'What is lawful and unlawful',
    questions: [
      AssistantQA(
        id: 'ali1',
        questionFr: 'Qu\'est-ce qui est halal et haram en nourriture ?',

        questionEn: 'How to perform Umrah?',
        keywords: ['halal', 'haram', 'nourriture', 'manger', 'interdit', 'permis'],
        reponseFr: 'Règles alimentaires en Islam :\n\nHaram (interdit) :\n• Le porc et ses dérivés (gélatine porcine, saindoux)\n• L\'alcool et les substances enivrantes\n• La viande non égorgée au nom d\'Allah (sauf les gens du Livre selon certains avis)\n• La viande d\'animaux morts naturellement (Mayta)\n• Le sang coulé\n• Les animaux carnivores et les oiseaux de proie\n• L\'âne domestique\n\nHalal (permis) :\n• Tous les fruits, légumes, céréales, légumineuses\n• Les fruits de mer (poissons et fruits de mer — tous halal sans égorgement)\n• La viande égorgée au nom d\'Allah (Dhabiha)\n• Les produits laitiers, les œufs, le miel\n\nEn cas de nécessité vitale (risque de mort), le haram devient temporairement permis pour survivre.',

        reponseEn: 'The steps of Umrah:\n\n1. Ihram — consecration at the Miqat. Ghusl (major ablution), Ihram clothes (2 white sheets for men), intention and Talbiya: "Labbayk Allahumma labbayk, labbayka la sharika laka labbayk. Inna al-hamda wa an-ni\'mata laka wal-mulk, la sharika lak."\n\n2. Tawaf — 7 circuits around the Ka\'ba counter-clockwise, starting from the Black Stone. Free supplication during Tawaf. Finish with 2 rak\'at behind Maqam Ibrahim.\n\n3. Sa\'i — 7 back-and-forth journeys between Safa and Marwa, starting from Safa.\n\n4. Halq or Taqsir — shaving the head (halq, recommended for men) or cutting hair (taqsir). For women: cut the length of a finger.\n\nAfter this, Umrah is complete and one exits the state of Ihram.',
        source: 'Coran, Al-Ma\'ida 5:3 ; Al-Baqara 2:173',
      ),
      AssistantQA(
        id: 'ali2',
        questionFr: 'Quelles sont les bonnes manières à table en Islam ?',

        questionEn: 'How to pray?',
        keywords: ['table', 'manger', 'adab', 'maniere', 'nourriture', 'repas'],
        reponseFr: 'Les adab (bonnes manières) à table selon la Sunna :\n\nAvant de manger :\n• Dire « Bismillah » (Au nom d\'Allah)\n• Se laver les mains\n\nPendant le repas :\n• Manger de la main droite — « Mangez de votre main droite » (Muslim)\n• Manger de ce qui est devant soi — ne pas piocher dans le plat des autres\n• Ne pas souffler sur la nourriture chaude — attendre qu\'elle refroidisse\n• Ne pas critiquer la nourriture — le Prophète ﷺ ne critiquait jamais un plat\n• Manger avec modération — « Remplis un tiers de ton estomac de nourriture, un tiers d\'eau, et laisse un tiers pour l\'air » (Tirmidhi)\n• Manger ensemble — « Rassemblez-vous pour manger et mentionnez le nom d\'Allah, vous serez bénis » (Abu Dawud)\n\nAprès le repas :\n• Dire « Al-hamdu lillah »\n• Se lécher les doigts avant de les essuyer\n• Ne pas gaspiller — le gaspillage est interdit en Islam',

        reponseEn: 'The steps of prayer:\n\n1. Have wudu (ablutions), face the Qibla, cover your \'awra (private parts)\n\n2. Takbirat al-Ihram — raise hands and say "Allahu Akbar"\n\n3. Opening supplication (Istiftah) — "Subhanaka Allahumma wa bihamdika..."\n\n4. Recite Al-Fatiha (obligatory in each rak\'a)\n\n5. Recite a chapter or verses (1st and 2nd rak\'a)\n\n6. Ruku\' — bowing saying "Subhana Rabbiyal-\'Adhim" (3x)\n\n7. Stand up: "Sami\'a Allahu liman hamidah, Rabbana wa lakal-hamd"\n\n8. Sujud — prostration saying "Subhana Rabbiyal-A\'la" (3x)\n\n9. Sit between the 2 prostrations: "Rabbi ighfir li" (2x)\n\n10. 2nd prostration\n\n11. Tashahhud (sitting) — "At-tahiyyatu lillahi..."\n\n12. Prayer upon the Prophet in the final tashahhud\n\n13. Taslim — turn head right then left: "As-salamu \'alaykum wa rahmatullah"',
        source: 'Bukhari, Muslim ; Tirmidhi',
      ),
      AssistantQA(
        id: 'ali3',
        questionFr: 'L\'alcool et les substances illicites en Islam',

        questionEn: 'How many rak\'at for each prayer?',
        keywords: ['alcool', 'drogue', 'vin', 'biere', 'haram', 'substance', 'interdit', 'khamr'],
        reponseFr: 'L\'interdiction de l\'alcool (Al-Khamr) en Islam est catégorique :\n\nLe Coran dit : « Le vin, le jeu de hasard, les pierres dressées et les flèches divinatoires sont une abomination, une œuvre du Diable. Écartez-vous-en afin que vous réussissiez. » (Al-Ma\'ida 5:90)\n\nCe qui est interdit :\n• Toute boisson enivrante, quelle que soit la quantité — « Ce dont une grande quantité enivre, même une petite quantité est interdite » (Tirmidhi)\n• Les drogues et substances altérant la raison\n• Vendre, acheter, transporter ou servir de l\'alcool\n• Cuisiner avec de l\'alcool\n\nSagesse de l\'interdiction :\n• Protéger la raison (Al-\'Aql) — l\'un des 5 objectifs de la Charia\n• L\'alcool est la « mère de tous les vices » (Umm al-Khaba\'ith)\n• Il détruit la santé, les familles et les sociétés\n\nPour celui qui est dépendant : la porte du repentir est ouverte. Allah aide celui qui veut sincèrement arrêter. Chercher de l\'aide médicale est recommandé.',

        reponseEn: 'Number of rak\'at for obligatory prayers:\n\n• Fajr (dawn): 2 rak\'at\n• Dhuhr (midday): 4 rak\'at\n• \'Asr (afternoon): 4 rak\'at\n• Maghrib (sunset): 3 rak\'at\n• \'Isha (night): 4 rak\'at\n\nRecommended Sunna prayers (Rawatib):\n• 2 before Fajr (highly recommended)\n• 4 before Dhuhr + 2 after\n• 2 after Maghrib\n• 2 after \'Isha\n\nOther Sunna:\n• Witr: 1, 3, 5, 7, 9 or 11 rak\'at (after \'Isha)\n• Duha: 2 to 8 rak\'at (between sunrise and noon)\n• Tahajjud: 2 by 2, as many as desired (last part of night)',
        source: 'Coran, Al-Ma\'ida 5:90-91 ; Tirmidhi',
      ),
    ],
  ),

  // ══════════════════════════════════════════════════════════════
  // FUNÉRAILLES
  // ══════════════════════════════════════════════════════════════
  AssistantTopic(
    id: 'funerailles',
    titleFr: 'Les Funérailles',

    titleEn: 'Funerals',
    emoji: '🕊️',
    descriptionFr: 'Rites funéraires islamiques',

    descriptionEn: 'Islamic funeral rites',
    questions: [
      AssistantQA(
        id: 'fun1',
        questionFr: 'Comment se passent les funérailles en Islam ?',

        questionEn: 'What invalidates prayer?',
        keywords: ['funerailles', 'mort', 'enterrement', 'janaza', 'deces'],
        reponseFr: 'Les étapes des funérailles islamiques :\n\n1. À l\'agonie — tourner le mourant vers la Qibla, lui souffler la Shahada (pas le forcer), réciter sourate Ya-Sin\n\n2. Après le décès — fermer les yeux du défunt, couvrir le corps, se hâter pour les funérailles (« Hâtez-vous pour les funérailles »)\n\n3. Le Ghusl (lavage) — par des personnes du même sexe, avec eau et lotus (sidr). Nombre impair de lavages. Le parfumer.\n\n4. Le Kafan (linceul) — envelopper dans des draps blancs (3 pour l\'homme, 5 pour la femme)\n\n5. La Salat al-Janaza — prière funéraire avec 4 Takbirat (pas de ruku\' ni sujud) : 1er Takbir + Al-Fatiha, 2e + Salat \'ala Nabi, 3e + du\'a pour le défunt, 4e + Taslim\n\n6. L\'enterrement — dans la terre, sur le côté droit face à la Qibla, sans cercueil si possible. Chacun met 3 poignées de terre. Du\'a pour le défunt.\n\n7. Les condoléances — 3 jours. Préparer de la nourriture pour la famille du défunt.',

        reponseEn: 'What invalidates prayer:\n\n1. Speaking intentionally (other than prayer remembrances)\n2. Eating or drinking\n3. Laughing loudly (smiling does not invalidate)\n4. Turning away from the Qibla\n5. Excessive continuous movements unrelated to prayer\n6. Breaking wudu (wind, bleeding according to schools)\n7. Intentionally uncovering \'awra\n8. Intentionally adding a pillar (e.g. an extra ruku\' knowingly)\n\nWhat does NOT invalidate: crying, coughing, sneezing, slight movement (scratching, adjusting clothes), killing a scorpion or snake.',
        source: 'Fiqh as-Sunna ; Bukhari, Muslim',
      ),
    ],
  ),

  // ══════════════════════════════════════════════════════════════
  // INVOCATIONS DU QUOTIDIEN
  // ══════════════════════════════════════════════════════════════
  AssistantTopic(
    id: 'adab',
    titleFr: 'Adab du Quotidien',

    titleEn: 'Daily Adab',
    emoji: '🌟',
    descriptionFr: 'Comportements et invocations de tous les jours',

    descriptionEn: 'Everyday behaviours and invocations',
    questions: [
      AssistantQA(
        id: 'adb1',
        questionFr: 'Quelles sont les invocations du quotidien ?',

        questionEn: 'How to pray Friday prayer (Jumu\'ah)?',
        keywords: ['invocation', 'quotidien', 'dua', 'jour', 'dhikr'],
        reponseFr: 'Invocations essentielles du quotidien :\n\n• Au réveil : « Al-hamdu lillahi alladhi ahyana ba\'da ma amatana wa ilayhi an-nushur »\n• Avant de manger : « Bismillah » — si on oublie : « Bismillah fi awwalihi wa akhirihi »\n• Après manger : « Al-hamdu lillahi alladhi at\'amani hadha wa razaqanihi min ghayri hawlin minni wa la quwwa »\n• En sortant de la maison : « Bismillah, tawakkaltu \'alallah, wa la hawla wa la quwwata illa billah »\n• En entrant à la maison : « Bismillah walajnah, wa bismillah kharajna, wa \'ala Rabbina tawakkalna »\n• Avant de dormir : réciter Ayat al-Kursi, les 3 Qul, souffler dans les mains et passer sur le corps\n• En entrant aux toilettes : « Allahumma inni a\'udhu bika min al-khubthi wal-khaba\'ith »\n• En s\'habillant : « Al-hamdu lillahi alladhi kasani hadha wa razaqanihi min ghayri hawlin minni wa la quwwa »',

        reponseEn: 'Friday prayer (Salat al-Jumu\'ah) is obligatory for every free, resident Muslim man in good health:\n\nSunna before Jumu\'ah:\n• Ghusl (ritual bath) — strongly recommended\n• Perfume and wear good clothes\n• Arrive early at the mosque — the earlier you arrive, the greater the reward\n• Recite Surah Al-Kahf — "Whoever recites Al-Kahf on Friday, a light will illuminate him until the next Friday"\n\nProcedure:\n1. The Muezzin gives the Adhan\n2. The Imam ascends the minbar and delivers 2 Khutbas (sermons) separated by a brief pause\n3. During the sermon: listen silently, do not speak or play with pebbles\n4. Prayer of 2 rak\'at in congregation (aloud)\n\nAnswered hour: There is an hour on Friday when every supplication is accepted. The Prophet indicated it is between the Imam\'s sitting down and the end of prayer.',
        source: 'Bukhari, Muslim, Abu Dawud, Tirmidhi',
      ),
      AssistantQA(
        id: 'adb2',
        questionFr: 'Quels sont les adab de la mosquée ?',

        questionEn: 'What is the night prayer (Tahajjud)?',
        keywords: ['mosquee', 'adab', 'masjid', 'entrer', 'sortir', 'comportement'],
        reponseFr: 'Les bonnes manières à la mosquée :\n\nAvant d\'y aller :\n• Faire le wudu à la maison\n• Se parfumer et porter de beaux vêtements propres\n• Éviter de manger de l\'ail ou de l\'oignon crus\n• Marcher avec calme et dignité\n\nEn entrant :\n• Entrer du pied droit\n• Dire : « Bismillah, was-salatu was-salamu \'ala Rasulillah. Allahumma iftah li abwaba rahmatik » (Ô Allah, ouvre-moi les portes de Ta miséricorde)\n• Prier 2 rak\'at de salutation de la mosquée (Tahiyyat al-Masjid) avant de s\'asseoir\n\nDans la mosquée :\n• Ne pas enjamber les gens — s\'asseoir là où il y a de la place\n• Ne pas parler fort ni faire de commerce\n• Éteindre son téléphone ou le mettre en silencieux\n• Combler les espaces dans les rangs de prière\n\nEn sortant :\n• Sortir du pied gauche\n• Dire : « Bismillah, was-salatu was-salamu \'ala Rasulillah. Allahumma inni as\'aluka min fadlik »',

        reponseEn: 'Tahajjud (Qiyam al-Layl) is the night prayer, the best prayer after the 5 obligatory ones:\n\nWhen? In the last third of the night (approximately 1.5-2 hours before Fajr). It is when Allah descends to the lowest heaven and says: "Is there anyone who calls upon Me so I may answer? Who asks Me so I may give? Who seeks forgiveness so I may forgive?"\n\nHow?\n• Wake up and perform wudu\n• Pray 2 rak\'at by 2 rak\'at (no fixed number)\n• The Prophet prayed 11 rak\'at (8 of Tahajjud + 3 of Witr)\n• Recite at length if possible\n• End with Witr (1, 3, 5 or more rak\'at, odd numbers)\n\nMerits: "The best prayer after the obligatory is the night prayer." (Muslim)\nTahajjud is the mark of the pious: "They would pull themselves away from their beds to invoke their Lord." (As-Sajdah 32:16)',
        source: 'Muslim ; Abu Dawud',
      ),
      AssistantQA(
        id: 'adb3',
        questionFr: 'Quels sont les adab du sommeil en Islam ?',

        questionEn: 'How to perform wudu (ablution)?',
        keywords: ['dormir', 'sommeil', 'nuit', 'coucher', 'lit', 'adab'],
        reponseFr: 'Les adab du sommeil selon la Sunna du Prophète ﷺ :\n\nAvant de dormir :\n• Faire le wudu\n• Épousseter le lit 3 fois avec le pan de son vêtement\n• Se coucher sur le côté droit, la main droite sous la joue\n• Réciter Ayat al-Kursi — « celui qui la récite avant de dormir, un gardien d\'Allah ne le quitte pas jusqu\'au matin » (Bukhari)\n• Réciter les 3 dernières sourates (Al-Ikhlas, Al-Falaq, An-Nas), souffler dans les mains et passer sur le corps (3 fois)\n• Réciter les derniers versets de sourate Al-Baqara\n• Dire : « Bismika Allahumma amutu wa ahya » (Par Ton nom Ô Allah, je meurs et je vis)\n• Faire le dhikr : 33x Subhanallah, 33x Al-hamdulillah, 34x Allahu Akbar\n\nAu réveil :\n• Dire : « Al-hamdu lillahi alladhi ahyana ba\'da ma amatana wa ilayhi an-nushur »\n• Se frotter le visage pour chasser le sommeil\n• Se rincer le nez 3 fois (car « le Shaytan passe la nuit dans les narines »)',

        reponseEn: 'The steps of Wudu:\n\n1. Intention in the heart + say "Bismillah"\n2. Wash hands 3 times\n3. Rinse mouth 3 times (Madmada)\n4. Rinse nose 3 times (Istinshaq)\n5. Wash face 3 times (from forehead to chin, ear to ear)\n6. Wash arms to elbows 3 times (starting with right)\n7. Wipe the head with wet hands (once, from front to back and back)\n8. Wipe ears (inside and outside)\n9. Wash feet to ankles 3 times (starting with right)\n\nSupplication after wudu: "I testify that there is no god but Allah alone, without partners, and I testify that Muhammad is His servant and messenger. O Allah, make me among the repentant and among the purified."',
        source: 'Bukhari, Muslim',
      ),
    ],
  ),

  // ══════════════════════════════════════════════════════════════
  // ZAKAT
  // ══════════════════════════════════════════════════════════════
  AssistantTopic(
    id: 'zakat',
    titleFr: 'La Zakat',

    titleEn: 'Zakat',
    emoji: '💰',
    descriptionFr: 'L\'aumône obligatoire et purificatrice',
    descriptionEn: 'The obligatory purifying alms',
    questions: [
      AssistantQA(
        id: 'zak1',
        questionFr: 'Qu\'est-ce que la Zakat ?',

        questionEn: 'What invalidates wudu?',
        keywords: ['zakat', 'aumone', 'obligatoire', 'pilier', 'argent'],
        reponseFr: 'La Zakat est le 3e pilier de l\'Islam. C\'est une aumône obligatoire prélevée sur les biens du musulman qui atteint un certain seuil (Nisab) et qui a été possédé pendant un an lunaire complet.\n\nElle purifie les biens et l\'âme du donneur, et aide les plus démunis de la communauté. Allah dit : « Prélève de leurs biens une aumône par laquelle tu les purifies et les bénis. » (At-Tawba 9:103)\n\nLe taux général est de 2,5% sur l\'épargne (or, argent, liquidités). D\'autres taux s\'appliquent aux récoltes (5% ou 10%), au bétail, et aux marchandises.\n\nLe Nisab est l\'équivalent de 85g d\'or ou 595g d\'argent.',

        reponseEn: 'What invalidates wudu:\n\n1. Anything exiting the natural passages (urine, stool, gas, blood according to some schools)\n2. Deep sleep (lying down or reclining)\n3. Loss of consciousness (fainting)\n4. Touching private parts directly without barrier (according to some schools)\n5. Eating camel meat (according to the Hanbali school)\n\nWhat does NOT invalidate wudu: doubt (remain on certainty), light bleeding from a wound (according to Shafi\'i and Maliki schools), vomiting (disagreement), touching a woman (disagreement between schools).',
        source: 'Coran, At-Tawba 9:103 ; Bukhari, Muslim',
      ),
      AssistantQA(
        id: 'zak2',
        questionFr: 'Qui a droit à la Zakat ?',

        questionEn: 'When is Ghusl obligatory?',
        keywords: ['beneficiaire', 'zakat', 'droit', 'recevoir', 'categorie'],
        reponseFr: 'Allah a défini 8 catégories de bénéficiaires dans le Coran (At-Tawba 9:60) :\n\n1. Al-Fuqara (les pauvres) — ceux qui n\'ont pas le minimum vital\n2. Al-Masakin (les nécessiteux) — ceux qui n\'ont pas assez pour vivre dignement\n3. Al-\'Amilin \'alayha (les collecteurs de Zakat) — ceux qui gèrent la collecte et la distribution\n4. Al-Mu\'allafatu Qulubuhum (les cœurs à rapprocher) — les nouveaux musulmans ou ceux qu\'on espère guider\n5. Fi ar-Riqab (l\'affranchissement des esclaves) — ou la libération de prisonniers\n6. Al-Gharimin (les endettés) — ceux criblés de dettes légitimes\n7. Fi Sabilillah (dans le chemin d\'Allah) — le Jihad au sens large, les causes islamiques\n8. Ibn as-Sabil (le voyageur en détresse) — celui qui est loin de chez lui sans moyens\n\nOn NE donne PAS la Zakat à ses parents, enfants, ou conjoint (on est déjà tenu de les entretenir).',

        reponseEn: 'Ghusl (major ablution) is obligatory in these cases:\n\n1. After intimate relations (even without ejaculation)\n2. After ejaculation (even during sleep — wet dreams)\n3. After menstruation\n4. After postpartum bleeding (lochia)\n5. Upon entering Islam (for converts)\n6. After death (washing the deceased)\n\nRecommended Ghusl (Sunna): on Friday, both \'Eids, before Ihram, after washing the deceased.\n\nHow to perform Ghusl: intention, Bismillah, wash private parts, perform complete wudu, pour water over the head 3 times, then wash the entire body starting with the right side.',
        source: 'Coran, At-Tawba 9:60',
      ),
      AssistantQA(
        id: 'zak3',
        questionFr: 'Qu\'est-ce que la Zakat al-Fitr ?',

        questionEn: 'How to perform Tayammum?',
        keywords: ['zakat', 'fitr', 'ramadan', 'fin', 'eid', 'fitrana'],
        reponseFr: 'La Zakat al-Fitr est une aumône obligatoire liée au mois de Ramadan. Elle se distingue de la Zakat annuelle :\n\nQui doit la payer ? Tout musulman qui possède de quoi se nourrir le jour de l\'Aïd, pour lui-même et chaque membre de sa famille (y compris les enfants et les personnes à charge).\n\nCombien ? Un Sa\' (environ 2,5 à 3 kg) de nourriture de base du pays (blé, riz, dattes, orge). En valeur monétaire, cela varie selon les pays (généralement entre 5 et 15 euros par personne).\n\nQuand ? Elle doit être versée AVANT la prière de l\'Aïd al-Fitr. Il est permis de la donner 1 ou 2 jours avant. Après la prière de l\'Aïd, elle est considérée comme une simple aumône.\n\nPourquoi ? Elle purifie le jeûneur de ses manquements et nourrit les pauvres le jour de la fête.',

        reponseEn: 'Tayammum is dry ablution, an ease from Allah when water is unavailable or harmful:\n\nWhen to perform:\n• Absence of water (travel, desert)\n• Insufficient water (just enough to drink)\n• Illness or wound where water would worsen the condition\n• Extremely cold water with no means to heat it and risk to health\n\nHow to perform:\n1. Intention in the heart\n2. Say "Bismillah"\n3. Strike clean earth (sand, stone, soil) with both palms once\n4. Wipe the face with the palms\n5. Wipe the hands and forearms (right hand then left)\n\nRules:\n• Tayammum replaces both Wudu AND Ghusl\n• It is nullified by the same things as Wudu + presence of water\n• One can pray as many times as desired with one Tayammum as long as it is not nullified\n\nAllah says: "If you do not find water, then use pure earth." (An-Nisa 4:43)',
        source: 'Bukhari, Muslim ; Abu Dawud',
      ),
      AssistantQA(
        id: 'zak4',
        questionFr: 'Comment calculer la Zakat sur son argent ?',

        questionEn: 'How is an Islamic marriage conducted?',
        keywords: ['calculer', 'zakat', 'combien', 'montant', 'nisab', 'epargne'],
        reponseFr: 'Méthode de calcul de la Zakat sur l\'épargne :\n\n1. Vérifier le Nisab — votre épargne totale doit dépasser le Nisab (équivalent de 85g d\'or, soit environ 5 000-6 000 euros selon le cours de l\'or)\n\n2. La durée — cet argent doit avoir été en votre possession pendant un an lunaire complet (354 jours)\n\n3. Le calcul — 2,5% du montant total\n\nExemple : vous avez 10 000 euros d\'épargne depuis un an\n→ Zakat = 10 000 x 2,5% = 250 euros\n\nCe qui est inclus dans le calcul :\n• Comptes bancaires (courant + épargne)\n• Liquidités en espèces\n• Or et argent (bijoux selon les écoles)\n• Investissements et actions (valeur marchande)\n• Marchandises de commerce\n\nCe qui est exclu : la résidence principale, la voiture personnelle, les vêtements, les meubles.',

        reponseEn: 'Islamic marriage (Nikah) requires these essential elements:\n\n1. Consent of both spouses — the woman has absolute right to refuse\n2. Wali (guardian) of the woman — usually her father\n3. Two Muslim witnesses\n4. Mahr (dower) — a gift from the groom to the bride, which is entirely hers\n5. Offer and acceptance (Ijab wa Qabul)\n\nSunna of marriage: a Khutba (sermon) before the contract, publicly announcing the marriage, organizing a Walima (wedding feast), supplicating for the couple: "May Allah bless you both and unite you in goodness."\n\nMarriage in Islam is a civil and religious contract, not a sacrament. It may include conditions accepted by both parties.',
        source: 'Fiqh az-Zakat, Yusuf al-Qaradawi',
      ),
    ],
  ),

  // ══════════════════════════════════════════════════════════════
  // 99 NOMS D'ALLAH
  // ══════════════════════════════════════════════════════════════
  AssistantTopic(
    id: 'noms_allah',
    titleFr: 'Les 99 Noms d\'Allah',
    titleEn: 'The 99 Names of Allah',
    emoji: '✨',
    descriptionFr: 'Al-Asma al-Husna, les plus beaux Noms',

    descriptionEn: 'Al-Asma al-Husna, the Most Beautiful Names',
    questions: [
      AssistantQA(
        id: 'nom1',
        questionFr: 'Quels sont les 99 Noms d\'Allah ?',

        questionEn: 'What are the rights of the wife in marriage?',
        keywords: ['99', 'noms', 'allah', 'asma', 'husna', 'beaux'],
        reponseFr: 'Les 99 Noms d\'Allah (Al-Asma al-Husna) sont les plus beaux Noms par lesquels Allah s\'est décrit dans le Coran et la Sunna. Le Prophète ﷺ a dit : « Allah a 99 Noms, cent moins un. Quiconque les apprend (les comprend et les met en pratique) entrera au Paradis. »\n\nParmi les plus connus :\n• Ar-Rahman (Le Tout-Miséricordieux)\n• Ar-Rahim (Le Très-Miséricordieux)\n• Al-Malik (Le Souverain)\n• Al-Quddus (Le Saint)\n• As-Salam (La Paix)\n• Al-Ghaffar (Le Grand Pardonneur)\n• Al-Razzaq (Le Pourvoyeur)\n• Al-\'Alim (L\'Omniscient)\n• As-Sami\' (L\'Audient)\n• Al-Basir (Le Clairvoyant)\n• Al-Hakam (Le Juge)\n• Al-\'Adl (Le Juste)\n• Al-Latif (Le Subtil Bienveillant)\n• Al-Wadud (Le Bien-Aimant)\n• Al-Hayy (Le Vivant)\n• Al-Qayyum (Le Subsistant par Lui-même)',

        reponseEn: 'The rights of the wife in Islam:\n\n1. Mahr — the dower belongs entirely to her, the husband cannot take it back\n2. Maintenance (Nafaqa) — the husband must provide housing, food, clothing and care according to his means\n3. Good treatment — "The best of you are those best to their wives" — Tirmidhi\n4. Respect and dignity — prohibited from humiliation, degradation or hitting\n5. Right to intimacy and marital relations\n6. Right to education and work — with consultation\n7. Right to keep her family name\n8. Right to own her own property — complete financial independence\n9. Right to request divorce (Khul\') if necessary\n10. Right to justice in case of polygamy',
        source: 'Bukhari, Muslim ; Coran, Al-A\'raf 7:180',
      ),
      AssistantQA(
        id: 'nom2',
        questionFr: 'Comment invoquer Allah par Ses Noms ?',

        questionEn: 'What are the rights of the husband in marriage?',
        keywords: ['invoquer', 'noms', 'allah', 'dua', 'appeler'],
        reponseFr: 'Allah dit : « C\'est à Allah qu\'appartiennent les plus beaux Noms. Invoquez-Le par ces Noms. » (Al-A\'raf 7:180)\n\nMéthode d\'invocation par les Noms d\'Allah :\n\n1. Choisir le Nom approprié à la situation :\n• Malade → Ya Shafi (Ô Guérisseur)\n• Besoin → Ya Razzaq (Ô Pourvoyeur)\n• Péché → Ya Ghaffar (Ô Pardonneur)\n• Peur → Ya Hafidh (Ô Protecteur)\n• Tristesse → Ya Latif (Ô Subtil Bienveillant)\n\n2. Comprendre le sens du Nom — ne pas juste répéter mécaniquement\n\n3. Vivre le Nom — si Allah est Al-Karim (Le Généreux), sois généreux. Si Allah est Ar-Rahman (Le Miséricordieux), sois miséricordieux.\n\n4. Le dhikr — répéter un Nom avec méditation : « Ya Hayyu Ya Qayyum, bi rahmatika astaghith » (Ô Vivant, Ô Subsistant, par Ta miséricorde je demande secours).',

        reponseEn: 'The rights of the husband in Islam:\n\n1. Mutual respect and goodwill\n2. Management of the household — the husband is responsible (Qawwam) for financial support and family protection\n3. Mutual loyalty and fidelity\n4. Preservation of honor and household property in his absence\n5. Obedience in good (Ma\'ruf) — not in disobedience to Allah\n6. Consultation (Shura) in family decisions\n\nImportant: the concept of Qawwama (husband\'s responsibility) means to protect, provide and guide, NOT to dominate or oppress. The Prophet helped with housework, mended his clothes and served his family. The couple is based on complementarity, not hierarchy.',
        source: 'Coran, Al-A\'raf 7:180 ; Tirmidhi',
      ),
    ],
  ),

  // ══════════════════════════════════════════════════════════════
  // MORT ET AU-DELÀ
  // ══════════════════════════════════════════════════════════════
  AssistantTopic(
    id: 'mort',
    titleFr: 'La Mort et l\'Au-delà',
    titleEn: 'Death and the Afterlife',
    emoji: '🌅',
    descriptionFr: 'La vie après la mort, la tombe, le Jour Dernier',

    descriptionEn: 'Life after death, the grave, the Day of Judgment',
    questions: [
      AssistantQA(
        id: 'mor1',
        questionFr: 'Que se passe-t-il après la mort en Islam ?',

        questionEn: 'What is Mahr (dower) in marriage?',
        keywords: ['mort', 'apres', 'ame', 'barzakh', 'tombe'],
        reponseFr: 'Après la mort, l\'âme entre dans le Barzakh (la vie intermédiaire entre la mort et la Résurrection) :\n\n1. L\'ange de la mort saisit l\'âme — douce extraction pour le croyant, difficile pour le mécréant\n\n2. L\'âme monte aux cieux — les portes s\'ouvrent pour le croyant, se ferment pour le mécréant\n\n3. L\'âme retourne au corps dans la tombe\n\n4. L\'interrogatoire des deux anges Munkar et Nakir — trois questions :\n   • « Qui est ton Seigneur ? » → Allah\n   • « Quelle est ta religion ? » → L\'Islam\n   • « Qui est cet homme envoyé parmi vous ? » → Muhammad ﷺ\n\n5. Selon les réponses : la tombe devient un jardin du Paradis ou une fosse de l\'Enfer\n\n6. L\'âme attend la Résurrection dans cet état\n\nLe Prophète ﷺ a dit : « La tombe est la première étape de l\'au-delà. »',

        reponseEn: 'Mahr is the obligatory gift from the groom to the bride in an Islamic marriage:\n\nWhat is it?\n• Entirely the property of the bride\n• The groom must give it willingly and without pressure\n• It symbolizes respect and commitment\n\nWhat can Mahr be?\n• Money (gold, silver, or fiat currency)\n• Property (house, car, land)\n• Something of value (jewelry, Qur\'an, knowledge)\n• Services (teaching Qur\'an, Islamic knowledge)\n• Anything of value acceptable to both parties\n\nAmount:\n• No minimum or maximum in Islamic law\n• Should be according to the groom\'s capacity and social standing\n• It\'s better to keep it simple and affordable\n\nKey principles:\n• The bride can never be forced to accept less\n• If she wishes to gift some back, that\'s her choice\n• If divorced before consummation, she gets half the Mahr\n• It remains hers even if she initiates divorce (Khul\')',
        source: 'Tirmidhi ; Ahmad ; Coran, Al-Mu\'minun 23:99-100',
      ),
      AssistantQA(
        id: 'mor2',
        questionFr: 'Qu\'est-ce que le Jour du Jugement ?',

        questionEn: 'What is the role of men in Islam?',
        keywords: ['jugement', 'jour', 'dernier', 'resurrection', 'qiyama'],
        reponseFr: 'Le Jour du Jugement (Yawm al-Qiyama) est le jour où Allah ressuscitera toute la création pour le jugement final :\n\n1. Le Souffle de la Trompe (As-Sur) — l\'ange Israfil soufflera deux fois : la première tue tout être vivant, la seconde ressuscite tous les morts\n\n2. Le Rassemblement (Al-Hashr) — tous les humains depuis Adam seront réunis nus et pieds nus\n\n3. L\'Intercession (Ash-Shafa\'a) — le Prophète Muhammad ﷺ intercédera pour sa communauté\n\n4. Les Livres des actes — chacun recevra son livre : dans la main droite (bonheur) ou dans la main gauche (malheur)\n\n5. La Balance (Al-Mizan) — les bonnes et mauvaises actions seront pesées\n\n6. Le Bassin (Al-Hawdh) — le bassin du Prophète ﷺ dont l\'eau est plus blanche que le lait\n\n7. Le Pont (As-Sirat) — au-dessus de l\'Enfer, plus fin qu\'un cheveu, plus tranchant qu\'une épée\n\n8. Le Paradis ou l\'Enfer — destination finale selon les actes et la miséricorde d\'Allah',

        reponseEn: 'The role of men in Islam:\n\nTowards the family:\n• Primary provider and protector (Qawwam)\n• Responsible for maintenance and security\n• Guide and counselor\n• Compassionate and merciful leader\n\nTowards society:\n• Honesty and integrity in dealings\n• Justice and fairness\n• Courage in standing for truth\n\nSpiritual:\n• Personal responsibility before Allah\n• Leading the family in worship\n• Seeking knowledge\n\nImportant: Qawwama does NOT mean dominance or oppression. The Prophet said: "The best of you are those best to your families." He would help his wives with household work, mend his clothes, and serve his family.\n\nComplementarity: Men and women have different roles in some areas but are equal in worth and spiritual responsibility.',
        source: 'Coran, Az-Zalzala 99:1-8 ; Al-Qari\'a 101:1-11',
      ),
      AssistantQA(
        id: 'mor3',
        questionFr: 'Comment se préparer à la mort ?',

        questionEn: 'What is the role of women in Islam?',
        keywords: ['preparer', 'mort', 'pret', 'akhira', 'au-dela'],
        reponseFr: 'Le Prophète ﷺ a dit : « Le plus intelligent des croyants est celui qui se rappelle le plus souvent de la mort et s\'y prépare le mieux. »\n\nSe préparer à la mort :\n\n1. La sincérité dans l\'adoration — prier les 5 prières, jeûner, donner la Zakat\n\n2. Le repentir constant — ne pas remettre la Tawba à demain\n\n3. Régler ses dettes — ne pas laisser de dettes impayées\n\n4. Écrire son testament (Wasiyya) — c\'est une sunna fortement recommandée\n\n5. Se réconcilier — ne pas garder de rancune, demander pardon aux gens\n\n6. Les bonnes œuvres continues (Sadaqa Jariya) — un puits, un arbre, un livre utile, un enfant pieux qui invoque pour vous\n\n7. Le dhikr de la mort — visiter les cimetières, penser à la brièveté de la vie\n\n8. Multiplier le dhikr — « La ilaha illallah » est la meilleure parole avec laquelle on quitte ce monde',

        reponseEn: 'The role of women in Islam:\n\nIn the family:\n• Primary educator of the next generation\n• Custodian of the home (if she chooses)\n• Equal partner in decisions\n• Equal right to work (if she chooses)\n\nSpiritual:\n• Equal responsibility before Allah\n• Full right to worship and prayer\n• Can be scholars and teachers\n• Full inheritance and property rights\n\nSocial:\n• Can work, earn, teach, judge\n• Can own businesses\n• Can refuse marriage\n• Can demand divorce\n• Sanctity and honor must be protected\n\nHistorical elevation:\n• Before Islam: had no rights, no inheritance, could be killed\n• Islam: guaranteed all these rights\n• Prophet said: "Women are the twin halves of men" and "Paradise is at the feet of mothers"\n\nImportant: Many cultural practices wrongly restrict women under the name of Islam. True Islam honors women\'s agency and dignity.',
        source: 'Tirmidhi ; Ibn Majah ; Muslim',
      ),
    ],
  ),

  // ══════════════════════════════════════════════════════════════
  // SABR ET TAWBA
  // ══════════════════════════════════════════════════════════════
  AssistantTopic(
    id: 'sabr_tawba',
    titleFr: 'Sabr et Tawba',

    titleEn: 'Sabr and Tawba',
    emoji: '🤍',
    descriptionFr: 'La patience et le repentir',

    descriptionEn: 'Patience and repentance',
    questions: [
      AssistantQA(
        id: 'sab1',
        questionFr: 'Qu\'est-ce que le Sabr en Islam ?',

        questionEn: 'How does divorce work in Islam?',
        keywords: ['sabr', 'patience', 'epreuve', 'endurance', 'difficulte'],
        reponseFr: 'Le Sabr (patience) est une vertu fondamentale en Islam. Allah mentionne la patience plus de 90 fois dans le Coran.\n\nLes 3 types de Sabr :\n\n1. Sabr \'ala at-Ta\'a — patience dans l\'obéissance à Allah (persévérer dans la prière, le jeûne même quand c\'est difficile)\n\n2. Sabr \'an al-Ma\'siya — patience face aux tentations (s\'abstenir du péché)\n\n3. Sabr \'ala al-Qadar — patience face aux épreuves et aux malheurs du destin\n\nLes récompenses du Sabr :\n• « Les endurants recevront leur récompense sans compter » (Az-Zumar 39:10)\n• « Allah est avec les patients » (Al-Baqara 2:153)\n• Le Prophète ﷺ a dit : « Aucune fatigue, maladie, souci, tristesse, douleur ou chagrin n\'atteint le musulman, même une épine qui le pique, sans qu\'Allah ne lui efface par cela une partie de ses péchés. »\n\nLe Sabr n\'est pas la passivité — c\'est la force de persévérer tout en agissant.',

        reponseEn: 'Divorce (Talaq) in Islam:\n\nDefinition:\n• Dissolution of the marriage contract\n• Permitted but "the most disliked of permissible things"\n\nWho can initiate:\n• The husband (Talaq)\n• The wife (Khul\' or Tatliq)\n• Both through mutual agreement (Mubarat)\n\nProcedure:\n1. Husband pronounces clearly: "You are divorced"\n2. Waiting period (\'Iddah) begins: 3 menstrual cycles or 3 months\n3. During \'Iddah, reconciliation is possible\n4. After \'Iddah, divorce is final\n\nWife\'s rights after divorce:\n• Maintenance during \'Iddah\n• Return of Mahr\n• Custody of young children\n• Child support from husband\n• Right to remarry after \'Iddah\n\nTypes:\n• Talaq Raj\'i (revocable): husband can reconcile during \'Iddah\n• Talaq Ba\'in (irrevocable): cannot reconcile without new contract',
        source: 'Coran, Al-Baqara 2:153 ; Bukhari',
      ),
      AssistantQA(
        id: 'sab2',
        questionFr: 'Comment faire la Tawba (repentir) ?',

        questionEn: 'What is the waiting period (\'Iddah)?',
        keywords: ['tawba', 'repentir', 'pardon', 'peche', 'revenir'],
        reponseFr: 'La Tawba (repentir) est le retour sincère vers Allah après un péché. Allah dit : « Ô Mes serviteurs qui avez commis des excès à votre propre détriment, ne désespérez pas de la miséricorde d\'Allah. Car Allah pardonne tous les péchés. » (Az-Zumar 39:53)\n\nLes conditions de la Tawba sincère :\n\n1. Arrêter le péché immédiatement\n2. Regretter sincèrement de l\'avoir commis\n3. Prendre la ferme résolution de ne pas y revenir\n4. Si le péché implique un droit d\'autrui : réparer le tort (rendre ce qu\'on a volé, demander pardon à la personne)\n\nLa prière du repentir (Salat at-Tawba) — 2 rak\'at, puis demander pardon à Allah.\n\nIstighfar quotidien : « Astaghfirullah al-\'Adhim alladhi la ilaha illa Huwa al-Hayyu al-Qayyum wa atubu ilayh »\n\nLe Prophète ﷺ demandait pardon à Allah plus de 70 fois par jour, alors qu\'il était le meilleur des hommes.',

        reponseEn: 'The \'Iddah is the waiting period after divorce or widowhood:\n\nDuration:\n\nFor divorced woman:\n• 3 menstrual cycles (if menstruating)\n• 3 months (if not menstruating due to age or condition)\n• 4 months and 10 days (if pregnant, ends at childbirth)\n\nFor widow:\n• 4 months and 10 days\n• Until childbirth (if pregnant)\n\nPurposes:\n• Allow time for reconciliation\n• Establish paternity of any child\n• Show respect for the marriage bond\n• Allow both parties to reflect\n\nRights during \'Iddah:\n• Wife remains in marital home (unless she chooses to leave)\n• Husband provides maintenance (housing, food, clothing)\n• She can beautify herself but should not go out unnecessarily\n• She should not accept marriage proposals\n• She can go out for necessity (work, shopping, doctor)\n\nAfter \'Iddah:\n• She is free to remarry\n• She is no longer under husband\'s maintenance\n• She can keep or leave the marital home',
        source: 'Coran, Az-Zumar 39:53 ; Bukhari, Muslim',
      ),
      AssistantQA(
        id: 'sab3',
        questionFr: 'Comment faire face aux épreuves ?',

        questionEn: 'How to educate your children in Islam?',
        keywords: ['epreuve', 'difficulte', 'probleme', 'malheur', 'triste', 'anxiete'],
        reponseFr: 'L\'Islam offre un cadre spirituel puissant pour faire face aux épreuves :\n\n1. Comprendre la sagesse — les épreuves sont des tests d\'Allah, pas des punitions. « Nous vous éprouverons par un peu de peur, de faim, de perte de biens, de vies et de récoltes. Annonce la bonne nouvelle aux patients. » (Al-Baqara 2:155)\n\n2. La du\'a — se tourner vers Allah : « Allahumma inni a\'udhu bika min al-hammi wal-hazan, wal-\'ajzi wal-kasal » (Ô Allah, je cherche refuge auprès de Toi contre le souci, la tristesse, l\'incapacité et la paresse)\n\n3. La prière — « Cherchez secours dans la patience et la prière » (Al-Baqara 2:45)\n\n4. Le Tawakkul — faire confiance au plan d\'Allah tout en agissant\n\n5. Le Dhikr — « N\'est-ce pas par le rappel d\'Allah que les cœurs se tranquillisent ? » (Ar-Ra\'d 13:28)\n\n6. La compagnie des gens pieux — s\'entourer de croyants qui nous rappellent Allah\n\n7. Se rappeler que l\'épreuve est temporaire — « Certes, avec la difficulté vient la facilité » (Ash-Sharh 94:6)',

        reponseEn: 'The prophetic method of education:\n\n1. Love and tenderness — the Prophet embraced his grandchildren and played with them. When a Bedouin said he never kissed his children, the Prophet replied: "What can I do for you if Allah has removed mercy from your heart?"\n\n2. Good example (Qudwa) — children imitate, not lecture. Be what you want your children to become.\n\n3. Gentleness before firmness — "Allah is gentle and loves gentleness in all matters."\n\n4. Equity between children — do not favor one over another\n\n5. Encouragement and appreciation — praise good behaviors\n\n6. Dialogue — explain the why of rules, do not just impose\n\n7. Patience — education is a long-term investment\n\n8. Supplication — invoke Allah for your children\'s guidance',
        source: 'Coran, Al-Baqara 2:155-156 ; Ash-Sharh 94:5-6',
      ),
    ],
  ),

  // ══════════════════════════════════════════════════════════════
  // INVOCATIONS DU VOYAGE
  // ══════════════════════════════════════════════════════════════
  AssistantTopic(
    id: 'voyage',
    titleFr: 'Le Voyage en Islam',

    titleEn: 'Travel in Islam',
    emoji: '✈️',
    descriptionFr: 'Invocations et règles du voyageur',

    descriptionEn: 'Islamic rulings for the traveller',
    questions: [
      AssistantQA(
        id: 'voy1',
        questionFr: 'Quelles sont les invocations du voyage ?',

        questionEn: 'At what age should children learn prayer?',
        keywords: ['voyage', 'invocation', 'dua', 'transport', 'voiture', 'avion'],
        reponseFr: 'Invocations du voyageur :\n\nEn montant dans un véhicule :\n« Bismillah. Subhana alladhi sakhkhara lana hadha wa ma kunna lahu muqrinin, wa inna ila Rabbina la munqalibun » (Gloire à Celui qui a mis ceci à notre service alors que nous n\'étions pas capables de le faire, et c\'est vers notre Seigneur que nous retournerons.)\n\nDu\'a du voyage :\n« Allahumma inna nas\'aluka fi safarina hadha al-birra wa at-taqwa, wa min al-\'amali ma tarda. Allahumma hawwin \'alayna safarana hadha watwi \'anna bu\'dah. Allahumma anta as-sahibu fi as-safari wal-khalifatu fil-ahli. »\n\nAu retour :\n« Ayibun, ta\'ibun, \'abidun, li Rabbina hamidun » (Nous revenons repentants, adorateurs, à notre Seigneur louangeurs.)\n\nLa du\'a du voyageur est exaucée — profitez-en pour invoquer pour vous et vos proches.',

        reponseEn: 'The Prophet said: "Command your children to pray at 7 years old, and discipline them gently if they do not do so at 10 years."\n\nRecommended progression:\n\n• 3-4 years: child sees parents pray, imitates naturally\n• 5-6 years: teach Al-Fatiha and short chapters\n• 7 years: teach complete prayer and encourage regularly\n• 10 years: prayer becomes an established habit\n• Puberty: prayer becomes obligatory\n\nAdvice: make prayer enjoyable (not punishment), pray as a family, praise the child when he prays, give him a prayer mat he likes, never associate prayer with pain or punishment.',
        source: 'Muslim ; Tirmidhi',
      ),
      AssistantQA(
        id: 'voy2',
        questionFr: 'Quelles sont les facilités pour le voyageur ?',

        questionEn: 'How to teach children the Qur\'an?',
        keywords: ['voyageur', 'raccourcir', 'priere', 'regrouper', 'jeune', 'facilite'],
        reponseFr: 'Allah accorde des facilités au voyageur en Islam :\n\n1. Raccourcir la prière (Qasr) — les prières de 4 rak\'at deviennent 2 rak\'at (Dhuhr, \'Asr, \'Isha). Fajr et Maghrib restent inchangés.\n\n2. Regrouper les prières (Jam\') — on peut regrouper Dhuhr+\'Asr ensemble, et Maghrib+\'Isha ensemble (en avance ou en retard).\n\n3. Ne pas jeûner — le voyageur peut reporter le jeûne du Ramadan et rattraper les jours manqués plus tard.\n\n4. Essuyer sur les chaussettes (Mashu) — pendant 3 jours et 3 nuits (au lieu de 1 jour pour le résident).\n\n5. Les prières surérogatoires — le voyageur peut délaisser les Rawatib (sunna régulières) sauf la sunna du Fajr et le Witr.\n\nConditions : la distance minimale du voyage est d\'environ 80 km selon la majorité des savants. La durée maximale de ces facilités est de 4 jours selon certains avis.',

        reponseEn: 'Method for teaching Qur\'an to children:\n\n1. Start early — from age 3-4 with listening. The child\'s brain is a sponge.\n\n2. Gentle repetition — recite chapters often (short ones in Juz\' Amma) in the car, before bedtime, etc.\n\n3. Start with short chapters — An-Nas, Al-Falaq, Al-Ikhlas, Al-Masad... working backwards.\n\n4. Audio — listen to a reciter with a beautiful voice (Mishary, Husary, Minshawi for children)\n\n5. Understanding — explain the meaning simply. Children retain better what they understand.\n\n6. Regularity — 10-15 minutes daily is better than one hour weekly\n\n7. Reward — praise, encourage, small gifts for milestones\n\n8. Quranic school (Maktab/Dar al-Quran) — group learning motivates\n\n9. Patience — each child has their own pace. Never compare.',
        source: 'Coran, An-Nisa 4:101 ; Bukhari, Muslim',
      ),
    ],
  ),

  // ══════════════════════════════════════════════════════════════
  // JEÛNES SURÉROGATOIRES
  // ══════════════════════════════════════════════════════════════
  AssistantTopic(
    id: 'jeunes',
    titleFr: 'Jeûnes Surérogatoires',

    titleEn: 'Voluntary Fasting',
    emoji: '🌟',
    descriptionFr: 'Shawwal, \'Arafa, \'Achoura et autres jeûnes',
    descriptionEn: 'Recommended fasts throughout the year',
    questions: [
      AssistantQA(
        id: 'jeu1',
        questionFr: 'Quels sont les 6 jours de Shawwal ?',

        questionEn: 'What are Islamic funeral rites?',
        keywords: ['shawwal', '6', 'jours', 'jeune', 'apres', 'ramadan'],
        reponseFr: 'Les 6 jours de Shawwal sont un jeûne surérogatoire fortement recommandé après le Ramadan.\n\nLe Prophète ﷺ a dit : « Quiconque jeûne le Ramadan puis le fait suivre de 6 jours de Shawwal, c\'est comme s\'il avait jeûné toute l\'année. » (Muslim)\n\nExplication : Ramadan = 30 jours × 10 = 300 jours de récompense. 6 jours de Shawwal × 10 = 60 jours. Total = 360 jours = toute l\'année.\n\nRègles :\n• On commence après le jour de l\'Aïd (il est interdit de jeûner le jour de l\'Aïd)\n• On peut les jeûner consécutivement ou séparément\n• On peut les jeûner n\'importe quand dans le mois de Shawwal\n• Il est préférable de rattraper les jours manqués du Ramadan avant de jeûner Shawwal (divergence)\n• On peut combiner l\'intention du rattrapage et de Shawwal selon certains savants',

        reponseEn: 'Islamic funeral rites (Janaiz):\n\nBefore burial:\n1. Ghusl (washing) — with water and camphor (kaafur), starting from right side, respectfully\n2. Kafan (shroud) — 3 white sheets (for men), tightly wrapped. No perfume except camphor.\n3. Janazah prayer — standing without bowing or prostration. Supplication for the deceased.\n\nDuring funeral:\n• Procession to cemetery\n• Community participation is encouraged\n• Women may attend (some schools restrict)\n• No singing, wailing, or excessive mourning\n\nAt burial:\n• Body laid on right side facing Mecca\n• "From it We created you, to it We return you, and from it We bring you out once more"\n• Soil placed with three handfuls\n\nAfter burial:\n• Dua for the deceased\n• Family stays for three days (mourning period)\n• Women observe \'Iddah if widow (4 months 10 days)\n\nIslam prohibits:\n• Cremation\n• Embalming (in most schools)\n• Photography\n• Unveiling the face unnecessarily\n• Excessive mourning (more than 3 days)\n• Burying with valuables',
        source: 'Muslim',
      ),
      AssistantQA(
        id: 'jeu2',
        questionFr: 'Quels sont les autres jeûnes recommandés ?',

        questionEn: 'What are the daily invocations (Adhkar)?',
        keywords: ['jeune', 'recommande', 'sunna', 'volontaire', 'surérogatoire', 'achoura', 'arafa'],
        reponseFr: 'Les jeûnes surérogatoires recommandés :\n\n1. Les lundis et jeudis — le Prophète ﷺ les jeûnait car « les actes sont présentés à Allah ces jours-là »\n\n2. Les 3 jours blancs — les 13, 14 et 15 de chaque mois lunaire (nuits de pleine lune)\n\n3. Le jour de \'Arafa (9 Dhul Hijja) — pour les non-pèlerins. « Il expie les péchés de l\'année passée et de l\'année à venir. » (Muslim)\n\n4. Le jour de \'Achoura (10 Muharram) — « Il expie les péchés de l\'année passée. » Il est recommandé de jeûner aussi le 9 ou le 11 pour se distinguer.\n\n5. Le jeûne de Dawud — un jour sur deux, c\'est le meilleur jeûne\n\n6. Le mois de Sha\'ban — le Prophète ﷺ jeûnait beaucoup en Sha\'ban\n\n7. Les 9 premiers jours de Dhul Hijja — surtout le jour de \'Arafa\n\nJours interdits de jeûner : les deux jours de l\'Aïd, les jours de Tashriq (11, 12, 13 Dhul Hijja selon certains avis).',

        reponseEn: 'Essential daily supplications:\n\nMorning (after Fajr):\n• "There is no god but Allah alone, without partners. To Him belongs the dominion and to Him belongs all praise. He gives life and brings death, and He is living and does not die. In His hand is all good, and He is capable of all things."\n• Subhan\'Allah (Glory be to Allah) 33 times\n• Alhamdulillah (All praise is for Allah) 33 times\n• Allahu Akbar (Allah is Greatest) 34 times\n\nEvening (before Maghrib):\n• Same as morning\n\nBefore sleep:\n• "In Your name O Allah, I live and die"\n• Ayat al-Kursi (2:255)\n• Last 3 chapters of Qur\'an (Al-Ikhlas, Al-Falaq, An-Nas)\n\nWhen entering/leaving home:\n• Entering: "Bismillah, allahumma inni as\'aluka khayra al-mawlij wa khayra al-makhraj"\n• Leaving: "Bismillah, tawakkaltu \'alallah"\n\nBefore eating:\n• "Bismillah" (In the name of Allah)\n\nAfter eating:\n• "Alhamdulillah alladhi atamana wa akala-na wa lam ya\'adhhib-una"\n\nMerit: The Prophet said whoever says these adhkar will enter Paradise.',
        source: 'Bukhari, Muslim ; Tirmidhi',
      ),
    ],
  ),

  // ══════════════════════════════════════════════════════════════
  // PILIERS DE LA FOI
  // ══════════════════════════════════════════════════════════════
  AssistantTopic(
    id: 'iman',
    titleFr: 'Les Piliers de la Foi',

    titleEn: 'The Pillars of Faith',
    emoji: '🕌',
    descriptionFr: 'Les fondements de la croyance',

    descriptionEn: 'Belief in Allah, His angels, scriptures, prophets, the Last Day, and divine decree',
    questions: [
      AssistantQA(
        id: 'ima1',
        questionFr: 'Quels sont les 5 piliers de l\'Islam ?',

        questionEn: 'What are the etiquettes (adab) of the mosque?',
        keywords: ['piliers', 'islam', '5', 'cinq', 'fondements', 'base'],
        reponseFr: 'Les 5 piliers de l\'Islam sont les fondements pratiques de la foi musulmane :\n\n1. La Shahada (l\'attestation de foi) — « Ash-hadu an la ilaha illallah wa ash-hadu anna Muhammadan rasulullah » (J\'atteste qu\'il n\'y a de divinité qu\'Allah et que Muhammad est Son messager). C\'est la porte d\'entrée en Islam.\n\n2. La Salat (la prière) — 5 prières quotidiennes obligatoires (Fajr, Dhuhr, \'Asr, Maghrib, \'Isha). C\'est le lien direct entre le serviteur et son Seigneur.\n\n3. La Zakat (l\'aumône purificatrice) — 2,5% de l\'épargne annuelle pour les nécessiteux. Elle purifie les biens et renforce la solidarité.\n\n4. Le Siyam (le jeûne du Ramadan) — s\'abstenir de manger, boire et de rapports intimes du Fajr au Maghrib pendant le mois de Ramadan.\n\n5. Le Hajj (le pèlerinage) — se rendre à La Mecque au moins une fois dans sa vie si on en a les moyens physiques et financiers.\n\nLe Prophète ﷺ a dit : « L\'Islam est bâti sur cinq piliers... »',

        reponseEn: 'Good manners in the mosque:\n\nBefore entering:\n• Perform wudu (ablutions)\n• Wear clean, modest clothes\n• Apply perfume (men)\n• Trim nails and remove visible impurities\n\nInside the mosque:\n• Walk with dignity and purpose\n• Greet others with salam\n• Sit in the rows, especially back rows\n• Avoid talking unnecessarily\n• Do not block others\' prayer lines\n• Sit with legs crossed or folded\n• Do not eat or chew\n• Silence during Quran recitation and sermon\n• Do not play with pebbles or dirt during sermon\n\nDuring prayer:\n• Remove shoes and place them carefully\n• Turn off phones or mute them\n• Do not push to the front\n• Keep humility and focus\n\nAfter prayer:\n• Do not rush out abruptly\n• Respect the space\n• Help elderly or children\n• Offer salam to neighbors\n\nWomen in the mosque:\n• May attend all prayers (contrary to some cultures)\n• Sit in back sections (optional)\n• Dress modestly\n• Maintain humility\n\nProhibited in mosque:\n• Loud conversations\n• Children running and playing\n• Eating and drinking\n• Perfume (for women — it may distract men)\n• Impurity\n• Business transactions',
        source: 'Bukhari, Muslim (hadith de Jibril)',
      ),
      AssistantQA(
        id: 'ima2',
        questionFr: 'Quels sont les 6 piliers de la foi (Iman) ?',

        questionEn: 'What are the etiquettes of eating in Islam?',
        keywords: ['piliers', 'foi', 'iman', '6', 'six', 'croyance'],
        reponseFr: 'Les 6 piliers de la Foi (Al-Iman) sont les fondements de la croyance musulmane :\n\n1. La foi en Allah — croire en Son existence, Son unicité, Ses Noms et Attributs\n\n2. La foi en Ses Anges — des créatures de lumière qui obéissent à Allah. Parmi eux : Jibril (révélation), Mikail (subsistance), Israfil (la Trompe), \'Izra\'il (la mort), Munkar et Nakir (la tombe)\n\n3. La foi en Ses Livres — la Torah, les Psaumes, l\'Évangile et le Coran (dernier et préservé)\n\n4. La foi en Ses Messagers — d\'Adam à Muhammad ﷺ, 25 mentionnés dans le Coran\n\n5. La foi au Jour Dernier — la mort, la tombe, la Résurrection, le Jugement, le Paradis et l\'Enfer\n\n6. La foi au Destin (Al-Qadr) — croire que tout ce qui arrive, en bien ou en mal, est par la volonté et la science d\'Allah. Cela n\'annule pas le libre arbitre humain.\n\nCes piliers sont tirés du célèbre hadith de Jibril, quand l\'ange demanda au Prophète ﷺ : « Qu\'est-ce que l\'Iman ? »',

        reponseEn: 'Islamic table manners according to the Sunnah:\n\nBefore eating:\n• Say "Bismillah" (In the name of Allah)\n• Wash hands\n• Sit properly\n\nDuring eating:\n• Eat with your right hand\n• Eat from what is in front of you\n• Do not reach across others\n• Eat slowly and chew well\n• Eat in moderation — "A believer eats in one intestine (is moderate) while a disbeliever eats in seven"\n• Do not waste food\n• Do not blow on hot food (against Sunnah)\n• Respect the food\n• Do not criticize the food\n\nManner:\n• Sit upright or cross-legged\n• Do not lounge or lie down while eating\n• Do not talk with mouth full\n• Avoid eating alone (invite others when possible)\n• Share food with family\n\nAfter eating:\n• Say "Alhamdulillah" (All praise is for Allah)\n• Thank your host\n• Lick your fingers (it is Sunna)\n• Help clean up\n• Do not leave until others finish (unless permitted)\n\nGeneral principles:\n• Eating is a mercy from Allah\n• Food is not to be wasted\n• Gratitude is essential\n• Moderation is the path',
        source: 'Muslim (hadith de Jibril) ; Coran, Al-Baqara 2:285',
      ),
      AssistantQA(
        id: 'ima3',
        questionFr: 'Qu\'est-ce que le Tawhid ?',

        questionEn: 'What are the etiquettes of eating in Islam?',
        keywords: ['tawhid', 'unicite', 'monotheisme', 'allah', 'un', 'seul'],
        reponseFr: 'Le Tawhid est le fondement absolu de l\'Islam : l\'unicité d\'Allah. C\'est le message de tous les prophètes depuis Adam.\n\nLes 3 catégories du Tawhid :\n\n1. Tawhid ar-Rububiyya (unicité de la seigneurie) — Allah seul est le Créateur, le Pourvoyeur, le Maître de l\'univers. Nul ne crée, ne donne la vie, ne fait mourir, ni ne gère l\'univers en dehors de Lui.\n\n2. Tawhid al-Uluhiyya (unicité de l\'adoration) — seul Allah mérite d\'être adoré. Toute prière, invocation, sacrifice, ou acte d\'adoration doit être dirigé vers Allah exclusivement. C\'est le sens de « La ilaha illallah ».\n\n3. Tawhid al-Asma wa as-Sifat (unicité des Noms et Attributs) — affirmer les Noms et Attributs qu\'Allah s\'est donnés dans le Coran et la Sunna, sans les nier, les déformer, ou les comparer à la création.\n\nLe Shirk (associer quoi que ce soit à Allah) est le seul péché qu\'Allah ne pardonne pas s\'il n\'y a pas de repentir : « Allah ne pardonne pas qu\'on Lui donne des associés, mais Il pardonne en deçà de cela à qui Il veut. » (An-Nisa 4:48)',

        reponseEn: 'Islamic table manners according to the Sunnah:\n\nBefore eating:\n• Say "Bismillah" (In the name of Allah)\n• Wash hands\n• Sit properly\n\nDuring eating:\n• Eat with your right hand\n• Eat from what is in front of you\n• Do not reach across others\n• Eat slowly and chew well\n• Eat in moderation — "A believer eats in one intestine (is moderate) while a disbeliever eats in seven"\n• Do not waste food\n• Do not blow on hot food (against Sunnah)\n• Respect the food\n• Do not criticize the food\n\nManner:\n• Sit upright or cross-legged\n• Do not lounge or lie down while eating\n• Do not talk with mouth full\n• Avoid eating alone (invite others when possible)\n• Share food with family\n\nAfter eating:\n• Say "Alhamdulillah" (All praise is for Allah)\n• Thank your host\n• Lick your fingers (it is Sunna)\n• Help clean up\n• Do not leave until others finish (unless permitted)\n\nGeneral principles:\n• Eating is a mercy from Allah\n• Food is not to be wasted\n• Gratitude is essential\n• Moderation is the path',
        source: 'Coran, Al-Ikhlas 112:1-4 ; An-Nisa 4:48',
      ),
    ],
  ),

  // ══════════════════════════════════════════════════════════════
  // HIJAB ET PUDEUR
  // ══════════════════════════════════════════════════════════════
  AssistantTopic(
    id: 'hijab',
    titleFr: 'Le Hijab et la Pudeur',

    titleEn: 'Hijab and Modesty',
    emoji: '🧕',
    descriptionFr: 'La pudeur vestimentaire en Islam',

    descriptionEn: 'Islamic dress code and modesty',
    questions: [
      AssistantQA(
        id: 'hij1',
        questionFr: 'Le hijab est-il obligatoire en Islam ?',

        questionEn: 'What is Halal food?',
        keywords: ['hijab', 'voile', 'obligatoire', 'femme', 'vetement', 'couvrir'],
        reponseFr: 'Le hijab (voile) est considéré comme obligatoire par le consensus des savants classiques et contemporains, basé sur le Coran et la Sunna :\n\nLe Coran dit : « Ô Prophète ! Dis à tes épouses, à tes filles et aux femmes des croyants de ramener sur elles leurs grands voiles. » (Al-Ahzab 33:59)\n\nEt : « Qu\'elles rabattent leur voile (Khimar) sur leurs poitrines. » (An-Nur 24:31)\n\nConditions du vêtement islamique (homme et femme) :\n1. Couvrir la \'awra — pour la femme : tout le corps sauf le visage et les mains (divergence sur le visage)\n2. Ne pas être transparent\n3. Ne pas être moulant (décrire les formes du corps)\n4. Ne pas ressembler aux vêtements spécifiques de l\'autre sexe\n5. Ne pas être un vêtement de renommée (ostentation)\n\nLe hijab est un acte d\'adoration envers Allah, un choix de dignité et de pudeur, pas une soumission à l\'homme.',

        reponseEn: 'Halal (lawful) food in Islam:\n\nHalal means:\n• Permitted and lawful\n• Prepared according to Islamic rules\n• Safe and ethical\n• No harm in its consumption\n\nAnimal meat:\n• Must be from lawful animals (cattle, sheep, goats, poultry, fish)\n• Slaughtered with Allah\'s name mentioned\n• Slaughtered by Muslim or person of the Book\n• All blood drained\n• Done with sharp blade quickly\n• Prohibition to hurt the animal\n\nHaram (unlawful) animals:\n• Pork (explicitly forbidden in Qur\'an)\n• Carnivorous animals (predators)\n• Birds of prey\n• Reptiles\n• Shellfish (according to some schools)\n• Insects (except locust)\n• Intoxicating animals\n\nFish and seafood:\n• Generally halal (all types)\n• Widely permitted\n• No special slaughtering needed\n\nVegetation:\n• All fruits and vegetables halal\n• Unless poisoned or harmful\n\nWhat is Haram (unlawful):\n• Pork and pork products\n• Meat not slaughtered Islamically\n• Blood\n• Intoxicating substances\n• Carrion (dead animals)\n• Meat of carnivorous animals\n\nWisdom:\n• Health benefits\n• Ethical treatment of animals\n• Cleanliness and hygiene\n• Spiritual purity\n\nModern considerations:\n• Certification from Islamic bodies\n• Check ingredients (gelatin, additives)\n• Intention matters',
        source: 'Coran, Al-Ahzab 33:59 ; An-Nur 24:31',
      ),
      AssistantQA(
        id: 'hij2',
        questionFr: 'Qu\'est-ce que la pudeur (Haya) en Islam ?',

        questionEn: 'Why is alcohol forbidden in Islam?',
        keywords: ['pudeur', 'haya', 'modestie', 'comportement', 'regard'],
        reponseFr: 'La Haya (pudeur) est une branche de la foi. Le Prophète ﷺ a dit : « La pudeur fait partie de la foi. » (Bukhari) Et : « La pudeur ne vient qu\'avec le bien. » (Muslim)\n\nLa pudeur concerne :\n\n1. Le regard — « Dis aux croyants de baisser leurs regards et de garder leur chasteté. » (An-Nur 24:30) Cela s\'applique aux HOMMES en premier dans le verset.\n\n2. La parole — éviter les propos vulgaires, les plaisanteries indécentes, la séduction inappropriée\n\n3. Le vêtement — couvrir sa \'awra dignement (pour les hommes aussi : du nombril au genou minimum)\n\n4. Le comportement — éviter la mixité non nécessaire, le khalwa (isolement homme-femme non mahram)\n\n5. La pudeur envers Allah — avoir conscience qu\'Allah nous observe en tout temps\n\nLe Prophète ﷺ était le plus pudique des gens, « plus pudique qu\'une jeune fille dans sa chambre » (Bukhari).\n\nLa pudeur n\'est pas de la timidité — c\'est une noblesse de caractère.',

        reponseEn: 'The prohibition of alcohol (Khamr) in Islam:\n\nReligious reason:\nAllah says: "O you who have believed, indeed, intoxicants, gambling, and stone altars and divining arrows are unclean from the work of Satan, so avoid them." (Al-Ma\'idah 5:90)\n\nPractical reasons:\n1. Health — alcohol damages the brain, liver, causes addiction, diseases\n2. Morality — intoxication leads to immoral behavior, loss of dignity\n3. Safety — impairs judgment, causes accidents, violence\n4. Social — breaks families, causes poverty and crime\n5. Spiritual — prevents worship and connection with Allah\n\nProgressive prohibition:\n• Initially discouraged\n• Then forbidden before prayer\n• Finally completely forbidden\n\nWhat is forbidden:\n• All alcoholic drinks (beer, wine, spirits)\n• Fermented grape juice\n• Anything that intoxicates in large quantities\n• Even one drop\n\nWhat is permissible:\n• Non-alcoholic grape juice\n• Freshly made drinks (before fermentation)\n• Medicines containing alcohol if no alternative\n\nPunishment:\n• 80 lashes for drinking (in Islamic state)\n• Repentance is always accepted\n\nWisdom: Allah protected mental faculties, which distinguish humans from animals. Intoxication surrenders this gift.',
        source: 'Bukhari, Muslim ; Coran, An-Nur 24:30-31',
      ),
      AssistantQA(
        id: 'hij3',
        questionFr: 'Comment aider quelqu\'un à porter le hijab ?',

        questionEn: 'Is hijab obligatory in Islam?',
        keywords: ['porter', 'hijab', 'commencer', 'encourager', 'conseil', 'difficulte'],
        reponseFr: 'Conseils pour accompagner vers le hijab avec bienveillance :\n\n1. La douceur avant tout — « Allah est doux et aime la douceur en toute chose. » Ne jamais forcer, humilier ou culpabiliser.\n\n2. L\'éducation — comprendre POURQUOI avant le COMMENT. Quand la personne comprend la sagesse divine, la conviction vient naturellement.\n\n3. La progressivité — commencer par des vêtements plus amples et modestes, puis progresser vers le hijab complet. La foi grandit par étapes.\n\n4. L\'environnement — s\'entourer de sœurs pratiquantes qui portent le hijab avec joie et fierté.\n\n5. La du\'a — invoquer Allah sincèrement pour soi ou pour la personne. La guidance vient d\'Allah.\n\n6. Le bon exemple — être un modèle de comportement, pas juste d\'apparence. Le hijab du cœur accompagne celui du corps.\n\n7. La patience — chaque personne a son rythme. Le Prophète ﷺ a mis 23 ans pour transmettre l\'Islam complet.\n\n8. Ne pas juger — seul Allah connaît le cœur des gens. Encourager sans condamner.',

        reponseEn: 'The hijab (Islamic headscarf) in Islam:\n\nRuling:\n• Considered obligatory by the majority of scholars\n• Clear Qur\'anic command: "Tell the believing women to lower their gaze and guard their chastity; not to display their adornment except what is apparent, and to draw their veils (khimar) over their bosoms..."\n• Part of Islamic modest dress (Haya)\n\nWhat is required:\n• Cover the hair\n• Cover the neck and shoulders\n• Modest, loose-fitting clothing\n• Not transparent or revealing\n• Not for adornment, but modesty\n\nVariations:\n• Different styles in different cultures (Turkish, Arab, Persian, etc.)\n• Essential is the principle, not the style\n• Can be creative while maintaining modesty\n\nWisdom:\n1. Spiritual protection — guard against lustful looks\n2. Social respect — dignified presentation\n3. Identity — mark of Muslim identity\n4. Equality — judged by character, not beauty\n5. Chastity — protects both men and women\n\nNot obligatory:\n• For young children (before puberty)\n• For elderly women (according to some)\n\nCompanion women:\n• Wore hijab\n• It was immediate practice\n• No debate among Sahaba\n\nKey point:\n• Hijab is between woman and Allah\n• No one can force or judge\n• Her choice to wear it\n• Respect is mutual',
        source: 'Approche prophétique de la da\'wa',
      ),
    ],
  ),

  // ══════════════════════════════════════════════════════════════
  // SADAQA ET GÉNÉROSITÉ
  // ══════════════════════════════════════════════════════════════
  AssistantTopic(
    id: 'sadaqa',
    titleFr: 'La Sadaqa',

    titleEn: 'Sadaqa',
    emoji: '🤲',
    descriptionFr: 'La charité volontaire et ses mérites',

    descriptionEn: 'Voluntary charity',
    questions: [
      AssistantQA(
        id: 'sad1',
        questionFr: 'Qu\'est-ce que la Sadaqa ?',

        questionEn: 'What is Haya (modesty)?',
        keywords: ['sadaqa', 'charite', 'don', 'aumone', 'volontaire', 'genereux'],
        reponseFr: 'La Sadaqa est la charité volontaire en Islam, distincte de la Zakat (obligatoire). Elle est l\'une des meilleures actions en Islam.\n\nFormes de Sadaqa :\n• L\'argent — donner aux pauvres, aux mosquées, aux associations\n• Le sourire — « Ton sourire à ton frère est une Sadaqa » (Tirmidhi)\n• La bonne parole — « La bonne parole est une Sadaqa » (Bukhari)\n• Retirer un obstacle du chemin — « Écarter une nuisance du chemin est une Sadaqa »\n• Aider quelqu\'un — porter ses affaires, le guider sur la route\n• Le dhikr — « Subhanallah, Al-hamdulillah, La ilaha illallah, Allahu Akbar sont des Sadaqat »\n• L\'eau — « La meilleure Sadaqa est de donner de l\'eau » (Ahmad)\n\nMérites :\n• La Sadaqa éteint les péchés comme l\'eau éteint le feu\n• Elle protège de l\'Enfer — « Protégez-vous du Feu, ne serait-ce qu\'avec une demi-datte »\n• Elle n\'appauvrit jamais — « La Sadaqa ne diminue pas un bien »\n• Elle ombrage le donneur le Jour du Jugement',

        reponseEn: 'Haya (Islamic modesty/shame):\n\nDefinition:\n• A feeling that prevents one from indecency and impropriety\n• Part of faith\n• Healthy shame before Allah and society\n\nQuran and Hadith:\n• "Haya (modesty) is a branch of faith"\n• Prophet said: "Modesty brings nothing but good"\n• "Each religion has a character, and the character of Islam is modesty"\n\nManifestations:\n• In dress — covering \'awra (private parts)\n• In behavior — lowering gaze, respectful conduct\n• In speech — avoiding foul language\n• In dealings — honest and fair\n• In relationships — appropriate boundaries\n\nFor women:\n• Modest dress and behavior\n• Not displaying beauty unnecessarily\n• Speaking respectfully\n• Not being alone with unrelated men\n• Humble demeanor\n\nFor men:\n• Lowering gaze\n• Respectful behavior towards women\n• Not staring or flirting\n• Modest dress\n• Pure intentions\n\nBenefit:\n• Prevents sin\n• Protects honor and dignity\n• Creates respectful society\n• Pleases Allah\n• Internal purity\n\nLoss of Haya:\n• Sign of weakness in faith\n• Leads to corruption\n• Loss of dignity\n• Spiritual emptiness\n• Social decay',
        source: 'Bukhari, Muslim ; Tirmidhi',
      ),
      AssistantQA(
        id: 'sad2',
        questionFr: 'Qu\'est-ce que la Sadaqa Jariya ?',

        questionEn: 'How to gently guide someone to wear hijab?',
        keywords: ['sadaqa', 'jariya', 'continue', 'apres', 'mort', 'perpetuelle'],
        reponseFr: 'La Sadaqa Jariya est l\'aumône continue dont la récompense perdure APRÈS la mort :\n\nLe Prophète ﷺ a dit : « Quand le fils d\'Adam meurt, ses œuvres s\'arrêtent sauf trois : une Sadaqa Jariya, une science dont on profite, ou un enfant pieux qui invoque pour lui. » (Muslim)\n\nExemples de Sadaqa Jariya :\n1. Construire ou participer à la construction d\'une mosquée\n2. Creuser un puits ou installer un point d\'eau\n3. Planter un arbre — tout être vivant qui en mange génère une récompense\n4. Publier un livre utile ou enseigner une science\n5. Construire une école ou un hôpital\n6. Parrainer un orphelin\n7. Distribuer des exemplaires du Coran\n8. Créer un Waqf (donation pieuse perpétuelle)\n9. Élever des enfants pieux qui invoquent pour vous\n\nC\'est l\'investissement le plus intelligent — un retour éternel pour un investissement terrestre limité.',

        reponseEn: 'Approaching hijab with love and wisdom:\n\nWays to help:\n1. Lead by example — wear hijab with pride and beauty\n2. Share knowledge — explain Islamic wisdom without judgment\n3. Beautiful presentation — show how hijab can be fashionable and confident\n4. Story and testimony — share personal journeys\n5. Community support — introduce to hijab-wearing sisters\n6. Patience — change takes time\n\nWhat to avoid:\n1. Judgment or criticism — "You\'re not a good Muslim"\n2. Force — will create resistance\n3. Public shaming — humiliation pushes away\n4. Lectures — boring and counterproductive\n5. Making her feel inferior — she has her journey\n\nInvolving family:\n• Mother/sister\'s gentle influence\n• Family support and encouragement\n• Making it normal, not exceptional\n• Celebrating when she chooses it\n\nWhen she starts:\n• Celebrate her choice\n• Help with styles and confidence\n• Introduce hijab community\n• Support through adjustment\n• Share encouraging stories\n\nSpiritual approach:\n• Pray for her guidance\n• Make du\'a (supplication)\n• Trust Allah\'s timing\n• Every soul has its journey\n\nRemember:\n• Hijab is between her and Allah\n• Forcing creates resentment\n• Gentle kindness opens hearts\n• Example is most powerful teacher',
        source: 'Muslim',
      ),
      AssistantQA(
        id: 'sad3',
        questionFr: 'Comment donner la Sadaqa en secret ?',

        questionEn: 'What are the 5 Pillars of Faith (Iman)?',
        keywords: ['secret', 'sadaqa', 'cacher', 'discret', 'ostentation', 'riya'],
        reponseFr: 'La Sadaqa en secret est supérieure à la Sadaqa publique dans la plupart des cas :\n\nAllah dit : « Si vous donnez vos aumônes ouvertement, c\'est bien. Mais si vous les cachez pour les donner aux pauvres, c\'est encore mieux pour vous. » (Al-Baqara 2:271)\n\nParmi les 7 catégories protégées sous l\'Ombre d\'Allah le Jour du Jugement : « Un homme qui donne en charité si secrètement que sa main gauche ne sait pas ce que sa main droite a donné. » (Bukhari)\n\nConseils pratiques :\n• Donner anonymement (enveloppe, virement sans nom)\n• Ne pas en parler aux gens — pas de publication sur les réseaux sociaux\n• Varier les bénéficiaires pour ne pas être identifié\n• Vérifier son intention (Niyya) — la Sadaqa est pour Allah, pas pour la réputation\n\nException : la Sadaqa publique est permise si elle encourage les autres à donner, à condition que l\'intention reste pure.',

        reponseEn: 'The 5 Pillars of Islamic Faith (Iman):\n\n1. Belief in Allah (Tawhid):\n• Monotheism — one God\n• No partners or equals\n• Belief in His attributes and names\n• Submission to His will\n\n2. Belief in His Angels:\n• Jibril (Gabriel) — brought revelation\n• Mikail (Michael) — nourishment\n• Israfil — will blow the horn\n• Malik — guardian of Hell\n• Angels record deeds\n• Many others we don\'t know about\n\n3. Belief in His Books:\n• Qur\'an — final and preserved revelation\n• Bible — original revelation (now changed)\n• Torah — original revelation (now changed)\n• Psalms — revealed to David\n• Scrolls of Abraham and Moses\n\n4. Belief in His Messengers:\n• Prophet Muhammad — final messenger\n• Abraham, Moses, Jesus — major prophets\n• All messengers had same core message\n• Muhammad came for all humanity\n• No prophet after Muhammad\n\n5. Belief in the Last Day:\n• Day of Judgment\n• Resurrection of all humans\n• Accountability for deeds\n• Heaven (Jannah) and Hell (Jahannam)\n• Reckoning before Allah\n\n6. (Sometimes counted 6th) Belief in Divine Decree:\n• Allah\'s knowledge of all things\n• Everything is predetermined\n• Human free choice within Allah\'s knowledge\n• Balance between predestination and choice\n\nVirtue: These form the foundation of Islamic belief and practice.',
        source: 'Coran, Al-Baqara 2:271 ; Bukhari',
      ),
    ],
  ),

  // ══════════════════════════════════════════════════════════════
  // COMMERCE EN ISLAM
  // ══════════════════════════════════════════════════════════════
  AssistantTopic(
    id: 'commerce',
    titleFr: 'Le Commerce en Islam',

    titleEn: 'Trade and Commerce in Islam',
    emoji: '⚖️',
    descriptionFr: 'Éthique commerciale et finance islamique',

    descriptionEn: 'Islamic business ethics and rulings',
    questions: [
      AssistantQA(
        id: 'com1',
        questionFr: 'Quelles sont les règles du commerce en Islam ?',

        questionEn: 'What are the rules of business in Islam?',
        keywords: ['commerce', 'vente', 'achat', 'business', 'halal', 'travail'],
        reponseFr: 'L\'Islam encourage le commerce et le travail honnête. Le Prophète ﷺ était lui-même commerçant.\n\nPrincipes du commerce halal :\n1. L\'honnêteté — « Le commerçant honnête et digne de confiance sera avec les prophètes, les véridiques et les martyrs » (Tirmidhi)\n2. Pas de tromperie — interdiction de cacher les défauts d\'un produit\n3. Pas de Riba (usure/intérêts) — strictement interdit\n4. Pas de Gharar (incertitude excessive) — vente aléatoire, jeux de hasard\n5. Pas de marchandise haram — alcool, porc, drogue, etc.\n6. Le consentement mutuel — « Le commerce n\'est licite que par consentement mutuel » (An-Nisa 4:29)\n7. Peser et mesurer justement — « Malheur aux fraudeurs ! » (Al-Mutaffifin 83:1)\n\nConseils prophétiques :\n• Être souple dans la vente et l\'achat\n• Accorder des délais aux débiteurs en difficulté\n• Invoquer la bénédiction d\'Allah dans son commerce',

        reponseEn: 'Islamic business ethics and rulings:\n\nGeneral principles:\n1. Honesty — "The honest merchant will be with the prophets on the Day of Judgment"\n2. Fairness — just weights and measures\n3. Transparency — no deception\n4. Consent — both parties must agree willingly\n5. Quality — provide good products/services\n\nProhibited practices:\n1. Riba (interest/usury) — completely forbidden\n2. Gharar (uncertainty/ambiguity) — undefined contracts\n3. Tadallis (deception) — hiding defects\n4. Ihtikar (hoarding) — artificially raising prices\n5. Bai\'al-haramain (selling prohibited items)\n6. False oaths — to sell more\n\nPermitted business:\n• Buying and selling (with honesty)\n• Partnerships\n• Agriculture\n• Manufacturing\n• Skilled labor\n• Professional services\n\nCommendable practices:\n1. Keeping scales honest — reward is great\n2. Being merciful to customers\n3. Giving time to debtors\n4. Returning profits after expenses\n5. Contributing to society\n\nProphet\'s guidance:\n• "Seeking sustenance is a duty" — work is worship\n• Business based on truth and trust\n• Good reputation is capital\n• Charity from business wealth',
        source: 'Coran, Al-Baqara 2:275 ; An-Nisa 4:29 ; Tirmidhi',
      ),
      AssistantQA(
        id: 'com2',
        questionFr: 'Pourquoi le Riba (intérêt) est-il interdit ?',

        questionEn: 'Why is Riba (interest) forbidden?',
        keywords: ['riba', 'interet', 'usure', 'banque', 'pret', 'interdit', 'haram'],
        reponseFr: 'Le Riba (usure/intérêts) est l\'un des plus grands péchés en Islam. Allah dit : « Ceux qui pratiquent le Riba ne se lèveront [le Jour du Jugement] que comme se lève celui que le Diable a frappé de folie. » (Al-Baqara 2:275)\n\nLe Prophète ﷺ a maudit : celui qui prend le Riba, celui qui le donne, celui qui l\'écrit et les deux témoins. (Muslim)\n\nPourquoi c\'est interdit :\n1. Il exploite les nécessiteux — on profite de la détresse des gens\n2. Il crée de la richesse sans travail ni risque réel\n3. Il creuse les inégalités sociales\n4. Il mène aux crises financières (la crise de 2008 en est un exemple)\n\nAlternatives islamiques :\n• Murabaha — vente avec marge transparente\n• Musharaka — partenariat avec partage des profits ET des pertes\n• Ijara — location-vente\n• Qard Hasan — prêt sans intérêt (la meilleure forme)\n\nLes banques islamiques proposent ces alternatives conformes à la Charia.',

        reponseEn: 'The prohibition of Riba (usury/interest):\n\nIslamic prohibition:\n• Forbidden 4 times in the Qur\'an (strongest prohibition)\n• Warned harshly: "Those who consume interest will not stand except as one who has been driven to madness by the touch of Satan."\n\nTypes of Riba:\n1. Riba al-Fadl (interest on exchange) — unequal exchange of same commodity\n2. Riba al-Nasia (time interest) — loaning with interest\n\nWhy forbidden:\n\n1. Exploitation — creditor takes advantage of desperate debtor\n2. Injustice — unfair gain without effort or risk\n3. Destroys society — creates debt slavery, poverty, wealth disparity\n4. Moral corruption — prioritizes greed over compassion\n5. Economic damage — leads to inflation, unemployment\n\nHistorical evidence:\n• All major religions condemned it\n• Pre-Islamic Arabia\'s moral decline was linked to usury\n• Prophet\'s generation abolished it immediately\n\nAlternatives:\n• Zakat — wealth purification\n• Partnerships — shared risk and profit\n• Islamic banking — profit-and-loss sharing\n• Qard Hasan — interest-free loan\n\nReward for abandoning:\n• Those who give it up get full capital back\n• Allah replaces it with lawful earnings\n• Blessing in earnings',
        source: 'Coran, Al-Baqara 2:275-279 ; Muslim',
      ),
      AssistantQA(
        id: 'com3',
        questionFr: 'Le travail de la femme est-il permis en Islam ?',

        questionEn: 'Is women\'s work permitted in Islam?',
        keywords: ['travail', 'femme', 'emploi', 'permis', 'profession', 'carriere'],
        reponseFr: 'Le travail de la femme est permis en Islam, sous certaines conditions :\n\nPreuves historiques :\n• Khadija (épouse du Prophète ﷺ) était une grande commerçante prospère\n• Les femmes participaient à la vie économique et sociale à l\'époque du Prophète ﷺ\n• Des femmes compagnons exerçaient des métiers variés (médecine, commerce, artisanat)\n\nConditions :\n1. Le travail doit être licite (halal) en soi\n2. Respecter la pudeur vestimentaire et comportementale\n3. Ne pas nuire à ses obligations familiales essentielles (par concertation avec la famille)\n4. Un environnement de travail respectueux\n\nPrincipes :\n• La femme a le droit total de disposer de son salaire — elle n\'est pas obligée de le dépenser pour le foyer\n• L\'entretien du foyer reste la responsabilité du mari, même si la femme travaille\n• La concertation (Shura) au sein du couple est essentielle\n• Aucun texte du Coran ou de la Sunna n\'interdit le travail de la femme en soi',

        reponseEn: 'Women\'s work in Islam:\n\nGeneral ruling:\n• Work is permitted for women\n• Can own businesses, trade, work in professions\n• Financial independence is her right\n• Can keep her earnings entirely\n\nConditions (if married/required):\n1. Consultation with husband (not permission)\n2. Does not harm family responsibilities\n3. Modest dress and conduct\n4. No mixing with unrelated men unnecessarily\n5. No compromising Islamic values\n6. Safe working conditions\n7. Reasonable hours allowing family time\n\nHistorical examples:\n• Khadijah (wife of Prophet) — successful merchant\n• Asma (Sahaba) — managed business\n• Umm Qirfa — had business enterprises\n\nRecommendable professions:\n• Teaching (Islamic knowledge)\n• Medicine (especially for women)\n• Crafts and skills\n• Trade and commerce\n• Writing and education\n• Nursing and healthcare\n• Administrative work\n\nPermitted areas:\n• Can work in all-female environments\n• Can be teachers, doctors, scholars\n• Can manage family business\n• Can earn and inherit\n\nParent/child balance:\n• If she chooses family over work — honored\n• If she chooses work — it is her right\n• Both are valid life choices\n\nKey: Consultation, not permission from husband',
        source: 'Pratique prophétique ; consensus des savants contemporains',
      ),
    ],
  ),

  // ══════════════════════════════════════════════════════════════
  // LA SUNNA DU PROPHÈTE ﷺ
  // ══════════════════════════════════════════════════════════════
  AssistantTopic(
    id: 'sunna',
    titleFr: 'La Sunna du Prophète ﷺ',

    titleEn: 'The Sunnah of the Prophet',
    emoji: '🌿',
    descriptionFr: 'Suivre l\'exemple du Prophète Muhammad ﷺ',
    descriptionEn: 'The teachings and practices of Muhammad',
    questions: [
      AssistantQA(
        id: 'sun1',
        questionFr: 'Qu\'est-ce que la Sunna ?',

        questionEn: 'What is the Shahada (Islamic declaration)?',
        keywords: ['sunna', 'prophete', 'hadith', 'exemple', 'tradition'],
        reponseFr: 'La Sunna est l\'ensemble des paroles, actes, approbations et caractéristiques du Prophète Muhammad ﷺ. Elle est la deuxième source de la législation islamique après le Coran.\n\nTypes de Sunna :\n1. Sunna Qawliyya (paroles) — les hadiths rapportant ses paroles\n2. Sunna Fi\'liyya (actes) — ce qu\'il faisait au quotidien\n3. Sunna Taqririyya (approbations) — ce qu\'il a vu faire sans l\'interdire\n4. Sunna Wasafiyya (descriptions) — ses caractéristiques physiques et morales\n\nStatuts de la Sunna :\n• Sunna Mu\'akkada — fortement recommandée (ex: les Rawatib)\n• Sunna Ghayru Mu\'akkada — recommandée mais moins appuyée\n• Les actes spécifiques au Prophète ﷺ (ex: le mariage avec plus de 4 femmes)\n\nAllah dit : « En vérité, vous avez dans le Messager d\'Allah un excellent modèle. » (Al-Ahzab 33:21)\nEt : « Ce que le Messager vous donne, prenez-le. Et ce qu\'il vous interdit, abstenez-vous-en. » (Al-Hashr 59:7)',

        reponseEn: 'The Shahada (Declaration of Faith):\n\nText:\n"La ilaha illallah, Muhammadur rasulullah"\n"There is no god but Allah, and Muhammad is the Messenger of Allah"\n\nPillars:\n1. La ilaha (there is no god)\n• Negation of false deities\n• Rejection of partners with Allah\n• Denial of idolatry\n\n2. Illallah (except Allah)\n• Affirmation of one God\n• Allah\'s uniqueness\n• Absolute monotheism\n\n3. Muhammadur rasulullah (Muhammad is the Messenger)\n• Prophet\'s truthfulness\n• Following his teachings\n• Accepting his guidance\n• Obedience to his Sunnah\n\nSignificance:\n• Entry to Islam\n• Most important statement\n• All beliefs rest on it\n• Sincerity is essential\n• Heart and tongue together\n\nReward:\n• Immediate acceptance\n• Gateway to Paradise\n• Foundation of practice\n• Unifies Muslims\n\nMeaning:\n• Not just words\n• Complete submission\n• Belief and action\n• Following Muhammad\'s path\n• Pure monotheism',
        source: 'Coran, Al-Ahzab 33:21 ; Al-Hashr 59:7',
      ),
      AssistantQA(
        id: 'sun2',
        questionFr: 'Quelles sont les sunna quotidiennes faciles à pratiquer ?',

        questionEn: 'What is Tawhid (Islamic monotheism)?',
        keywords: ['sunna', 'quotidien', 'facile', 'simple', 'pratique', 'habitude'],
        reponseFr: 'Sunna quotidiennes faciles et très récompensées :\n\nLe matin :\n• Dire les adhkar du matin après Fajr\n• Utiliser le Siwak (bâtonnet pour les dents)\n• Dire « Bismillah » avant toute action\n\nLes repas :\n• Manger de la main droite\n• Dire « Bismillah » avant et « Al-hamdulillah » après\n• Ne pas gaspiller\n\nLa journée :\n• Sourire — c\'est une Sadaqa\n• Saluer (Salam) en premier — « Le meilleur est celui qui commence par le Salam »\n• Dire « Yarhamukallah » quand quelqu\'un éternue\n• Marcher vers la mosquée — chaque pas efface un péché\n\nAvant de dormir :\n• Faire le wudu\n• Réciter Ayat al-Kursi et les 3 Qul\n• Dormir sur le côté droit\n\nHebdomadaire :\n• Jeûner les lundis et jeudis\n• Couper les ongles\n• Réciter sourate Al-Kahf le vendredi\n\nToutes ces sunna sont simples mais accumulent des montagnes de récompenses.',

        reponseEn: 'Tawhid (Islamic Monotheism):\n\nDefinition:\n• Acknowledging that Allah is One\n• No partners, equals, or associates\n• Foundation of entire Islamic faith\n• Most important concept in Islam\n\nQur\'anic basis:\n• "Say, He is Allah, the One" (Al-Ikhlas 112:1)\n• "There is nothing like unto Him" (Ash-Shura 42:11)\n• "Verily, I am Allah, none has the right to be worshipped but I" (An-Nisa 4:163)\n\nThree aspects:\n\n1. Tawhid Al-Rububiyyah (Lordship):\n• Allah alone is the Creator\n• Allah alone sustains and controls creation\n• Accepting this is basic Tawhid\n\n2. Tawhid Al-Uluhiyyah (Worship):\n• All worship is due to Allah alone\n• No intercession except through Allah\n• Directing all acts of devotion to Him\n• Not seeking help from anyone else\n\n3. Tawhid Al-Asma wa As-Sifat (Names and Attributes):\n• Believing in His beautiful names\n• Understanding His perfect attributes\n• Not comparing Him to creation\n• Invoking Him through His names\n\nImplications:\n• Complete submission to Allah\n• Trust and reliance on Him\n• Fear only Him\n• Hope only in His mercy\n• Seek only His approval\n\nNegation:\n• No partners in worship\n• No idolatry (physical or spiritual)\n• No polytheism\n• No innovation in religion\n\nBenefit:\n• Purifies the heart\n• Gives purpose to life\n• Freedom from creation\'s judgment\n• Inner peace and certainty',
        source: 'Bukhari, Muslim ; Abu Dawud',
      ),
      AssistantQA(
        id: 'sun3',
        questionFr: 'Comment était le caractère du Prophète ﷺ ?',

        questionEn: 'What are the 6 fasts of Shawwal?',
        keywords: ['caractere', 'prophete', 'comportement', 'personnalite', 'exemple', 'akhlaq'],
        reponseFr: 'Le Prophète Muhammad ﷺ avait le meilleur caractère de toute l\'humanité. Allah le décrit : « Et tu es certes d\'un caractère éminent. » (Al-Qalam 68:4)\n\nSon caractère :\n• La miséricorde — « Nous ne t\'avons envoyé que comme miséricorde pour les mondes » (Al-Anbiya 21:107). Il était miséricordieux même envers ses ennemis.\n• La douceur — il ne s\'est jamais vengé pour lui-même. Il pardonnait même à ceux qui l\'avaient persécuté.\n• L\'humilité — il raccommodait ses chaussures, trayait ses chèvres, aidait à la maison.\n• La générosité — il donnait sans compter, jamais il n\'a dit « non » à quelqu\'un qui demandait.\n• La justice — il traitait tous les gens équitablement, riches ou pauvres.\n• La patience — il a enduré 13 ans de persécution à La Mecque sans perdre espoir.\n• La pudeur — plus pudique qu\'une jeune fille.\n• L\'amour des enfants — il portait ses petits-enfants pendant la prière, jouait avec eux.\n• Le sourire — « Il était le plus souriant des gens » (Tirmidhi)\n\nAïcha a dit quand on lui a demandé son caractère : « Son caractère était le Coran. »',

        reponseEn: 'The 6 fasts of Shawwal:\n\nDefinition:\n• Six voluntary fasts after Ramadan\n• Performed in Shawwal (10th lunar month)\n• Highly recommended (Sunna)\n\nWhen to fast:\n• After Ramadan ends (after \'Eid al-Fitr)\n• Any 6 days during Shawwal\n• Consecutively or separately\n• Before next Ramadan begins\n\nReward:\n• Prophet said: "Fasting Ramadan then six of Shawwal is like fasting the whole year"\n• Equals fasting 360 days\n• Great reward and blessing\n• Continuation of worship after Ramadan\n\nManner:\n• Same as Ramadan fasting\n• From dawn to sunset\n• Intention made each night\n• Same rules apply (no food, drink, intimate relations)\n\nBenefit:\n• Maintains momentum after Ramadan\n• Shows gratitude to Allah\n• Increases closeness to Allah\n• Develops discipline\n• Easy way to gain major reward\n\nNot obligatory:\n• Highly recommended but not required\n• Those unable can skip\n• No penalty for missing\n• Those with valid excuse (travel, illness) may defer\n\nTiming:\n• Best to do consecutively\n• Can be spread throughout Shawwal\n• Must finish before Shawwal ends',
        source: 'Coran, Al-Qalam 68:4 ; Muslim ; Tirmidhi',
      ),
    ],
  ),

  // ══════════════════════════════════════════════════════════════
  // LES COMPAGNONS
  // ══════════════════════════════════════════════════════════════
  AssistantTopic(
    id: 'compagnons',
    titleFr: 'Les Compagnons (Sahaba)',

    titleEn: 'The Companions (Sahaba)',
    emoji: '⭐',
    descriptionFr: 'Les meilleurs après les prophètes',

    descriptionEn: 'The blessed generation that accompanied the Prophet',
    questions: [
      AssistantQA(
        id: 'cpn1',
        questionFr: 'Qui sont les compagnons du Prophète ﷺ ?',

        questionEn: 'Who are the Companions of the Prophet?',
        keywords: ['compagnon', 'sahaba', 'sahabi', 'prophete', 'meilleur'],
        reponseFr: 'Les Compagnons (Sahaba) sont ceux qui ont rencontré le Prophète ﷺ, ont cru en lui et sont morts sur la foi. Ils sont la meilleure génération de cette communauté.\n\nLe Prophète ﷺ a dit : « Les meilleurs des gens sont ma génération, puis ceux qui les suivent, puis ceux qui les suivent. » (Bukhari)\n\nLes 4 Califes bien-guidés (Al-Khulafa ar-Rashidun) :\n1. Abu Bakr as-Siddiq — le plus grand compagnon, premier calife, meilleur ami du Prophète ﷺ\n2. \'Umar ibn al-Khattab — le juste, deuxième calife, connu pour sa force et son équité\n3. \'Uthman ibn \'Affan — le généreux, troisième calife, a compilé le Coran\n4. \'Ali ibn Abi Talib — le cousin et gendre du Prophète ﷺ, quatrième calife, porte du savoir\n\nLes 10 promis au Paradis incluent aussi : Talha, Zubayr, \'Abdur-Rahman ibn \'Awf, Sa\'d ibn Abi Waqqas, Sa\'id ibn Zayd, Abu \'Ubayda ibn al-Jarrah.\n\nLe respect des Compagnons fait partie de la foi du musulman.',

        reponseEn: 'The Companions (Sahaba):\n\nDefinition:\n• Those who met Muhammad and believed in him\n• Lived during his lifetime and after\n\nVirtues:\n• Best generation after the Prophets\n• "My Companions are like the stars, follow any of them and you will be guided"\n• Closest to the Prophet\'s teachings\n• Witnessed his actions and manners\n• Memorized and preserved the Qur\'an\n\nNotable Companions:\n• Abu Bakr (Al-Siddiq) — first Caliph, closest friend\n• Umar ibn Al-Khattab — 2nd Caliph, strong judge\n• Uthman ibn Affan — 3rd Caliph, compiled Qur\'an\n• Ali ibn Abi Talib — 4th Caliph, great scholar\n• Aisha (Mother of Believers) — narrated many Hadith\n• Fatima — daughter of Prophet\n• Bilal — first Muezzin\n• Hamza — Uncle, mighty warrior\n• Khadijah — first wife\n\nMissions:\n• Spread Islam to all corners\n• Memorized and preserved knowledge\n• Established Islamic state\n• Fought for justice\n• Sacrificed wealth and life\n\nVirtue in their era:\n• Many were slaves who freed themselves\n• Many were wealthy merchants who gave all\n• Many were warriors who fought for Islam\n• All were tested and remained steadfast',
        source: 'Bukhari, Muslim ; Tirmidhi',
      ),
      AssistantQA(
        id: 'cpn2',
        questionFr: 'Qui sont les grandes femmes de l\'Islam ?',

        questionEn: 'What were the contributions of early Companions?',
        keywords: ['femme', 'islam', 'grande', 'khadija', 'aicha', 'fatima', 'maryam'],
        reponseFr: 'Les grandes femmes de l\'Islam sont des modèles d\'excellence :\n\nLes 4 meilleures femmes de l\'humanité :\n1. Maryam bint \'Imran (Marie) — la plus pure des femmes, mère de \'Isa (Jésus), une sourate entière porte son nom\n2. Khadija bint Khuwaylid — première épouse du Prophète ﷺ, première musulmane, grande commerçante, elle l\'a soutenu dans les moments les plus difficiles\n3. Fatima az-Zahra — fille du Prophète ﷺ, maîtresse des femmes du Paradis\n4. Asiya bint Muzahim — épouse de Pharaon, elle a cru malgré la tyrannie de son mari\n\nAutres grandes figures :\n• Aïcha bint Abi Bakr — la plus grande savante de l\'Islam, elle a transmis plus de 2 200 hadiths\n• Hafsa bint \'Umar — gardienne du manuscrit original du Coran\n• Sumayya bint Khayyat — première martyre de l\'Islam\n• Nusayba bint Ka\'b — combattante qui a protégé le Prophète ﷺ à Uhud\n• Khawla bint Tha\'laba — celle dont la plainte a fait descendre une révélation coranique',

        reponseEn: 'Early Companions (Sahaba) contributions:\n\nSpiritual:\n• Preserved and memorized the Qur\'an\n• Transmitted Hadith with accuracy\n• Established Islamic sciences\n• Set example of devotion\n\nPolitical:\n• Established Islamic government\n• Expanded Islamic state\n• Conquered territories\n• Organized administration\n\nIntellectual:\n• Developed Islamic jurisprudence\n• Explained Qur\'anic verses\n• Derived Islamic law principles\n• Created scholarly traditions\n\nSocial:\n• Freed slaves\n• Established social welfare\n• Cared for orphans and widows\n• Built community bonds\n\nEconomic:\n• Organized Zakat system\n• Regulated commerce\n• Established markets\n• Fair trade practices\n\nMilitary:\n• Defended Islam\n• Trained armies\n• Strategic battles\n• Protecting communities',
        source: 'Bukhari, Muslim ; Tirmidhi',
      ),
      AssistantQA(
        id: 'cpn3',
        questionFr: 'Qu\'est-ce que la Hijra (émigration) ?',

        questionEn: 'How did the Companions live?',
        keywords: ['hijra', 'emigration', 'medine', 'mecque', 'migration', 'calendrier'],
        reponseFr: 'La Hijra est l\'émigration du Prophète ﷺ et des musulmans de La Mecque vers Médine en 622 après J.-C. C\'est l\'événement qui marque le début du calendrier islamique.\n\nContexte : après 13 ans de prédication à La Mecque, les musulmans subissaient persécution, torture et boycott. Allah a permis l\'émigration vers Médine (alors Yathrib), où les Ansar (habitants de Médine) les ont accueillis.\n\nLe voyage :\n• Le Prophète ﷺ est parti avec Abu Bakr\n• Ils se sont cachés dans la grotte de Thawr pendant 3 jours\n• Quand Abu Bakr avait peur, le Prophète ﷺ dit : « Ne sois pas triste, Allah est avec nous » (At-Tawba 9:40)\n• Les Quraysh avaient mis une récompense de 100 chameaux pour les capturer\n\nÀ Médine :\n• La première mosquée a été construite (Quba)\n• La fraternité entre Muhajirin (émigrés) et Ansar (habitants) a été établie\n• La première communauté musulmane organisée est née\n\nLa Hijra symbolise le sacrifice pour sa foi — quitter sa patrie, ses biens et sa famille pour Allah.',

        reponseEn: 'Lifestyle of the Companions:\n\nSimplicity:\n• Austere living\n• Minimal possessions\n• Focus on spiritual\n• No material attachment\n\nDedication:\n• Whole life to Islam\n• Sacrificed families, wealth\n• Ready for martyrdom\n• Complete submission\n\nKnowledge:\n• Sat with Prophet daily\n• Memorized teachings\n• Practiced what learned\n• Transmitted to others\n\nMorality:\n• Truthful dealings\n• Honest merchants\n• Just judges\n• Merciful leaders\n\nFaith:\n• Strong belief\n• Trust in Allah\n• Patience in trials\n• Gratitude always\n\nCommunity:\n• Helped each other\n• Defended one another\n• Shared resources\n• United purpose',
        source: 'Coran, At-Tawba 9:40 ; Bukhari, Muslim',
      ),
    ],
  ),

  // ══════════════════════════════════════════════════════════════
  // RELATIONS SOCIALES
  // ══════════════════════════════════════════════════════════════
  AssistantTopic(
    id: 'relations',
    titleFr: 'Relations Sociales',

    titleEn: 'Social Relations',
    emoji: '🤝',
    descriptionFr: 'Le voisinage, la famille et la communauté',

    descriptionEn: 'Islamic etiquette and social conduct',
    questions: [
      AssistantQA(
        id: 'rel1',
        questionFr: 'Quels sont les droits du voisin en Islam ?',

        questionEn: 'What are other recommended fasts throughout the year?',
        keywords: ['voisin', 'droit', 'voisinage', 'relation', 'respect'],
        reponseFr: 'Les droits du voisin sont immenses en Islam. Le Prophète ﷺ a dit : « Jibril n\'a cessé de me recommander le voisin au point où j\'ai cru qu\'il allait lui donner droit à l\'héritage. » (Bukhari)\n\nDroits du voisin :\n1. Ne pas lui nuire — « Par Allah, il n\'est pas croyant celui dont le voisin ne se sent pas en sécurité de ses méfaits » (Bukhari)\n2. Le supporter et être patient avec lui\n3. Partager sa nourriture — « Si tu cuisines un bouillon, mets-y plus d\'eau et offre à ton voisin »\n4. Le visiter quand il est malade\n5. Le consoler dans le malheur\n6. Le féliciter dans la joie\n7. Ne pas le regarder de haut\n8. Ne pas élever son bâtiment pour lui bloquer l\'air sans sa permission\n\nCes droits s\'appliquent à TOUS les voisins, musulmans ou non. Le voisin musulman et parent a 3 droits (voisinage + Islam + parenté), le voisin musulman en a 2, et le voisin non-musulman en a 1 (le voisinage).',

        reponseEn: 'Recommended fasts throughout the Islamic year:\n\nMonthly:\n• 3 days each month (preferably on days 13, 14, 15 — Ayyam al-Bidh)\n• Monday and Thursday\n• Any day that feels comfortable\n\nSeasonal:\n\n1. Fasting in Muharram (1st month):\n• 10th of Muharram (Ashura) — compensation for past sins\n• Also fast 9th (Tasu\'a) before it\n• Most recommended day of year for optional fasting\n\n2. Fasting in Rajab (7th month):\n• Month of Allah\n• Whole month if possible\n• If not possible, then certain days\n\n3. Fasting in Sha\'ban (8th month):\n• Preparation for Ramadan\n• Most of the month if possible\n• Prophet fasted most of Sha\'ban\n\n4. Six fasts of Shawwal (after Ramadan):\n• Equals a whole year of fasting reward\n\nSpecial days:\n• 9th of Dhul-Hijjah (Day of \'Arafah) — for those not on Hajj\n• After seeing crescent of Dhul-Hijjah till 10th\n• Jummah (Friday) — together with Thursday better\n\nBenefit:\n• Nearness to Allah\n• Spiritual discipline\n• Forgiveness of sins\n• Preparation for Ramadan\n• Habit of self-control\n\nFlexibility:\n• Not obligatory\n• Do as much as ability allows\n• Can break if travel or illness\n• Reward is proportional to sincerity',
        source: 'Bukhari, Muslim',
      ),
      AssistantQA(
        id: 'rel2',
        questionFr: 'Comment traiter les non-musulmans en Islam ?',

        questionEn: 'What happens after death in Islam?',
        keywords: ['non-musulman', 'chretien', 'juif', 'coexistence', 'relation', 'tolerance'],
        reponseFr: 'L\'Islam enseigne le respect, la justice et la coexistence pacifique avec les non-musulmans :\n\nPrincipes coraniques :\n• « Pas de contrainte en religion » (Al-Baqara 2:256)\n• « À vous votre religion, et à moi ma religion » (Al-Kafirun 109:6)\n• « Allah ne vous interdit pas d\'être bons et équitables envers ceux qui ne vous combattent pas à cause de votre religion. Allah aime les équitables. » (Al-Mumtahana 60:8)\n\nLe Prophète ﷺ et les non-musulmans :\n• Il visitait ses voisins juifs et chrétiens quand ils étaient malades\n• Il a établi la Constitution de Médine qui garantissait les droits de tous les citoyens\n• Il s\'est levé par respect au passage d\'un cortège funéraire juif\n• Il a envoyé de la nourriture à des familles non-musulmanes pauvres\n\nRègles :\n• La justice est obligatoire envers tous, sans exception\n• Le bon comportement et la da\'wa par l\'exemple\n• Interdiction d\'insulter les croyances des autres\n• Coopérer dans le bien commun',

        reponseEn: 'What happens after death in Islamic belief:\n\nAt the moment of death:\n• Angel of death comes to take the soul\n• Soul leaves the body\n• Loved ones gather and recite Surah Yasin\n• Body is washed and shrouded\n\nBarzakh (the time between death and resurrection):\n• Life of the soul in the grave/spiritual realm\n• Not sleep, but not like earthly life\n• Soul is aware and conscious\n• Can see and hear events\n• Receives visitors through their charity and du\'a\n\nIn the grave:\n• Body is placed on right side\n• Two angels come: Munkar and Nakir\n• They ask three questions:\n  1. "Who is your Lord?"\n  2. "What is your religion?"\n  3. "Who is your Prophet?"\n• The righteous answer with certainty\n• The disbeliever is confused\n\nReward in Barzakh:\n• Righteous see gardens (Jannah)\n• Punishment for wrongdoers\n• But not permanent — that comes later\n\nConnections:\n• Family can help through:\n  - Sadaqa Jariya (ongoing charity)\n  - Du\'a (supplication)\n  - Islamic knowledge they left behind\n  - Righteous children praying for them\n\nDay of Judgment:\n• All people resurrected\n• Held before Allah for accountability\n• Paradise or Hell (eternal)\n\nConsolation:\n• Death unites with loved ones eventually\n• Righteous find peace\n• Separation is temporary',
        source: 'Coran, Al-Baqara 2:256 ; Al-Mumtahana 60:8 ; Bukhari',
      ),
      AssistantQA(
        id: 'rel3',
        questionFr: 'Quels sont les liens de parenté (Silat ar-Rahim) ?',

        questionEn: 'What is the Day of Judgment (Qiyamah)?',
        keywords: ['parente', 'famille', 'silat', 'rahim', 'lien', 'rupture', 'parent'],
        reponseFr: 'Maintenir les liens de parenté (Silat ar-Rahim) est une obligation majeure en Islam :\n\nLe Prophète ﷺ a dit : « Celui qui rompt les liens de parenté n\'entrera pas au Paradis. » (Bukhari)\n\nEt : « Quiconque veut que sa subsistance soit augmentée et que sa vie soit prolongée, qu\'il maintienne les liens de parenté. » (Bukhari)\n\nComment maintenir ces liens :\n1. Rendre visite aux proches régulièrement\n2. Prendre de leurs nouvelles (appels, messages)\n3. Les aider financièrement si besoin\n4. Partager les moments de joie et de peine\n5. Les inviter et accepter leurs invitations\n6. Pardonner leurs erreurs\n7. Invoquer pour eux\n\nMême si les proches sont injustes :\nLe Prophète ﷺ a dit : « Le vrai maintien des liens n\'est pas celui qui rend la pareille, mais celui qui les maintient quand l\'autre les rompt. » (Bukhari)\n\nLa rupture des liens familiaux est un péché majeur, même si les proches sont difficiles.',

        reponseEn: 'The Day of Judgment (Yawm al-Qiyamah):\n\nDefinition:\n• The day Allah will resurrect all humans\n• Day of final reckoning and justice\n• End of the worldly life\n• Beginning of eternal afterlife\n\nSigns before it:\n\nSmall signs (some have occurred):\n• Appearance of Prophet Muhammad\n• Knowledge becoming scarce\n• Immorality increasing\n• Conflicts and wars\n• Technology and travel increasing\n• Women becoming leaders (in some hadith interpretations)\n\nGreat signs:\n• Dajjal (the Anti-christ) appears\n• Jesus descends from heaven\n• Sun rises from the west\n• Beast of the earth appears\n• Smoke covers the earth\n• Gog and Magog released\n• Earth destroyed\n• Mountains blow away like dust\n\nOn the Day:\n• All people resurrected\n• Barefoot, naked, and uncircumcised\n• Gathered in one place\n• Sun brought near\n• Everyone sweating in fear\n\nThe Reckoning:\n• Deeds weighed on the scale\n• Every action accounted for\n• Even small kindnesses remembered\n• No intercession except through Allah and Prophet\n\nOutcome:\n• Paradise (Jannah) for believers\n• Hellfire (Jahannam) for disbelievers\n• Eternal reward or punishment\n\nQur\'anic emphasis:\n• Mentioned 70+ times\n• Signs all around\n• Prepare through righteous deeds\n• None knows the hour\n• Always be ready',
        source: 'Bukhari, Muslim',
      ),
    ],
  ),

  // ══════════════════════════════════════════════════════════════
  // LE DHIKR
  // ══════════════════════════════════════════════════════════════
  AssistantTopic(
    id: 'dhikr',
    titleFr: 'Le Dhikr (Rappel d\'Allah)',
    titleEn: 'Dhikr (Remembrance of Allah)',
    emoji: '📿',
    descriptionFr: 'Les formules de rappel et leurs mérites',

    descriptionEn: 'Invocations and remembrance of Allah',
    questions: [
      AssistantQA(
        id: 'dhk1',
        questionFr: 'Quelles sont les meilleures formules de dhikr ?',

        questionEn: 'What are the best forms of dhikr?',
        keywords: ['dhikr', 'formule', 'meilleur', 'rappel', 'tasbih', 'takbir'],
        reponseFr: 'Les meilleures formules de dhikr selon le Prophète ﷺ :\n\n1. « La ilaha illallah » — la meilleure parole de dhikr. Elle est la clé du Paradis.\n\n2. « Subhanallah wa bihamdihi, Subhanallah al-\'Adhim » — « Deux paroles légères sur la langue, lourdes dans la Balance, aimées du Tout-Miséricordieux. » (Bukhari)\n\n3. « Subhanallah, Al-hamdulillah, La ilaha illallah, Allahu Akbar » — « Plus aimées d\'Allah que tout ce sur quoi le soleil se lève. » (Muslim)\n\n4. « La hawla wa la quwwata illa billah » — un trésor du Paradis (Bukhari)\n\n5. « Astaghfirullah » — l\'Istighfar ouvre les portes de la subsistance et dissipe les soucis\n\n6. « Allahumma salli \'ala Muhammad » — la Salat \'ala Nabi : « Celui qui prie sur moi une fois, Allah prie sur lui 10 fois » (Muslim)\n\n7. Les adhkar du matin et du soir — le bouclier du croyant\n\n8. « Subhanallah » 33x, « Al-hamdulillah » 33x, « Allahu Akbar » 34x — après chaque prière',

        reponseEn: 'The best invocations (Dhikr) according to the Prophet:\n\nBest of all:\n"There is no god but Allah alone, without partners. To Him belongs the dominion and to Him belongs all praise. He gives life and brings death, and He is living and does not die. In His hand is all good, and He is capable of all things."\n\nSimple forms:\n• Subhan\'Allah (Glory be to Allah) — 33 times\n• Alhamdulillah (All praise is for Allah) — 33 times\n• Allahu Akbar (Allah is Greatest) — 34 times\n\nSpecific times:\n• Morning and evening — adhkar al-Sabah wa al-Masaa\n• Before sleep — Qul Huwa Allahu Ahad (Al-Ikhlas)\n• After prayer — 33 times each of above\n• During difficulty — La hawla wa la quwwata illa billah (There is no power except with Allah)\n\nDuring activities:\n• While walking — any dhikr\n• While working — brief invocations\n• During hardship — istighfar (asking forgiveness)\n• When happy — gratitude to Allah\n\nVirtue:\n• Purifies the heart\n• Increases remembrance\n• Opens doors of knowledge\n• Protects from evil\n• Brings peace and tranquility',
        source: 'Bukhari, Muslim',
      ),
      AssistantQA(
        id: 'dhk2',
        questionFr: 'Quels sont les adhkar du matin et du soir ?',

        questionEn: 'What are the morning and evening supplications?',
        keywords: ['adhkar', 'matin', 'soir', 'protection', 'invocation', 'quotidien'],
        reponseFr: 'Les adhkar du matin (après Fajr) et du soir (après \'Asr) sont un bouclier protecteur :\n\nAdhkar essentiels (matin ET soir) :\n• Ayat al-Kursi (1 fois) — protection toute la journée/nuit\n• Sourate Al-Ikhlas, Al-Falaq, An-Nas (3 fois chacune) — protection contre tout mal\n• « Bismillahi alladhi la yadurru ma\'a ismihi shay\'un fil-ardi wa la fis-sama\'i wa huwa as-Sami\' al-\'Alim » (3 fois) — rien ne pourra vous nuire\n• « A\'udhu bi kalimatillahi at-tammati min sharri ma khalaq » (3 fois, le soir) — protection contre les nuisances\n• « Allahumma inni as\'aluka al-\'afiya » — demander la bonne santé et la protection\n\nLe matin spécifiquement :\n• « Asbahna wa asbahal-mulku lillah... »\n• « Allahumma bika asbahna wa bika amsayna... »\n\nLe soir :\n• « Amsayna wa amsal-mulku lillah... »\n\nCes adhkar prennent 5-10 minutes et offrent une protection immense. Le Prophète ﷺ ne les délaissait jamais.',

        reponseEn: 'Morning (Sabah) and Evening (Masaa) Adhkar:\n\nAfter Fajr (Morning):\n1. Subhan\'Allah — 33 times\n2. Alhamdulillah — 33 times\n3. Allahu Akbar — 34 times\n4. "There is no god but Allah alone, without partners..."\n5. "O Allah, by Your knowledge of the unseen and Your power over creation, keep me alive as long as You know that life is good for me, and take me when death is better for me..."\n\nAfter \'Asr or before Maghrib (Evening):\nSame as morning\n\nAdditional recommended (morning and evening):\n• Ayat al-Kursi\n• Last 3 chapters of Qur\'an\n• "O Allah, as the night enters and as the day departs, I ask You for the good..."\n\nBefore sleep (evening):\n• "In Your name O Allah, I live and die"\n• Ayat al-Kursi (2:255)\n• Qul Huwa Allahu Ahad (Al-Ikhlas)\n• Qul A\'udhu bi rabbi al-Falaq (Al-Falaq)\n• Qul A\'udhu bi rabbi an-Nas (An-Nas)\n\nBenefit:\n• Protection throughout day/night\n• Spiritual strengthening\n• Connection with Allah\n• Peace and tranquility\n• Guard against evil\n\nThe Prophet said: "Whoever says these in morning, they are sufficient for all day"',
        source: 'Abu Dawud, Tirmidhi ; Bukhari, Muslim',
      ),
      AssistantQA(
        id: 'dhk3',
        questionFr: 'Qu\'est-ce que l\'Istighfar et ses bienfaits ?',

        questionEn: 'What is Istighfar (seeking forgiveness)?',
        keywords: ['istighfar', 'pardon', 'astaghfirullah', 'bienfait', 'merite'],
        reponseFr: 'L\'Istighfar est la demande de pardon à Allah. C\'est l\'une des armes les plus puissantes du croyant.\n\nLa formule de base : « Astaghfirullah » (Je demande pardon à Allah)\n\nLa meilleure formule (Sayyid al-Istighfar) :\n« Allahumma anta Rabbi, la ilaha illa ant. Khalaqtani wa ana \'abduk. Wa ana \'ala \'ahdika wa wa\'dika ma istata\'t. A\'udhu bika min sharri ma sana\'t. Abu\'u laka bi ni\'matika \'alayya wa abu\'u bi dhanbi. Faghfir li fa innahu la yaghfiru adh-dhunuba illa ant. »\nLe Prophète ﷺ a dit : « Celui qui la dit le matin avec conviction et meurt dans la journée entre au Paradis. » (Bukhari)\n\nBienfaits de l\'Istighfar :\n1. Le pardon des péchés — bien sûr\n2. L\'augmentation de la subsistance — « Demandez pardon à votre Seigneur, Il vous enverra du ciel des pluies abondantes » (Nuh 71:10-12)\n3. La dissipation des soucis et de l\'angoisse\n4. La facilitation des affaires\n5. La descendance et les biens\n\nLe Prophète ﷺ faisait l\'Istighfar plus de 70 fois par jour.',

        reponseEn: 'Istighfar (asking Allah for forgiveness):\n\nDefinition:\n• Seeking pardon from Allah for sins\n• Repentance and confession\n• Return to the right path\n\nSimple Istighfar:\n• "Astaghfiru Allah" (I seek forgiveness from Allah) — can be repeated\n• Powerful and effective\n• Best said after every prayer\n\nComplete Istighfar:\n"Allahumma anta Rabbi, la ilaha illa anta, khalaqtani wa ana \'abduka, wa ana \'ala \'ahdika wa wa\'dika mastata\'tu, abu\'u laka bi ni\'amika \'alayya wa abu\'u lika bidhanbi, faghfir li fa \'innahu la yaghfiru adh-dhunuba illa anta"\n\nMerit:\n• Wipes away sins\n• Opens doors of provision\n• Brings joy to the heart\n• Prophet said: "Whoever makes istighfar a habit, Allah will provide a way out of every hardship"\n\nWhen to say:\n• After every prayer (especially)\n• Before sleep\n• When making a mistake\n• When facing hardship\n• Throughout the day\n\nCondition:\n• True repentance (not to repeat)\n• Sincere intention\n• Change of heart\n• Effort to correct behavior\n\nBenefit:\n• Spiritual healing\n• Divine forgiveness\n• New beginnings\n• Peace and tranquility',
        source: 'Bukhari ; Coran, Nuh 71:10-12',
      ),
    ],
  ),
];
