import 'app_locale.dart';

// decouvrir_data.dart
// Données pour le module Découvrir – Application UpYourDeen

// ── Questions du Jour ─────────────────────────────────────────────

class QuestionDuJour {
  final String id;
  final String questionFr;
  final String questionEn;
  final String emoji;
  final String reponseFr;
  final String reponseEn;
  final String source;

  const QuestionDuJour({
    required this.id,
    required this.questionFr,
    required this.questionEn,
    required this.emoji,
    required this.reponseFr,
    required this.reponseEn,
    required this.source,
  });

  String get question => AppLocale().isFrench ? questionFr : questionEn;
  String get reponse => AppLocale().isFrench ? reponseFr : reponseEn;
}

const kQuestionsDuJour = <QuestionDuJour>[
  QuestionDuJour(
    id: 'q1', emoji: '🍽️',
    questionFr: 'Pourquoi dit-on Bismillah avant de manger ?',
    questionEn: 'Why do we say Bismillah before eating?',
    reponseFr: 'Dire Bismillah (Au nom d\'Allah) avant de manger est une sunna du Prophète ﷺ. Cela permet de bénir la nourriture, de remercier Allah pour ce bienfait, et d\'empêcher Shaytan de partager notre repas. Le Prophète ﷺ a dit : « Quand l\'un de vous mange, qu\'il mentionne le nom d\'Allah. S\'il oublie de le mentionner au début, qu\'il dise : Bismillah fi awwalihi wa akhirihi. »',
    reponseEn: 'Saying Bismillah (In the name of Allah) before eating is a Sunnah of the Prophet ﷺ. It blesses the food, expresses gratitude to Allah for this blessing, and prevents Shaytan from sharing our meal. The Prophet ﷺ said: "When one of you eats, let him mention the name of Allah. If he forgets to mention it at the beginning, let him say: Bismillah fi awwalihi wa akhirihi."',
    source: 'Abu Dawud, Tirmidhi',
  ),
  QuestionDuJour(
    id: 'q2', emoji: '🌙',
    questionFr: 'Quelle est la sagesse du jeûne en Islam ?',
    questionEn: 'What is the wisdom of fasting in Islam?',
    reponseFr: 'Le jeûne (Siyam) développe la taqwa (conscience d\'Allah), la maîtrise de soi, la patience et l\'empathie envers les plus démunis. Il purifie le corps et l\'âme. Allah dit dans le Coran : « Ô vous qui croyez ! Le jeûne vous est prescrit comme il a été prescrit à ceux qui vous ont précédés, afin que vous atteigniez la piété. » Le jeûne est aussi un bouclier contre le Feu.',
    reponseEn: 'Fasting (Siyam) develops taqwa (God-consciousness), self-control, patience, and empathy for those in need. It purifies the body and soul. Allah says in the Quran: "O you who believe! Fasting is prescribed for you as it was prescribed for those before you, so that you may attain piety." Fasting is also a shield against the Fire.',
    source: 'Coran, Al-Baqara 2:183 ; Bukhari',
  ),
  QuestionDuJour(
    id: 'q3', emoji: '🕋',
    questionFr: 'Pourquoi les musulmans prient-ils vers La Mecque ?',
    questionEn: 'Why do Muslims pray towards Mecca?',
    reponseFr: 'La Ka\'ba à La Mecque est la première maison construite pour l\'adoration d\'Allah, bâtie par Ibrahim (Abraham) et son fils Ismaïl. Prier vers cette direction (Qibla) unifie les musulmans du monde entier dans une même direction, symbolisant l\'unité de la Oumma. Initialement, les musulmans priaient vers Jérusalem, puis Allah a ordonné le changement de Qibla vers La Mecque.',
    reponseEn: 'The Ka\'ba in Mecca is the first house built for the worship of Allah, built by Ibrahim (Abraham) and his son Ismail. Praying in this direction (Qibla) unites Muslims worldwide in a single direction, symbolising the unity of the Ummah. Initially Muslims prayed toward Jerusalem, then Allah ordered the change of Qibla to Mecca.',
    source: 'Coran, Al-Baqara 2:144 ; Al-Imran 3:96',
  ),
  QuestionDuJour(
    id: 'q4', emoji: '📖',
    questionFr: 'Comment le Coran a-t-il été préservé ?',
    questionEn: 'How was the Quran preserved?',
    reponseFr: 'Le Coran a été préservé par trois moyens simultanés : la mémorisation par cœur (des milliers de compagnons l\'avaient mémorisé), l\'écriture sur des supports divers du vivant du Prophète ﷺ, et la compilation officielle sous Abu Bakr puis Othman. Allah a promis sa préservation : « C\'est Nous qui avons fait descendre le Rappel et c\'est Nous qui en sommes les gardiens. » Chaque lettre est identique depuis plus de 1400 ans.',
    reponseEn: 'The Quran was preserved through three simultaneous means: memorisation by heart (thousands of companions had memorised it), writing on various surfaces during the Prophet\'s ﷺ lifetime, and official compilation under Abu Bakr then Uthman. Allah promised its preservation: "Indeed, it is We who sent down the Reminder and indeed, We will be its guardian." Every letter has been identical for over 1,400 years.',
    source: 'Coran, Al-Hijr 15:9',
  ),
  QuestionDuJour(
    id: 'q5', emoji: '🤲',
    questionFr: 'Pourquoi les du\'a sont-elles si importantes ?',
    questionEn: 'Why are du\'as so important?',
    reponseFr: 'La du\'a (invocation) est le cœur de l\'adoration. Le Prophète ﷺ a dit : « La du\'a est l\'adoration elle-même. » C\'est un lien direct entre le serviteur et son Seigneur, sans intermédiaire. Allah dit : « Invoquez-Moi, Je vous répondrai. » Les moments privilégiés pour la du\'a sont : le dernier tiers de la nuit, entre l\'adhan et l\'iqama, en prosternation, et le vendredi.',
    reponseEn: 'Du\'a (supplication) is the essence of worship. The Prophet ﷺ said: "Du\'a is worship itself." It is a direct connection between the servant and his Lord, with no intermediary. Allah says: "Call upon Me; I will respond to you." Privileged times for du\'a include: the last third of the night, between the adhan and iqama, in prostration, and on Fridays.',
    source: 'Coran, Ghafir 40:60 ; Tirmidhi',
  ),
  QuestionDuJour(
    id: 'q6', emoji: '💰',
    questionFr: 'Pourquoi l\'Islam interdit-il le Riba (intérêt) ?',
    questionEn: 'Why does Islam forbid Riba (interest)?',
    reponseFr: 'Le Riba (usure/intérêt) est interdit car il crée une injustice : l\'argent génère de l\'argent sans effort ni risque, au détriment de l\'emprunteur. L\'Islam promeut le partage des risques et des profits. Allah dit : « Allah a rendu licite le commerce et illicite l\'intérêt. » L\'alternative islamique est le commerce équitable, le partenariat (Moudaraba, Moucharaka) et le financement participatif.',
    reponseEn: 'Riba (usury/interest) is forbidden because it creates injustice: money generates money without effort or risk, at the expense of the borrower. Islam promotes risk and profit sharing. Allah says: "Allah has made trade lawful and forbidden interest." The Islamic alternative is fair trade, partnership (Mudaraba, Musharaka) and participatory financing.',
    source: 'Coran, Al-Baqara 2:275',
  ),
  QuestionDuJour(
    id: 'q7', emoji: '👨‍👩‍👧',
    questionFr: 'Quelle place les parents ont-ils en Islam ?',
    questionEn: 'What place do parents hold in Islam?',
    reponseFr: 'Les parents occupent la plus haute place après Allah et Son Messager. Allah ordonne la bienfaisance envers eux juste après l\'ordre de L\'adorer Lui seul. Le Prophète ﷺ a dit : « Le Paradis est sous les pieds des mères. » Et quand on lui demanda qui mérite le plus la bonne compagnie, il répondit trois fois : « Ta mère », puis « Ton père. » Même non-musulmans, les parents méritent respect et bonté.',
    reponseEn: 'Parents hold the highest place after Allah and His Messenger. Allah commands kindness to them immediately after the command to worship Him alone. The Prophet ﷺ said: "Paradise lies under the feet of mothers." When asked who most deserves good companionship, he replied three times: "Your mother," then "Your father." Even if non-Muslim, parents deserve respect and kindness.',
    source: 'Coran, Al-Isra 17:23-24 ; Nasa\'i',
  ),
  QuestionDuJour(
    id: 'q8', emoji: '🌟',
    questionFr: 'Qu\'est-ce que la Laylat al-Qadr ?',
    questionEn: 'What is Laylat al-Qadr?',
    reponseFr: 'La Nuit du Destin (Laylat al-Qadr) est la nuit durant laquelle le Coran a été révélé. Elle est meilleure que mille mois (soit plus de 83 ans d\'adoration). Elle se trouve dans les dix dernières nuits de Ramadan, probablement les nuits impaires (21, 23, 25, 27, 29). Les anges et l\'Esprit (Jibril) y descendent. Le Prophète ﷺ intensifiait ses adorations durant ces nuits.',
    reponseEn: 'The Night of Decree (Laylat al-Qadr) is the night on which the Quran was revealed. It is better than a thousand months (equivalent to over 83 years of worship). It falls within the last ten nights of Ramadan, most likely the odd nights (21st, 23rd, 25th, 27th, 29th). Angels and the Spirit (Jibril) descend on it. The Prophet ﷺ intensified his worship during these nights.',
    source: 'Coran, Al-Qadr 97:1-5',
  ),
  QuestionDuJour(
    id: 'q9', emoji: '⚖️',
    questionFr: 'Comment l\'Islam voit-il la justice sociale ?',
    questionEn: 'How does Islam view social justice?',
    reponseFr: 'La justice (\'Adl) est un pilier fondamental de l\'Islam. Allah ordonne la justice même envers ceux qu\'on n\'aime pas : « Soyez justes, car la justice est plus proche de la piété. » La Zakat redistribue la richesse, le Waqf finance les biens publics, et le Prophète ﷺ a interdit toute discrimination. Son dernier sermon rappelle : « Aucun Arabe n\'est supérieur à un non-Arabe, sauf par la piété. »',
    reponseEn: 'Justice (\'Adl) is a fundamental pillar of Islam. Allah commands justice even toward those one dislikes: "Be just, for justice is closer to piety." Zakat redistributes wealth, Waqf finances public goods, and the Prophet ﷺ forbade all discrimination. His farewell sermon states: "No Arab is superior to a non-Arab except in piety."',
    source: 'Coran, Al-Ma\'ida 5:8 ; Sermon d\'adieu',
  ),
  QuestionDuJour(
    id: 'q10', emoji: '🕊️',
    questionFr: 'Qu\'est-ce que le Tawakkul ?',
    questionEn: 'What is Tawakkul?',
    reponseFr: 'Le Tawakkul est la confiance totale en Allah après avoir fait les efforts nécessaires. Ce n\'est pas la passivité, mais l\'action accompagnée de la certitude qu\'Allah est le meilleur des planificateurs. Le Prophète ﷺ a dit à l\'homme qui ne voulait pas attacher son chameau : « Attache-le, puis place ta confiance en Allah. » Le vrai Tawakkul combine l\'effort humain et la foi en la sagesse divine.',
    reponseEn: 'Tawakkul is total trust in Allah after having made the necessary efforts. It is not passivity, but action combined with the certainty that Allah is the best of planners. The Prophet ﷺ said to the man who did not want to tie his camel: "Tie it, then place your trust in Allah." True Tawakkul combines human effort and faith in divine wisdom.',
    source: 'Tirmidhi ; Coran, At-Talaq 65:3',
  ),
  QuestionDuJour(
    id: 'q11', emoji: '🧠',
    questionFr: 'Pourquoi l\'Islam encourage-t-il la science ?',
    questionEn: 'Why does Islam encourage science?',
    reponseFr: 'Le premier mot révélé du Coran est « Iqra » (Lis !). L\'Islam considère la recherche du savoir comme une obligation. Le Prophète ﷺ a dit : « La recherche du savoir est une obligation pour chaque musulman. » Le Coran invite constamment à observer, réfléchir et méditer sur la création. C\'est pourquoi la civilisation islamique a été pionnière en médecine, astronomie, mathématiques et chimie.',
    reponseEn: 'The first word revealed in the Quran is "Iqra" (Read!). Islam considers the pursuit of knowledge an obligation. The Prophet ﷺ said: "Seeking knowledge is an obligation upon every Muslim." The Quran constantly invites us to observe, reflect and contemplate creation. This is why Islamic civilisation was a pioneer in medicine, astronomy, mathematics and chemistry.',
    source: 'Coran, Al-Alaq 96:1 ; Ibn Majah',
  ),
  QuestionDuJour(
    id: 'q12', emoji: '💎',
    questionFr: 'Qu\'est-ce que l\'Ihsan ?',
    questionEn: 'What is Ihsan?',
    reponseFr: 'L\'Ihsan est le plus haut degré de la foi. Le Prophète ﷺ l\'a défini : « C\'est que tu adores Allah comme si tu Le voyais, car si tu ne Le vois pas, Lui te voit. » C\'est la quête de l\'excellence dans chaque acte d\'adoration et dans le comportement envers les gens. L\'Islam repose sur trois niveaux : l\'Islam (les actes), l\'Iman (la foi), et l\'Ihsan (l\'excellence spirituelle).',
    reponseEn: 'Ihsan is the highest level of faith. The Prophet ﷺ defined it: "It is to worship Allah as though you see Him, for even if you do not see Him, He sees you." It is the pursuit of excellence in every act of worship and in behaviour toward people. Islam rests on three levels: Islam (acts), Iman (faith), and Ihsan (spiritual excellence).',
    source: 'Hadith de Jibril — Muslim',
  ),
];

// ── Le Saviez-Vous ? ──────────────────────────────────────────────

class FaitMarquant {
  final String id;
  final String emoji;
  final String titreFr;
  final String titreEn;
  final String contenuFr;
  final String contenuEn;
  final String categorie; // 'science', 'histoire', 'coran', 'civilisation'

  const FaitMarquant({
    required this.id,
    required this.emoji,
    required this.titreFr,
    required this.titreEn,
    required this.contenuFr,
    required this.contenuEn,
    required this.categorie,
  });

  String get titre => AppLocale().isFrench ? titreFr : titreEn;
  String get contenu => AppLocale().isFrench ? contenuFr : contenuEn;
}

const kFaitsMarquants = <FaitMarquant>[
  FaitMarquant(id: 'f1', emoji: '🔬', categorie: 'science',
    titreFr: 'Le cycle de l\'eau dans le Coran',
    titreEn: 'The water cycle in the Quran',
    contenuFr: 'Le Coran décrit le cycle de l\'eau avec précision 1400 ans avant la science moderne : « N\'as-tu pas vu qu\'Allah fait descendre du ciel de l\'eau, puis Il l\'achemine vers des sources dans la terre ? » (Az-Zumar, 39:21). La description coranique inclut l\'évaporation, la condensation et les précipitations.',
    contenuEn: 'The Quran describes the water cycle with precision 1,400 years before modern science: "Have you not seen that Allah sends down water from the sky, then He causes it to travel through the earth as springs?" (Az-Zumar, 39:21). The Quranic description includes evaporation, condensation and precipitation.',
  ),
  FaitMarquant(id: 'f2', emoji: '👁️', categorie: 'civilisation',
    titreFr: 'Ibn al-Haytham, père de l\'optique',
    titreEn: 'Ibn al-Haytham, father of optics',
    contenuFr: 'Le savant musulman Ibn al-Haytham (965-1040) est considéré comme le père de l\'optique moderne. Son « Livre de l\'optique » a révolutionné la compréhension de la vision et de la lumière. Il a inventé la camera obscura et posé les bases de la méthode scientifique expérimentale, 600 ans avant Galilée.',
    contenuEn: 'Muslim scholar Ibn al-Haytham (965–1040) is considered the father of modern optics. His "Book of Optics" revolutionised the understanding of vision and light. He invented the camera obscura and laid the foundations of the experimental scientific method, 600 years before Galileo.',
  ),
  FaitMarquant(id: 'f3', emoji: '🏥', categorie: 'civilisation',
    titreFr: 'Les premiers hôpitaux',
    titreEn: 'The first hospitals',
    contenuFr: 'Les premiers hôpitaux modernes (Bimaristans) ont été fondés dans le monde musulman dès le 8e siècle. L\'hôpital Al-Mansur au Caire (1284) avait des départements spécialisés, des pharmacies, et soignait gratuitement tous les patients, quelle que soit leur religion ou leur statut social.',
    contenuEn: 'The first modern hospitals (Bimaristans) were founded in the Muslim world as early as the 8th century. Al-Mansur Hospital in Cairo (1284) had specialised departments, pharmacies, and treated all patients free of charge, regardless of their religion or social status.',
  ),
  FaitMarquant(id: 'f4', emoji: '🌍', categorie: 'science',
    titreFr: 'Les montagnes comme des piquets',
    titreEn: 'Mountains as pegs',
    contenuFr: 'Le Coran compare les montagnes à des piquets : « N\'avons-Nous pas fait de la terre une couche, et des montagnes des piquets ? » (An-Naba, 78:6-7). La géologie moderne a confirmé que les montagnes ont des racines profondes qui stabilisent la croûte terrestre, exactement comme des piquets.',
    contenuEn: 'The Quran compares mountains to pegs: "Have We not made the earth a resting place, and the mountains as pegs?" (An-Naba, 78:6–7). Modern geology has confirmed that mountains have deep roots that stabilise the earth\'s crust, exactly like pegs.',
  ),
  FaitMarquant(id: 'f5', emoji: '✈️', categorie: 'civilisation',
    titreFr: 'Abbas ibn Firnas et le vol',
    titreEn: 'Abbas ibn Firnas and flight',
    contenuFr: 'En 875, Abbas ibn Firnas, un inventeur andalou, a réalisé le premier vol plané de l\'histoire en se lançant depuis une colline de Cordoue avec des ailes fabriquées. Il a plané pendant plusieurs minutes avant d\'atterrir. C\'était 600 ans avant Léonard de Vinci et plus de 1000 ans avant les frères Wright.',
    contenuEn: 'In 875, Abbas ibn Firnas, an Andalusian inventor, achieved the first gliding flight in history by launching himself from a hill in Córdoba with crafted wings. He glided for several minutes before landing. This was 600 years before Leonardo da Vinci and over 1,000 years before the Wright brothers.',
  ),
  FaitMarquant(id: 'f6', emoji: '🔢', categorie: 'civilisation',
    titreFr: 'Al-Khwarizmi et l\'algèbre',
    titreEn: 'Al-Khwarizmi and algebra',
    contenuFr: 'Muhammad ibn Musa al-Khwarizmi (780-850) est le père de l\'algèbre. Le mot « algèbre » vient du titre de son livre « Al-Jabr ». Le mot « algorithme » vient de la latinisation de son nom. Ses travaux en mathématiques ont révolutionné la science et sont à la base de l\'informatique moderne.',
    contenuEn: 'Muhammad ibn Musa al-Khwarizmi (780–850) is the father of algebra. The word "algebra" comes from the title of his book "Al-Jabr." The word "algorithm" comes from the Latinisation of his name. His work in mathematics revolutionised science and forms the basis of modern computing.',
  ),
  FaitMarquant(id: 'f7', emoji: '🧬', categorie: 'science',
    titreFr: 'L\'embryologie dans le Coran',
    titreEn: 'Embryology in the Quran',
    contenuFr: 'Le Coran décrit les étapes du développement embryonnaire avec une précision remarquable : nutfa (goutte), alaqa (adhérence), mudgha (morceau mâché), puis os recouverts de chair. Le Professeur Keith Moore, éminent embryologiste, a reconnu que ces descriptions ne pouvaient pas provenir des connaissances humaines du 7e siècle.',
    contenuEn: 'The Quran describes the stages of embryonic development with remarkable precision: nutfa (drop), alaqa (clinging), mudgha (chewed lump), then bones covered with flesh. Professor Keith Moore, a renowned embryologist, acknowledged that these descriptions could not have come from human knowledge of the 7th century.',
  ),
  FaitMarquant(id: 'f8', emoji: '📚', categorie: 'histoire',
    titreFr: 'La Maison de la Sagesse',
    titreEn: 'The House of Wisdom',
    contenuFr: 'La Maison de la Sagesse (Bayt al-Hikma) fondée à Bagdad au 9e siècle était la plus grande bibliothèque et centre de traduction au monde. Des savants de toutes religions y traduisaient les œuvres grecques, persanes et indiennes en arabe, préservant et enrichissant le savoir antique pour les générations futures.',
    contenuEn: 'The House of Wisdom (Bayt al-Hikma) founded in Baghdad in the 9th century was the largest library and translation centre in the world. Scholars of all religions translated Greek, Persian and Indian works into Arabic, preserving and enriching ancient knowledge for future generations.',
  ),
  FaitMarquant(id: 'f9', emoji: '🌊', categorie: 'science',
    titreFr: 'La barrière entre les mers',
    titreEn: 'The barrier between seas',
    contenuFr: 'Le Coran mentionne une barrière invisible entre deux mers qui se rencontrent : « Il a donné libre cours aux deux mers pour se rencontrer ; il y a entre elles une barrière qu\'elles ne dépassent pas. » (Ar-Rahman, 55:19-20). L\'océanographie moderne a confirmé l\'existence de ces frontières de salinité entre les masses d\'eau.',
    contenuEn: 'The Quran mentions an invisible barrier between two seas that meet: "He released the two seas, meeting side by side; between them is a barrier they do not transgress." (Ar-Rahman, 55:19–20). Modern oceanography has confirmed the existence of these salinity boundaries between water masses.',
  ),
  FaitMarquant(id: 'f10', emoji: '🕌', categorie: 'histoire',
    titreFr: 'L\'Université Al-Qarawiyyin',
    titreEn: 'Al-Qarawiyyin University',
    contenuFr: 'Fondée en 859 par Fatima al-Fihri à Fès (Maroc), Al-Qarawiyyin est reconnue par l\'UNESCO comme la plus ancienne université encore en activité au monde. Elle a formé des érudits de toutes disciplines pendant plus de 1100 ans et a inspiré les universités européennes médiévales.',
    contenuEn: 'Founded in 859 by Fatima al-Fihri in Fez (Morocco), Al-Qarawiyyin is recognised by UNESCO as the oldest continuously operating university in the world. It has trained scholars across all disciplines for over 1,100 years and inspired medieval European universities.',
  ),
];

// ── Histoires des Prophètes ───────────────────────────────────────

class ProphetStory {
  final String id;
  final String nom;
  final String? nomEn;
  final String nomArabe;
  final String emoji;
  final String titreFr;
  final String titreEn;
  final String resumeFr;
  final String resumeEn;
  final List<String> leconsFr;
  final List<String> leconsEn;
  final String versetCleFr;
  final String versetCleEn;
  final String refVerset;

  const ProphetStory({
    required this.id,
    required this.nom,
    this.nomEn,
    required this.nomArabe,
    required this.emoji,
    required this.titreFr,
    required this.titreEn,
    required this.resumeFr,
    required this.resumeEn,
    required this.leconsFr,
    required this.leconsEn,
    required this.versetCleFr,
    required this.versetCleEn,
    required this.refVerset,
  });

  String get displayNom => AppLocale().isFrench ? nom : (nomEn ?? nom);
  String get titre => AppLocale().isFrench ? titreFr : titreEn;
  String get resume => AppLocale().isFrench ? resumeFr : resumeEn;
  List<String> get lecons => AppLocale().isFrench ? leconsFr : leconsEn;
  String get versetCle => AppLocale().isFrench ? versetCleFr : versetCleEn;
}

const kProphetStories = <ProphetStory>[
  ProphetStory(
    id: 'adam', nom: 'Adam', nomArabe: 'آدم', emoji: '🌿',
    titreFr: 'Le premier homme et prophète',
    titreEn: 'The first man and prophet',
    resumeFr: 'Allah a créé Adam de terre et lui a enseigné les noms de toutes choses. Les anges se sont prosternés devant lui sur ordre d\'Allah, sauf Iblis qui a refusé par orgueil. Adam et Hawwa (Ève) vivaient au Paradis mais ont désobéi en mangeant de l\'arbre interdit, influencés par Iblis. Ils se sont repentis sincèrement et Allah leur a pardonné, puis les a envoyés sur terre comme Ses représentants (khalifas).',
    resumeEn: 'Allah created Adam from clay and taught him the names of all things. The angels prostrated before him on Allah\'s command, except Iblis who refused out of pride. Adam and Hawwa (Eve) lived in Paradise but disobeyed by eating from the forbidden tree, influenced by Iblis. They repented sincerely and Allah forgave them, then sent them to earth as His representatives (khalifas).',
    leconsFr: [
      'Le repentir sincère efface les péchés — Allah est Le Tout-Pardonnant',
      'L\'orgueil est le premier péché (celui d\'Iblis)',
      'L\'être humain est honoré par Allah et a une mission sur terre',
      'Shaytan est un ennemi déclaré — il faut rester vigilant',
    ],
    leconsEn: ['Sincere repentance erases sins — Allah is The Most Forgiving', 'Pride is the first sin (that of Iblis)', 'Mankind is honoured by Allah and has a mission on earth', 'Shaytan is a declared enemy — one must remain vigilant'],
    versetCleFr: 'Quand ton Seigneur dit aux anges : Je vais établir un représentant sur la terre.',
    versetCleEn: 'When your Lord said to the angels: I am going to place a representative on the earth.',
    refVerset: 'Al-Baqara, 2:30',
  ),
  ProphetStory(
    id: 'nuh', nom: 'Nouh (Noé)', nomEn: 'Nuh (Noah)', nomArabe: 'نوح', emoji: '🚢',
    titreFr: 'Le prophète de la patience',
    titreEn: 'The prophet of patience',
    resumeFr: 'Nouh a prêché le monothéisme pendant 950 ans à un peuple obstiné dans l\'idolâtrie. Malgré les moqueries et le rejet, il n\'a jamais abandonné. Allah lui a ordonné de construire une arche, et le Déluge a englouti les mécréants. Même le fils de Nouh a refusé de monter à bord, montrant que la foi est un choix personnel, pas un héritage.',
    resumeEn: 'Nuh preached monotheism for 950 years to a people stubbornly attached to idol worship. Despite mockery and rejection, he never gave up. Allah commanded him to build an ark, and the Flood overwhelmed the disbelievers. Even Nuh\'s own son refused to board, showing that faith is a personal choice, not an inheritance.',
    leconsFr: [
      'La patience dans la prédication — 950 ans sans abandonner',
      'La foi ne se transmet pas par le sang mais par le choix',
      'Allah sauve les croyants même dans les pires épreuves',
      'L\'obstination dans le péché mène à la destruction',
    ],
    leconsEn: ['Patience in calling to Allah — 950 years without giving up', 'Faith is not inherited through blood but chosen personally', 'Allah saves believers even in the worst of trials', 'Persistence in sin leads to destruction'],
    versetCleFr: 'Noé invoqua son Seigneur : Je suis vaincu, secours-moi !',
    versetCleEn: 'Noah called upon his Lord: I am overcome, so help me!',
    refVerset: 'Al-Qamar, 54:10',
  ),
  ProphetStory(
    id: 'ibrahim', nom: 'Ibrahim (Abraham)', nomArabe: 'إبراهيم', emoji: '🔥',
    titreFr: 'L\'ami intime d\'Allah',
    titreEn: 'The intimate friend of Allah',
    resumeFr: 'Ibrahim a rejeté l\'idolâtrie de son peuple et de son père en utilisant la raison. Jeté dans un feu par le roi Nimrod, Allah l\'a protégé. Il a été éprouvé par l\'ordre de sacrifier son fils Ismaïl — tous deux se sont soumis à la volonté d\'Allah, qui les a récompensés. Ibrahim a construit la Ka\'ba avec Ismaïl et est l\'ancêtre commun des prophètes.',
    resumeEn: 'Ibrahim rejected the idolatry of his people and his father through reason. Thrown into a fire by King Nimrod, Allah protected him. He was tested by the command to sacrifice his son Ismail — both submitted to the will of Allah, who rewarded them. Ibrahim built the Ka\'ba with Ismail and is the common ancestor of the prophets.',
    leconsFr: [
      'La soumission totale à Allah (l\'Islam dans son essence)',
      'Utiliser la raison pour trouver la vérité',
      'Allah protège ceux qui Lui font confiance',
      'L\'épreuve d\'Allah est une élévation, pas une punition',
    ],
    leconsEn: ['Total submission to Allah (the essence of Islam)', 'Using reason to find the truth', 'Allah protects those who trust in Him', 'Allah\'s trial is an elevation, not a punishment'],
    versetCleFr: 'Quand son Seigneur lui dit : Soumets-toi ! Il dit : Je me soumets au Seigneur des mondes.',
    versetCleEn: 'When his Lord said to him: Submit! He said: I submit to the Lord of the worlds.',
    refVerset: 'Al-Baqara, 2:131',
  ),
  ProphetStory(
    id: 'yusuf', nom: 'Youssef (Joseph)', nomEn: 'Yusuf (Joseph)', nomArabe: 'يوسف', emoji: '🌟',
    titreFr: 'La plus belle des histoires',
    titreEn: 'The most beautiful of stories',
    resumeFr: 'Youssef, fils de Ya\'qub, a été jeté dans un puits par ses frères jaloux, vendu comme esclave en Égypte, accusé injustement et emprisonné. Malgré toutes ces épreuves, il est resté patient et fidèle à Allah. Il est devenu ministre d\'Égypte grâce à son don d\'interprétation des rêves et a pardonné à ses frères quand ils sont venus à lui.',
    resumeEn: 'Yusuf, son of Ya\'qub, was thrown into a well by his jealous brothers, sold into slavery in Egypt, falsely accused and imprisoned. Despite all these trials, he remained patient and faithful to Allah. He became minister of Egypt through his gift of interpreting dreams and forgave his brothers when they came to him.',
    leconsFr: [
      'La patience face à l\'injustice mène à l\'élévation',
      'La chasteté et l\'intégrité même dans la difficulté',
      'Le pardon est plus noble que la vengeance',
      'Allah a un plan même quand on ne le comprend pas',
    ],
    leconsEn: ['Patience in the face of injustice leads to elevation', 'Chastity and integrity even in hardship', 'Forgiveness is nobler than revenge', 'Allah has a plan even when we do not understand it'],
    versetCleFr: 'Certes, quiconque craint Allah et patiente... Allah ne fait pas perdre la récompense des bienfaisants.',
    versetCleEn: 'Indeed, whoever fears Allah and is patient... Allah does not allow to be lost the reward of those who do good.',
    refVerset: 'Yusuf, 12:90',
  ),
  ProphetStory(
    id: 'musa', nom: 'Moussa (Moïse)', nomEn: 'Musa (Moses)', nomArabe: 'موسى', emoji: '🌊',
    titreFr: 'Le prophète le plus cité dans le Coran',
    titreEn: 'The most mentioned prophet in the Quran',
    resumeFr: 'Moussa est le prophète le plus mentionné dans le Coran. Sauvé des eaux étant bébé, élevé dans le palais de Pharaon, il a fui en Madian où Allah lui a parlé au buisson ardent. Il est retourné en Égypte pour affronter Pharaon et libérer les Fils d\'Israël. Allah a fendu la mer pour le sauver et lui a donné la Torah au mont Sinaï.',
    resumeEn: 'Musa is the most mentioned prophet in the Quran. Saved from the waters as a baby and raised in Pharaoh\'s palace, he fled to Madyan where Allah spoke to him through a burning bush. He returned to Egypt to confront Pharaoh and liberate the Children of Israel. Allah parted the sea to save him and gave him the Torah on Mount Sinai.',
    leconsFr: [
      'Allah choisit Ses messagers selon Sa sagesse',
      'Le courage face à la tyrannie est un devoir',
      'Allah transforme la faiblesse en force',
      'La gratitude après la délivrance est essentielle',
    ],
    leconsEn: ['Allah chooses His messengers according to His wisdom', 'Courage in the face of tyranny is a duty', 'Allah transforms weakness into strength', 'Gratitude after deliverance is essential'],
    versetCleFr: 'Va vers Pharaon, car il a transgressé toute limite.',
    versetCleEn: 'Go to Pharaoh, for he has transgressed all bounds.',
    refVerset: 'Ta-Ha, 20:24',
  ),
  ProphetStory(
    id: 'issa', nom: 'Issa (Jésus)', nomEn: 'Isa (Jesus)', nomArabe: 'عيسى', emoji: '✨',
    titreFr: 'Le Messie, serviteur d\'Allah',
    titreEn: 'The Messiah, servant of Allah',
    resumeFr: 'Issa est né miraculeusement de Maryam (Marie) sans père, par la volonté d\'Allah. Il a accompli de nombreux miracles : guérir les aveugles et les lépreux, ressusciter les morts, avec la permission d\'Allah. Il a prêché le monothéisme pur et annoncé la venue du dernier prophète. Selon le Coran, il n\'a pas été crucifié mais élevé au ciel par Allah, et il reviendra à la fin des temps.',
    resumeEn: 'Issa was born miraculously from Maryam (Mary) without a father, by the will of Allah. He performed many miracles: healing the blind and lepers, raising the dead, with Allah\'s permission. He preached pure monotheism and announced the coming of the final prophet. According to the Quran, he was not crucified but was raised to heaven by Allah, and he will return at the end of times.',
    leconsFr: [
      'Les miracles viennent d\'Allah seul, pas des prophètes',
      'L\'humilité dans la servitude envers Allah',
      'La pureté de Maryam comme modèle pour les croyants',
      'Le monothéisme est le message de tous les prophètes',
    ],
    leconsEn: ['Miracles come from Allah alone, not from the prophets', 'Humility in servitude to Allah', 'The purity of Maryam as a model for believers', 'Monotheism is the message of all the prophets'],
    versetCleFr: 'Le Messie Issa fils de Maryam n\'est qu\'un messager d\'Allah, Sa parole qu\'Il envoya à Maryam, et un esprit venant de Lui.',
    versetCleEn: 'The Messiah Issa son of Maryam is only a messenger of Allah, His word which He directed to Maryam, and a soul from Him.',
    refVerset: 'An-Nisa, 4:171',
  ),
  ProphetStory(
    id: 'muhammad', nom: 'Muhammad ﷺ', nomArabe: 'محمد', emoji: '🕌',
    titreFr: 'Le sceau des prophètes',
    titreEn: 'The seal of the prophets',
    resumeFr: 'Muhammad ﷺ est né orphelin à La Mecque en 570. À 40 ans, il a reçu la première révélation du Coran par l\'ange Jibril. Persécuté pendant 13 ans à La Mecque, il a émigré à Médine (Hégire) où il a établi la première société islamique fondée sur la justice, la fraternité et la miséricorde. En 10 ans, il a unifié l\'Arabie et transmis le message final d\'Allah à l\'humanité entière.',
    resumeEn: 'Muhammad ﷺ was born an orphan in Mecca in 570. At the age of 40, he received the first revelation of the Quran from the angel Jibril. Persecuted for 13 years in Mecca, he emigrated to Medina (Hijra) where he established the first Islamic society founded on justice, brotherhood and mercy. Within 10 years, he united Arabia and conveyed Allah\'s final message to all of humanity.',
    leconsFr: [
      'La miséricorde est au cœur du message islamique',
      'La patience dans l\'épreuve mène au succès',
      'Le Prophète ﷺ est le modèle parfait de comportement',
      'L\'Islam est un message universel pour toute l\'humanité',
    ],
    leconsEn: ['Mercy is at the heart of the Islamic message', 'Patience in trial leads to success', 'The Prophet ﷺ is the perfect model of behaviour', 'Islam is a universal message for all humanity'],
    versetCleFr: 'Nous ne t\'avons envoyé qu\'en miséricorde pour les mondes.',
    versetCleEn: 'And We have not sent you except as a mercy to the worlds.',
    refVerset: 'Al-Anbiya, 21:107',
  ),
];

// ── Sagesses & Citations ──────────────────────────────────────────

class Sagesse {
  final String id;
  final String texteFr;
  final String texteEn;
  final String auteur;
  final String categorie; // 'patience', 'tawakkul', 'science', 'famille', 'repentir', 'amour'
  final String emoji;

  const Sagesse({
    required this.id,
    required this.texteFr,
    required this.texteEn,
    required this.auteur,
    required this.categorie,
    required this.emoji,
  });

  String get texte => AppLocale().isFrench ? texteFr : texteEn;
}

const kSagesses = <Sagesse>[
  // Patience
  Sagesse(id: 's1', emoji: '🏔️', categorie: 'patience',
    texteFr: 'La patience n\'est pas de supporter passivement, c\'est d\'accepter avec confiance que le plan d\'Allah est meilleur que le tien.',
    texteEn: 'Patience is not passive endurance; it is accepting with trust that Allah\'s plan is better than yours.',
    auteur: 'Ibn al-Qayyim'),
  Sagesse(id: 's2', emoji: '🌧️', categorie: 'patience',
    texteFr: 'Sois patient, car la pluie ne tombe pas sur une seule terre.',
    texteEn: 'Be patient, for rain does not fall on only one land.',
    auteur: 'Proverbe arabe'),
  Sagesse(id: 's3', emoji: '💪', categorie: 'patience',
    texteFr: 'Le vrai fort n\'est pas celui qui terrasse son adversaire, mais celui qui se maîtrise dans la colère.',
    texteEn: 'The truly strong person is not the one who defeats his opponent, but the one who controls himself in anger.',
    auteur: 'Prophète Muhammad ﷺ — Bukhari'),

  // Tawakkul
  Sagesse(id: 's4', emoji: '🕊️', categorie: 'tawakkul',
    texteFr: 'Si vous placiez votre confiance en Allah comme il se doit, Il vous nourrirait comme Il nourrit les oiseaux : ils partent le ventre vide et reviennent le ventre plein.',
    texteEn: 'If you were to truly rely on Allah as He deserves, He would provide for you as He provides for the birds: they leave hungry and return satisfied.',
    auteur: 'Prophète Muhammad ﷺ — Tirmidhi'),
  Sagesse(id: 's5', emoji: '🌅', categorie: 'tawakkul',
    texteFr: 'Quand Allah veut du bien pour quelqu\'un, Il lui ouvre la porte de l\'action et lui ferme la porte du débat.',
    texteEn: 'When Allah wants good for someone, He opens for them the door of action and closes the door of debate.',
    auteur: 'Hassan al-Basri'),
  Sagesse(id: 's6', emoji: '🌙', categorie: 'tawakkul',
    texteFr: 'Ne sois pas triste, ce que tu as perdu reviendra sous une autre forme.',
    texteEn: 'Do not be sad; what you have lost will return in another form.',
    auteur: 'Rumi'),

  // Science
  Sagesse(id: 's7', emoji: '📚', categorie: 'science',
    texteFr: 'Cherchez la science du berceau jusqu\'à la tombe.',
    texteEn: 'Seek knowledge from the cradle to the grave.',
    auteur: 'Proverbe islamique'),
  Sagesse(id: 's8', emoji: '🕯️', categorie: 'science',
    texteFr: 'L\'encre du savant est plus sacrée que le sang du martyr.',
    texteEn: 'The ink of a scholar is more sacred than the blood of a martyr.',
    auteur: 'Attribué au Prophète ﷺ'),
  Sagesse(id: 's9', emoji: '🧠', categorie: 'science',
    texteFr: 'Celui qui ne goûte pas l\'amertume de l\'apprentissage pendant un moment, goûtera l\'humiliation de l\'ignorance toute sa vie.',
    texteEn: 'Whoever does not taste the bitterness of learning for a while will taste the humiliation of ignorance all his life.',
    auteur: 'Imam Ash-Shafi\'i'),

  // Famille
  Sagesse(id: 's10', emoji: '👨‍👩‍👧', categorie: 'famille',
    texteFr: 'Le meilleur d\'entre vous est celui qui est le meilleur envers sa famille, et je suis le meilleur d\'entre vous envers ma famille.',
    texteEn: 'The best of you are those who are best to their families, and I am the best of you to my family.',
    auteur: 'Prophète Muhammad ﷺ — Tirmidhi'),
  Sagesse(id: 's11', emoji: '💞', categorie: 'famille',
    texteFr: 'Et parmi Ses signes, Il a créé pour vous des épouses issues de vous-mêmes pour que vous trouviez la quiétude auprès d\'elles.',
    texteEn: 'And of His signs is that He created for you from yourselves mates that you may find tranquility in them.',
    auteur: 'Coran, Ar-Rum 30:21'),

  // Repentir
  Sagesse(id: 's12', emoji: '🌱', categorie: 'repentir',
    texteFr: 'Ô fils d\'Adam, tant que tu M\'invoques et que tu espères en Moi, Je te pardonne quoi que tu aies fait, et cela ne Me pèse pas.',
    texteEn: 'O son of Adam, as long as you call upon Me and hope in Me, I will forgive you for what you have done, and I do not mind.',
    auteur: 'Hadith Qudsi — Tirmidhi'),
  Sagesse(id: 's13', emoji: '🌊', categorie: 'repentir',
    texteFr: 'Allah se réjouit du repentir de Son serviteur plus que celui qui retrouve son chameau perdu dans le désert.',
    texteEn: 'Allah rejoices more at the repentance of His servant than a person who finds his lost camel in the desert.',
    auteur: 'Prophète Muhammad ﷺ — Muslim'),
  Sagesse(id: 's14', emoji: '🔄', categorie: 'repentir',
    texteFr: 'Chaque fils d\'Adam commet des erreurs, et les meilleurs parmi ceux qui commettent des erreurs sont ceux qui se repentent.',
    texteEn: 'Every son of Adam commits mistakes, and the best of those who make mistakes are those who repent.',
    auteur: 'Prophète Muhammad ﷺ — Tirmidhi'),

  // Amour d\'Allah
  Sagesse(id: 's15', emoji: '💚', categorie: 'amour',
    texteFr: 'Dans le cœur, il y a un vide qui ne peut être comblé que par l\'amour d\'Allah, le fait de se tourner vers Lui et de Le mentionner constamment.',
    texteEn: 'In the heart there is a void that cannot be filled except by the love of Allah, turning to Him and constantly remembering Him.',
    auteur: 'Ibn al-Qayyim'),
  Sagesse(id: 's16', emoji: '🌺', categorie: 'amour',
    texteFr: 'Allah est beau et Il aime la beauté.',
    texteEn: 'Allah is beautiful and He loves beauty.',
    auteur: 'Prophète Muhammad ﷺ — Muslim'),
];

// ── Quiz Islamique ────────────────────────────────────────────────

class QuizQuestion {
  final String id;
  final String questionFr;
  final String questionEn;
  final List<String> optionsFr;
  final List<String> optionsEn;
  final int correctIndex;
  final String explicationFr;
  final String explicationEn;
  final String categorie; // 'coran', 'sira', 'piliers', 'prophetes', 'general'

  const QuizQuestion({
    required this.id,
    required this.questionFr,
    required this.questionEn,
    required this.optionsFr,
    required this.optionsEn,
    required this.correctIndex,
    required this.explicationFr,
    required this.explicationEn,
    required this.categorie,
  });

  String get question => AppLocale().isFrench ? questionFr : questionEn;
  List<String> get options => AppLocale().isFrench ? optionsFr : optionsEn;
  String get explication => AppLocale().isFrench ? explicationFr : explicationEn;
}

const kQuizQuestions = <QuizQuestion>[
  QuizQuestion(id: 'qz1', categorie: 'piliers',
    questionFr: 'Combien de piliers comporte l\'Islam ?',
    questionEn: 'How many pillars does Islam have?',
    optionsFr: ['3', '4', '5', '6'],
    optionsEn: ['3', '4', '5', '6'],
    correctIndex: 2,
    explicationFr: 'Les 5 piliers sont : la Shahada, la Salat, la Zakat, le Siyam (jeûne de Ramadan) et le Hajj (pèlerinage).',
    explicationEn: 'The 5 pillars are: the Shahada, Salat, Zakat, Siyam (Ramadan fasting) and Hajj (pilgrimage).'),
  QuizQuestion(id: 'qz2', categorie: 'coran',
    questionFr: 'Quel est le premier mot révélé du Coran ?',
    questionEn: 'What is the first word revealed in the Quran?',
    optionsFr: ['Bismillah', 'Alhamdulillah', 'Iqra (Lis)', 'Qul (Dis)'],
    optionsEn: ['Bismillah', 'Alhamdulillah', 'Iqra (Read)', 'Qul (Say)'],
    correctIndex: 2,
    explicationFr: 'Le premier mot révélé est « Iqra » (Lis !), sourate Al-Alaq, révélée dans la grotte de Hira.',
    explicationEn: 'The first revealed word is "Iqra" (Read!), from Surah Al-Alaq, revealed in the cave of Hira.'),
  QuizQuestion(id: 'qz3', categorie: 'coran',
    questionFr: 'Combien de sourates contient le Coran ?',
    questionEn: 'How many surahs does the Quran contain?',
    optionsFr: ['100', '114', '120', '124'],
    optionsEn: ['100', '114', '120', '124'],
    correctIndex: 1,
    explicationFr: 'Le Coran contient 114 sourates, de Al-Fatiha à An-Nas.',
    explicationEn: 'The Quran contains 114 surahs, from Al-Fatiha to An-Nas.'),
  QuizQuestion(id: 'qz4', categorie: 'sira',
    questionFr: 'Dans quelle grotte le Prophète ﷺ a-t-il reçu la première révélation ?',
    questionEn: 'In which cave did the Prophet ﷺ receive the first revelation?',
    optionsFr: ['Grotte de Thawr', 'Grotte de Hira', 'Grotte de Kahf', 'Grotte de Uhud'],
    optionsEn: ['Cave of Thawr', 'Cave of Hira', 'Cave of the Kahf', 'Cave of Uhud'],
    correctIndex: 1,
    explicationFr: 'La première révélation a eu lieu dans la grotte de Hira, sur le mont An-Nur, près de La Mecque.',
    explicationEn: 'The first revelation took place in the cave of Hira, on Mount An-Nur, near Mecca.'),
  QuizQuestion(id: 'qz5', categorie: 'prophetes',
    questionFr: 'Quel prophète a construit la Ka\'ba avec son fils ?',
    questionEn: 'Which prophet built the Ka\'ba with his son?',
    optionsFr: ['Adam', 'Nouh', 'Ibrahim', 'Muhammad ﷺ'],
    optionsEn: ['Adam', 'Nuh', 'Ibrahim', 'Muhammad ﷺ'],
    correctIndex: 2,
    explicationFr: 'Ibrahim (Abraham) et son fils Ismaïl ont construit (ou reconstruit) la Ka\'ba sur ordre d\'Allah.',
    explicationEn: 'Ibrahim (Abraham) and his son Ismail built (or rebuilt) the Ka\'ba on Allah\'s command.'),
  QuizQuestion(id: 'qz6', categorie: 'coran',
    questionFr: 'Quelle sourate est appelée « le cœur du Coran » ?',
    questionEn: 'Which surah is called "the heart of the Quran"?',
    optionsFr: ['Al-Baqara', 'Ya-Sin', 'Al-Rahman', 'Al-Mulk'],
    optionsEn: ['Al-Baqara', 'Ya-Sin', 'Al-Rahman', 'Al-Mulk'],
    correctIndex: 1,
    explicationFr: 'La sourate Ya-Sin est appelée « le cœur du Coran » par le Prophète ﷺ.',
    explicationEn: 'Surah Ya-Sin is called "the heart of the Quran" by the Prophet ﷺ.'),
  QuizQuestion(id: 'qz7', categorie: 'sira',
    questionFr: 'En quelle année a eu lieu l\'Hégire ?',
    questionEn: 'In which year did the Hijra take place?',
    optionsFr: ['610', '620', '622', '632'],
    optionsEn: ['610', '620', '622', '632'],
    correctIndex: 2,
    explicationFr: 'L\'Hégire (émigration de La Mecque à Médine) a eu lieu en 622 après J.-C. et marque le début du calendrier islamique.',
    explicationEn: 'The Hijra (migration from Mecca to Medina) took place in 622 CE and marks the beginning of the Islamic calendar.'),
  QuizQuestion(id: 'qz8', categorie: 'piliers',
    questionFr: 'Combien de prières obligatoires y a-t-il par jour ?',
    questionEn: 'How many obligatory prayers are there per day?',
    optionsFr: ['3', '4', '5', '7'],
    optionsEn: ['3', '4', '5', '7'],
    correctIndex: 2,
    explicationFr: 'Les 5 prières sont : Fajr, Dhuhr, Asr, Maghrib et Isha.',
    explicationEn: 'The 5 prayers are: Fajr, Dhuhr, Asr, Maghrib and Isha.'),
  QuizQuestion(id: 'qz9', categorie: 'prophetes',
    questionFr: 'Quel prophète est le plus mentionné dans le Coran ?',
    questionEn: 'Which prophet is mentioned most in the Quran?',
    optionsFr: ['Ibrahim', 'Issa', 'Moussa', 'Muhammad ﷺ'],
    optionsEn: ['Ibrahim', 'Issa', 'Musa', 'Muhammad ﷺ'],
    correctIndex: 2,
    explicationFr: 'Moussa (Moïse) est mentionné 136 fois dans le Coran, plus que tout autre prophète.',
    explicationEn: 'Musa (Moses) is mentioned 136 times in the Quran, more than any other prophet.'),
  QuizQuestion(id: 'qz10', categorie: 'general',
    questionFr: 'Quel ange est chargé de transmettre la révélation ?',
    questionEn: 'Which angel is responsible for conveying revelation?',
    optionsFr: ['Mikail', 'Israfil', 'Jibril', 'Azraïl'],
    optionsEn: ['Mikail', 'Israfil', 'Jibril', 'Azrail'],
    correctIndex: 2,
    explicationFr: 'Jibril (Gabriel) est l\'ange chargé de transmettre la révélation d\'Allah aux prophètes.',
    explicationEn: 'Jibril (Gabriel) is the angel responsible for conveying Allah\'s revelation to the prophets.'),
  QuizQuestion(id: 'qz11', categorie: 'coran',
    questionFr: 'Quel verset est le plus important du Coran selon le Prophète ﷺ ?',
    questionEn: 'Which verse is the most important in the Quran according to the Prophet ﷺ?',
    optionsFr: ['Al-Fatiha, v.1', 'Ayat al-Kursi (Al-Baqara, v.255)', 'Al-Ikhlas', 'Al-Falaq'],
    optionsEn: ['Al-Fatiha, v.1', 'Ayat al-Kursi (Al-Baqara, v.255)', 'Al-Ikhlas', 'Al-Falaq'],
    correctIndex: 1,
    explicationFr: 'Ayat al-Kursi (le Verset du Trône, Al-Baqara 2:255) est le plus grandiose verset du Coran selon le Prophète ﷺ.',
    explicationEn: 'Ayat al-Kursi (the Throne Verse, Al-Baqara 2:255) is the most magnificent verse of the Quran according to the Prophet ﷺ.'),
  QuizQuestion(id: 'qz12', categorie: 'general',
    questionFr: 'Combien de Noms Sublimes (Al-Asma al-Husna) Allah a-t-Il ?',
    questionEn: 'How many Sublime Names (Al-Asma al-Husna) does Allah have?',
    optionsFr: ['33', '66', '99', '100'],
    optionsEn: ['33', '66', '99', '100'],
    correctIndex: 2,
    explicationFr: 'Allah a 99 Noms Sublimes. Le Prophète ﷺ a dit : « Quiconque les apprend par cœur entrera au Paradis. »',
    explicationEn: 'Allah has 99 Sublime Names. The Prophet ﷺ said: "Whoever learns them by heart will enter Paradise."'),
  QuizQuestion(id: 'qz13', categorie: 'prophetes',
    questionFr: 'Quel prophète a été jeté dans un puits par ses frères ?',
    questionEn: 'Which prophet was thrown into a well by his brothers?',
    optionsFr: ['Ismaïl', 'Youssef', 'Shu\'ayb', 'Dawud'],
    optionsEn: ['Ismail', 'Yusuf', 'Shu\'ayb', 'Dawud'],
    correctIndex: 1,
    explicationFr: 'Youssef (Joseph) a été jeté dans un puits par ses frères jaloux, puis vendu comme esclave en Égypte.',
    explicationEn: 'Yusuf (Joseph) was thrown into a well by his jealous brothers, then sold into slavery in Egypt.'),
  QuizQuestion(id: 'qz14', categorie: 'sira',
    questionFr: 'Comment s\'appelle la première épouse du Prophète ﷺ ?',
    questionEn: 'What is the name of the Prophet\'s ﷺ first wife?',
    optionsFr: ['Aïcha', 'Khadija', 'Hafsa', 'Fatima'],
    optionsEn: ['Aisha', 'Khadija', 'Hafsa', 'Fatima'],
    correctIndex: 1,
    explicationFr: 'Khadija bint Khuwaylid fut la première épouse du Prophète ﷺ et la première personne à embrasser l\'Islam.',
    explicationEn: 'Khadija bint Khuwaylid was the first wife of the Prophet ﷺ and the first person to embrace Islam.'),
  QuizQuestion(id: 'qz15', categorie: 'piliers',
    questionFr: 'Pendant quel mois le jeûne est-il obligatoire ?',
    questionEn: 'During which month is fasting obligatory?',
    optionsFr: ['Sha\'ban', 'Rajab', 'Ramadan', 'Dhul Hijja'],
    optionsEn: ['Sha\'ban', 'Rajab', 'Ramadan', 'Dhul Hijja'],
    correctIndex: 2,
    explicationFr: 'Le jeûne est obligatoire pendant le mois de Ramadan, le 9e mois du calendrier islamique.',
    explicationEn: 'Fasting is obligatory during the month of Ramadan, the 9th month of the Islamic calendar.'),
];

// ── Catégories de sagesses pour filtrage ──────────────────────────

// Bilingual categories - translate in screen based on AppLocale
const kSagesseCategories = <String, String>{
  'all': 'Toutes / All',
  'patience': '🏔️ Patience / Patience',
  'tawakkul': '🕊️ Tawakkul / Tawakkul',
  'science': '📚 Science / Science',
  'famille': '👨‍👩‍👧 Famille / Family',
  'repentir': '🌱 Repentir / Repentance',
  'amour': '💚 Amour d\'Allah / Love of Allah',
};

const kQuizCategories = <String, String>{
  'all': 'Toutes / All',
  'coran': '📖 Coran / Quran',
  'sira': '🕌 Sira / Sira',
  'piliers': '🕋 Piliers / Pillars',
  'prophetes': '🌟 Prophètes / Prophets',
  'general': '💎 Général / General',
};
