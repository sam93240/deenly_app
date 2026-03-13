// notification_data.dart
// Messages de notification — Application Deenly
// Ton : meilleur ami bienveillant, chaleureux, musulman
// 100+ messages uniques

// ── Catégories de messages ───────────────────────────────────────────

enum NotifType {
  motivation,    // Encourager à continuer
  streak,        // Féliciter / alerter sur la série
  bienEtre,      // Prendre des nouvelles
  comeback,      // Utilisateur absent depuis longtemps
  defiJour,      // Petit défi quotidien
  rappelPriere,  // Rappels spirituels doux
  sadaqaJariya,  // Appel aux dons (rare, respectueux)
  celebration,   // Félicitations pour un accomplissement
}

class DeenlyNotif {
  final NotifType type;
  final String emoji;
  final String titre;
  final String message;
  final String? actionLabel;
  final String? actionRoute;

  const DeenlyNotif({
    required this.type,
    required this.emoji,
    required this.titre,
    required this.message,
    this.actionLabel,
    this.actionRoute,
  });
}

// ══════════════════════════════════════════════════════════════════════
// MOTIVATION — Encourager à revenir et apprendre (20 messages)
// ══════════════════════════════════════════════════════════════════════
const kMotivationNotifs = <DeenlyNotif>[
  DeenlyNotif(
    type: NotifType.motivation,
    emoji: '💪',
    titre: 'Tu es sur la bonne voie !',
    message: 'Chaque petit pas compte. Le Prophète ﷺ a dit : « Les actes les plus aimés d\'Allah sont les plus réguliers, même s\'ils sont peu nombreux. » Allez, on continue ensemble ?',
    actionLabel: 'Continuer',
    actionRoute: 'learning',
  ),
  DeenlyNotif(
    type: NotifType.motivation,
    emoji: '🌟',
    titre: 'Hey, ça fait plaisir de te voir !',
    message: 'Tu sais quoi ? Le simple fait d\'ouvrir Deenly, c\'est déjà une intention de bien. Et Allah récompense les intentions. Tu veux lire un verset aujourd\'hui ?',
    actionLabel: 'Lire le Coran',
    actionRoute: 'quran',
  ),
  DeenlyNotif(
    type: NotifType.motivation,
    emoji: '📖',
    titre: 'Un verset, ça change une journée',
    message: 'Sérieusement, même un seul verset lu avec le cœur peut illuminer ta journée entière. Le Prophète ﷺ a dit que celui qui lit le Coran avec difficulté a une double récompense. Tu es doublement récompensé(e) !',
    actionLabel: 'Lire un verset',
    actionRoute: 'quran',
  ),
  DeenlyNotif(
    type: NotifType.motivation,
    emoji: '🤲',
    titre: 'Allah est fier de toi',
    message: 'Tu cherches à apprendre, à comprendre, à t\'améliorer. C\'est exactement ce qu\'Allah aime. « Et quiconque emprunte un chemin pour acquérir un savoir, Allah lui facilite un chemin vers le Paradis. »',
    actionLabel: 'Apprendre',
    actionRoute: 'learning',
  ),
  DeenlyNotif(
    type: NotifType.motivation,
    emoji: '✨',
    titre: 'Petit rappel entre amis',
    message: 'Même les Compagnons du Prophète ﷺ se rappelaient les uns les autres. Considère-moi comme ton compagnon de route. On avance ensemble, à ton rythme, sans pression.',
  ),
  DeenlyNotif(
    type: NotifType.motivation,
    emoji: '🌙',
    titre: 'La nuit porte conseil... et bénédictions',
    message: 'Si tu lis ça le soir, sache que le dernier tiers de la nuit est le moment où Allah descend au ciel le plus proche et dit : « Y a-t-il quelqu\'un qui M\'invoque pour que Je lui réponde ? » Tu as une du\'a à faire ?',
  ),
  DeenlyNotif(
    type: NotifType.motivation,
    emoji: '🕊️',
    titre: 'Tu n\'es jamais seul(e)',
    message: '« Il est avec vous où que vous soyez. » (Al-Hadid 57:4). Même dans les moments difficiles, Allah est là. Et moi aussi, je suis là dans ta poche. 😊',
  ),
  DeenlyNotif(
    type: NotifType.motivation,
    emoji: '🌺',
    titre: 'Chaque jour est un nouveau départ',
    message: 'En Islam, chaque aube est une chance de recommencer. Tu n\'as pas lu hier ? Pas grave. Tu n\'as pas prié à l\'heure ? Recommence maintenant. Allah aime ceux qui se repentent et qui se purifient.',
    actionLabel: 'Reprendre',
    actionRoute: 'learning',
  ),
  DeenlyNotif(
    type: NotifType.motivation,
    emoji: '🏃',
    titre: 'Pas besoin d\'être parfait',
    message: 'Allah ne te demande pas la perfection. Il te demande l\'effort. Le Prophète ﷺ a dit : « Rapprochez-vous de la perfection, rectifiez, et réjouissez-vous. » L\'important c\'est d\'avancer.',
    actionLabel: 'Avancer',
    actionRoute: 'learning',
  ),
  DeenlyNotif(
    type: NotifType.motivation,
    emoji: '💎',
    titre: 'Tu vaux plus que tu ne crois',
    message: 'Allah t\'a créé(e) avec un but. Tu n\'es pas là par hasard. Chaque seconde que tu passes à apprendre ta religion, c\'est un investissement éternel. Pas mal comme rendement, non ?',
  ),
  DeenlyNotif(
    type: NotifType.motivation,
    emoji: '🌤️',
    titre: 'Le savoir est une lumière',
    message: 'L\'Imam ash-Shafi\'i a dit : « Le savoir est une lumière, et la lumière d\'Allah n\'est pas donnée au pécheur. » En cherchant le savoir, tu allumes ta propre lumière.',
    actionLabel: 'S\'illuminer',
    actionRoute: 'learning',
  ),
  DeenlyNotif(
    type: NotifType.motivation,
    emoji: '🦁',
    titre: 'Tu es plus fort(e) que tu ne penses',
    message: 'Umar ibn al-Khattab est passé de persécuteur à pilier de l\'Islam. Le changement est toujours possible. Si lui a pu transformer sa vie, toi aussi tu peux apprendre et grandir.',
  ),
  DeenlyNotif(
    type: NotifType.motivation,
    emoji: '🎓',
    titre: 'L\'encre du savant...',
    message: '...est plus précieuse que le sang du martyr. Tu le savais ? En apprenant, tu accomplis un acte de dévotion immense. Continue, chaque connaissance est un trésor.',
    actionLabel: 'Apprendre',
    actionRoute: 'learning',
  ),
  DeenlyNotif(
    type: NotifType.motivation,
    emoji: '🌻',
    titre: 'Le meilleur moment c\'est maintenant',
    message: 'On reporte toujours à demain. Mais demain n\'est promis à personne. 5 minutes de Coran maintenant valent mieux que 2 heures que tu ne feras jamais. On y va ?',
    actionLabel: '5 minutes',
    actionRoute: 'quran',
  ),
  DeenlyNotif(
    type: NotifType.motivation,
    emoji: '🔑',
    titre: 'La patience est la clé',
    message: 'Le Prophète ﷺ a dit : « Celui qui patiente, Allah lui donnera la patience. Et personne n\'a reçu de don meilleur et plus vaste que la patience. » Tu es en train de construire quelque chose de beau.',
  ),
  DeenlyNotif(
    type: NotifType.motivation,
    emoji: '🌈',
    titre: 'Après la pluie...',
    message: '...le beau temps. Après la difficulté, la facilité. C\'est la promesse d\'Allah, répétée deux fois dans sourate Ash-Sharh. Si c\'est dur en ce moment, tiens bon. Le soulagement arrive.',
  ),
  DeenlyNotif(
    type: NotifType.motivation,
    emoji: '📚',
    titre: 'Les anges t\'accompagnent',
    message: 'Le Prophète ﷺ a dit : « Quand des gens se réunissent pour étudier le Livre d\'Allah, la sérénité descend sur eux, la miséricorde les enveloppe et les anges les entourent. » Tu n\'es pas seul(e) !',
    actionLabel: 'Étudier',
    actionRoute: 'quran',
  ),
  DeenlyNotif(
    type: NotifType.motivation,
    emoji: '⛰️',
    titre: 'Sommet après sommet',
    message: 'Le chemin de la connaissance, c\'est comme gravir une montagne. Parfois c\'est dur, parfois tu veux abandonner. Mais la vue d\'en haut... SubhanAllah. Continue à grimper.',
  ),
  DeenlyNotif(
    type: NotifType.motivation,
    emoji: '🕋',
    titre: 'Chaque pas compte',
    message: 'Le pèlerin qui marche vers la Ka\'ba ne la voit pas au début. Mais il sait qu\'elle est là. Chaque pas d\'apprentissage te rapproche d\'Allah, même si tu ne vois pas encore le résultat.',
  ),
  DeenlyNotif(
    type: NotifType.motivation,
    emoji: '🌴',
    titre: 'Comme un palmier',
    message: 'Le Prophète ﷺ a comparé le croyant à un palmier : utile en toute saison, résistant aux tempêtes, et dont chaque partie est bénéfique. En apprenant, tu deviens ce palmier.',
    actionLabel: 'Grandir',
    actionRoute: 'learning',
  ),
];

// ══════════════════════════════════════════════════════════════════════
// STREAK — Félicitations et alertes de série (8 messages)
// ══════════════════════════════════════════════════════════════════════
const kStreakNotifs = <DeenlyNotif>[
  // Séries positives (index 0-3)
  DeenlyNotif(
    type: NotifType.streak,
    emoji: '🔥',
    titre: 'Série en feu !',
    message: 'MashaAllah ! Tu es là depuis {streak} jours d\'affilée. Le Prophète ﷺ aimait la régularité. Tu es en train de construire une belle habitude, continue !',
  ),
  DeenlyNotif(
    type: NotifType.streak,
    emoji: '⚡',
    titre: '{streak} jours, rien ne t\'arrête !',
    message: 'SubhanAllah, quelle constance ! À ce rythme, tu vas devenir un(e) vrai(e) hafiz/hafiza. Je suis tellement fier/fière de toi. Enfin, c\'est Allah qui doit être fier, mais moi aussi !',
  ),
  DeenlyNotif(
    type: NotifType.streak,
    emoji: '🌟',
    titre: '{streak} jours de lumière !',
    message: 'Tu sais ce que ça veut dire, {streak} jours ? Ça veut dire que tu as choisi Allah {streak} fois de suite. C\'est magnifique. La régularité, c\'est la sunna.',
  ),
  DeenlyNotif(
    type: NotifType.streak,
    emoji: '💫',
    titre: 'Quelle discipline MashaAllah !',
    message: '{streak} jours consécutifs ! Le Prophète ﷺ a dit : « L\'acte le plus aimé d\'Allah est le plus constant, même s\'il est modeste. » Tu incarnes ce hadith.',
  ),
  // Alerte de perte (index 4)
  DeenlyNotif(
    type: NotifType.streak,
    emoji: '😰',
    titre: 'Ta série est en danger !',
    message: 'Hé, ne perds pas ta série de {streak} jours ! Il te suffit de lire un seul verset ou de faire un seul dhikr. 30 secondes et c\'est sauvé. Tu le fais ?',
    actionLabel: 'Sauver ma série',
    actionRoute: 'quran',
  ),
  DeenlyNotif(
    type: NotifType.streak,
    emoji: '⏰',
    titre: 'Vite, ta série !',
    message: 'Ta série de {streak} jours va s\'éteindre ! Ouvre juste le Coran, lis Bismillah, et c\'est sauvé. On ne lâche pas maintenant !',
    actionLabel: 'Sauver',
    actionRoute: 'quran',
  ),
  // Série perdue (index 6-7)
  DeenlyNotif(
    type: NotifType.streak,
    emoji: '💚',
    titre: 'C\'est pas grave, on recommence',
    message: 'Ta série est retombée à zéro, mais tu sais quoi ? Le Prophète ﷺ a dit : « Celui qui se repent du péché est comme celui qui n\'a pas de péché. » On recommence aujourd\'hui, ensemble ?',
    actionLabel: 'Nouvelle série',
    actionRoute: 'learning',
  ),
  DeenlyNotif(
    type: NotifType.streak,
    emoji: '🌅',
    titre: 'Un nouveau matin, une nouvelle chance',
    message: 'Ta série est repartie de zéro. Et alors ? Ibrahim a été jeté dans le feu et il s\'est relevé. Yunus est sorti du ventre de la baleine. Toi, tu peux bien relancer une série !',
    actionLabel: 'On repart',
    actionRoute: 'learning',
  ),
];

// ══════════════════════════════════════════════════════════════════════
// BIEN-ÊTRE — Prendre des nouvelles sincèrement (18 messages)
// ══════════════════════════════════════════════════════════════════════
const kBienEtreNotifs = <DeenlyNotif>[
  DeenlyNotif(
    type: NotifType.bienEtre,
    emoji: '💛',
    titre: 'Comment tu vas aujourd\'hui ?',
    message: 'Sincèrement, pas de façade. Si tu vas bien, alhamdulillah. Si ça ne va pas trop, sache que « Certes, avec la difficulté vient la facilité » (94:6). Et n\'oublie pas de parler à quelqu\'un de confiance si tu en as besoin.',
  ),
  DeenlyNotif(
    type: NotifType.bienEtre,
    emoji: '🤗',
    titre: 'Juste un petit coucou',
    message: 'As-salamu alaykum ! Je passais juste te dire que tu comptes. Pour Allah, tu es unique parmi des milliards de créatures. Prends soin de toi aujourd\'hui, c\'est aussi une ibadah.',
  ),
  DeenlyNotif(
    type: NotifType.bienEtre,
    emoji: '☀️',
    titre: 'N\'oublie pas de sourire',
    message: 'Le Prophète ﷺ a dit : « Sourire à ton frère est une aumône. » Alors souris — à toi-même dans le miroir, à un inconnu dans la rue, à tes proches. Ça change tout.',
  ),
  DeenlyNotif(
    type: NotifType.bienEtre,
    emoji: '🍃',
    titre: 'Respire un peu',
    message: 'Si ta journée est chargée, prends 2 minutes. Ferme les yeux. Dis « SubhanAllah » 33 fois. Sens la paix. Le dhikr est le repos du cœur. « C\'est par le rappel d\'Allah que les cœurs se tranquillisent. » (13:28)',
    actionLabel: 'Faire du dhikr',
    actionRoute: 'spiritualite',
  ),
  DeenlyNotif(
    type: NotifType.bienEtre,
    emoji: '🌊',
    titre: 'Les épreuves passent toujours',
    message: 'Si tu traverses un moment dur, rappelle-toi : après la pluie vient le soleil. Le Prophète ﷺ a dit : « L\'affaire du croyant est étonnante, car tout est un bien pour lui. » Tiens bon, je suis avec toi.',
  ),
  DeenlyNotif(
    type: NotifType.bienEtre,
    emoji: '🌸',
    titre: 'Tu as mangé aujourd\'hui ?',
    message: 'Oui, je te demande ça parce que prendre soin de son corps, c\'est aussi une amana (un dépôt d\'Allah). Mange bien, bois de l\'eau, dors suffisamment. Ton corps a des droits sur toi !',
  ),
  DeenlyNotif(
    type: NotifType.bienEtre,
    emoji: '🫂',
    titre: 'Appelle tes parents',
    message: 'Si tes parents sont encore là, appelle-les. Même 2 minutes. Le Coran dit : « Et dis-leur des paroles respectueuses. » (17:23) Un simple « comment tu vas ? » peut illuminer leur journée.',
  ),
  DeenlyNotif(
    type: NotifType.bienEtre,
    emoji: '💧',
    titre: 'Tu as bu assez d\'eau ?',
    message: 'Le Prophète ﷺ buvait en 3 gorgées et disait Bismillah. L\'hydratation c\'est la base ! Ton cerveau et ton corps en ont besoin pour fonctionner. Va chercher un verre d\'eau, je t\'attends.',
  ),
  DeenlyNotif(
    type: NotifType.bienEtre,
    emoji: '😴',
    titre: 'Tu dors assez ?',
    message: 'Le sommeil, c\'est sacré en Islam. Le Prophète ﷺ dormait tôt et se levait pour le tahajjud. Si tu es fatigué(e), repose-toi. Allah ne te demande pas de t\'épuiser.',
  ),
  DeenlyNotif(
    type: NotifType.bienEtre,
    emoji: '🌿',
    titre: 'Prends l\'air',
    message: 'Sors marcher, même 10 minutes. Regarde le ciel, les arbres, la création d\'Allah. « C\'est Lui qui a étendu la terre... » (13:3). La nature est un rappel vivant.',
  ),
  DeenlyNotif(
    type: NotifType.bienEtre,
    emoji: '❤️',
    titre: 'Tu es aimé(e)',
    message: 'Même si parfois tu te sens seul(e), sache que ton Créateur t\'aime. Il t\'a donné la vie, les yeux pour voir, les oreilles pour entendre, un cœur pour aimer. Alhamdulillah pour tout ça.',
  ),
  DeenlyNotif(
    type: NotifType.bienEtre,
    emoji: '🎵',
    titre: 'Écoute du Coran',
    message: 'Si tu te sens stressé(e) ou anxieux/anxieuse, écoute une récitation du Coran. Pas besoin de comprendre chaque mot — le son seul apaise le cœur. C\'est prouvé même scientifiquement.',
    actionLabel: 'Lire le Coran',
    actionRoute: 'quran',
  ),
  DeenlyNotif(
    type: NotifType.bienEtre,
    emoji: '🤲',
    titre: 'Parle à Allah',
    message: 'Si quelque chose te pèse, fais une du\'a. Pas besoin de formules. Dis juste ce que tu as sur le cœur, en français, en arabe, peu importe. Allah est Al-Sami\' — Celui qui entend tout.',
  ),
  DeenlyNotif(
    type: NotifType.bienEtre,
    emoji: '🧘',
    titre: 'Le stress n\'est pas ta nature',
    message: 'Allah t\'a créé(e) dans la fitrah — la nature pure et paisible. Le stress est un symptôme, pas ton identité. Reviens à ta fitrah avec le dhikr et la prière.',
    actionLabel: 'Dhikr apaisant',
    actionRoute: 'spiritualite',
  ),
  DeenlyNotif(
    type: NotifType.bienEtre,
    emoji: '🍵',
    titre: 'Pause thé et rappel',
    message: 'Fais-toi un thé (ou un café, on ne juge pas 😄). Et pendant qu\'il refroidit, lis un petit hadith. Ce genre de petits moments de paix, c\'est précieux.',
    actionLabel: 'Lire un hadith',
    actionRoute: 'hadith',
  ),
  DeenlyNotif(
    type: NotifType.bienEtre,
    emoji: '🌻',
    titre: 'Cite 3 bienfaits d\'Allah',
    message: 'Petit exercice : cite 3 choses pour lesquelles tu es reconnaissant(e) en ce moment. La vue, la santé, un toit, un repas... « Si vous comptez les bienfaits d\'Allah, vous ne saurez pas les dénombrer. » (14:34)',
  ),
  DeenlyNotif(
    type: NotifType.bienEtre,
    emoji: '🤝',
    titre: 'Tu as pris des nouvelles de quelqu\'un ?',
    message: 'Le Prophète ﷺ visitait les malades, saluait tout le monde, demandait des nouvelles. Envoie un message à un ami, un frère, une sœur. Un simple salam peut tout changer.',
  ),
  DeenlyNotif(
    type: NotifType.bienEtre,
    emoji: '🌙',
    titre: 'La nuit est un cadeau',
    message: 'Si tout le monde dort et que tu es éveillé(e), c\'est peut-être un signe. Le Prophète ﷺ priait la nuit quand la ville dormait. Même 2 rak\'at à cette heure valent des montagnes.',
  ),
];

// ══════════════════════════════════════════════════════════════════════
// COMEBACK — Utilisateur absent depuis plusieurs jours (8 messages)
// ══════════════════════════════════════════════════════════════════════
const kComebackNotifs = <DeenlyNotif>[
  DeenlyNotif(
    type: NotifType.comeback,
    emoji: '👋',
    titre: 'Tu m\'as manqué !',
    message: 'Ça fait {jours} jours qu\'on ne s\'est pas vus. Je ne te juge pas du tout — la vie, c\'est comme ça. Mais je suis content(e) que tu sois de retour. On reprend doucement ?',
    actionLabel: 'Reprendre',
    actionRoute: 'learning',
  ),
  DeenlyNotif(
    type: NotifType.comeback,
    emoji: '🏠',
    titre: 'De retour à la maison !',
    message: 'Deenly, c\'est un peu ta maison spirituelle. Tu peux partir, voyager, t\'absenter... mais tu seras toujours le/la bienvenu(e) ici. Alhamdulillah pour ton retour !',
  ),
  DeenlyNotif(
    type: NotifType.comeback,
    emoji: '🌱',
    titre: 'La graine est toujours là',
    message: 'Même si tu n\'as pas ouvert l\'app depuis un moment, la graine de foi que tu as plantée est toujours là. Elle attend juste un peu d\'eau. Un verset, un dhikr, et elle repousse.',
    actionLabel: 'Arroser la graine',
    actionRoute: 'quran',
  ),
  DeenlyNotif(
    type: NotifType.comeback,
    emoji: '🤝',
    titre: 'Zéro jugement, que de l\'amour',
    message: 'Le Prophète ﷺ n\'a jamais abandonné personne. Et moi non plus. Que tu reviennes après 2 jours ou 2 mois, l\'accueil est le même. Bismillah, on repart !',
    actionLabel: 'Bismillah',
    actionRoute: 'learning',
  ),
  DeenlyNotif(
    type: NotifType.comeback,
    emoji: '🕊️',
    titre: 'Content de te revoir',
    message: 'Younus (Jonas) est resté dans le ventre de la baleine, puis Allah l\'a ramené. Parfois on s\'éloigne, puis on revient. C\'est le retour qui compte. Et te voilà.',
    actionLabel: 'Revenir',
    actionRoute: 'learning',
  ),
  DeenlyNotif(
    type: NotifType.comeback,
    emoji: '🌅',
    titre: '{jours} jours, mais tu es là',
    message: 'Ça fait {jours} jours. Mais tu sais quoi ? Le fils prodigue est toujours accueilli. Allah dit : « Revenez vers votre Seigneur » (39:54). Le retour est toujours beau.',
  ),
  DeenlyNotif(
    type: NotifType.comeback,
    emoji: '💪',
    titre: 'L\'important c\'est de revenir',
    message: 'Abu Bakr ne jugeait jamais ceux qui trébuchaient. Il les relevait. Deenly aussi. Tu es tombé(e) ? Relève-toi. Tu as oublié ? Rappelle-toi. Tu es parti(e) ? Reviens. On t\'attend.',
    actionLabel: 'Se relever',
    actionRoute: 'learning',
  ),
  DeenlyNotif(
    type: NotifType.comeback,
    emoji: '🌟',
    titre: 'La porte est toujours ouverte',
    message: 'Allah dit : « Ma miséricorde embrasse toute chose » (7:156). Il n\'y a pas de deadline pour revenir vers le bien. Tu es là maintenant, et c\'est tout ce qui compte.',
    actionLabel: 'Entrer',
    actionRoute: 'quran',
  ),
];

// ══════════════════════════════════════════════════════════════════════
// RAPPELS SPIRITUELS — Doux rappels (15 messages)
// ══════════════════════════════════════════════════════════════════════
const kRappelNotifs = <DeenlyNotif>[
  DeenlyNotif(
    type: NotifType.rappelPriere,
    emoji: '🕌',
    titre: 'As-tu prié aujourd\'hui ?',
    message: 'Pas de pression, juste un rappel entre amis. La salat est le premier acte sur lequel on sera interrogé. Si tu l\'as faite, alhamdulillah ! Sinon, il est encore temps.',
  ),
  DeenlyNotif(
    type: NotifType.rappelPriere,
    emoji: '📿',
    titre: 'Adhkar du matin',
    message: 'Le Prophète ﷺ ne commençait jamais sa journée sans les adhkar du matin. C\'est comme une armure invisible. Tu veux les lire ensemble ?',
    actionLabel: 'Lire les adhkar',
    actionRoute: 'spiritualite',
  ),
  DeenlyNotif(
    type: NotifType.rappelPriere,
    emoji: '🌙',
    titre: 'Adhkar du soir',
    message: 'Avant de dormir, protège-toi avec les adhkar du soir. Ayat al-Kursi, les 3 dernières sourates... C\'est le bouclier de la nuit.',
    actionLabel: 'Adhkar du soir',
    actionRoute: 'spiritualite',
  ),
  DeenlyNotif(
    type: NotifType.rappelPriere,
    emoji: '✨',
    titre: 'Petit dhikr, grande récompense',
    message: '« SubhanAllahi wa bihamdihi, SubhanAllahi al-Azim. » Deux mots légers sur la langue, lourds sur la balance, aimés du Tout Miséricordieux. Dis-les maintenant. 💛',
  ),
  DeenlyNotif(
    type: NotifType.rappelPriere,
    emoji: '🤲',
    titre: 'N\'oublie pas tes du\'as',
    message: 'La du\'a, c\'est parler directement à Allah. Pas besoin de mots parfaits, pas besoin d\'arabe. Parle-Lui avec ton cœur, dans ta langue. Il comprend tout.',
  ),
  DeenlyNotif(
    type: NotifType.rappelPriere,
    emoji: '🕋',
    titre: 'La qibla du cœur',
    message: 'Quand tu pries, imagine que tu es devant la Ka\'ba. Que rien ne te sépare d\'Allah. La salat n\'est pas une corvée — c\'est un rendez-vous intime avec ton Créateur.',
  ),
  DeenlyNotif(
    type: NotifType.rappelPriere,
    emoji: '🌅',
    titre: 'Salat al-Fajr',
    message: 'Le Prophète ﷺ a dit : « Celui qui prie le Fajr est sous la protection d\'Allah. » Si tu l\'as priée ce matin, bravo. Si tu l\'as ratée, fais-la maintenant en rattrapage.',
  ),
  DeenlyNotif(
    type: NotifType.rappelPriere,
    emoji: '💫',
    titre: 'Istighfar : la clé de tout',
    message: 'L\'istighfar (demander pardon) ouvre les portes de la subsistance, de la paix et de la réussite. « Astaghfirullah » — 3 secondes, des récompenses infinies.',
  ),
  DeenlyNotif(
    type: NotifType.rappelPriere,
    emoji: '📖',
    titre: 'Sourate Al-Mulk avant de dormir',
    message: 'Le Prophète ﷺ ne dormait jamais sans lire Al-Mulk. Elle protège de la punition de la tombe. 67 versets entre toi et la tranquillité. Tu la lis ce soir ?',
    actionLabel: 'Lire Al-Mulk',
    actionRoute: 'quran',
  ),
  DeenlyNotif(
    type: NotifType.rappelPriere,
    emoji: '🌟',
    titre: 'Salawat sur le Prophète ﷺ',
    message: 'Dis « Allahumma salli \'ala Muhammad » 10 fois maintenant. Le Prophète ﷺ a dit : « Celui qui prie sur moi une fois, Allah prie sur lui 10 fois. » Facile et immense.',
  ),
  DeenlyNotif(
    type: NotifType.rappelPriere,
    emoji: '🌙',
    titre: 'Les 2 rak\'at de Duha',
    message: 'Entre le lever du soleil et le dhuhr, il y a la prière de Duha. Même 2 rak\'at suffisent. Le Prophète ﷺ la recommandait vivement. C\'est un cadeau du milieu de matinée.',
  ),
  DeenlyNotif(
    type: NotifType.rappelPriere,
    emoji: '📿',
    titre: '33-33-34',
    message: 'Après chaque prière : 33 SubhanAllah, 33 Alhamdulillah, 34 Allahu Akbar. Ça prend 2 minutes. Le Prophète ﷺ a dit que celui qui fait ça verra ses péchés pardonnés, même s\'ils étaient comme l\'écume de la mer.',
    actionLabel: 'Compter',
    actionRoute: 'spiritualite',
  ),
  DeenlyNotif(
    type: NotifType.rappelPriere,
    emoji: '🕊️',
    titre: 'Le vendredi, c\'est spécial',
    message: 'Si c\'est vendredi : lis sourate Al-Kahf, fais beaucoup de salawat sur le Prophète ﷺ, et multiplie les du\'as. Il y a une heure ce jour-là où toute du\'a est exaucée.',
    actionLabel: 'Al-Kahf',
    actionRoute: 'quran',
  ),
  DeenlyNotif(
    type: NotifType.rappelPriere,
    emoji: '🛡️',
    titre: 'Ta protection quotidienne',
    message: 'Ayat al-Kursi le matin, Ayat al-Kursi le soir, Ayat al-Kursi après chaque prière. C\'est le verset le plus puissant du Coran. Tu le connais par cœur ?',
    actionLabel: 'Roqya',
    actionRoute: 'spiritualite',
  ),
  DeenlyNotif(
    type: NotifType.rappelPriere,
    emoji: '🤲',
    titre: 'Du\'a pour tes proches',
    message: 'Fais une du\'a pour quelqu\'un sans qu\'il le sache. Le Prophète ﷺ a dit : « La du\'a du musulman pour son frère en son absence est exaucée. Un ange dit : et pour toi de même. »',
  ),
];

// ══════════════════════════════════════════════════════════════════════
// DÉFIS DU JOUR — Petits challenges quotidiens (15 messages)
// ══════════════════════════════════════════════════════════════════════
const kDefiNotifs = <DeenlyNotif>[
  DeenlyNotif(
    type: NotifType.defiJour,
    emoji: '🎯',
    titre: 'Défi du jour',
    message: 'Aujourd\'hui, essaie de lire 5 versets du Coran avec leur traduction. Pas de vitesse, juste de la compréhension. Tu acceptes le défi ?',
    actionLabel: 'Accepter',
    actionRoute: 'quran',
  ),
  DeenlyNotif(
    type: NotifType.defiJour,
    emoji: '🎯',
    titre: 'Défi du jour',
    message: 'Apprends un nouveau nom d\'Allah aujourd\'hui. Comprends son sens, médite dessus. Il y en a 99, chacun est un trésor.',
    actionLabel: 'Découvrir',
    actionRoute: 'spiritualite',
  ),
  DeenlyNotif(
    type: NotifType.defiJour,
    emoji: '🎯',
    titre: 'Défi du jour',
    message: 'Lis un hadith et essaie de l\'appliquer aujourd\'hui. Juste un seul. La sunna se vit au quotidien, pas seulement dans les livres.',
    actionLabel: 'Lire un hadith',
    actionRoute: 'hadith',
  ),
  DeenlyNotif(
    type: NotifType.defiJour,
    emoji: '🎯',
    titre: 'Défi du jour',
    message: 'Dis « Astaghfirullah » 100 fois aujourd\'hui. Ça prend 3 minutes. Le Prophète ﷺ le faisait plus de 70 fois par jour alors qu\'il était déjà pardonné.',
  ),
  DeenlyNotif(
    type: NotifType.defiJour,
    emoji: '🎯',
    titre: 'Défi famille',
    message: 'Raconte une histoire de prophète à un enfant de ta famille aujourd\'hui. Tu seras récompensé(e) pour chaque mot de bien que tu transmets.',
    actionLabel: 'Histoires',
    actionRoute: 'famille',
  ),
  DeenlyNotif(
    type: NotifType.defiJour,
    emoji: '🎯',
    titre: 'Défi gentillesse',
    message: 'Fais une bonne action pour quelqu\'un sans qu\'il le sache. Paye un café, laisse passer quelqu\'un, offre un compliment sincère. La sadaqa secrète éteint la colère du Seigneur.',
  ),
  DeenlyNotif(
    type: NotifType.defiJour,
    emoji: '🎯',
    titre: 'Défi mémorisation',
    message: 'Apprends un nouveau verset par cœur aujourd\'hui. Juste un. Répète-le 10 fois. Demain, tu t\'en souviendras. Dans un an, tu auras appris 365 versets.',
    actionLabel: 'Mémoriser',
    actionRoute: 'quran',
  ),
  DeenlyNotif(
    type: NotifType.defiJour,
    emoji: '🎯',
    titre: 'Défi silence',
    message: 'Le Prophète ﷺ a dit : « Que celui qui croit en Allah et au Jour Dernier dise du bien ou se taise. » Aujourd\'hui, essaie de ne dire que du bien. Pas de médisance, pas de plainte.',
  ),
  DeenlyNotif(
    type: NotifType.defiJour,
    emoji: '🎯',
    titre: 'Défi gratitude',
    message: 'Ce soir, avant de dormir, écris 5 choses pour lesquelles tu es reconnaissant(e) envers Allah. La gratitude multiplie les bienfaits. « Si vous êtes reconnaissants, Je vous donnerai davantage. » (14:7)',
    actionLabel: 'Journal',
    actionRoute: 'learning',
  ),
  DeenlyNotif(
    type: NotifType.defiJour,
    emoji: '🎯',
    titre: 'Défi pardon',
    message: 'Y a-t-il quelqu\'un à qui tu dois pardonner ? Le Prophète ﷺ a pardonné aux gens de Quraysh après des années de persécution. Si lui a pu, on peut essayer nous aussi.',
  ),
  DeenlyNotif(
    type: NotifType.defiJour,
    emoji: '🎯',
    titre: 'Défi sadaqa',
    message: 'Donne quelque chose aujourd\'hui. Même 1€. Même un sourire. Même un bon conseil. « La main qui donne est meilleure que celle qui reçoit. »',
  ),
  DeenlyNotif(
    type: NotifType.defiJour,
    emoji: '🎯',
    titre: 'Défi Coran',
    message: 'Lis une page entière du Coran aujourd\'hui. Chaque lettre = 10 hassanat. Une page = des milliers de récompenses. Le calcul est vite fait !',
    actionLabel: 'Lire une page',
    actionRoute: 'quran',
  ),
  DeenlyNotif(
    type: NotifType.defiJour,
    emoji: '🎯',
    titre: 'Défi salam',
    message: 'Dis salam à 5 personnes aujourd\'hui. Le Prophète ﷺ a dit : « Répandez le salam entre vous. » C\'est la manière la plus simple de gagner des hassanat et de créer du lien.',
  ),
  DeenlyNotif(
    type: NotifType.defiJour,
    emoji: '🎯',
    titre: 'Défi tahajjud',
    message: 'Ce soir, essaie de te lever 15 minutes avant le fajr pour prier 2 rak\'at. Le tahajjud est la prière des élites. Tu es capable.',
  ),
  DeenlyNotif(
    type: NotifType.defiJour,
    emoji: '🎯',
    titre: 'Défi du\'a',
    message: 'Fais une longue du\'a aujourd\'hui. Pas juste « Allah aide-moi ». Vraiment parler à Allah de tout : tes rêves, tes peurs, tes espoirs. Il écoute chaque mot.',
  ),
];

// ══════════════════════════════════════════════════════════════════════
// CÉLÉBRATIONS — Félicitations pour accomplissements (8 messages)
// ══════════════════════════════════════════════════════════════════════
const kCelebrationNotifs = <DeenlyNotif>[
  DeenlyNotif(
    type: NotifType.celebration,
    emoji: '🎉',
    titre: 'Félicitations !',
    message: 'Tu viens d\'atteindre {xp} XP ! MashaAllah, tu es un(e) vrai(e) chercheur/chercheuse de lumière. Continue sur cette lancée.',
  ),
  DeenlyNotif(
    type: NotifType.celebration,
    emoji: '🏆',
    titre: 'Nouveau badge débloqué !',
    message: 'Tu as obtenu le badge « {badge} » ! Chaque badge représente un pas de plus sur le chemin de la connaissance. Fier/fière de toi !',
  ),
  DeenlyNotif(
    type: NotifType.celebration,
    emoji: '📖',
    titre: 'MashaAllah, {versets} versets lus !',
    message: 'Le Prophète ﷺ a dit : « Lisez le Coran, car il viendra le Jour de la Résurrection comme intercesseur pour ceux qui le lisaient. » Tu es sur le bon chemin.',
  ),
  DeenlyNotif(
    type: NotifType.celebration,
    emoji: '⭐',
    titre: 'Tu brilles !',
    message: '{xp} XP accumulés ! Le savoir que tu acquiers aujourd\'hui sera ta lumière demain. Le Prophète ﷺ a dit que les savants sont les héritiers des prophètes.',
  ),
  DeenlyNotif(
    type: NotifType.celebration,
    emoji: '🌟',
    titre: 'MashaAllah, quel parcours !',
    message: 'Regarde tout le chemin que tu as parcouru. Tu as commencé et tu n\'as pas lâché. C\'est exactement l\'istiqama (la constance) que l\'Islam encourage.',
  ),
  DeenlyNotif(
    type: NotifType.celebration,
    emoji: '💫',
    titre: 'Les anges sont témoins',
    message: 'Chaque lettre du Coran que tu as lue, chaque hadith appris, chaque dhikr récité — tout est enregistré. Les anges sont témoins de ton effort. Continue !',
  ),
  DeenlyNotif(
    type: NotifType.celebration,
    emoji: '🎊',
    titre: 'Record battu !',
    message: 'Tu n\'as jamais été aussi loin ! {xp} XP, c\'est énorme. Si le Prophète ﷺ était là, il te tapoter sur l\'épaule et te dirait : « Ahsant ! » (Bien joué !)',
  ),
  DeenlyNotif(
    type: NotifType.celebration,
    emoji: '🏅',
    titre: '{versets} versets, ça se fête !',
    message: 'Ibn Mas\'ud a dit : « Le Coran est le festin d\'Allah sur terre. » Et toi, tu as goûté à {versets} de ses plats. Continue de te régaler spirituellement !',
  ),
];

// ══════════════════════════════════════════════════════════════════════
// SADAQA JARIYA — Appels aux dons (respectueux, 8 messages)
// ══════════════════════════════════════════════════════════════════════
const kSadaqaNotifs = <DeenlyNotif>[
  DeenlyNotif(
    type: NotifType.sadaqaJariya,
    emoji: '💝',
    titre: 'Sadaqa Jariya',
    message: 'Deenly est gratuite et le restera toujours, insha\'Allah. Mais si tu veux soutenir le projet, chaque don est une sadaqa jariya : tant que quelqu\'un apprend grâce à Deenly, tu en récoltes les récompenses. Même après ta mort.',
    actionLabel: 'Soutenir Deenly',
  ),
  DeenlyNotif(
    type: NotifType.sadaqaJariya,
    emoji: '🌍',
    titre: 'Aide-nous à grandir',
    message: 'Chaque verset lu sur Deenly, chaque histoire apprise par un enfant, chaque dhikr récité... tout ça grâce à des gens comme toi. Un don, même de 1€, aide à maintenir cette lumière allumée.',
    actionLabel: 'Contribuer',
  ),
  DeenlyNotif(
    type: NotifType.sadaqaJariya,
    emoji: '📢',
    titre: 'Partage Deenly autour de toi',
    message: 'Le Prophète ﷺ a dit : « Celui qui guide vers un bien a la même récompense que celui qui le fait. » Partage Deenly avec un ami, un cousin, un voisin. C\'est une sadaqa gratuite !',
    actionLabel: 'Partager',
  ),
  DeenlyNotif(
    type: NotifType.sadaqaJariya,
    emoji: '🤲',
    titre: 'Une du\'a pour Deenly',
    message: 'Si tu ne peux pas donner d\'argent, fais une du\'a pour que Deenly aide le plus de musulmans possible. La du\'a est la plus belle des aumônes.',
  ),
  DeenlyNotif(
    type: NotifType.sadaqaJariya,
    emoji: '👨‍👩‍👧‍👦',
    titre: 'Offre Deenly à une famille',
    message: 'Tu connais une famille qui cherche à éduquer ses enfants dans l\'Islam ? Parle-leur de Deenly. Les histoires des prophètes, le Coran, les hadiths... tout est là, gratuit.',
    actionLabel: 'Partager',
  ),
  DeenlyNotif(
    type: NotifType.sadaqaJariya,
    emoji: '💎',
    titre: 'L\'investissement éternel',
    message: 'Le Prophète ﷺ a dit que 3 choses profitent au croyant après sa mort : un enfant pieux, un savoir utile, et une sadaqa jariya. En soutenant Deenly, tu cumules les 3.',
    actionLabel: 'Investir',
  ),
  DeenlyNotif(
    type: NotifType.sadaqaJariya,
    emoji: '⭐',
    titre: 'Laisse un avis',
    message: 'Tu aimes Deenly ? Laisse un avis 5 étoiles sur l\'App Store ou Google Play. Chaque avis aide d\'autres musulmans à découvrir l\'app. C\'est gratuit et c\'est une sadaqa !',
  ),
  DeenlyNotif(
    type: NotifType.sadaqaJariya,
    emoji: '🌙',
    titre: 'Ramadan approche',
    message: 'Les récompenses sont multipliées pendant le Ramadan. Si tu veux soutenir Deenly, c\'est le meilleur moment. Chaque centime donné pendant le Ramadan a une valeur décuplée.',
    actionLabel: 'Soutenir',
  ),
];

// ══════════════════════════════════════════════════════════════════════
// SALUTATIONS selon le moment de la journée
// ══════════════════════════════════════════════════════════════════════
const kMorningGreetings = <String>[
  'Sabah al-khayr ! ☀️ Prêt(e) pour une belle journée ?',
  'Bonjour ! Qu\'Allah bénisse ta journée.',
  'Le fajr est passé, la journée commence. Bismillah !',
  'Sabah an-nour ! Que cette journée soit remplie de bien.',
  'Bonjour ! Le Prophète ﷺ aimait commencer tôt. Tu as de l\'avance !',
];

const kAfternoonGreetings = <String>[
  'As-salamu alaykum ! Comment se passe ta journée ?',
  'Coucou ! Une pause spirituelle, ça te dit ?',
  'Mi-journée ! Un petit verset pour recharger ?',
  'Hey ! Tu as déjà fait du bien aujourd\'hui, continue !',
  'As-salamu alaykum ! Petit rappel : Allah t\'aime.',
];

const kEveningGreetings = <String>[
  'Masa\' al-khayr ! Bientôt les adhkar du soir.',
  'Bonsoir ! Tu as pensé à remercier Allah pour cette journée ?',
  'La journée touche à sa fin. Qu\'as-tu appris aujourd\'hui ?',
  'Masa\' an-nour ! Une journée de plus, une bénédiction de plus.',
  'Le soleil se couche, mais ta lumière intérieure ne s\'éteint jamais.',
];

const kNightGreetings = <String>[
  'Bonne nuit ! N\'oublie pas Ayat al-Kursi avant de dormir.',
  'Que ta nuit soit paisible. « C\'est Lui qui a fait la nuit pour que vous vous y reposiez. »',
  'Dors en paix. Les anges veillent sur les croyants.',
  'Tisbah \'ala khayr ! Qu\'Allah te protège cette nuit.',
  'Le dernier tiers de la nuit est le plus précieux. Mais d\'abord, repose-toi.',
];
