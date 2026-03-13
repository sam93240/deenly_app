// protection_data.dart — Section "Comprendre" du module Protection
// Articles éducatifs sur le monde invisible en Islam

class ProtectionArticle {
  final String id;
  final String title;
  final String emoji;
  final String subtitle;
  final List<ProtectionSection> sections;
  const ProtectionArticle({
    required this.id,
    required this.title,
    required this.emoji,
    required this.subtitle,
    required this.sections,
  });
}

class ProtectionSection {
  final String heading;
  final String body;
  const ProtectionSection({required this.heading, required this.body});
}

const kProtectionArticles = <ProtectionArticle>[
  // ═══════════════════════════════════════════════════════════════════════
  // 1 — LES JINN
  // ═══════════════════════════════════════════════════════════════════════
  ProtectionArticle(
    id: 'jinn',
    title: 'Les Jinn',
    emoji: '\uD83D\uDD25',
    subtitle: 'Cr\u00e9atures du monde invisible',
    sections: [
      ProtectionSection(
        heading: 'Qu\'est-ce qu\'un jinn ?',
        body: 'Les jinn sont des cr\u00e9atures cr\u00e9\u00e9es par Allah \u00e0 partir d\'un feu sans fum\u00e9e (m\u00e2rij min n\u00e2r). Allah dit dans le Coran : \u00ab Et les jinn, Nous les avons cr\u00e9\u00e9s auparavant d\'un feu d\'une chaleur ardente \u00bb (Al-Hijr, 15:27). Ils existent en parall\u00e8le des humains, dans un monde invisible \u00e0 nos yeux. Comme nous, ils ont \u00e9t\u00e9 cr\u00e9\u00e9s pour adorer Allah : \u00ab Je n\'ai cr\u00e9\u00e9 les jinn et les humains que pour qu\'ils M\'adorent \u00bb (Adh-Dhariyat, 51:56).',
      ),
      ProtectionSection(
        heading: 'Leurs capacit\u00e9s et limites',
        body: 'Les jinn peuvent nous voir sans que nous les voyions. Ils peuvent se d\u00e9placer tr\u00e8s rapidement, prendre diff\u00e9rentes formes (animaux, humains), et vivent bien plus longtemps que nous. Cependant, ils ont des limites claires : ils ne connaissent pas l\'invisible (al-ghayb), ils ne peuvent pas cr\u00e9er ni donner la vie, ils ne peuvent pas changer le destin (qadr) d\'une personne, et ils sont soumis \u00e0 Allah comme toute cr\u00e9ature. Le Proph\u00e8te \u00a7 a dit que les jinn mangent, boivent, se marient et ont des enfants, comme les humains.',
      ),
      ProtectionSection(
        heading: 'Types de jinn',
        body: 'Parmi les jinn, il y a des croyants (musulmans) et des m\u00e9cr\u00e9ants. Sourate Al-Jinn rapporte que certains jinn ont dit : \u00ab Il y a parmi nous des vertueux et d\'autres qui le sont moins ; nous \u00e9tions r\u00e9partis en voies diff\u00e9rentes \u00bb (72:11). Les jinn m\u00e9cr\u00e9ants sont appel\u00e9s shayatin (d\u00e9mons). Iblis (Satan) est un jinn qui a refus\u00e9 de se prosterner devant Adam par orgueil. Parmi les jinn il y a aussi les \u2018Ifrit (puissants et rebelles), les Marid (tr\u00e8s puissants), et les Qareen \u2014 un jinn compagnon assign\u00e9 \u00e0 chaque \u00eatre humain.',
      ),
      ProtectionSection(
        heading: 'Le Qareen : votre compagnon invisible',
        body: 'Chaque \u00eatre humain a un qareen, un jinn qui l\'accompagne toute sa vie. Le Proph\u00e8te \u00a7 a dit : \u00ab Il n\'y a aucun d\'entre vous qui n\'ait un compagnon parmi les jinn. \u00bb Les Compagnons ont demand\u00e9 : \u00ab M\u00eame toi, \u00f4 Messager d\'Allah ? \u00bb Il a r\u00e9pondu : \u00ab M\u00eame moi, sauf qu\'Allah m\'a aid\u00e9 contre lui et il est devenu musulman. \u00bb (Muslim). Le qareen essaye de pousser la personne vers le mal, les d\u00e9sirs et les p\u00e9ch\u00e9s. C\'est pourquoi le dhikr quotidien et la pri\u00e8re sont si importants pour se prot\u00e9ger de son influence.',
      ),
      ProtectionSection(
        heading: 'Comment se prot\u00e9ger des jinn',
        body: 'La meilleure protection contre les jinn est le rappel d\'Allah (dhikr). Les adhkar du matin et du soir cr\u00e9ent une barri\u00e8re de protection. Ayat al-Kursi r\u00e9cit\u00e9 avant de dormir est une protection jusqu\'au matin. Dire \u00ab Bismillah \u00bb en entrant chez soi emp\u00eache les shayatin d\'entrer. La r\u00e9citation des sourates Al-Baqara, Al-Falaq et An-Nas est particuli\u00e8rement puissante. Le Proph\u00e8te \u00a7 a dit : \u00ab Ne faites pas de vos maisons des tombeaux. Le Shaytan fuit la maison o\u00f9 l\'on r\u00e9cite Sourate Al-Baqara \u00bb (Muslim).',
      ),
    ],
  ),

  // ═══════════════════════════════════════════════════════════════════════
  // 2 — LA SORCELLERIE (SIHR)
  // ═══════════════════════════════════════════════════════════════════════
  ProtectionArticle(
    id: 'sihr',
    title: 'La Sorcellerie (Sihr)',
    emoji: '\u26A0\uFE0F',
    subtitle: 'R\u00e9alit\u00e9, danger et gu\u00e9rison',
    sections: [
      ProtectionSection(
        heading: 'La r\u00e9alit\u00e9 du sihr en Islam',
        body: 'La sorcellerie (sihr) est une r\u00e9alit\u00e9 confirm\u00e9e par le Coran et la Sunna. Allah dit : \u00ab Et ils suivirent ce que les d\u00e9mons racont\u00e8rent sur le r\u00e8gne de Salomon. Salomon n\'\u00e9tait pas m\u00e9cr\u00e9ant mais les d\u00e9mons l\'\u00e9taient, enseignant aux gens la magie \u00bb (Al-Baqara, 2:102). Le sihr fonctionne par l\'interm\u00e9diaire des shayatin (d\u00e9mons) : le sorcier fait des actes de m\u00e9cr\u00e9ance pour obtenir l\'aide d\'un jinn qui va ensuite nuire \u00e0 la victime. C\'est un pacte entre le sorcier et les d\u00e9mons.',
      ),
      ProtectionSection(
        heading: 'Le jugement du sihr en Islam',
        body: 'La pratique de la sorcellerie est un p\u00e9ch\u00e9 majeur, un acte de m\u00e9cr\u00e9ance (kufr). Le Proph\u00e8te \u00a7 a dit : \u00ab \u00c9vitez les sept p\u00e9ch\u00e9s destructeurs \u00bb et il a mentionn\u00e9 parmi eux la sorcellerie (Bukhari et Muslim). Le sorcier renie Allah en faisant des rituels qui impliquent la profanation du Coran, le sacrifice pour les d\u00e9mons, ou l\'\u00e9criture de talismans avec des invocations \u00e0 d\'autres qu\'Allah. Aller voir un sorcier est aussi interdit : \u00ab Celui qui va voir un voyant et le questionne, sa pri\u00e8re n\'est pas accept\u00e9e pendant 40 jours \u00bb (Muslim).',
      ),
      ProtectionSection(
        heading: 'Les types de sorcellerie',
        body: 'Les savants mentionnent plusieurs types de sihr : le sihr de s\u00e9paration (tafr\u00eeq) qui vise \u00e0 s\u00e9parer un couple \u2014 c\'est le plus r\u00e9pandu et le plus aim\u00e9 d\'Iblis. Le Proph\u00e8te \u00a7 a inform\u00e9 qu\'Iblis envoie ses soldats tenter les gens et celui qui revient en disant \u00ab j\'ai s\u00e9par\u00e9 un homme de sa femme \u00bb re\u00e7oit la plus haute r\u00e9compense de Satan (Muslim). Il y a aussi le sihr de blocage (rabs) qui bloque le travail, le mariage ou les \u00e9tudes ; le sihr de maladie qui provoque des douleurs sans cause m\u00e9dicale ; le sihr d\'amour (taw\u00e2lah) qui force l\'attachement ; et le sihr de folie qui trouble la raison.',
      ),
      ProtectionSection(
        heading: 'Les signes possibles de sihr',
        body: 'Attention : ces signes ne signifient pas forc\u00e9ment qu\'il y a du sihr. Il faut d\'abord \u00e9liminer les causes naturelles et m\u00e9dicales. Parmi les signes \u00e9voqu\u00e9s par les savants : des blocages r\u00e9p\u00e9t\u00e9s et inexplicables (travail, mariage), un changement soudain de sentiments envers le conjoint sans raison, des cauchemars r\u00e9currents (serpents, chiens, chutes), des douleurs chroniques sans diagnostic m\u00e9dical, une aversion soudaine pour la pri\u00e8re et le Coran, une angoisse permanente et inexplicable. Le diagnostic doit \u00eatre fait par un raqi (exorciste) comp\u00e9tent qui utilise uniquement le Coran et les invocations proph\u00e9tiques.',
      ),
      ProtectionSection(
        heading: 'La gu\u00e9rison du sihr',
        body: 'La gu\u00e9rison du sihr passe exclusivement par le Coran et les invocations proph\u00e9tiques \u2014 jamais par un autre sorcier. Allah dit : \u00ab Nous faisons descendre du Coran ce qui est une gu\u00e9rison et une mis\u00e9ricorde pour les croyants \u00bb (Al-Isra, 17:82). Les \u00e9tapes sont : la roqya (r\u00e9citation de versets sp\u00e9cifiques), les du\'as de protection, la consommation d\'eau coranis\u00e9e (eau sur laquelle on a r\u00e9cit\u00e9 le Coran), le bain avec eau de sidr (jujubier), et la pers\u00e9v\u00e9rance dans les adhkar quotidiens. La confiance absolue en Allah est la cl\u00e9 : \u00ab Et si Allah te touche d\'un mal, nul ne peut l\'\u00f4ter en dehors de Lui \u00bb (Al-An\'am, 6:17).',
      ),
    ],
  ),

  // ═══════════════════════════════════════════════════════════════════════
  // 3 — LE MAUVAIS OEIL (AL-'AYN)
  // ═══════════════════════════════════════════════════════════════════════
  ProtectionArticle(
    id: 'ayn',
    title: 'Le Mauvais \u0152il (Al-\'Ayn)',
    emoji: '\uD83D\uDC41\uFE0F',
    subtitle: 'R\u00e9alit\u00e9 confirm\u00e9e par le Proph\u00e8te \u00a7',
    sections: [
      ProtectionSection(
        heading: 'La r\u00e9alit\u00e9 du mauvais oeil',
        body: 'Le mauvais oeil (al-\'ayn) est une r\u00e9alit\u00e9 confirm\u00e9e par le Proph\u00e8te \u00a7 qui a dit : \u00ab Le mauvais oeil est une v\u00e9rit\u00e9. S\'il y avait une chose qui pouvait pr\u00e9c\u00e9der le destin, ce serait le mauvais oeil \u00bb (Muslim). Il a aussi dit : \u00ab Le mauvais oeil fait entrer l\'homme dans la tombe et le chameau dans la marmite \u00bb (rapport\u00e9 par Abu Nu\'aym). Le mauvais oeil se produit quand une personne regarde quelque chose ou quelqu\'un avec admiration, envie ou jalousie sans mentionner le nom d\'Allah (dire MashaAllah, Allahumma Barik).',
      ),
      ProtectionSection(
        heading: 'Comment le mauvais oeil fonctionne',
        body: 'Le mauvais oeil n\'est pas de la superstition. C\'est un m\u00e9canisme r\u00e9el o\u00f9 l\'\u00e2me humaine, charg\u00e9e d\'envie ou d\'admiration excessive, \u00e9met une \u00e9nergie n\u00e9gative qui atteint la personne vis\u00e9e par la permission d\'Allah. Attention : une personne peut se donner le mauvais oeil \u00e0 elle-m\u00eame ou \u00e0 ses propres enfants ! Le Proph\u00e8te \u00a7 a ordonn\u00e9 \u00e0 celui qui voit quelque chose qui lui pla\u00eet de dire \u00ab Allahumma Barik \u00bb (qu\'Allah b\u00e9nisse) ou \u00ab MashaAllah la quwwata illa billah \u00bb. C\'est la raison pour laquelle on doit toujours mentionner Allah quand on admire quelque chose.',
      ),
      ProtectionSection(
        heading: 'Les signes possibles du mauvais oeil',
        body: 'L\u00e0 encore, il faut \u00eatre prudent et ne pas attribuer tout mal au mauvais oeil. Parmi les signes mentionn\u00e9s : une fatigue soudaine et inexplicable, une perte d\'app\u00e9tit ou de poids sans raison m\u00e9dicale, des maux de t\u00eate r\u00e9currents apr\u00e8s un \u00e9v\u00e9nement o\u00f9 on a \u00e9t\u00e9 compliment\u00e9 ou regard\u00e9, un teint qui change (p\u00e2leur), un enfant qui \u00e9tait en pleine sant\u00e9 et qui tombe soudainement malade apr\u00e8s une visite, un commerce qui fonctionnait et qui s\'effondre soudainement. Le diagnostic se fait par la roqya.',
      ),
      ProtectionSection(
        heading: 'Pr\u00e9vention et gu\u00e9rison',
        body: 'La pr\u00e9vention passe par les adhkar quotidiens du matin et du soir, la r\u00e9citation des Mu\'awwidhat (sourates Al-Falaq et An-Nas), et le fait de toujours dire \u00ab MashaAllah \u00bb ou \u00ab Allahumma Barik \u00bb quand on voit quelque chose de beau. Pour la gu\u00e9rison, le Proph\u00e8te \u00a7 a prescrit le ghusl (lavage) : si on conna\u00eet la personne qui a donn\u00e9 le oeil, on lui demande de faire ses ablutions et l\'eau est vers\u00e9e sur la victime. Sinon, la roqya avec les versets de protection et l\'eau coranis\u00e9e est le traitement. Le Proph\u00e8te \u00a7 pratiquait la roqya sur lui-m\u00eame chaque soir.',
      ),
    ],
  ),

  // ═══════════════════════════════════════════════════════════════════════
  // 4 — LE WASWAS
  // ═══════════════════════════════════════════════════════════════════════
  ProtectionArticle(
    id: 'waswas',
    title: 'Le Waswas',
    emoji: '\uD83D\uDDE3\uFE0F',
    subtitle: 'Les chuchotements de Shaytan',
    sections: [
      ProtectionSection(
        heading: 'Qu\'est-ce que le waswas ?',
        body: 'Le waswas (chuchotement) est l\'arme principale de Shaytan. Allah dit : \u00ab [Je cherche refuge] contre le mal du chuchoteur furtif, qui chuchote dans les poitrines des gens \u00bb (An-Nas, 114:4-5). Le waswas est une pens\u00e9e n\u00e9gative, un doute ou une suggestion mauvaise que Shaytan injecte dans le coeur et l\'esprit de l\'homme. Il peut concerner la foi (doutes sur Allah, sur l\'Islam), la pri\u00e8re (ai-je bien fait 3 ou 4 rak\'at ?), les relations (m\u00e9fiance envers le conjoint), ou pousser vers le p\u00e9ch\u00e9.',
      ),
      ProtectionSection(
        heading: 'Les strat\u00e9gies de Shaytan',
        body: 'Shaytan est un strat\u00e8ge patient. Il ne commence jamais par le p\u00e9ch\u00e9 majeur mais proc\u00e8de par \u00e9tapes : d\'abord la n\u00e9gligence (retarder la pri\u00e8re), puis le petit p\u00e9ch\u00e9, puis le grand p\u00e9ch\u00e9. Ibn al-Qayyim a d\u00e9crit ses niveaux d\'attaque : 1) la m\u00e9cr\u00e9ance et le shirk, 2) l\'innovation religieuse (bid\'a), 3) les grands p\u00e9ch\u00e9s, 4) les petits p\u00e9ch\u00e9s, 5) occuper la personne par le licite pour qu\'elle n\u00e9glige le m\u00e9ritoire, 6) l\'occuper par le m\u00e9ritoire inf\u00e9rieur pour qu\'elle n\u00e9glige le sup\u00e9rieur. Si aucun de ces niveaux ne marche, il envoie ses soldats pour la tourmenter.',
      ),
      ProtectionSection(
        heading: 'Shaytan et le couple',
        body: 'L\'une des cibles pr\u00e9f\u00e9r\u00e9es de Shaytan est le couple. Le Proph\u00e8te \u00a7 a dit : \u00ab Iblis place son tr\u00f4ne sur l\'eau puis envoie ses d\u00e9tachements. Le plus proche de lui en rang est celui qui cause le plus de fitna (d\u00e9sordre). L\'un d\'eux vient et dit : j\'ai fait ceci et cela. Et il r\u00e9pond : tu n\'as rien fait. Puis l\'un d\'eux vient et dit : je ne l\'ai pas l\u00e2ch\u00e9 jusqu\'\u00e0 ce que j\'aie s\u00e9par\u00e9 l\'homme de sa femme. Alors Iblis le rapproche de lui et dit : oui, toi tu es bien ! \u00bb (Muslim). Shaytan souffle la m\u00e9fiance, amplifie les d\u00e9fauts du conjoint, et transforme les petites disputes en grandes ruptures.',
      ),
      ProtectionSection(
        heading: 'Shaytan et la col\u00e8re',
        body: 'La col\u00e8re est une porte grande ouverte pour Shaytan. Le Proph\u00e8te \u00a7 a dit : \u00ab La col\u00e8re vient du Shaytan, et le Shaytan a \u00e9t\u00e9 cr\u00e9\u00e9 de feu, et le feu n\'est \u00e9teint que par l\'eau. Quand l\'un de vous se met en col\u00e8re, qu\'il fasse ses ablutions \u00bb (Abu Dawud). Quand une personne est en col\u00e8re, elle perd son discernement : elle dit des paroles qu\'elle regrette (divorce prononc\u00e9 sous la col\u00e8re, insultes, rupture des liens familiaux). Le rem\u00e8de proph\u00e9tique : se taire, changer de position (s\'asseoir si debout, se coucher si assis), faire les ablutions, et dire \u00ab A\'udhu billahi min ash-Shaytan ir-rajim \u00bb.',
      ),
      ProtectionSection(
        heading: 'Vaincre le waswas',
        body: 'Le rem\u00e8de contre le waswas est simple mais demande de la constance. Le Proph\u00e8te \u00a7 a dit : quand Shaytan vient \u00e0 l\'un de vous et dit \u00ab Qui a cr\u00e9\u00e9 ceci ? Qui a cr\u00e9\u00e9 cela ? \u00bb jusqu\'\u00e0 dire \u00ab Qui a cr\u00e9\u00e9 Allah ? \u00bb, qu\'il cherche refuge aupr\u00e8s d\'Allah et qu\'il cesse d\'y penser (Bukhari et Muslim). Les cl\u00e9s : 1) Ne jamais suivre le waswas \u2014 l\'ignorer compl\u00e8tement, 2) Chercher refuge aupr\u00e8s d\'Allah (isti\'adha), 3) Dire \u00ab \u00c2mantu billah \u00bb (je crois en Allah), 4) R\u00e9citer sourate An-Nas, 5) Maintenir les adhkar quotidiens, 6) Rester en \u00e9tat de puret\u00e9 (wudu). Le fait m\u00eame d\'avoir du waswas est un signe de foi, car Shaytan ne s\'acharne pas sur celui qui est d\u00e9j\u00e0 \u00e9gar\u00e9.',
      ),
    ],
  ),

  // ═══════════════════════════════════════════════════════════════════════
  // 5 — LA POSSESSION
  // ═══════════════════════════════════════════════════════════════════════
  ProtectionArticle(
    id: 'possession',
    title: 'La Possession (Mass)',
    emoji: '\uD83D\uDEE1\uFE0F',
    subtitle: 'Quand un jinn touche l\'humain',
    sections: [
      ProtectionSection(
        heading: 'La r\u00e9alit\u00e9 de la possession',
        body: 'La possession (mass) est le fait qu\'un jinn entre dans le corps d\'un \u00eatre humain ou exerce une influence forte sur lui. Allah dit : \u00ab Ceux qui mangent de l\'usure ne se l\u00e8vent que comme se l\u00e8ve celui que le toucher de Shaytan a boulevers\u00e9 \u00bb (Al-Baqara, 2:275). Les savants de l\'Islam, dont Ibn Taymiyya, ont affirm\u00e9 que la possession est une r\u00e9alit\u00e9 prouv\u00e9e par le Coran, la Sunna et le consensus des savants. Les raisons pour lesquelles un jinn peut poss\u00e9der un humain sont multiples.',
      ),
      ProtectionSection(
        heading: 'Les causes de la possession',
        body: 'Un jinn peut toucher un humain pour plusieurs raisons : la vengeance (si la personne a fait du mal au jinn sans le savoir, en versant de l\'eau chaude sans dire Bismillah, en jetant des pierres), l\'amour (un jinn qui s\'\u00e9prend d\'un humain), l\'ordre d\'un sorcier (le sihr envoie un jinn serviteur), ou simplement la m\u00e9chancet\u00e9 du jinn. L\'\u00e9loignement du dhikr et des pri\u00e8res rend la personne vuln\u00e9rable. Le Proph\u00e8te \u00a7 a dit que le Shaytan circule dans le fils d\'Adam comme le sang circule dans ses veines (Bukhari et Muslim).',
      ),
      ProtectionSection(
        heading: 'Signes possibles',
        body: 'Prudence : ces signes ne sont pas un diagnostic et il faut d\'abord consulter un m\u00e9decin pour \u00e9liminer les causes m\u00e9dicales. Parmi les signes \u00e9voqu\u00e9s par les sp\u00e9cialistes de la roqya : des convulsions ou mouvements involontaires pendant la r\u00e9citation du Coran, parler dans une langue inconnue pendant la roqya, une force physique anormale, des changements soudains de personnalit\u00e9, une aversion intense pour le Coran et la pri\u00e8re, des cauchemars r\u00e9currents et terrifiants, une paralysie du sommeil fr\u00e9quente. Le diagnostic ne peut \u00eatre pos\u00e9 que par un raqi comp\u00e9tent et pieux.',
      ),
      ProtectionSection(
        heading: 'Le traitement',
        body: 'Le traitement de la possession passe exclusivement par la roqya shar\'iyya (l\u00e9gif\u00e9r\u00e9e). Le raqi r\u00e9cite le Coran sur la personne, en particulier Sourate Al-Baqara, Ayat al-Kursi, les versets de sihr (de Sourate Al-A\'raf, Yunus et Ta-Ha), et les Mu\'awwidhat. Le jinn est somm\u00e9 de sortir au nom d\'Allah. Le traitement peut prendre du temps et n\u00e9cessite de la patience. La personne doit aussi faire sa part : pri\u00e8res \u00e0 l\'heure, adhkar quotidiens, \u00e9coute r\u00e9guli\u00e8re du Coran dans la maison, et invocations avant d\'entrer aux toilettes et avant de dormir.',
      ),
      ProtectionSection(
        heading: 'Mise en garde importante',
        body: 'M\u00e9fiez-vous des charlatans ! Un vrai raqi ne demande jamais d\'\u00e9gorger un animal de telle couleur, ne donne pas de talismans avec des \u00e9critures incompr\u00e9hensibles, ne demande pas \u00e0 la personne de s\'isoler dans le noir, ne touche pas les femmes non-mahram, et n\'utilise que le Coran et les invocations authentiques. Il ne demande pas des sommes exorbitantes. Si un \u00ab raqi \u00bb fait l\'une de ces choses, fuyez : c\'est un sorcier d\u00e9guis\u00e9 qui aggravera votre situation. La roqya l\u00e9gif\u00e9r\u00e9e est gratuite ou \u00e0 prix symbolique, et chacun peut la pratiquer sur soi-m\u00eame.',
      ),
    ],
  ),

  // ═══════════════════════════════════════════════════════════════════════
  // 6 — SE PRÉMUNIR AU QUOTIDIEN
  // ═══════════════════════════════════════════════════════════════════════
  ProtectionArticle(
    id: 'prevention',
    title: 'Se Pr\u00e9munir au Quotidien',
    emoji: '\uD83D\uDCA1',
    subtitle: 'Les habitudes qui prot\u00e8gent',
    sections: [
      ProtectionSection(
        heading: 'Le bouclier quotidien',
        body: 'La meilleure protection est la pr\u00e9vention. Les adhkar du matin et du soir sont votre armure invisible. Le Proph\u00e8te \u00a7 ne les a jamais n\u00e9glig\u00e9s. Parmi les plus importants : Ayat al-Kursi apr\u00e8s chaque pri\u00e8re et avant de dormir, les 3 Qul (Al-Ikhlas, Al-Falaq, An-Nas) trois fois matin et soir, \u00ab Bismillah alladhi la yadurru ma\'a ismihi shay\'un fil-ardi wa la fis-sama\'i wa Huwa as-Sami\' al-\'Alim \u00bb trois fois matin et soir. Ces adhkar sont comme un mur fortifi\u00e9 que ni le sihr ni le \'ayn ni les jinn ne peuvent franchir.',
      ),
      ProtectionSection(
        heading: 'Les invocations des moments cl\u00e9s',
        body: 'L\'Islam a pr\u00e9vu une invocation pour chaque moment de la journ\u00e9e, et chacune est une protection. En entrant chez soi : le salam emp\u00eache Shaytan d\'entrer. Avant de manger : Bismillah emp\u00eache Shaytan de partager votre repas. En entrant aux toilettes : l\'invocation sp\u00e9cifique prot\u00e8ge des jinn (les toilettes sont un lieu o\u00f9 ils r\u00e9sident). Avant le rapport intime : \u00ab Allahumma jannibna ash-Shaytan wa jannib ash-Shaytana ma razaqtana \u00bb prot\u00e8ge l\'enfant \u00e0 na\u00eetre. En sortant de la maison : l\'invocation du voyage. Chaque moment est couvert.',
      ),
      ProtectionSection(
        heading: 'La maison prot\u00e9g\u00e9e',
        body: 'Votre maison peut devenir une forteresse spirituelle. Les \u00e9tapes : r\u00e9citer ou \u00e9couter Sourate Al-Baqara r\u00e9guli\u00e8rement (le Shaytan fuit cette maison pendant 3 jours), faire le dhikr \u00e0 voix haute, prier les pri\u00e8res surr\u00e9rogatoires (nawafil) \u00e0 la maison, \u00e9viter la musique avec instruments (qui attire les shayatin selon les hadiths), \u00e9viter les images d\'\u00eatres anim\u00e9s accroch\u00e9es (les anges n\'entrent pas dans une maison o\u00f9 il y a des images selon le hadith), et dire Bismillah en fermant les portes le soir. Le Proph\u00e8te \u00a7 a dit de fermer les portes en mentionnant le nom d\'Allah car le Shaytan n\'ouvre pas une porte ferm\u00e9e.',
      ),
      ProtectionSection(
        heading: 'L\'hygi\u00e8ne de vie spirituelle',
        body: 'Au-del\u00e0 des adhkar, certaines habitudes renforcent votre protection : maintenir les 5 pri\u00e8res \u00e0 l\'heure (la pri\u00e8re est la premi\u00e8re ligne de d\u00e9fense), lire le Coran quotidiennement (m\u00eame quelques versets), rester en \u00e9tat de wudu le plus possible, faire la sadaqa (l\'aum\u00f4ne repousse le malheur), \u00e9viter les grands p\u00e9ch\u00e9s qui affaiblissent la protection, garder de bonnes relations avec les parents et la famille, demander pardon \u00e0 Allah (istighfar) fr\u00e9quemment. Le Proph\u00e8te \u00a7 faisait l\'istighfar plus de 70 fois par jour alors qu\'il \u00e9tait le meilleur des hommes.',
      ),
    ],
  ),
];
