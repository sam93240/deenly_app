// decouvrir_data.dart
// Données pour le module Découvrir – Application UpYourDeen

// ── Questions du Jour ─────────────────────────────────────────────

class QuestionDuJour {
  final String id;
  final String question;
  final String emoji;
  final String reponse;
  final String source;

  const QuestionDuJour({
    required this.id,
    required this.question,
    required this.emoji,
    required this.reponse,
    required this.source,
  });
}

const kQuestionsDuJour = <QuestionDuJour>[
  QuestionDuJour(
    id: 'q1', emoji: '🍽️',
    question: 'Pourquoi dit-on Bismillah avant de manger ?',
    reponse: 'Dire Bismillah (Au nom d\'Allah) avant de manger est une sunna du Prophète ﷺ. Cela permet de bénir la nourriture, de remercier Allah pour ce bienfait, et d\'empêcher Shaytan de partager notre repas. Le Prophète ﷺ a dit : « Quand l\'un de vous mange, qu\'il mentionne le nom d\'Allah. S\'il oublie de le mentionner au début, qu\'il dise : Bismillah fi awwalihi wa akhirihi. »',
    source: 'Abu Dawud, Tirmidhi',
  ),
  QuestionDuJour(
    id: 'q2', emoji: '🌙',
    question: 'Quelle est la sagesse du jeûne en Islam ?',
    reponse: 'Le jeûne (Siyam) développe la taqwa (conscience d\'Allah), la maîtrise de soi, la patience et l\'empathie envers les plus démunis. Il purifie le corps et l\'âme. Allah dit dans le Coran : « Ô vous qui croyez ! Le jeûne vous est prescrit comme il a été prescrit à ceux qui vous ont précédés, afin que vous atteigniez la piété. » Le jeûne est aussi un bouclier contre le Feu.',
    source: 'Coran, Al-Baqara 2:183 ; Bukhari',
  ),
  QuestionDuJour(
    id: 'q3', emoji: '🕋',
    question: 'Pourquoi les musulmans prient-ils vers La Mecque ?',
    reponse: 'La Ka\'ba à La Mecque est la première maison construite pour l\'adoration d\'Allah, bâtie par Ibrahim (Abraham) et son fils Ismaïl. Prier vers cette direction (Qibla) unifie les musulmans du monde entier dans une même direction, symbolisant l\'unité de la Oumma. Initialement, les musulmans priaient vers Jérusalem, puis Allah a ordonné le changement de Qibla vers La Mecque.',
    source: 'Coran, Al-Baqara 2:144 ; Al-Imran 3:96',
  ),
  QuestionDuJour(
    id: 'q4', emoji: '📖',
    question: 'Comment le Coran a-t-il été préservé ?',
    reponse: 'Le Coran a été préservé par trois moyens simultanés : la mémorisation par cœur (des milliers de compagnons l\'avaient mémorisé), l\'écriture sur des supports divers du vivant du Prophète ﷺ, et la compilation officielle sous Abu Bakr puis Othman. Allah a promis sa préservation : « C\'est Nous qui avons fait descendre le Rappel et c\'est Nous qui en sommes les gardiens. » Chaque lettre est identique depuis plus de 1400 ans.',
    source: 'Coran, Al-Hijr 15:9',
  ),
  QuestionDuJour(
    id: 'q5', emoji: '🤲',
    question: 'Pourquoi les du\'a sont-elles si importantes ?',
    reponse: 'La du\'a (invocation) est le cœur de l\'adoration. Le Prophète ﷺ a dit : « La du\'a est l\'adoration elle-même. » C\'est un lien direct entre le serviteur et son Seigneur, sans intermédiaire. Allah dit : « Invoquez-Moi, Je vous répondrai. » Les moments privilégiés pour la du\'a sont : le dernier tiers de la nuit, entre l\'adhan et l\'iqama, en prosternation, et le vendredi.',
    source: 'Coran, Ghafir 40:60 ; Tirmidhi',
  ),
  QuestionDuJour(
    id: 'q6', emoji: '💰',
    question: 'Pourquoi l\'Islam interdit-il le Riba (intérêt) ?',
    reponse: 'Le Riba (usure/intérêt) est interdit car il crée une injustice : l\'argent génère de l\'argent sans effort ni risque, au détriment de l\'emprunteur. L\'Islam promeut le partage des risques et des profits. Allah dit : « Allah a rendu licite le commerce et illicite l\'intérêt. » L\'alternative islamique est le commerce équitable, le partenariat (Moudaraba, Moucharaka) et le financement participatif.',
    source: 'Coran, Al-Baqara 2:275',
  ),
  QuestionDuJour(
    id: 'q7', emoji: '👨‍👩‍👧',
    question: 'Quelle place les parents ont-ils en Islam ?',
    reponse: 'Les parents occupent la plus haute place après Allah et Son Messager. Allah ordonne la bienfaisance envers eux juste après l\'ordre de L\'adorer Lui seul. Le Prophète ﷺ a dit : « Le Paradis est sous les pieds des mères. » Et quand on lui demanda qui mérite le plus la bonne compagnie, il répondit trois fois : « Ta mère », puis « Ton père. » Même non-musulmans, les parents méritent respect et bonté.',
    source: 'Coran, Al-Isra 17:23-24 ; Nasa\'i',
  ),
  QuestionDuJour(
    id: 'q8', emoji: '🌟',
    question: 'Qu\'est-ce que la Laylat al-Qadr ?',
    reponse: 'La Nuit du Destin (Laylat al-Qadr) est la nuit durant laquelle le Coran a été révélé. Elle est meilleure que mille mois (soit plus de 83 ans d\'adoration). Elle se trouve dans les dix dernières nuits de Ramadan, probablement les nuits impaires (21, 23, 25, 27, 29). Les anges et l\'Esprit (Jibril) y descendent. Le Prophète ﷺ intensifiait ses adorations durant ces nuits.',
    source: 'Coran, Al-Qadr 97:1-5',
  ),
  QuestionDuJour(
    id: 'q9', emoji: '⚖️',
    question: 'Comment l\'Islam voit-il la justice sociale ?',
    reponse: 'La justice (\'Adl) est un pilier fondamental de l\'Islam. Allah ordonne la justice même envers ceux qu\'on n\'aime pas : « Soyez justes, car la justice est plus proche de la piété. » La Zakat redistribue la richesse, le Waqf finance les biens publics, et le Prophète ﷺ a interdit toute discrimination. Son dernier sermon rappelle : « Aucun Arabe n\'est supérieur à un non-Arabe, sauf par la piété. »',
    source: 'Coran, Al-Ma\'ida 5:8 ; Sermon d\'adieu',
  ),
  QuestionDuJour(
    id: 'q10', emoji: '🕊️',
    question: 'Qu\'est-ce que le Tawakkul ?',
    reponse: 'Le Tawakkul est la confiance totale en Allah après avoir fait les efforts nécessaires. Ce n\'est pas la passivité, mais l\'action accompagnée de la certitude qu\'Allah est le meilleur des planificateurs. Le Prophète ﷺ a dit à l\'homme qui ne voulait pas attacher son chameau : « Attache-le, puis place ta confiance en Allah. » Le vrai Tawakkul combine l\'effort humain et la foi en la sagesse divine.',
    source: 'Tirmidhi ; Coran, At-Talaq 65:3',
  ),
  QuestionDuJour(
    id: 'q11', emoji: '🧠',
    question: 'Pourquoi l\'Islam encourage-t-il la science ?',
    reponse: 'Le premier mot révélé du Coran est « Iqra » (Lis !). L\'Islam considère la recherche du savoir comme une obligation. Le Prophète ﷺ a dit : « La recherche du savoir est une obligation pour chaque musulman. » Le Coran invite constamment à observer, réfléchir et méditer sur la création. C\'est pourquoi la civilisation islamique a été pionnière en médecine, astronomie, mathématiques et chimie.',
    source: 'Coran, Al-Alaq 96:1 ; Ibn Majah',
  ),
  QuestionDuJour(
    id: 'q12', emoji: '💎',
    question: 'Qu\'est-ce que l\'Ihsan ?',
    reponse: 'L\'Ihsan est le plus haut degré de la foi. Le Prophète ﷺ l\'a défini : « C\'est que tu adores Allah comme si tu Le voyais, car si tu ne Le vois pas, Lui te voit. » C\'est la quête de l\'excellence dans chaque acte d\'adoration et dans le comportement envers les gens. L\'Islam repose sur trois niveaux : l\'Islam (les actes), l\'Iman (la foi), et l\'Ihsan (l\'excellence spirituelle).',
    source: 'Hadith de Jibril — Muslim',
  ),
];

// ── Le Saviez-Vous ? ──────────────────────────────────────────────

class FaitMarquant {
  final String id;
  final String emoji;
  final String titre;
  final String contenu;
  final String categorie; // 'science', 'histoire', 'coran', 'civilisation'

  const FaitMarquant({
    required this.id,
    required this.emoji,
    required this.titre,
    required this.contenu,
    required this.categorie,
  });
}

const kFaitsMarquants = <FaitMarquant>[
  FaitMarquant(id: 'f1', emoji: '🔬', categorie: 'science',
    titre: 'Le cycle de l\'eau dans le Coran',
    contenu: 'Le Coran décrit le cycle de l\'eau avec précision 1400 ans avant la science moderne : « N\'as-tu pas vu qu\'Allah fait descendre du ciel de l\'eau, puis Il l\'achemine vers des sources dans la terre ? » (Az-Zumar, 39:21). La description coranique inclut l\'évaporation, la condensation et les précipitations.',
  ),
  FaitMarquant(id: 'f2', emoji: '👁️', categorie: 'civilisation',
    titre: 'Ibn al-Haytham, père de l\'optique',
    contenu: 'Le savant musulman Ibn al-Haytham (965-1040) est considéré comme le père de l\'optique moderne. Son « Livre de l\'optique » a révolutionné la compréhension de la vision et de la lumière. Il a inventé la camera obscura et posé les bases de la méthode scientifique expérimentale, 600 ans avant Galilée.',
  ),
  FaitMarquant(id: 'f3', emoji: '🏥', categorie: 'civilisation',
    titre: 'Les premiers hôpitaux',
    contenu: 'Les premiers hôpitaux modernes (Bimaristans) ont été fondés dans le monde musulman dès le 8e siècle. L\'hôpital Al-Mansur au Caire (1284) avait des départements spécialisés, des pharmacies, et soignait gratuitement tous les patients, quelle que soit leur religion ou leur statut social.',
  ),
  FaitMarquant(id: 'f4', emoji: '🌍', categorie: 'science',
    titre: 'Les montagnes comme des piquets',
    contenu: 'Le Coran compare les montagnes à des piquets : « N\'avons-Nous pas fait de la terre une couche, et des montagnes des piquets ? » (An-Naba, 78:6-7). La géologie moderne a confirmé que les montagnes ont des racines profondes qui stabilisent la croûte terrestre, exactement comme des piquets.',
  ),
  FaitMarquant(id: 'f5', emoji: '✈️', categorie: 'civilisation',
    titre: 'Abbas ibn Firnas et le vol',
    contenu: 'En 875, Abbas ibn Firnas, un inventeur andalou, a réalisé le premier vol plané de l\'histoire en se lançant depuis une colline de Cordoue avec des ailes fabriquées. Il a plané pendant plusieurs minutes avant d\'atterrir. C\'était 600 ans avant Léonard de Vinci et plus de 1000 ans avant les frères Wright.',
  ),
  FaitMarquant(id: 'f6', emoji: '🔢', categorie: 'civilisation',
    titre: 'Al-Khwarizmi et l\'algèbre',
    contenu: 'Muhammad ibn Musa al-Khwarizmi (780-850) est le père de l\'algèbre. Le mot « algèbre » vient du titre de son livre « Al-Jabr ». Le mot « algorithme » vient de la latinisation de son nom. Ses travaux en mathématiques ont révolutionné la science et sont à la base de l\'informatique moderne.',
  ),
  FaitMarquant(id: 'f7', emoji: '🧬', categorie: 'science',
    titre: 'L\'embryologie dans le Coran',
    contenu: 'Le Coran décrit les étapes du développement embryonnaire avec une précision remarquable : nutfa (goutte), alaqa (adhérence), mudgha (morceau mâché), puis os recouverts de chair. Le Professeur Keith Moore, éminent embryologiste, a reconnu que ces descriptions ne pouvaient pas provenir des connaissances humaines du 7e siècle.',
  ),
  FaitMarquant(id: 'f8', emoji: '📚', categorie: 'histoire',
    titre: 'La Maison de la Sagesse',
    contenu: 'La Maison de la Sagesse (Bayt al-Hikma) fondée à Bagdad au 9e siècle était la plus grande bibliothèque et centre de traduction au monde. Des savants de toutes religions y traduisaient les œuvres grecques, persanes et indiennes en arabe, préservant et enrichissant le savoir antique pour les générations futures.',
  ),
  FaitMarquant(id: 'f9', emoji: '🌊', categorie: 'science',
    titre: 'La barrière entre les mers',
    contenu: 'Le Coran mentionne une barrière invisible entre deux mers qui se rencontrent : « Il a donné libre cours aux deux mers pour se rencontrer ; il y a entre elles une barrière qu\'elles ne dépassent pas. » (Ar-Rahman, 55:19-20). L\'océanographie moderne a confirmé l\'existence de ces frontières de salinité entre les masses d\'eau.',
  ),
  FaitMarquant(id: 'f10', emoji: '🕌', categorie: 'histoire',
    titre: 'L\'Université Al-Qarawiyyin',
    contenu: 'Fondée en 859 par Fatima al-Fihri à Fès (Maroc), Al-Qarawiyyin est reconnue par l\'UNESCO comme la plus ancienne université encore en activité au monde. Elle a formé des érudits de toutes disciplines pendant plus de 1100 ans et a inspiré les universités européennes médiévales.',
  ),
];

// ── Histoires des Prophètes ───────────────────────────────────────

class ProphetStory {
  final String id;
  final String nom;
  final String nomArabe;
  final String emoji;
  final String titre;
  final String resume;
  final List<String> lecons;
  final String versetCle;
  final String refVerset;

  const ProphetStory({
    required this.id,
    required this.nom,
    required this.nomArabe,
    required this.emoji,
    required this.titre,
    required this.resume,
    required this.lecons,
    required this.versetCle,
    required this.refVerset,
  });
}

const kProphetStories = <ProphetStory>[
  ProphetStory(
    id: 'adam', nom: 'Adam', nomArabe: 'آدم', emoji: '🌿',
    titre: 'Le premier homme et prophète',
    resume: 'Allah a créé Adam de terre et lui a enseigné les noms de toutes choses. Les anges se sont prosternés devant lui sur ordre d\'Allah, sauf Iblis qui a refusé par orgueil. Adam et Hawwa (Ève) vivaient au Paradis mais ont désobéi en mangeant de l\'arbre interdit, influencés par Iblis. Ils se sont repentis sincèrement et Allah leur a pardonné, puis les a envoyés sur terre comme Ses représentants (khalifas).',
    lecons: [
      'Le repentir sincère efface les péchés — Allah est Le Tout-Pardonnant',
      'L\'orgueil est le premier péché (celui d\'Iblis)',
      'L\'être humain est honoré par Allah et a une mission sur terre',
      'Shaytan est un ennemi déclaré — il faut rester vigilant',
    ],
    versetCle: 'Quand ton Seigneur dit aux anges : Je vais établir un représentant sur la terre.',
    refVerset: 'Al-Baqara, 2:30',
  ),
  ProphetStory(
    id: 'nuh', nom: 'Nouh (Noé)', nomArabe: 'نوح', emoji: '🚢',
    titre: 'Le prophète de la patience',
    resume: 'Nouh a prêché le monothéisme pendant 950 ans à un peuple obstiné dans l\'idolâtrie. Malgré les moqueries et le rejet, il n\'a jamais abandonné. Allah lui a ordonné de construire une arche, et le Déluge a englouti les mécréants. Même le fils de Nouh a refusé de monter à bord, montrant que la foi est un choix personnel, pas un héritage.',
    lecons: [
      'La patience dans la prédication — 950 ans sans abandonner',
      'La foi ne se transmet pas par le sang mais par le choix',
      'Allah sauve les croyants même dans les pires épreuves',
      'L\'obstination dans le péché mène à la destruction',
    ],
    versetCle: 'Noé invoqua son Seigneur : Je suis vaincu, secours-moi !',
    refVerset: 'Al-Qamar, 54:10',
  ),
  ProphetStory(
    id: 'ibrahim', nom: 'Ibrahim (Abraham)', nomArabe: 'إبراهيم', emoji: '🔥',
    titre: 'L\'ami intime d\'Allah',
    resume: 'Ibrahim a rejeté l\'idolâtrie de son peuple et de son père en utilisant la raison. Jeté dans un feu par le roi Nimrod, Allah l\'a protégé. Il a été éprouvé par l\'ordre de sacrifier son fils Ismaïl — tous deux se sont soumis à la volonté d\'Allah, qui les a récompensés. Ibrahim a construit la Ka\'ba avec Ismaïl et est l\'ancêtre commun des prophètes.',
    lecons: [
      'La soumission totale à Allah (l\'Islam dans son essence)',
      'Utiliser la raison pour trouver la vérité',
      'Allah protège ceux qui Lui font confiance',
      'L\'épreuve d\'Allah est une élévation, pas une punition',
    ],
    versetCle: 'Quand son Seigneur lui dit : Soumets-toi ! Il dit : Je me soumets au Seigneur des mondes.',
    refVerset: 'Al-Baqara, 2:131',
  ),
  ProphetStory(
    id: 'yusuf', nom: 'Youssef (Joseph)', nomArabe: 'يوسف', emoji: '🌟',
    titre: 'La plus belle des histoires',
    resume: 'Youssef, fils de Ya\'qub, a été jeté dans un puits par ses frères jaloux, vendu comme esclave en Égypte, accusé injustement et emprisonné. Malgré toutes ces épreuves, il est resté patient et fidèle à Allah. Il est devenu ministre d\'Égypte grâce à son don d\'interprétation des rêves et a pardonné à ses frères quand ils sont venus à lui.',
    lecons: [
      'La patience face à l\'injustice mène à l\'élévation',
      'La chasteté et l\'intégrité même dans la difficulté',
      'Le pardon est plus noble que la vengeance',
      'Allah a un plan même quand on ne le comprend pas',
    ],
    versetCle: 'Certes, quiconque craint Allah et patiente... Allah ne fait pas perdre la récompense des bienfaisants.',
    refVerset: 'Yusuf, 12:90',
  ),
  ProphetStory(
    id: 'musa', nom: 'Moussa (Moïse)', nomArabe: 'موسى', emoji: '🌊',
    titre: 'Le prophète le plus cité dans le Coran',
    resume: 'Moussa est le prophète le plus mentionné dans le Coran. Sauvé des eaux étant bébé, élevé dans le palais de Pharaon, il a fui en Madian où Allah lui a parlé au buisson ardent. Il est retourné en Égypte pour affronter Pharaon et libérer les Fils d\'Israël. Allah a fendu la mer pour le sauver et lui a donné la Torah au mont Sinaï.',
    lecons: [
      'Allah choisit Ses messagers selon Sa sagesse',
      'Le courage face à la tyrannie est un devoir',
      'Allah transforme la faiblesse en force',
      'La gratitude après la délivrance est essentielle',
    ],
    versetCle: 'Va vers Pharaon, car il a transgressé toute limite.',
    refVerset: 'Ta-Ha, 20:24',
  ),
  ProphetStory(
    id: 'issa', nom: 'Issa (Jésus)', nomArabe: 'عيسى', emoji: '✨',
    titre: 'Le Messie, serviteur d\'Allah',
    resume: 'Issa est né miraculeusement de Maryam (Marie) sans père, par la volonté d\'Allah. Il a accompli de nombreux miracles : guérir les aveugles et les lépreux, ressusciter les morts, avec la permission d\'Allah. Il a prêché le monothéisme pur et annoncé la venue du dernier prophète. Selon le Coran, il n\'a pas été crucifié mais élevé au ciel par Allah, et il reviendra à la fin des temps.',
    lecons: [
      'Les miracles viennent d\'Allah seul, pas des prophètes',
      'L\'humilité dans la servitude envers Allah',
      'La pureté de Maryam comme modèle pour les croyants',
      'Le monothéisme est le message de tous les prophètes',
    ],
    versetCle: 'Le Messie Issa fils de Maryam n\'est qu\'un messager d\'Allah, Sa parole qu\'Il envoya à Maryam, et un esprit venant de Lui.',
    refVerset: 'An-Nisa, 4:171',
  ),
  ProphetStory(
    id: 'muhammad', nom: 'Muhammad ﷺ', nomArabe: 'محمد', emoji: '🕌',
    titre: 'Le sceau des prophètes',
    resume: 'Muhammad ﷺ est né orphelin à La Mecque en 570. À 40 ans, il a reçu la première révélation du Coran par l\'ange Jibril. Persécuté pendant 13 ans à La Mecque, il a émigré à Médine (Hégire) où il a établi la première société islamique fondée sur la justice, la fraternité et la miséricorde. En 10 ans, il a unifié l\'Arabie et transmis le message final d\'Allah à l\'humanité entière.',
    lecons: [
      'La miséricorde est au cœur du message islamique',
      'La patience dans l\'épreuve mène au succès',
      'Le Prophète ﷺ est le modèle parfait de comportement',
      'L\'Islam est un message universel pour toute l\'humanité',
    ],
    versetCle: 'Nous ne t\'avons envoyé qu\'en miséricorde pour les mondes.',
    refVerset: 'Al-Anbiya, 21:107',
  ),
];

// ── Sagesses & Citations ──────────────────────────────────────────

class Sagesse {
  final String id;
  final String texte;
  final String auteur;
  final String categorie; // 'patience', 'tawakkul', 'science', 'famille', 'repentir', 'amour'
  final String emoji;

  const Sagesse({
    required this.id,
    required this.texte,
    required this.auteur,
    required this.categorie,
    required this.emoji,
  });
}

const kSagesses = <Sagesse>[
  // Patience
  Sagesse(id: 's1', emoji: '🏔️', categorie: 'patience',
    texte: 'La patience n\'est pas de supporter passivement, c\'est d\'accepter avec confiance que le plan d\'Allah est meilleur que le tien.',
    auteur: 'Ibn al-Qayyim'),
  Sagesse(id: 's2', emoji: '🌧️', categorie: 'patience',
    texte: 'Sois patient, car la pluie ne tombe pas sur une seule terre.',
    auteur: 'Proverbe arabe'),
  Sagesse(id: 's3', emoji: '💪', categorie: 'patience',
    texte: 'Le vrai fort n\'est pas celui qui terrasse son adversaire, mais celui qui se maîtrise dans la colère.',
    auteur: 'Prophète Muhammad ﷺ — Bukhari'),

  // Tawakkul
  Sagesse(id: 's4', emoji: '🕊️', categorie: 'tawakkul',
    texte: 'Si vous placiez votre confiance en Allah comme il se doit, Il vous nourrirait comme Il nourrit les oiseaux : ils partent le ventre vide et reviennent le ventre plein.',
    auteur: 'Prophète Muhammad ﷺ — Tirmidhi'),
  Sagesse(id: 's5', emoji: '🌅', categorie: 'tawakkul',
    texte: 'Quand Allah veut du bien pour quelqu\'un, Il lui ouvre la porte de l\'action et lui ferme la porte du débat.',
    auteur: 'Hassan al-Basri'),
  Sagesse(id: 's6', emoji: '🌙', categorie: 'tawakkul',
    texte: 'Ne sois pas triste, ce que tu as perdu reviendra sous une autre forme.',
    auteur: 'Rumi'),

  // Science
  Sagesse(id: 's7', emoji: '📚', categorie: 'science',
    texte: 'Cherchez la science du berceau jusqu\'à la tombe.',
    auteur: 'Proverbe islamique'),
  Sagesse(id: 's8', emoji: '🕯️', categorie: 'science',
    texte: 'L\'encre du savant est plus sacrée que le sang du martyr.',
    auteur: 'Attribué au Prophète ﷺ'),
  Sagesse(id: 's9', emoji: '🧠', categorie: 'science',
    texte: 'Celui qui ne goûte pas l\'amertume de l\'apprentissage pendant un moment, goûtera l\'humiliation de l\'ignorance toute sa vie.',
    auteur: 'Imam Ash-Shafi\'i'),

  // Famille
  Sagesse(id: 's10', emoji: '👨‍👩‍👧', categorie: 'famille',
    texte: 'Le meilleur d\'entre vous est celui qui est le meilleur envers sa famille, et je suis le meilleur d\'entre vous envers ma famille.',
    auteur: 'Prophète Muhammad ﷺ — Tirmidhi'),
  Sagesse(id: 's11', emoji: '💞', categorie: 'famille',
    texte: 'Et parmi Ses signes, Il a créé pour vous des épouses issues de vous-mêmes pour que vous trouviez la quiétude auprès d\'elles.',
    auteur: 'Coran, Ar-Rum 30:21'),

  // Repentir
  Sagesse(id: 's12', emoji: '🌱', categorie: 'repentir',
    texte: 'Ô fils d\'Adam, tant que tu M\'invoques et que tu espères en Moi, Je te pardonne quoi que tu aies fait, et cela ne Me pèse pas.',
    auteur: 'Hadith Qudsi — Tirmidhi'),
  Sagesse(id: 's13', emoji: '🌊', categorie: 'repentir',
    texte: 'Allah se réjouit du repentir de Son serviteur plus que celui qui retrouve son chameau perdu dans le désert.',
    auteur: 'Prophète Muhammad ﷺ — Muslim'),
  Sagesse(id: 's14', emoji: '🔄', categorie: 'repentir',
    texte: 'Chaque fils d\'Adam commet des erreurs, et les meilleurs parmi ceux qui commettent des erreurs sont ceux qui se repentent.',
    auteur: 'Prophète Muhammad ﷺ — Tirmidhi'),

  // Amour d\'Allah
  Sagesse(id: 's15', emoji: '💚', categorie: 'amour',
    texte: 'Dans le cœur, il y a un vide qui ne peut être comblé que par l\'amour d\'Allah, le fait de se tourner vers Lui et de Le mentionner constamment.',
    auteur: 'Ibn al-Qayyim'),
  Sagesse(id: 's16', emoji: '🌺', categorie: 'amour',
    texte: 'Allah est beau et Il aime la beauté.',
    auteur: 'Prophète Muhammad ﷺ — Muslim'),
];

// ── Quiz Islamique ────────────────────────────────────────────────

class QuizQuestion {
  final String id;
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explication;
  final String categorie; // 'coran', 'sira', 'piliers', 'prophetes', 'general'

  const QuizQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explication,
    required this.categorie,
  });
}

const kQuizQuestions = <QuizQuestion>[
  QuizQuestion(id: 'qz1', categorie: 'piliers',
    question: 'Combien de piliers comporte l\'Islam ?',
    options: ['3', '4', '5', '6'],
    correctIndex: 2,
    explication: 'Les 5 piliers sont : la Shahada, la Salat, la Zakat, le Siyam (jeûne de Ramadan) et le Hajj (pèlerinage).'),
  QuizQuestion(id: 'qz2', categorie: 'coran',
    question: 'Quel est le premier mot révélé du Coran ?',
    options: ['Bismillah', 'Alhamdulillah', 'Iqra (Lis)', 'Qul (Dis)'],
    correctIndex: 2,
    explication: 'Le premier mot révélé est « Iqra » (Lis !), sourate Al-Alaq, révélée dans la grotte de Hira.'),
  QuizQuestion(id: 'qz3', categorie: 'coran',
    question: 'Combien de sourates contient le Coran ?',
    options: ['100', '114', '120', '124'],
    correctIndex: 1,
    explication: 'Le Coran contient 114 sourates, de Al-Fatiha à An-Nas.'),
  QuizQuestion(id: 'qz4', categorie: 'sira',
    question: 'Dans quelle grotte le Prophète ﷺ a-t-il reçu la première révélation ?',
    options: ['Grotte de Thawr', 'Grotte de Hira', 'Grotte de Kahf', 'Grotte de Uhud'],
    correctIndex: 1,
    explication: 'La première révélation a eu lieu dans la grotte de Hira, sur le mont An-Nur, près de La Mecque.'),
  QuizQuestion(id: 'qz5', categorie: 'prophetes',
    question: 'Quel prophète a construit la Ka\'ba avec son fils ?',
    options: ['Adam', 'Nouh', 'Ibrahim', 'Muhammad ﷺ'],
    correctIndex: 2,
    explication: 'Ibrahim (Abraham) et son fils Ismaïl ont construit (ou reconstruit) la Ka\'ba sur ordre d\'Allah.'),
  QuizQuestion(id: 'qz6', categorie: 'coran',
    question: 'Quelle sourate est appelée « le cœur du Coran » ?',
    options: ['Al-Baqara', 'Ya-Sin', 'Al-Rahman', 'Al-Mulk'],
    correctIndex: 1,
    explication: 'La sourate Ya-Sin est appelée « le cœur du Coran » par le Prophète ﷺ.'),
  QuizQuestion(id: 'qz7', categorie: 'sira',
    question: 'En quelle année a eu lieu l\'Hégire ?',
    options: ['610', '620', '622', '632'],
    correctIndex: 2,
    explication: 'L\'Hégire (émigration de La Mecque à Médine) a eu lieu en 622 après J.-C. et marque le début du calendrier islamique.'),
  QuizQuestion(id: 'qz8', categorie: 'piliers',
    question: 'Combien de prières obligatoires y a-t-il par jour ?',
    options: ['3', '4', '5', '7'],
    correctIndex: 2,
    explication: 'Les 5 prières sont : Fajr, Dhuhr, Asr, Maghrib et Isha.'),
  QuizQuestion(id: 'qz9', categorie: 'prophetes',
    question: 'Quel prophète est le plus mentionné dans le Coran ?',
    options: ['Ibrahim', 'Issa', 'Moussa', 'Muhammad ﷺ'],
    correctIndex: 2,
    explication: 'Moussa (Moïse) est mentionné 136 fois dans le Coran, plus que tout autre prophète.'),
  QuizQuestion(id: 'qz10', categorie: 'general',
    question: 'Quel ange est chargé de transmettre la révélation ?',
    options: ['Mikail', 'Israfil', 'Jibril', 'Azraïl'],
    correctIndex: 2,
    explication: 'Jibril (Gabriel) est l\'ange chargé de transmettre la révélation d\'Allah aux prophètes.'),
  QuizQuestion(id: 'qz11', categorie: 'coran',
    question: 'Quel verset est le plus important du Coran selon le Prophète ﷺ ?',
    options: ['Al-Fatiha, v.1', 'Ayat al-Kursi (Al-Baqara, v.255)', 'Al-Ikhlas', 'Al-Falaq'],
    correctIndex: 1,
    explication: 'Ayat al-Kursi (le Verset du Trône, Al-Baqara 2:255) est le plus grandiose verset du Coran selon le Prophète ﷺ.'),
  QuizQuestion(id: 'qz12', categorie: 'general',
    question: 'Combien de Noms Sublimes (Al-Asma al-Husna) Allah a-t-Il ?',
    options: ['33', '66', '99', '100'],
    correctIndex: 2,
    explication: 'Allah a 99 Noms Sublimes. Le Prophète ﷺ a dit : « Quiconque les apprend par cœur entrera au Paradis. »'),
  QuizQuestion(id: 'qz13', categorie: 'prophetes',
    question: 'Quel prophète a été jeté dans un puits par ses frères ?',
    options: ['Ismaïl', 'Youssef', 'Shu\'ayb', 'Dawud'],
    correctIndex: 1,
    explication: 'Youssef (Joseph) a été jeté dans un puits par ses frères jaloux, puis vendu comme esclave en Égypte.'),
  QuizQuestion(id: 'qz14', categorie: 'sira',
    question: 'Comment s\'appelle la première épouse du Prophète ﷺ ?',
    options: ['Aïcha', 'Khadija', 'Hafsa', 'Fatima'],
    correctIndex: 1,
    explication: 'Khadija bint Khuwaylid fut la première épouse du Prophète ﷺ et la première personne à embrasser l\'Islam.'),
  QuizQuestion(id: 'qz15', categorie: 'piliers',
    question: 'Pendant quel mois le jeûne est-il obligatoire ?',
    options: ['Sha\'ban', 'Rajab', 'Ramadan', 'Dhul Hijja'],
    correctIndex: 2,
    explication: 'Le jeûne est obligatoire pendant le mois de Ramadan, le 9e mois du calendrier islamique.'),
];

// ── Catégories de sagesses pour filtrage ──────────────────────────

const kSagesseCategories = <String, String>{
  'all': 'Toutes',
  'patience': '🏔️ Patience',
  'tawakkul': '🕊️ Tawakkul',
  'science': '📚 Science',
  'famille': '👨‍👩‍👧 Famille',
  'repentir': '🌱 Repentir',
  'amour': '💚 Amour d\'Allah',
};

const kQuizCategories = <String, String>{
  'all': 'Toutes',
  'coran': '📖 Coran',
  'sira': '🕌 Sira',
  'piliers': '🕋 Piliers',
  'prophetes': '🌟 Prophètes',
  'general': '💎 Général',
};
