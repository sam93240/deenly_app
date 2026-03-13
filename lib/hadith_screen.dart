// hadith_screen.dart — Deenly · Module Hadith (v3 – share image feature)

import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ── Palette ──────────────────────────────────────────────────────────────────
const _kGreenDeep    = Color(0xFF0A2018);
const _kGreenPrimary = Color(0xFF1B4D38);
const _kGreenMedium  = Color(0xFF2A7A52);
const _kGold         = Color(0xFFC8933A);
const _kGoldLight    = Color(0xFFFFF4DC);
const _kBeige        = Color(0xFFF6F0E3);
const _kBeigeCard    = Color(0xFFFFFFFF);
const _kBeigeBorder  = Color(0xFFD6C9AF);
const _kTextDark     = Color(0xFF1A130A);
const _kTextMid      = Color(0xFF5A4833);
const _kTextLight    = Color(0xFF8A7863);
const _kRed          = Color(0xFFE53935);
const _kRedLight     = Color(0xFFFFEBEB);
const _kBlue         = Color(0xFF1CB0F6);
const _kBlueLight    = Color(0xFFE7F7FF);
const _kOrange       = Color(0xFFFF9800);
const _kGreen        = Color(0xFF4CAF50);
const _kGreenLight   = Color(0xFFE8F5E9);

// ── Format de partage ─────────────────────────────────────────────────────────
enum _ShareFormat { square, story }

// ══════════════════════════════════════════════════════════════════════════════
// MODÈLE
// ══════════════════════════════════════════════════════════════════════════════
class HadithModel {
  final String arabe;
  final String traduction;
  final String narrateur;
  final String source;
  final String phonetique;
  final String categorie;
  final String explication;
  final String applicationQuotidienne;

  const HadithModel({
    required this.arabe,
    required this.traduction,
    required this.narrateur,
    required this.source,
    required this.phonetique,
    required this.categorie,
    required this.explication,
    required this.applicationQuotidienne,
  });
}

// ══════════════════════════════════════════════════════════════════════════════
// DONNÉES — 50 hadiths authentiques répartis par thèmes
// ══════════════════════════════════════════════════════════════════════════════
const List<HadithModel> _hadiths = [

  // ────────────────────── FOI (7 hadiths) ──────────────────────────────────
  HadithModel(
    arabe: 'إِنَّمَا الأَعْمَالُ بِالنِّيَّاتِ، وَإِنَّمَا لِكُلِّ امْرِئٍ مَا نَوَى',
    traduction: 'Les actes ne valent que par les intentions, et chaque homme n\'aura que ce qu\'il aura voulu.',
    narrateur: 'Omar ibn Al-Khattab (رضي الله عنه)',
    source: 'Sahih Al-Bukhari · Sahih Muslim · An-Nawawi n°1',
    phonetique: "Innamâ al-a'mâlu bin-niyyât, wa innamâ likulli imri'in mâ nawâ",
    categorie: 'Foi',
    explication: 'Ce hadith fondamental, premier du Sahih Al-Bukhari et des 40 An-Nawawi, enseigne que la valeur de chaque acte dépend de l\'intention qui le précède. Un même geste peut être une adoration s\'il est fait pour Allah, ou une simple action mondaine s\'il est motivé par autre chose.',
    applicationQuotidienne: 'Avant chaque prière, repas, travail ou geste envers autrui, prends un instant pour formuler mentalement ton intention : "Je fais ceci pour Allah." Cette simple habitude transforme les actes ordinaires en actes d\'adoration.',
  ),
  HadithModel(
    arabe: 'الدِّينُ النَّصِيحَةُ',
    traduction: 'La religion, c\'est la sincérité.',
    narrateur: 'Tamim Ad-Dari (رضي الله عنه)',
    source: 'Sahih Muslim · An-Nawawi n°7',
    phonetique: "Ad-dînu an-nasîha",
    categorie: 'Foi',
    explication: 'La "nasiha" désigne une sincérité totale envers Allah, Son Livre, Son Prophète ﷺ, les dirigeants musulmans et l\'ensemble des croyants. C\'est le socle de toutes les interactions islamiques : authenticité et bienveillance sincère dans chaque dimension de la vie.',
    applicationQuotidienne: 'Exprime tes conseils avec bienveillance, non pour critiquer mais pour aider. Sois sincère dans tes relations, même lorsque la vérité est difficile à dire.',
  ),
  HadithModel(
    arabe: 'إِنَّ اللَّهَ جَمِيلٌ يُحِبُّ الْجَمَالَ',
    traduction: 'Allah est Beau et Il aime la beauté.',
    narrateur: 'Abdallah ibn Masoud (رضي الله عنه)',
    source: 'Sahih Muslim',
    phonetique: "Inna Allâha jamîlun yuhibbu al-jamâl",
    categorie: 'Foi',
    explication: 'Ce hadith révèle un attribut d\'Allah — la Beauté parfaite et absolue. Le Prophète ﷺ l\'a cité après avoir défini l\'arrogance (kibr) comme le fait de mépriser les autres et de rejeter la vérité. Aimer la beauté désigne l\'élégance dans la conduite, l\'apparence soignée et l\'émerveillement devant la création.',
    applicationQuotidienne: 'Entretiens ton apparence, ton espace de vie et ta manière de parler. La propreté et l\'élégance dans les actes quotidiens sont des expressions de notre amour pour ce qu\'Allah aime.',
  ),
  HadithModel(
    arabe: 'قُلْ آمَنْتُ بِاللَّهِ ثُمَّ اسْتَقِمْ',
    traduction: 'Dis : "Je crois en Allah", puis reste droit sur le droit chemin.',
    narrateur: 'Sufyan ibn Abdallah At-Thaqafi (رضي الله عنه)',
    source: 'Sahih Muslim · An-Nawawi n°21',
    phonetique: "Qul: âmantu billâhi, thumma staqim",
    categorie: 'Foi',
    explication: 'Ce hadith résume l\'Islam en deux mots : la foi et la rectitude (istiqama). La foi s\'ancre dans le cœur par la parole, puis elle se manifeste par une conduite droite et constante dans toutes les sphères de la vie. L\'istiqama est souvent décrite par les savants comme l\'une des stations les plus élevées.',
    applicationQuotidienne: 'Renouvelle régulièrement ta foi par la shahada et l\'invocation d\'Allah. Puis demande-toi : "Est-ce que ma conduite aujourd\'hui est alignée avec ma foi ?" La droiture n\'est pas la perfection, c\'est la constance dans l\'effort.',
  ),
  HadithModel(
    arabe: 'الإِيمَانُ بِضْعٌ وَسَبْعُونَ شُعْبَةً، أَعْلَاهَا قَوْلُ لَا إِلَهَ إِلَّا اللَّهُ وَأَدْنَاهَا إِمَاطَةُ الأَذَى عَنِ الطَّرِيقِ',
    traduction: 'La foi comporte plus de soixante-dix branches. La plus haute est de dire "Lâ ilâha illallah" et la plus basse est d\'enlever une nuisance du chemin.',
    narrateur: 'Abu Huraira (رضي الله عنه)',
    source: 'Sahih Al-Bukhari · Sahih Muslim',
    phonetique: "Al-îmânu bid'un wa sab'ûna shu'ba, a'lâhâ qawlu Lâ ilâha illallâh, wa adnâhâ imâtatu al-adhâ 'an at-tarîq",
    categorie: 'Foi',
    explication: 'Ce hadith révèle la richesse et la profondeur de la foi islamique. Elle ne se limite pas aux grandes pratiques rituelles mais englobe les gestes les plus simples du quotidien. Enlever un obstacle du chemin — acte en apparence banal — est une branche de la foi.',
    applicationQuotidienne: 'Ne sous-estime jamais les petits actes de bien : ramasser un déchet, aider quelqu\'un à traverser, sourire à ton voisin. Chaque geste positif est une branche de ta foi qui se renforce.',
  ),
  HadithModel(
    arabe: 'لَا يَزَالُ عَبْدِي يَتَقَرَّبُ إِلَيَّ بِالنَّوَافِلِ حَتَّى أُحِبَّهُ',
    traduction: 'Mon serviteur ne cesse de se rapprocher de Moi par les actes surérogatoires jusqu\'à ce que Je l\'aime.',
    narrateur: 'Abu Huraira (رضي الله عنه)',
    source: 'Sahih Al-Bukhari (Hadith Qudsi)',
    phonetique: "Lâ yazâlu 'abdî yataqarrabu ilayya bin-nawâfili hattâ uhibbahu",
    categorie: 'Foi',
    explication: 'Ce hadith qudsi (parole divine rapportée par le Prophète ﷺ) dévoile le secret de la proximité avec Allah. Les obligations suffisent pour le salut, mais les actes surérogatoires (nawafil) — prières supplémentaires, jeûnes volontaires, aumônes — sont le chemin vers l\'amour divin.',
    applicationQuotidienne: 'Ajoute progressivement des actes volontaires à ta pratique : 2 rakats avant le fajr, la prière du doha, un jeûne le lundi ou jeudi. Ces actes supplémentaires construisent un lien intime et profond avec Allah.',
  ),
  HadithModel(
    arabe: 'الطَّهُورُ شَطْرُ الإِيمَانِ',
    traduction: 'La purification est la moitié de la foi.',
    narrateur: 'Abu Malik Al-Ash\'ari (رضي الله عنه)',
    source: 'Sahih Muslim · An-Nawawi n°23',
    phonetique: "At-tahûru shatru al-îmân",
    categorie: 'Foi',
    explication: 'La purification (tahara) en Islam est à la fois physique et spirituelle. Elle conditionne la validité de la prière et symbolise l\'état de pureté intérieure recherché par le croyant. Ce hadith souligne que la propreté du corps et de l\'âme est intrinsèquement liée à la foi.',
    applicationQuotidienne: 'Prends soin de ta pureté rituelle avec attention et intention. Chaque wudu (ablution) est une purification spirituelle et une préparation à la rencontre avec Allah lors de la prière.',
  ),

  // ─────────────────── COMPORTEMENT (7 hadiths) ────────────────────────────
  HadithModel(
    arabe: 'مَنْ كَانَ يُؤْمِنُ بِاللَّهِ وَالْيَوْمِ الآخِرِ فَلْيَقُلْ خَيْرًا أَوْ لِيَصْمُتْ',
    traduction: 'Que celui qui croit en Allah et au Jour dernier dise une bonne parole ou qu\'il se taise.',
    narrateur: 'Abu Huraira (رضي الله عنه)',
    source: 'Sahih Al-Bukhari · Sahih Muslim · An-Nawawi n°15',
    phonetique: "Man kâna yu'minu billâhi wal-yawmi al-âkhiri falyaqul khayran aw liyasmut",
    categorie: 'Comportement',
    explication: 'Ce hadith lie la qualité de notre parole à la solidité de notre foi. La parole est un outil puissant : source de bien immense ou de discorde. Le Prophète ﷺ nous offre deux options seulement : une bonne parole, ou le silence sage. Il n\'y a pas de place pour les paroles inutiles ou blessantes.',
    applicationQuotidienne: 'Avant de parler — en personne ou sur les réseaux sociaux — pose-toi la question : "Est-ce utile ou bienveillant ?" Si la réponse est non, garde le silence. C\'est une forme de sagesse et de maîtrise de soi.',
  ),
  HadithModel(
    arabe: 'الْمُسْلِمُ مَنْ سَلِمَ الْمُسْلِمُونَ مِنْ لِسَانِهِ وَيَدِهِ',
    traduction: 'Le musulman est celui dont les autres musulmans sont préservés de sa langue et de sa main.',
    narrateur: 'Abdallah ibn Amr (رضي الله عنه)',
    source: 'Sahih Al-Bukhari · Sahih Muslim',
    phonetique: "Al-muslimu man salima al-muslimûna min lisânihi wa yadih",
    categorie: 'Comportement',
    explication: 'L\'Islam ne se réduit pas aux rites de culte. Il englobe la conduite sociale dans son intégralité. Ce hadith définit le vrai musulman par sa non-nuisance aux autres : ni par les paroles (médisance, mensonge, insulte) ni par les actes physiques.',
    applicationQuotidienne: 'Surveille ta langue dans les conversations et sur les réseaux sociaux. Avant de critiquer quelqu\'un en son absence, demande-toi si tu accepterais qu\'on parle de toi ainsi.',
  ),
  HadithModel(
    arabe: 'مَنْ لَا يَشْكُرُ النَّاسَ لَا يَشْكُرُ اللَّهَ',
    traduction: 'Celui qui ne remercie pas les gens ne remercie pas Allah.',
    narrateur: 'Abu Huraira (رضي الله عنه)',
    source: 'Sunan Abu Dawood · At-Tirmidhi (Sahih)',
    phonetique: "Man lâ yashkuru an-nâsa lâ yashkuru Allâh",
    categorie: 'Comportement',
    explication: 'La gratitude envers Allah commence par la gratitude envers les humains qui sont les instruments de Ses bienfaits. Ce hadith établit un lien direct : la gratitude sociale et la gratitude spirituelle sont inséparables. Mépriser les bienfaits humains, c\'est mépriser les bienfaits divins.',
    applicationQuotidienne: 'Exprime ta gratitude concrètement — un "merci" sincère, un message de reconnaissance, un service rendu en retour. Cultiver le shukr (gratitude) transforme profondément notre regard sur la vie.',
  ),
  HadithModel(
    arabe: 'لَا تَغْضَبْ',
    traduction: 'Ne te mets pas en colère.',
    narrateur: 'Abu Huraira (رضي الله عنه)',
    source: 'Sahih Al-Bukhari · An-Nawawi n°16',
    phonetique: "Lâ taghdab",
    categorie: 'Comportement',
    explication: 'Un homme a demandé au Prophète ﷺ de lui donner un conseil. Il a répété "Ne te mets pas en colère" trois fois. La colère est mère de nombreux maux : paroles blessantes, décisions regrettables, relations brisées. La maîtriser est une forme de jihad contre soi-même.',
    applicationQuotidienne: 'Quand tu sens la colère monter, souviens-toi de ce conseil prophétique. Pratique des techniques concrètes : fais le wudu, change de position, sors prendre l\'air. Ne prends jamais de décision importante sous le coup de la colère.',
  ),
  HadithModel(
    arabe: 'إِنَّ اللَّهَ رَفِيقٌ يُحِبُّ الرِّفْقَ فِي الأَمْرِ كُلِّهِ',
    traduction: 'Allah est Doux et Il aime la douceur dans toutes les affaires.',
    narrateur: 'Aïcha (رضي الله عنها)',
    source: 'Sahih Al-Bukhari · Sahih Muslim',
    phonetique: "Inna Allâha rafîqun yuhibbu ar-rifqa fî al-amri kullih",
    categorie: 'Comportement',
    explication: 'Allah est Al-Rafiq (le Doux) et cette douceur est un attribut divin qu\'Il aime voir se refléter dans le comportement de Ses serviteurs. La douceur n\'est pas une faiblesse — c\'est une force qui ouvre les cœurs et préserve les relations là où la brutalité les détruirait.',
    applicationQuotidienne: 'Dans tes échanges — notamment lors des désaccords ou corrections — choisis toujours l\'approche douce. Un ton doux, des mots bienveillants et une attitude patiente accomplissent ce que la dureté ne peut jamais réaliser.',
  ),
  HadithModel(
    arabe: 'إِنَّ مِنْ أَكْمَلِ الْمُؤْمِنِينَ إِيمَانًا أَحْسَنُهُمْ خُلُقًا',
    traduction: 'Parmi les croyants les plus accomplis dans la foi, il y a ceux qui ont le meilleur caractère.',
    narrateur: 'Abu Huraira (رضي الله عنه)',
    source: 'Sunan At-Tirmidhi (Sahih) · Riyad As-Salihin',
    phonetique: "Inna min akmali al-mu'minîna îmânan ahsanuhum khuluqâ",
    categorie: 'Comportement',
    explication: 'Ce hadith établit un lien direct entre la qualité de la foi et la beauté du caractère. La foi n\'est pas uniquement une conviction intérieure — elle se manifeste extérieurement dans la façon dont on se comporte avec les autres. Un mauvais caractère révèle une foi incomplète.',
    applicationQuotidienne: 'Travaille activement sur ton caractère : patience, générosité, humilité, sourire. Ces qualités ne sont pas innées — elles se cultivent quotidiennement. Demande à Allah de t\'accorder un beau caractère comme le Prophète ﷺ y faisait appel dans ses invocations.',
  ),
  HadithModel(
    arabe: 'تَبَسُّمُكَ فِي وَجْهِ أَخِيكَ صَدَقَةٌ',
    traduction: 'Ton sourire face à ton frère est une aumône.',
    narrateur: 'Abu Dharr Al-Ghifari (رضي الله عنه)',
    source: 'Sunan At-Tirmidhi (Sahih)',
    phonetique: "Tabassumuqa fî wajhi akhîka sadaqa",
    categorie: 'Comportement',
    explication: 'Ce hadith révèle la générosité de l\'Islam : même un sourire sincère compte comme sadaqa. Il n\'est pas nécessaire d\'être riche pour être généreux. La bonté, l\'accueil et la bienveillance que l\'on exprime par le visage sont des actes d\'adoration à part entière.',
    applicationQuotidienne: 'Souris sincèrement aux personnes que tu rencontres. C\'est un geste gratuit qui illumine les journées, renforce les liens et sera compté parmi tes actes de charité. La générosité commence par le visage.',
  ),

  // ─────────────────────── FAMILLE (6 hadiths) ─────────────────────────────
  HadithModel(
    arabe: 'خَيْرُكُمْ خَيْرُكُمْ لِأَهْلِهِ، وَأَنَا خَيْرُكُمْ لِأَهْلِي',
    traduction: 'Le meilleur d\'entre vous est celui qui est le meilleur envers sa famille. Et je suis le meilleur d\'entre vous envers ma famille.',
    narrateur: 'Aïcha (رضي الله عنها)',
    source: 'Sunan At-Tirmidhi (Sahih)',
    phonetique: "Khayrukum khayrukum li'ahlih, wa anâ khayrukum li'ahlî",
    categorie: 'Famille',
    explication: 'Le Prophète ﷺ enseigne que l\'excellence n\'est pas une performance publique. Le vrai critère est la bonté dans l\'intimité du foyer. Celui qui est irritable chez lui mais souriant dehors n\'a pas encore saisi ce message fondamental. Le Prophète ﷺ en donne lui-même l\'exemple.',
    applicationQuotidienne: 'Sois aussi gentil(le) avec ta famille qu\'avec tes amis ou collègues. Un "merci" sincère, un sourire, un geste d\'affection au quotidien transforment l\'atmosphère du foyer.',
  ),
  HadithModel(
    arabe: 'الْجَنَّةُ تَحْتَ أَقْدَامِ الأُمَّهَاتِ',
    traduction: 'Le paradis est sous les pieds des mères.',
    narrateur: 'Mouawiyya ibn Jahima (رضي الله عنه)',
    source: 'Sunan An-Nasa\'i · Sunan Ibn Majah (Sahih)',
    phonetique: "Al-jannatu tahta aqdâmi al-ummahât",
    categorie: 'Famille',
    explication: 'Cette expression poétique signifie que le chemin vers le paradis passe par le service et la déférence envers sa mère. Elle exprime l\'immense statut de la mère en Islam — celle qui a porté, nourri et élevé ses enfants au prix d\'immenses sacrifices.',
    applicationQuotidienne: 'Appelle ta mère aujourd\'hui. Fais-lui un geste de tendresse ou rends-lui service. Si elle est décédée, prie pour elle, fais des aumônes en son nom, et lis la Fatiha pour son âme.',
  ),
  HadithModel(
    arabe: 'أَحَقُّ النَّاسِ بِحُسْنِ صَحَابَتِي؟ قَالَ أُمُّكَ، قَالَ ثُمَّ مَنْ؟ قَالَ أُمُّكَ، قَالَ ثُمَّ مَنْ؟ قَالَ أُمُّكَ، قَالَ ثُمَّ مَنْ؟ قَالَ أَبُوكَ',
    traduction: '"Qui mérite le plus ma bonne compagnie ?" Il dit : "Ta mère." "Puis qui ?" "Ta mère." "Puis qui ?" "Ta mère." "Puis qui ?" "Ton père."',
    narrateur: 'Abu Huraira (رضي الله عنه)',
    source: 'Sahih Al-Bukhari · Sahih Muslim',
    phonetique: "Aḥaqqu an-nâsi bihusni ṣaḥâbatî? Qâla: Ummuk. Thumma man? Ummuk. Thumma man? Ummuk. Thumma man? Abûk",
    categorie: 'Famille',
    explication: 'En répétant "ta mère" trois fois, le Prophète ﷺ souligne l\'immensité de la dette envers la mère — trois fois supérieure à celle envers le père. Cela reflète les épreuves de la grossesse, de l\'accouchement et de l\'allaitement. Le père vient en quatrième position, non par moindre respect, mais par équité.',
    applicationQuotidienne: 'Reflète-toi : est-ce que je donne à ma mère (et à mon père) la place qui leur revient ? Petits gestes quotidiens, appels téléphoniques, aide pratique — chaque attention compte dans ce compte rendu divin.',
  ),
  HadithModel(
    arabe: 'اسْتَوْصُوا بِالنِّسَاءِ خَيْرًا',
    traduction: 'Ayez de bonnes dispositions envers les femmes.',
    narrateur: 'Abu Huraira (رضي الله عنه)',
    source: 'Sahih Al-Bukhari · Sahih Muslim',
    phonetique: "Istawṣû bin-nisâ'i khayran",
    categorie: 'Famille',
    explication: 'Dans son dernier sermon, le Prophète ﷺ a exhorté les hommes à traiter les femmes avec bonté et respect. Ce hadith est un des fondements du droit des femmes en Islam. Il impose aux époux, aux pères et aux frères une attitude de bienveillance, de protection et de générosité.',
    applicationQuotidienne: 'Hommes : traitez les femmes de votre foyer — épouse, mère, filles, sœurs — avec gentillesse, écoute et respect. Femmes : enseignez à vos enfants le respect mutuel. Un foyer équilibré commence par la reconnaissance de la valeur de chacun.',
  ),
  HadithModel(
    arabe: 'صِلَةُ الرَّحِمِ تَزِيدُ فِي الْعُمُرِ وَتَزِيدُ فِي الرِّزْقِ',
    traduction: 'Maintenir les liens de parenté prolonge la vie et augmente la provision.',
    narrateur: 'Anas ibn Malik (رضي الله عنه)',
    source: 'Sahih Al-Bukhari (Musnad Ahmad)',
    phonetique: "Silatu ar-rahimi tazîdu fî al-'umuri wa tazîdu fî ar-rizq",
    categorie: 'Famille',
    explication: 'La silat ar-rahim (maintien des liens de parenté) est l\'une des pratiques les plus recommandées en Islam. Elle a des récompenses concrètes dans cette vie — longévité et bénédiction dans les provisions — en plus de la récompense divine dans l\'au-delà. La rupture des liens familiaux est au contraire un péché majeur.',
    applicationQuotidienne: 'Reprends contact avec un membre de ta famille que tu n\'as pas appelé depuis longtemps. Une visite, un message ou un coup de téléphone suffit. Ne laisse pas les liens se couper par inertie ou par orgueil.',
  ),
  HadithModel(
    arabe: 'لَيْسَ الْوَاصِلُ بِالْمُكَافِئِ، وَلَكِنِ الْوَاصِلُ الَّذِي إِذَا قُطِعَتْ رَحِمُهُ وَصَلَهَا',
    traduction: 'La vraie silat ar-rahim n\'est pas de rendre la pareille, mais de maintenir les liens même quand ils ont été rompus.',
    narrateur: 'Abdallah ibn Amr (رضي الله عنه)',
    source: 'Sahih Al-Bukhari',
    phonetique: "Laysa al-wâsilu bil-mukâfi', wa lâkinil-wâsilu alladhî idhâ quti'at raḥimuhu waṣalahâ",
    categorie: 'Famille',
    explication: 'Ce hadith définit la véritable silat ar-rahim (maintien des liens de parenté) : elle n\'est pas une simple réciprocité, mais un acte unilatéral de générosité. Maintenir les liens même avec quelqu\'un qui les a rompus est l\'expression la plus haute de cette pratique.',
    applicationQuotidienne: 'S\'il y a une brouille dans ta famille, fais le premier pas même si tu n\'es pas en tort. Oublier son ego pour préserver les liens familiaux est une grande victoire spirituelle qui mérite une grande récompense.',
  ),

  // ─────────────────────── COMMERCE (5 hadiths) ────────────────────────────
  HadithModel(
    arabe: 'التَّاجِرُ الصَّدُوقُ الأَمِينُ مَعَ النَّبِيِّينَ وَالصِّدِّيقِينَ وَالشُّهَدَاءِ',
    traduction: 'Le commerçant honnête et loyal sera aux côtés des prophètes, des véridiques et des martyrs.',
    narrateur: 'Abu Said Al-Khudri (رضي الله عنه)',
    source: 'Sunan At-Tirmidhi (Sahih)',
    phonetique: "At-tâjiru as-sadûqu al-amînu ma'a an-nabiyyîna was-siddîqîna wash-shuhadâ'",
    categorie: 'Commerce',
    explication: 'L\'Islam élève le statut du commerçant honnête à celui des plus grands servants d\'Allah. L\'honnêteté dans les transactions est une forme élevée d\'adoration. Ce hadith montre que la vie professionnelle peut mener aux plus hauts rangs si elle est conduite avec intégrité.',
    applicationQuotidienne: 'Dans tes achats et ventes, sois toujours transparent. Ne cache pas les défauts. La barakah se trouve dans l\'honnêteté commerciale, même si elle semble moins profitable à court terme.',
  ),
  HadithModel(
    arabe: 'إِيَّاكُمْ وَكَثْرَةَ الْحَلِفِ فِي الْبَيْعِ فَإِنَّهُ يُنَفِّقُ ثُمَّ يَمْحَقُ',
    traduction: 'Gardez-vous de trop jurer lors des transactions, car cela facilite temporairement la vente mais efface la bénédiction.',
    narrateur: 'Abu Qatada (رضي الله عنه)',
    source: 'Sahih Muslim',
    phonetique: "Iyyâkum wa kathrata al-halfi fî al-bay'i fa'innahu yunaffiqu thumma yamhaq",
    categorie: 'Commerce',
    explication: 'Jurer fréquemment pour convaincre un acheteur retire la barakah de la transaction. L\'honnêteté spontanée vaut infiniment mieux que des serments répétés. Ce hadith nous apprend que les gains obtenus par des procédés discutables sont privés de bénédiction.',
    applicationQuotidienne: 'Dans tes ventes et négociations, sois honnête sans avoir besoin de jurer. Bâtis ta réputation sur la qualité et la transparence. La confiance gagnée dure bien plus longtemps qu\'une vente obtenue par des serments.',
  ),
  HadithModel(
    arabe: 'مَنْ غَشَّنَا فَلَيْسَ مِنَّا',
    traduction: 'Celui qui nous trompe n\'est pas des nôtres.',
    narrateur: 'Abu Huraira (رضي الله عنه)',
    source: 'Sahih Muslim · Riyad As-Salihin',
    phonetique: "Man ghashsha-nâ fa laysa minnâ",
    categorie: 'Commerce',
    explication: 'Le Prophète ﷺ a dit ce hadith après avoir découvert de la nourriture avariée cachée sous de la nourriture fraîche sur un étal. La tromperie commerciale — cacher les défauts, falsifier la marchandise, mentir sur l\'origine — est une trahison de la confiance que l\'Islam ne tolère pas.',
    applicationQuotidienne: 'Ne cache jamais un défaut dans ce que tu vends. Ne promets pas ce que tu ne peux pas livrer. L\'honnêteté commerciale protège ta réputation ici-bas et ta récompense dans l\'au-delà.',
  ),
  HadithModel(
    arabe: 'الْبَيِّعَانِ بِالْخِيَارِ مَا لَمْ يَتَفَرَّقَا، فَإِنْ صَدَقَا وَبَيَّنَا بُورِكَ لَهُمَا فِي بَيْعِهِمَا',
    traduction: 'Les deux parties d\'une transaction ont le droit de se rétracter tant qu\'elles ne se sont pas séparées. Si elles sont honnêtes et transparentes, leur transaction sera bénie.',
    narrateur: 'Hakim ibn Hizam (رضي الله عنه)',
    source: 'Sahih Al-Bukhari · Sahih Muslim',
    phonetique: "Al-bayyiʿâni bil-khiyâri mâ lam yatafarraqâ, fa'in ṣadaqâ wa bayyinâ bûrika lahumâ fî bay'ihimâ",
    categorie: 'Commerce',
    explication: 'L\'Islam a institué un droit de rétractation pour protéger acheteur et vendeur. La bénédiction divine descend sur les transactions conclues dans la transparence et la franchise. Ce hadith est le fondement du droit de la consommation islamique.',
    applicationQuotidienne: 'Lors de tes transactions, donne à l\'autre partie le temps de réfléchir. Ne l\'empêche pas de se rétracter. La barakah dans tes affaires passe par le respect du droit de l\'autre.',
  ),
  HadithModel(
    arabe: 'أَعْطُوا الأَجِيرَ أَجْرَهُ قَبْلَ أَنْ يَجِفَّ عَرَقُهُ',
    traduction: 'Donnez au travailleur son salaire avant que sa sueur ne sèche.',
    narrateur: 'Abdallah ibn Omar (رضي الله عنه)',
    source: 'Sunan Ibn Majah (Sahih)',
    phonetique: "A'ṭû al-ajîra ajrahu qabla an yajiffa 'araquhu",
    categorie: 'Commerce',
    explication: 'Ce hadith établit un droit fondamental du travailleur : être payé promptement. Retarder le salaire d\'un employé ou d\'un artisan sans raison valable est une injustice grave en Islam. Ce principe s\'applique à toutes les formes de travail et de services rendus.',
    applicationQuotidienne: 'Paie tes employés, artisans ou prestataires dans les délais convenus. Si tu dois un service à quelqu\'un, règle-le rapidement. La promptitude dans les paiements est une forme de justice sociale.',
  ),

  // ──────────────────────── SAGESSE (6 hadiths) ────────────────────────────
  HadithModel(
    arabe: 'طَلَبُ الْعِلْمِ فَرِيضَةٌ عَلَى كُلِّ مُسْلِمٍ',
    traduction: 'La recherche du savoir est une obligation pour chaque musulman.',
    narrateur: 'Anas ibn Malik (رضي الله عنه)',
    source: 'Sunan Ibn Majah · Riyad As-Salihin',
    phonetique: "Talabu al-'ilmi farîdatun 'alâ kulli muslim",
    categorie: 'Sagesse',
    explication: 'L\'Islam valorise profondément la connaissance. Il s\'agit d\'abord du savoir religieux, mais les savants élargissent cela à toute connaissance utile. L\'ignorance volontaire ne peut être une excuse pour le croyant.',
    applicationQuotidienne: 'Consacre du temps chaque jour à apprendre : lis un verset avec son tafsir, écoute un cours, lis un livre enrichissant. Même 15 minutes par jour représentent plus de 90 heures d\'apprentissage par an.',
  ),
  HadithModel(
    arabe: 'خَيْرُكُمْ مَنْ تَعَلَّمَ الْقُرْآنَ وَعَلَّمَهُ',
    traduction: 'Le meilleur d\'entre vous est celui qui apprend le Coran et l\'enseigne.',
    narrateur: 'Uthman ibn Affan (رضي الله عنه)',
    source: 'Sahih Al-Bukhari',
    phonetique: "Khayrukum man ta'allama al-Qur'âna wa 'allamahu",
    categorie: 'Sagesse',
    explication: 'Le Coran est la parole d\'Allah et le meilleur des savoirs. Apprendre le Coran — lecture, mémorisation, compréhension — est l\'une des actions les plus nobles. L\'enseigner aux autres multiplie encore la récompense.',
    applicationQuotidienne: 'Consacre au moins 10 minutes par jour à la récitation ou à la mémorisation du Coran. Si tu sais lire, enseigne à quelqu\'un d\'autre. Si tu as des enfants, lis-leur régulièrement quelques versets.',
  ),
  HadithModel(
    arabe: 'مَنْ سَلَكَ طَرِيقًا يَلْتَمِسُ فِيهِ عِلْمًا سَهَّلَ اللَّهُ لَهُ طَرِيقًا إِلَى الْجَنَّةِ',
    traduction: 'Quiconque emprunte un chemin à la recherche du savoir, Allah lui facilite un chemin vers le paradis.',
    narrateur: 'Abu Huraira (رضي الله عنه)',
    source: 'Sahih Muslim · Riyad As-Salihin',
    phonetique: "Man salaka tarîqan yaltamisu fîhi 'ilman sahhalallâhu lahu tarîqan ilâ al-janna",
    categorie: 'Sagesse',
    explication: 'La quête du savoir est un acte d\'adoration qui ouvre littéralement le chemin vers le paradis. Que ce chemin soit physique (aller à un cours) ou virtuel, l\'intention sincère de s\'instruire pour plaire à Allah suffit pour déclencher cette facilitation divine.',
    applicationQuotidienne: 'Inscris-toi à un cours de religion, rejoins un cercle d\'étude, ou lis un ouvrage de fiqh. Chaque pas vers la connaissance est un pas sur le chemin du paradis — fais-en une priorité dans ton agenda.',
  ),
  HadithModel(
    arabe: 'مَنْ يُرِدِ اللَّهُ بِهِ خَيْرًا يُفَقِّهْهُ فِي الدِّينِ',
    traduction: 'Celui à qui Allah veut du bien, Il lui donne la compréhension profonde de la religion.',
    narrateur: 'Muawiyah ibn Abi Sufyan (رضي الله عنه)',
    source: 'Sahih Al-Bukhari · Sahih Muslim',
    phonetique: "Man yuridillâhu bihi khayran yufaqqihhu fî ad-dîn",
    categorie: 'Sagesse',
    explication: 'Le fiqh (compréhension profonde) de la religion est un don divin et le signe de la bienveillance d\'Allah envers Son serviteur. Comprendre la religion — ses règles, ses sagesses, ses objectifs — n\'est pas réservé aux savants : c\'est une aspiration que tout musulman doit entretenir.',
    applicationQuotidienne: 'Cherche à comprendre le "pourquoi" derrière les pratiques islamiques, pas seulement le "comment". Cette compréhension profonde renforce la foi, facilite l\'application et permet de guider les autres.',
  ),
  HadithModel(
    arabe: 'كُنْ فِي الدُّنْيَا كَأَنَّكَ غَرِيبٌ أَوْ عَابِرُ سَبِيلٍ',
    traduction: 'Sois dans ce monde comme un étranger ou un voyageur de passage.',
    narrateur: 'Abdallah ibn Omar (رضي الله عنه)',
    source: 'Sahih Al-Bukhari · An-Nawawi n°40',
    phonetique: "Kun fî ad-dunyâ ka'annaka gharîbun aw 'âbiru sabîl",
    categorie: 'Sagesse',
    explication: 'Dernier hadith des 40 An-Nawawi, il résume la philosophie islamique du rapport au monde. Le croyant ne doit pas s\'accrocher aux biens matériels ni se laisser absorber par le dunya au point d\'oublier l\'au-delà. Comme un voyageur, il prend ce dont il a besoin pour son voyage vers Allah.',
    applicationQuotidienne: 'Quand tu es tenté par un attachement excessif aux biens, aux statuts ou aux plaisirs, rappelle-toi : "Je suis de passage." Cet état d\'esprit libère du stress matériel et recentre sur l\'essentiel.',
  ),
  HadithModel(
    arabe: 'إِنَّ مِمَّا أَدْرَكَ النَّاسُ مِنْ كَلَامِ النُّبُوَّةِ الأُولَى: إِذَا لَمْ تَسْتَحْيِ فَاصْنَعْ مَا شِئْتَ',
    traduction: 'Parmi ce que les gens ont retenu des paroles des prophètes anciens : si tu n\'as pas de pudeur, fais ce que tu veux.',
    narrateur: 'Ibn Masoud (رضي الله عنه)',
    source: 'Sahih Al-Bukhari',
    phonetique: "Inna mimmâ adraka an-nâsu min kalâmi an-nubuwwati al-ûlâ: idhâ lam tastahi fasna' mâ shi't",
    categorie: 'Sagesse',
    explication: 'La haya (pudeur et retenue morale) est une sagesse prophétique ancestrale. Ce hadith signifie que sans pudeur, rien ne retient l\'être humain du mal. La pudeur n\'est pas timidité, c\'est une force intérieure qui agit comme un garde-fou moral dans toutes les situations.',
    applicationQuotidienne: 'Avant chaque acte ou parole, demande-toi : "Aurais-je honte si le Prophète ﷺ me voyait ?" Ce filtre simple de la haya peut transformer ton comportement dans chaque situation.',
  ),

  // ─────────────────── SPIRITUALITÉ (7 hadiths) ────────────────────────────
  HadithModel(
    arabe: 'إِنَّ اللَّهَ كَتَبَ الإِحْسَانَ عَلَى كُلِّ شَيْءٍ',
    traduction: 'Allah a prescrit l\'excellence (ihsan) dans toute chose.',
    narrateur: 'Shaddad ibn Aws (رضي الله عنه)',
    source: 'Sahih Muslim · An-Nawawi n°17',
    phonetique: "Inna Allâha kataba al-ihsâna 'alâ kulli shay'",
    categorie: 'Spiritualité',
    explication: 'L\'ihsan — faire les choses avec excellence comme si on voyait Allah — est le niveau le plus élevé de la pratique islamique. Il s\'applique à tout acte : prière, travail, service rendu. L\'excellence n\'est pas une option, elle est une prescription divine.',
    applicationQuotidienne: 'Dans ton travail, ta prière, et ta façon de traiter les gens, vise l\'excellence. Demande-toi : "Si Allah me regardait faire cela maintenant, serais-je à l\'aise ?" C\'est la définition concrète de l\'ihsan.',
  ),
  HadithModel(
    arabe: 'خَيْرُ النَّاسِ أَنْفَعُهُمْ لِلنَّاسِ',
    traduction: 'Le meilleur des gens est celui qui est le plus utile aux autres.',
    narrateur: 'Jabir ibn Abdallah (رضي الله عنه)',
    source: 'As-Silsilah As-Sahihah (Al-Albani)',
    phonetique: "Khayru an-nâsi anfa'uhum lin-nâs",
    categorie: 'Spiritualité',
    explication: 'L\'Islam définit la valeur d\'un être humain par sa contribution positive à la société. Ce n\'est pas la richesse, la notoriété ou l\'apparence de piété qui comptent, mais l\'utilité réelle et concrète pour les autres. Servir les gens est une forme de servir Allah.',
    applicationQuotidienne: 'Demande-toi chaque matin : "Comment puis-je être utile aujourd\'hui ?" Une aide concrète, même petite, vaut mieux que de grandes intentions non réalisées. Commence par les plus proches de toi.',
  ),
  HadithModel(
    arabe: 'مَثَلُ الَّذِي يَذْكُرُ رَبَّهُ وَالَّذِي لَا يَذْكُرُهُ مَثَلُ الْحَيِّ وَالْمَيِّتِ',
    traduction: 'Celui qui se rappelle son Seigneur et celui qui ne Le rappelle pas sont comme le vivant et le mort.',
    narrateur: 'Abu Musa Al-Ash\'ari (رضي الله عنه)',
    source: 'Sahih Al-Bukhari',
    phonetique: "Mathalu alladhî yadhkuru rabbahu walladhî lâ yadhkuruhu mathalu al-hayyi wal-mayyit",
    categorie: 'Spiritualité',
    explication: 'Le dhikr (rappel d\'Allah) est la vie du cœur. Un cœur qui ne rappelle pas Allah est comme un mort. Le Prophète ﷺ nous encourage à intégrer le rappel d\'Allah dans chaque moment de notre vie.',
    applicationQuotidienne: 'Intègre des dhikr simples dans tes activités : "Alhamdulillah" en te levant, "Bismillah" avant de manger, "Subhanallah" face à la beauté. Ces formules courtes entretiennent la vie du cœur tout au long de la journée.',
  ),
  HadithModel(
    arabe: 'كَلِمَتَانِ خَفِيفَتَانِ عَلَى اللِّسَانِ ثَقِيلَتَانِ فِي الْمِيزَانِ حَبِيبَتَانِ إِلَى الرَّحْمَنِ: سُبْحَانَ اللَّهِ وَبِحَمْدِهِ سُبْحَانَ اللَّهِ الْعَظِيمِ',
    traduction: 'Deux formules légères sur la langue, lourdes dans la balance, chères au Miséricordieux : "Subhanallah wabihamdih, Subhanallah al-Adhim."',
    narrateur: 'Abu Huraira (رضي الله عنه)',
    source: 'Sahih Al-Bukhari · Sahih Muslim',
    phonetique: "Kalimatâni khafîfatâni 'alâ al-lisân, thaqîlatâni fî al-mîzân, habîbatâni ilâ ar-rahmân: Subhânallâhi wa bihamdih, subhânallâhi al-'Adhîm",
    categorie: 'Spiritualité',
    explication: 'Ce hadith révèle l\'immense valeur de deux courtes formules de louange à Allah. Malgré leur facilité à prononcer, elles ont un poids considérable dans la balance divine le Jour du Jugement. Allah les aime particulièrement, ce qui en fait un investissement spirituel sans équivalent.',
    applicationQuotidienne: 'Répète "Subhanallah wabihamdih, Subhanallah al-Adhim" cent fois le matin. Cela ne prend que quelques minutes et efface les péchés selon d\'autres hadiths. C\'est l\'un des meilleurs rappels que tu puisses pratiquer quotidiennement.',
  ),
  HadithModel(
    arabe: 'مَنْ قَامَ رَمَضَانَ إِيمَانًا وَاحْتِسَابًا غُفِرَ لَهُ مَا تَقَدَّمَ مِنْ ذَنْبِهِ',
    traduction: 'Quiconque prie la nuit durant le Ramadan par foi sincère et en cherchant la récompense d\'Allah, ses péchés passés lui seront pardonnés.',
    narrateur: 'Abu Huraira (رضي الله عنه)',
    source: 'Sahih Al-Bukhari · Sahih Muslim',
    phonetique: "Man qâma ramadhâna îmânan wahtisâban ghufira lahu mâ taqaddama min dhambih",
    categorie: 'Spiritualité',
    explication: 'La qiyam (prière nocturne) du Ramadan — la Tarawih — est une opportunité de pardon extraordinaire. La condition est double : la foi sincère (iman) et l\'intention pure de chercher la récompense divine (ihtisab), sans ostentation ni contrainte sociale.',
    applicationQuotidienne: 'Durant le Ramadan, accomplis la prière du soir avec sincérité. En dehors du Ramadan, habitue-toi à la tahajjud (prière nocturne volontaire) — même 2 rakats après minuit — pour maintenir cette connexion spirituelle.',
  ),
  HadithModel(
    arabe: 'أَفْضَلُ الذِّكْرِ لَا إِلَهَ إِلَّا اللَّهُ، وَأَفْضَلُ الدُّعَاءِ الْحَمْدُ لِلَّهِ',
    traduction: 'Le meilleur des dhikr est "Lâ ilâha illallah" et la meilleure des invocations est "Al-hamdulillah".',
    narrateur: 'Jabir ibn Abdallah (رضي الله عنه)',
    source: 'Sunan At-Tirmidhi (Hasan)',
    phonetique: "Afdalu adh-dhikri Lâ ilâha illallâh, wa afdalu ad-du'â'i al-hamdulillâh",
    categorie: 'Spiritualité',
    explication: 'La shahada "Lâ ilâha illallah" est la clé de la foi et le meilleur des rappels. L\'Alhamdulillah est la meilleure invocation car elle exprime la gratitude totale à Allah — une gratitude qui inclut implicitement tous les bienfaits reçus.',
    applicationQuotidienne: 'Commence chaque journée par ces deux formules : renforce ta connexion à Allah par "Lâ ilâha illallah" puis exprime ta gratitude par "Al-hamdulillah". Ces deux clés ouvrent le cœur à la spiritualité la plus profonde.',
  ),
  HadithModel(
    arabe: 'أَحَبُّ الأَعْمَالِ إِلَى اللَّهِ أَدْوَمُهَا وَإِنْ قَلَّ',
    traduction: 'Les actes les plus aimés d\'Allah sont les plus constants, même s\'ils sont peu nombreux.',
    narrateur: 'Aïcha (رضي الله عنها)',
    source: 'Sahih Al-Bukhari · Sahih Muslim',
    phonetique: "Ahabbu al-a'mâli ilallâhi adwamuhâ wa in qall",
    categorie: 'Spiritualité',
    explication: 'Ce hadith révèle une sagesse profonde sur la vie spirituelle : la régularité vaut mieux que l\'intensité passagère. Un acte modeste mais quotidien est plus aimé d\'Allah qu\'un grand acte ponctuel. La constance forge le caractère et transforme l\'adoration en mode de vie.',
    applicationQuotidienne: 'Choisis une pratique que tu peux maintenir chaque jour, même petite : 2 pages de Coran, 10 dhikr du matin, un sadaqa hebdomadaire. La constance, même modeste, est la clé de la progression spirituelle.',
  ),

  // ─────────────────────── JUSTICE (6 hadiths) ─────────────────────────────
  HadithModel(
    arabe: 'اتَّقُوا الظُّلْمَ، فَإِنَّ الظُّلْمَ ظُلُمَاتٌ يَوْمَ الْقِيَامَةِ',
    traduction: 'Préservez-vous de l\'injustice, car l\'injustice sera de profondes ténèbres au Jour du Jugement.',
    narrateur: 'Jabir ibn Abdallah (رضي الله عنه)',
    source: 'Sahih Muslim',
    phonetique: "Ittaqû az-zulma, fa'inna az-zulma dhulumâtun yawma al-qiyâma",
    categorie: 'Justice',
    explication: 'L\'injustice (zulm) est parmi les plus grands péchés en Islam. Ce hadith utilise l\'image des ténèbres pour symboliser la désorientation totale au Jugement. Allah ne pardonne pas le zulm envers les créatures sans réconciliation préalable.',
    applicationQuotidienne: 'Sois juste dans tes jugements, même envers ceux que tu n\'apprécies pas. Ne prive personne de ses droits. Si tu as fait du tort à quelqu\'un, cherche à te réconcilier avant qu\'il soit trop tard.',
  ),
  HadithModel(
    arabe: 'الْمُسْلِمُ أَخُو الْمُسْلِمِ لَا يَظْلِمُهُ وَلَا يُسْلِمُهُ',
    traduction: 'Le musulman est le frère du musulman — il ne lui fait pas de tort et ne l\'abandonne pas.',
    narrateur: 'Abdallah ibn Omar (رضي الله عنه)',
    source: 'Sahih Al-Bukhari · Sahih Muslim',
    phonetique: "Al-muslimu akhû al-muslimi lâ yazlimuhu wa lâ yuslimuhu",
    categorie: 'Justice',
    explication: 'Ce hadith énonce deux piliers : ne pas nuire et ne pas abandonner. L\'abandon est aussi une forme d\'injustice. Laisser quelqu\'un seul face à ses difficultés quand on pourrait l\'aider est contraire aux valeurs fondamentales de l\'Islam.',
    applicationQuotidienne: 'N\'abandonne pas un ami ou un frère dans l\'épreuve. Soutiens-le même si tu n\'approuves pas toutes ses décisions. Être présent dans les moments difficiles est l\'une des plus belles expressions de la fraternité.',
  ),
  HadithModel(
    arabe: 'لَا ضَرَرَ وَلَا ضِرَارَ',
    traduction: 'Pas de préjudice, ni de représailles par le préjudice.',
    narrateur: 'Ibn Abbas · Abu Said Al-Khudri (رضي الله عنهم)',
    source: 'Sunan Ibn Majah · Musnad Ahmad · An-Nawawi n°32',
    phonetique: "Lâ darara wa lâ dirâr",
    categorie: 'Justice',
    explication: 'Ce hadith concis est l\'un des fondements du droit islamique. Il pose deux principes : interdiction de causer un préjudice (darar), et interdiction de répliquer par un préjudice équivalent (dirar). Il constitue l\'une des "règles d\'or" du fiqh appliquée dans tous les domaines.',
    applicationQuotidienne: 'Dans tes relations — professionnelles, familiales, sociales — veille à ne pas causer de tort, même involontairement. Et si tu as subi une injustice, résous-la par la justice, non par la vengeance.',
  ),
  HadithModel(
    arabe: 'كُلُّكُمْ رَاعٍ وَكُلُّكُمْ مَسْؤُولٌ عَنْ رَعِيَّتِهِ',
    traduction: 'Chacun de vous est un gardien et chacun de vous est responsable de ce dont il a la garde.',
    narrateur: 'Abdallah ibn Omar (رضي الله عنه)',
    source: 'Sahih Al-Bukhari · Sahih Muslim',
    phonetique: "Kullukum râ'in wa kullukum mas'ûlun 'an ra'iyyatih",
    categorie: 'Justice',
    explication: 'Ce hadith établit le principe de responsabilité universelle en Islam. Chaque personne est un berger (ra\'i) dans sa sphère : le dirigeant sur son peuple, l\'homme sur sa famille, la femme sur le foyer, l\'employé sur ce qu\'on lui a confié. Nul n\'est exempt de responsabilité.',
    applicationQuotidienne: 'Réfléchis aux personnes dont tu as la charge — tes enfants, tes employés, tes parents âgés — et demande-toi : "Est-ce que je m\'acquitte de ma responsabilité envers eux ?" La justice commence par ses propres responsabilités.',
  ),
  HadithModel(
    arabe: 'انْصُرْ أَخَاكَ ظَالِمًا أَوْ مَظْلُومًا',
    traduction: 'Aide ton frère qu\'il soit oppresseur ou opprimé.',
    narrateur: 'Anas ibn Malik (رضي الله عنه)',
    source: 'Sahih Al-Bukhari',
    phonetique: "Unsur akhâka dhâliman aw madhlûmâ",
    categorie: 'Justice',
    explication: 'Les compagnons ont demandé comment aider l\'oppresseur. Le Prophète ﷺ a répondu : "En l\'empêchant de commettre l\'injustice." Aider l\'oppresseur ne signifie pas le soutenir dans son injustice, mais l\'arrêter avant qu\'il ne se perde davantage. C\'est la vraie solidarité.',
    applicationQuotidienne: 'Si tu vois quelqu\'un commettre une injustice, interviens — avec sagesse et selon tes moyens. Ne ferme pas les yeux sous prétexte que ce n\'est "pas ton affaire". La justice est l\'affaire de tous.',
  ),
  HadithModel(
    arabe: 'مَنْ رَأَى مِنْكُمْ مُنْكَرًا فَلْيُغَيِّرْهُ بِيَدِهِ، فَإِنْ لَمْ يَسْتَطِعْ فَبِلِسَانِهِ، فَإِنْ لَمْ يَسْتَطِعْ فَبِقَلْبِهِ، وَذَلِكَ أَضْعَفُ الإِيمَانِ',
    traduction: 'Quiconque voit un acte répréhensible doit le changer par sa main ; s\'il ne peut pas, par sa langue ; s\'il ne peut pas, par son cœur — et c\'est le degré le plus faible de la foi.',
    narrateur: 'Abu Said Al-Khudri (رضي الله عنه)',
    source: 'Sahih Muslim · An-Nawawi n°34',
    phonetique: "Man ra'â minkum munkaran falyughayyirhu biyadih, fa'in lam yastati' fabisânih, fa'in lam yastati' fabi-qalbih — wa dhâlika ad'afu al-îmân",
    categorie: 'Justice',
    explication: 'Ce hadith définit les trois niveaux d\'engagement contre l\'injustice et le mal. Il établit une gradation selon les capacités : l\'action directe, la parole, puis au minimum le refus intérieur. Aucun croyant ne peut rester totalement passif devant le mal.',
    applicationQuotidienne: 'Face à une injustice ou un acte répréhensible, agis selon tes moyens. Au minimum, exprime ton désaccord intérieur. Ne laisse pas l\'habitude et l\'indifférence éteindre ton sens de la justice.',
  ),

  // ─────────────── AMOUR ET MISÉRICORDE (6 hadiths) ────────────────────────
  HadithModel(
    arabe: 'لَا يُؤْمِنُ أَحَدُكُمْ حَتَّى يُحِبَّ لِأَخِيهِ مَا يُحِبُّ لِنَفْسِهِ',
    traduction: 'Aucun d\'entre vous ne croit vraiment tant qu\'il n\'aime pas pour son frère ce qu\'il aime pour lui-même.',
    narrateur: 'Anas ibn Malik (رضي الله عنه)',
    source: 'Sahih Al-Bukhari · Sahih Muslim · An-Nawawi n°13',
    phonetique: "Lâ yu'minu ahadukum hattâ yuhibba li'akhîhi mâ yuhibbu linafsih",
    categorie: 'Amour et miséricorde',
    explication: 'Ce hadith des 40 An-Nawawi définit l\'amour authentique en Islam. Dépasser l\'égoïsme naturel pour souhaiter à notre prochain ce que nous souhaitons pour nous-mêmes est le test concret de la qualité de notre foi.',
    applicationQuotidienne: 'Quand tu vois un frère réussir, réjouis-toi sincèrement. Évite la jalousie. Prie pour les autres comme tu pries pour toi-même. La fraternité islamique commence dans le cœur.',
  ),
  HadithModel(
    arabe: 'ارْحَمُوا مَنْ فِي الأَرْضِ يَرْحَمْكُمْ مَنْ فِي السَّمَاءِ',
    traduction: 'Soyez miséricordieux envers ceux qui sont sur terre, et Celui qui est dans le ciel vous fera miséricorde.',
    narrateur: 'Abdallah ibn Amr (رضي الله عنه)',
    source: 'Sunan Abu Dawood · At-Tirmidhi (Sahih)',
    phonetique: "Irhamû man fî al-ardi yarhamkum man fî as-samâ'",
    categorie: 'Amour et miséricorde',
    explication: 'La miséricorde (rahma) est au cœur de la foi islamique. Ce hadith établit un principe de réciprocité divine : la miséricorde que tu accordes aux autres te revient multipliée d\'Allah. Elle s\'applique aux humains, aux animaux et à toute la création.',
    applicationQuotidienne: 'Montre de la compassion dans ton quotidien : envers les pauvres, les animaux, les enfants, les personnes âgées. Chaque acte de douceur sincère est un investissement pour recevoir la miséricorde divine.',
  ),
  HadithModel(
    arabe: 'مَنْ نَفَّسَ عَنْ مُؤْمِنٍ كُرْبَةً مِنْ كُرَبِ الدُّنْيَا نَفَّسَ اللَّهُ عَنْهُ كُرْبَةً مِنْ كُرَبِ يَوْمِ الْقِيَامَةِ',
    traduction: 'Quiconque soulage un croyant d\'une détresse de ce monde, Allah le soulagera d\'une détresse au Jour du Jugement.',
    narrateur: 'Abu Huraira (رضي الله عنه)',
    source: 'Sahih Muslim · An-Nawawi n°36',
    phonetique: "Man naffasa 'an mu'minin kurbatan min kurabi ad-dunyâ naffasallâhu 'anhu kurbatan min kurabi yawmi al-qiyâma",
    categorie: 'Amour et miséricorde',
    explication: 'Ce hadith des 40 An-Nawawi illustre la réciprocité divine. Ce que tu fais pour les créatures d\'Allah, Il te le retourne au moment le plus crucial. Aider les autres est une expression de la foi vécue.',
    applicationQuotidienne: 'Aide quelqu\'un concrètement aujourd\'hui : écoute un ami en difficulté, soutiens quelqu\'un dans le besoin, rends service sans attendre de remerciement. Chaque soulagement apporté est une graine pour le Jour du Jugement.',
  ),
  HadithModel(
    arabe: 'إِنَّ اللَّهَ لَا يَرْحَمُ مَنْ لَا يَرْحَمُ النَّاسَ',
    traduction: 'Allah ne fait pas miséricorde à celui qui ne fait pas miséricorde aux gens.',
    narrateur: 'Jarir ibn Abdallah (رضي الله عنه)',
    source: 'Sahih Al-Bukhari · Sahih Muslim',
    phonetique: "Inna Allâha lâ yarhamu man lâ yarhamu an-nâs",
    categorie: 'Amour et miséricorde',
    explication: 'Ce hadith est d\'une clarté saisissante : la miséricorde d\'Allah est conditionnée par notre propre miséricorde envers les autres. Ce n\'est pas une menace mais une loi spirituelle — le cœur qui se ferme à la compassion se ferme aussi à la réception de la miséricorde divine.',
    applicationQuotidienne: 'Cultive activement la compassion. Quand tu es tenté d\'être dur ou indifférent, rappelle-toi ce hadith. La miséricorde que tu retiendras de quelqu\'un aujourd\'hui pourrait être la miséricorde qui te sera retirée demain.',
  ),
  HadithModel(
    arabe: 'لَا تَحْقِرَنَّ مِنَ الْمَعْرُوفِ شَيْئًا وَلَوْ أَنْ تَلْقَى أَخَاكَ بِوَجْهٍ طَلْقٍ',
    traduction: 'Ne méprise aucune forme de bienfaisance, même rencontrer ton frère avec un visage souriant et ouvert.',
    narrateur: 'Abu Dharr Al-Ghifari (رضي الله عنه)',
    source: 'Sahih Muslim',
    phonetique: "Lâ tahqiranna mina al-ma'rûfi shay'an wa law an talqâ akhâka biwajhin talq",
    categorie: 'Amour et miséricorde',
    explication: 'Ce hadith élargit le concept de sadaqa (aumône) à tout acte de bonté, si petit soit-il. Un visage ouvert, une parole réconfortante, un geste d\'aide — rien n\'est trop petit pour compter devant Allah. Cette vision généreuse de l\'adoration met la spiritualité à la portée de tous.',
    applicationQuotidienne: 'Ne sous-estime jamais un acte de bonté, quelle que soit sa petitesse. Un sourire, une aide pour porter un sac, retenir une porte — tout cela compte. La générosité n\'est pas seulement financière, elle est dans chaque geste du quotidien.',
  ),
  HadithModel(
    arabe: 'الْمُسْلِمُ لِلْمُسْلِمِ كَالْبُنْيَانِ يَشُدُّ بَعْضُهُ بَعْضًا',
    traduction: 'Le musulman pour le musulman est comme une construction dont les parties se renforcent mutuellement.',
    narrateur: 'Abu Musa Al-Ash\'ari (رضي الله عنه)',
    source: 'Sahih Al-Bukhari · Sahih Muslim',
    phonetique: "Al-muslimu lil-muslimi kal-bunyâni yashuddu ba'duhu ba'dâ",
    categorie: 'Amour et miséricorde',
    explication: 'Cette métaphore architecturale décrit une fraternité de solidarité et d\'interdépendance. Comme les briques d\'un mur qui se soutiennent mutuellement, les musulmans doivent être une communauté soudée où chacun renforce l\'autre, plutôt qu\'une collection d\'individus isolés.',
    applicationQuotidienne: 'Renforce les autres autour de toi : un encouragement, un soutien moral, une aide pratique. La solidarité communautaire commence par les relations de proximité — famille, voisins, collègues croyants.',
  ),
];

const List<String> _categories = [
  'Tous', 'Foi', 'Comportement', 'Famille', 'Commerce',
  'Sagesse', 'Spiritualité', 'Justice', 'Amour et miséricorde',
];

// ══════════════════════════════════════════════════════════════════════════════
// ÉCRAN PRINCIPAL
// ══════════════════════════════════════════════════════════════════════════════
class HadithScreen extends StatefulWidget {
  const HadithScreen({super.key});

  @override
  State<HadithScreen> createState() => _HadithScreenState();
}

class _HadithScreenState extends State<HadithScreen> {
  String         _selectedCategorie = 'Tous';
  final Set<int> _favoris           = {};

  static const _kFavorisKey = 'deenly_hadith_favoris';

  @override
  void initState() {
    super.initState();
    _loadFavoris();
  }

  Future<void> _loadFavoris() async {
    final prefs = await SharedPreferences.getInstance();
    final list  = prefs.getStringList(_kFavorisKey) ?? [];
    if (mounted) {
      setState(() {
        _favoris.clear();
        _favoris.addAll(list.map((s) => int.tryParse(s) ?? -1).where((i) => i >= 0));
      });
    }
  }

  Future<void> _saveFavoris() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_kFavorisKey, _favoris.map((i) => i.toString()).toList());
  }

  // Hadith du jour basé sur le jour de l'année (change chaque jour)
  int get _hadithDuJourIndex => DateTime.now().dayOfYear % _hadiths.length;

  List<MapEntry<int, HadithModel>> get _filteredHadiths {
    final all = _hadiths.asMap().entries.toList();
    if (_selectedCategorie == 'Tous') return all;
    return all.where((e) => e.value.categorie == _selectedCategorie).toList();
  }

  void _toggleFavori(int index) {
    setState(() => _favoris.contains(index) ? _favoris.remove(index) : _favoris.add(index));
    _saveFavoris();
  }

  void _openDetail(int index) {
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => HadithDetailScreen(
        hadith:          _hadiths[index],
        hadithIndex:     index,
        isFavori:        _favoris.contains(index),
        onToggleFavori:  () => _toggleFavori(index),
        allHadiths:      _hadiths,
        allFavoris:      _favoris,
        onOpenHadith:    (idx) => _openDetail(idx),
      ),
    ));
  }

  void _showSagesseAleatoire() {
    final idx = Random().nextInt(_hadiths.length);
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _SagesseSheet(
        hadith:         _hadiths[idx],
        isFavori:       _favoris.contains(idx),
        onToggleFavori: () => _toggleFavori(idx),
        onVoirDetails:  () { Navigator.pop(context); _openDetail(idx); },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredHadiths;
    return Scaffold(
      backgroundColor: _kBeige,
      body: Column(children: [
        _buildHeader(context),
        Expanded(
          child: CustomScrollView(slivers: [
            if (_selectedCategorie == 'Tous') ...[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: _HadithDuJourBanner(
                    hadith:             _hadiths[_hadithDuJourIndex],
                    isFavori:           _favoris.contains(_hadithDuJourIndex),
                    onLireExplication:  () => _openDetail(_hadithDuJourIndex),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                  child: _SagesseButton(onTap: _showSagesseAleatoire),
                ),
              ),
            ],
            SliverToBoxAdapter(
              child: _CategoriesFilter(
                categories: _categories,
                selected:   _selectedCategorie,
                onSelect:   (cat) => setState(() => _selectedCategorie = cat),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, i) {
                    final entry = filtered[i];
                    return _HadithCard(
                      hadith:         entry.value,
                      isFavori:       _favoris.contains(entry.key),
                      onToggleFavori: () => _toggleFavori(entry.key),
                      onTap:          () => _openDetail(entry.key),
                    );
                  },
                  childCount: filtered.length,
                ),
              ),
            ),
          ]),
        ),
      ]),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(context, MaterialPageRoute(
          builder: (_) => HadithQuizScreen(hadiths: _hadiths),
        )),
        backgroundColor: _kGold,
        foregroundColor: _kGreenDeep,
        icon:  const Icon(Icons.quiz_rounded),
        label: const Text('Quiz Hadiths', style: TextStyle(fontWeight: FontWeight.w800)),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [_kGreenDeep, _kGreenPrimary],
          begin: Alignment.topLeft, end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: Row(children: [
            GestureDetector(
              onTap: () => Navigator.maybePop(context),
              child: Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                ),
                child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 15),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('الأحاديث النبوية',
                    style: TextStyle(color: _kGold, fontSize: 18, fontWeight: FontWeight.w700, height: 1.4)),
                Text('Sagesse du Prophète ﷺ',
                    style: TextStyle(color: Colors.white.withOpacity(0.55), fontSize: 11)),
              ]),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.12),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
              ),
              child: Text('${_hadiths.length} hadiths',
                  style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 11, fontWeight: FontWeight.w700)),
            ),
          ]),
        ),
      ),
    );
  }
}

// Extension utilitaire
extension on DateTime {
  int get dayOfYear {
    final start = DateTime(year, 1, 1);
    return difference(start).inDays;
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// HADITH DU JOUR BANNER
// ══════════════════════════════════════════════════════════════════════════════
class _HadithDuJourBanner extends StatelessWidget {
  final HadithModel hadith;
  final bool        isFavori;
  final VoidCallback onLireExplication;

  const _HadithDuJourBanner({
    required this.hadith,
    required this.isFavori,
    required this.onLireExplication,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_kGreenPrimary, _kGreenMedium],
          begin: Alignment.topLeft, end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [BoxShadow(color: _kGreenPrimary.withOpacity(0.3), blurRadius: 18, offset: const Offset(0, 6))],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: _kGold.withOpacity(0.22),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(mainAxisSize: MainAxisSize.min, children: const [
              Text('⭐', style: TextStyle(fontSize: 11)),
              SizedBox(width: 5),
              Text('Hadith du jour', style: TextStyle(color: _kGold, fontWeight: FontWeight.w800, fontSize: 11)),
            ]),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(hadith.categorie,
                style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 10, fontWeight: FontWeight.w600)),
          ),
        ]),
        const SizedBox(height: 14),
        Text(hadith.arabe,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            style: const TextStyle(color: _kGold, fontSize: 18, height: 1.9)),
        const SizedBox(height: 6),
        Text(hadith.phonetique,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.white.withOpacity(0.55),
                fontSize: 10.5,
                height: 1.5,
                fontStyle: FontStyle.italic)),
        const SizedBox(height: 10),
        Text(hadith.traduction,
            style: const TextStyle(color: Colors.white, fontSize: 13, height: 1.55)),
        const SizedBox(height: 6),
        Text('— ${hadith.narrateur}',
            style: TextStyle(color: Colors.white.withOpacity(0.65), fontSize: 11)),
        const SizedBox(height: 14),
        GestureDetector(
          onTap: onLireExplication,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.25)),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Lire l\'explication', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700)),
                SizedBox(width: 6),
                Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 14),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// BOUTON SAGESSE ALÉATOIRE
// ══════════════════════════════════════════════════════════════════════════════
class _SagesseButton extends StatelessWidget {
  final VoidCallback onTap;
  const _SagesseButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        decoration: BoxDecoration(
          color: _kGoldLight,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _kGold.withOpacity(0.4), width: 1.5),
        ),
        child: Row(children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _kGold.withOpacity(0.18),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text('🌟', style: TextStyle(fontSize: 18)),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Sagesse du Prophète ﷺ',
                  style: TextStyle(color: _kTextDark, fontSize: 13, fontWeight: FontWeight.w800)),
              SizedBox(height: 2),
              Text('Découvrir une sagesse aléatoire',
                  style: TextStyle(color: _kTextLight, fontSize: 11)),
            ]),
          ),
          const Icon(Icons.shuffle_rounded, color: _kGold, size: 20),
        ]),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// FILTRE CATÉGORIES
// ══════════════════════════════════════════════════════════════════════════════
class _CategoriesFilter extends StatelessWidget {
  final List<String>     categories;
  final String           selected;
  final Function(String) onSelect;

  const _CategoriesFilter({required this.categories, required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _kBeigeCard,
      child: SizedBox(
        height: 46,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
          itemCount: categories.length,
          itemBuilder: (context, i) {
            final cat        = categories[i];
            final isSelected = cat == selected;
            return GestureDetector(
              onTap: () => onSelect(cat),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                decoration: BoxDecoration(
                  color:  isSelected ? _kGreenPrimary : _kBeige,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? _kGreenPrimary : _kBeigeBorder,
                    width: 1.5,
                  ),
                ),
                child: Text(cat,
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected ? Colors.white : _kTextMid,
                      fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                    )),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// CARTE HADITH (liste)
// ══════════════════════════════════════════════════════════════════════════════
class _HadithCard extends StatelessWidget {
  final HadithModel  hadith;
  final bool         isFavori;
  final VoidCallback onToggleFavori;
  final VoidCallback onTap;

  const _HadithCard({
    required this.hadith,
    required this.isFavori,
    required this.onToggleFavori,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: _kBeigeCard,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _kBeigeBorder, width: 1.2),
        boxShadow: const [BoxShadow(color: Color(0x08000000), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Row(children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                decoration: BoxDecoration(
                  color: _kGreenPrimary.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(hadith.categorie,
                    style: const TextStyle(fontSize: 11, color: _kGreenPrimary, fontWeight: FontWeight.w800)),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  final text = '${hadith.arabe}\n\n« ${hadith.traduction} »\n— ${hadith.narrateur}\n${hadith.source}';
                  Share.share(text);
                },
                behavior: HitTestBehavior.opaque,
                child: const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Icon(Icons.ios_share_rounded, color: _kTextLight, size: 18),
                ),
              ),
              const SizedBox(width: 4),
              GestureDetector(
                onTap: onToggleFavori,
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Icon(
                    isFavori ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
                    color: isFavori ? _kRed : _kTextLight,
                    size: 20,
                  ),
                ),
              ),
            ]),
            const SizedBox(height: 12),
            Text(hadith.arabe,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 17, color: _kTextDark, height: 1.8)),
            const SizedBox(height: 4),
            Text(hadith.phonetique,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 10.5,
                    color: _kTextLight,
                    fontStyle: FontStyle.italic,
                    letterSpacing: 0.2)),
            const SizedBox(height: 6),
            Text(hadith.traduction,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12, color: _kTextMid, height: 1.5)),
            const SizedBox(height: 8),
            Row(children: [
              Text(hadith.narrateur,
                  style: const TextStyle(fontSize: 11, color: _kGreenPrimary, fontWeight: FontWeight.w700)),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios_rounded, size: 11, color: _kTextLight),
            ]),
          ]),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// ÉCRAN DÉTAIL
// ══════════════════════════════════════════════════════════════════════════════
class HadithDetailScreen extends StatefulWidget {
  final HadithModel         hadith;
  final int                 hadithIndex;
  final bool                isFavori;
  final VoidCallback         onToggleFavori;
  final List<HadithModel>   allHadiths;
  final Set<int>            allFavoris;
  final Function(int)       onOpenHadith;

  const HadithDetailScreen({
    Key? key,
    required this.hadith,
    required this.hadithIndex,
    required this.isFavori,
    required this.onToggleFavori,
    required this.allHadiths,
    required this.allFavoris,
    required this.onOpenHadith,
  }) : super(key: key);

  @override
  State<HadithDetailScreen> createState() => _HadithDetailScreenState();
}

class _HadithDetailScreenState extends State<HadithDetailScreen> {
  late bool _isFavori;

  @override
  void initState() {
    super.initState();
    _isFavori = widget.isFavori;
  }

  void _toggleFavori() {
    setState(() => _isFavori = !_isFavori);
    widget.onToggleFavori();
  }

  void _copyText() {
    final text = '${widget.hadith.arabe}\n\n« ${widget.hadith.traduction} »\n— ${widget.hadith.narrateur}\n${widget.hadith.source}';
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Hadith copié dans le presse-papiers'),
      backgroundColor: _kGreenPrimary,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(16),
    ));
  }

  void _showShareOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _ShareBottomSheet(hadith: widget.hadith),
    );
  }

  List<MapEntry<int, HadithModel>> get _similarHadiths =>
      widget.allHadiths.asMap().entries
          .where((e) => e.key != widget.hadithIndex && e.value.categorie == widget.hadith.categorie)
          .take(3)
          .toList();

  @override
  Widget build(BuildContext context) {
    final similar = _similarHadiths;

    return Scaffold(
      backgroundColor: _kBeige,
      body: Column(children: [
        // Header
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [_kGreenDeep, _kGreenPrimary],
                begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Row(children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(9),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 15),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(widget.hadith.categorie,
                      style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700)),
                ),
                GestureDetector(
                  onTap: _toggleFavori,
                  child: Container(
                    padding: const EdgeInsets.all(9),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      _isFavori ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
                      color: _isFavori ? _kRed : Colors.white,
                      size: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _showShareOptions,
                  child: Container(
                    padding: const EdgeInsets.all(9),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.ios_share_rounded, color: Colors.white, size: 18),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _copyText,
                  child: Container(
                    padding: const EdgeInsets.all(9),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.copy_rounded, color: Colors.white, size: 18),
                  ),
                ),
              ]),
            ),
          ),
        ),

        // Contenu
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [

              // Texte arabe
              Container(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0D3A25), Color(0xFF1B5E40)],
                    begin: Alignment.topLeft, end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [BoxShadow(color: _kGreenPrimary.withOpacity(0.28), blurRadius: 20, offset: const Offset(0, 6))],
                ),
                child: Text(widget.hadith.arabe,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: _kGold, fontSize: 22, height: 2.0)),
              ),

              const SizedBox(height: 10),

              // Phonétique
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: _kGreenPrimary.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _kGreenPrimary.withOpacity(0.12)),
                ),
                child: Text(widget.hadith.phonetique,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: _kTextMid,
                        fontSize: 12.5,
                        height: 1.6,
                        fontStyle: FontStyle.italic,
                        letterSpacing: 0.2)),
              ),

              const SizedBox(height: 10),

              // Traduction
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: _kGoldLight,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: _kGold.withOpacity(0.35)),
                ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: const [
                    Text('🌍', style: TextStyle(fontSize: 14)),
                    SizedBox(width: 6),
                    Text('TRADUCTION', style: TextStyle(color: Color(0xFFA85C00), fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1)),
                  ]),
                  const SizedBox(height: 10),
                  Text(widget.hadith.traduction,
                      style: const TextStyle(color: _kTextDark, fontSize: 15, height: 1.65, fontStyle: FontStyle.italic)),
                ]),
              ),

              const SizedBox(height: 10),

              // Source & narrateur
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: _kGreenPrimary.withOpacity(0.07),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: _kGreenPrimary.withOpacity(0.18)),
                ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    const Icon(Icons.person_outline_rounded, color: _kGreenPrimary, size: 15),
                    const SizedBox(width: 6),
                    Expanded(child: Text(widget.hadith.narrateur,
                        style: const TextStyle(color: _kGreenPrimary, fontSize: 13, fontWeight: FontWeight.w700))),
                  ]),
                  const SizedBox(height: 4),
                  Row(children: [
                    const Icon(Icons.menu_book_rounded, color: _kTextLight, size: 14),
                    const SizedBox(width: 6),
                    Expanded(child: Text(widget.hadith.source,
                        style: const TextStyle(color: _kTextMid, fontSize: 11))),
                  ]),
                ]),
              ),

              const SizedBox(height: 14),

              // Explication
              _DetailSection(
                icon: '💡',
                label: 'EXPLICATION',
                color: _kBlueLight,
                borderColor: _kBlue.withOpacity(0.3),
                labelColor: const Color(0xFF0078A8),
                content: widget.hadith.explication,
              ),

              const SizedBox(height: 10),

              // Application quotidienne
              _DetailSection(
                icon: '🌱',
                label: 'APPLICATION QUOTIDIENNE',
                color: _kGreenLight,
                borderColor: _kGreenPrimary.withOpacity(0.3),
                labelColor: _kGreenPrimary,
                content: widget.hadith.applicationQuotidienne,
              ),

              // Hadiths similaires
              if (similar.isNotEmpty) ...[
                const SizedBox(height: 24),
                const Text('Hadiths similaires',
                    style: TextStyle(color: _kTextDark, fontSize: 15, fontWeight: FontWeight.w800)),
                const SizedBox(height: 10),
                ...similar.map((e) => _SimilarCard(
                  hadith: e.value,
                  onTap: () {
                    Navigator.pop(context);
                    widget.onOpenHadith(e.key);
                  },
                )),
              ],
            ]),
          ),
        ),
      ]),
    );
  }
}

class _DetailSection extends StatelessWidget {
  final String icon;
  final String label;
  final Color  color;
  final Color  borderColor;
  final Color  labelColor;
  final String content;

  const _DetailSection({
    required this.icon,
    required this.label,
    required this.color,
    required this.borderColor,
    required this.labelColor,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text(icon, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(color: labelColor, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1)),
        ]),
        const SizedBox(height: 10),
        Text(content, style: const TextStyle(color: _kTextDark, fontSize: 13, height: 1.65)),
      ]),
    );
  }
}

class _SimilarCard extends StatelessWidget {
  final HadithModel  hadith;
  final VoidCallback onTap;

  const _SimilarCard({required this.hadith, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _kBeigeCard,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _kBeigeBorder),
        ),
        child: Row(children: [
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(hadith.arabe,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14, color: _kTextDark, height: 1.7)),
              const SizedBox(height: 4),
              Text(hadith.narrateur,
                  style: const TextStyle(fontSize: 11, color: _kGreenPrimary, fontWeight: FontWeight.w700)),
            ]),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_forward_ios_rounded, size: 13, color: _kTextLight),
        ]),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// CARTE HADITH PARTAGEABLE
// ══════════════════════════════════════════════════════════════════════════════
class HadithShareCard extends StatelessWidget {
  final HadithModel  hadith;
  final _ShareFormat format;

  const HadithShareCard({
    Key? key,
    required this.hadith,
    this.format = _ShareFormat.square,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool   isStory = format == _ShareFormat.story;
    const double w       = 360;
    final double h       = isStory ? 640 : 360;

    return SizedBox(
      width: w, height: h,
      child: Stack(children: [
        // ── Fond dégradé sombre ───────────────────────────────────────────────
        Container(
          width: w, height: h,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF061510), Color(0xFF0F2A1C), Color(0xFF091D13)],
              begin: Alignment.topCenter,
              end:   Alignment.bottomCenter,
            ),
          ),
        ),

        // ── Motif islamique discret ───────────────────────────────────────────
        Positioned.fill(child: CustomPaint(painter: _IslamicPatternPainter())),

        // ── Bandes dorées haut / bas ──────────────────────────────────────────
        Positioned(
          top: 0, left: 0, right: 0,
          child: Container(height: 3, color: const Color(0xFFC8933A).withOpacity(0.65)),
        ),
        Positioned(
          bottom: 0, left: 0, right: 0,
          child: Container(height: 3, color: const Color(0xFFC8933A).withOpacity(0.65)),
        ),

        // ── Contenu ───────────────────────────────────────────────────────────
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(28, 22, 28, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo Deenly / ديني
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text('Deenly',
                      style: TextStyle(
                          color: Color(0xFFC8933A), fontSize: 18,
                          fontWeight: FontWeight.w900, letterSpacing: 2.5)),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: 1, height: 14,
                    color: const Color(0xFFC8933A).withOpacity(0.45),
                  ),
                  const Text('ديني',
                      style: TextStyle(
                          color: Color(0xFFC8933A), fontSize: 18,
                          fontWeight: FontWeight.w700)),
                ]),

                SizedBox(height: isStory ? 36 : 20),

                // قال رسول الله ﷺ
                Text('قَالَ رَسُولُ اللَّهِ ﷺ',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.42),
                        fontSize: 12, letterSpacing: 0.3)),

                SizedBox(height: isStory ? 22 : 12),

                // Texte arabe
                Text(hadith.arabe,
                    textDirection: TextDirection.rtl,
                    textAlign:     TextAlign.center,
                    style: const TextStyle(
                        color: Color(0xFFC8933A),
                        fontSize: 17, height: 2.0, fontWeight: FontWeight.w500)),

                SizedBox(height: isStory ? 10 : 8),

                // Phonétique
                Text(hadith.phonetique,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.38),
                        fontSize: isStory ? 11 : 10,
                        height: 1.5,
                        fontStyle: FontStyle.italic)),

                SizedBox(height: isStory ? 20 : 12),

                // Séparateur doré
                Row(children: [
                  Expanded(child: Container(
                    height: 1,
                    color: const Color(0xFFC8933A).withOpacity(0.22),
                  )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text('✦',
                        style: TextStyle(
                            color: const Color(0xFFC8933A).withOpacity(0.55),
                            fontSize: 10)),
                  ),
                  Expanded(child: Container(
                    height: 1,
                    color: const Color(0xFFC8933A).withOpacity(0.22),
                  )),
                ]),

                SizedBox(height: isStory ? 28 : 16),

                // Traduction française
                Text('« ${hadith.traduction} »',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.88),
                        fontSize: isStory ? 15 : 13,
                        height: 1.75,
                        fontStyle: FontStyle.italic)),

                const Spacer(),

                // Pastille source
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.055),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFC8933A).withOpacity(0.22)),
                  ),
                  child: Text(hadith.source,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.58),
                          fontSize: 10.5, letterSpacing: 0.2)),
                ),

                const SizedBox(height: 10),

                // Signature Deenly
                Text('Deenly · Lumière sur ta foi',
                    style: TextStyle(
                        color: const Color(0xFFC8933A).withOpacity(0.55),
                        fontSize: 10, letterSpacing: 1.3)),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

// ── Motif islamique (étoiles octogonales discrètes) ───────────────────────────
class _IslamicPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color   = const Color(0xFFC8933A).withOpacity(0.048)
      ..style   = PaintingStyle.stroke
      ..strokeWidth = 0.7;

    const double step = 85.0;
    const double r    = 26.0;

    for (double x = 0; x <= size.width  + step; x += step) {
      for (double y = 0; y <= size.height + step; y += step) {
        _drawOctaStar(canvas, paint, x, y, r);
      }
    }
  }

  void _drawOctaStar(Canvas canvas, Paint paint, double cx, double cy, double r) {
    final path = Path();
    for (int i = 0; i < 8; i++) {
      final a      = i * pi / 4 - pi / 8;
      final radius = i % 2 == 0 ? r : r * 0.42;
      final x      = cx + radius * cos(a);
      final y      = cy + radius * sin(a);
      if (i == 0) path.moveTo(x, y); else path.lineTo(x, y);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _IslamicPatternPainter old) => false;
}

// ══════════════════════════════════════════════════════════════════════════════
// BOTTOM SHEET PARTAGE IMAGE
// ══════════════════════════════════════════════════════════════════════════════
class _ShareBottomSheet extends StatefulWidget {
  final HadithModel hadith;
  const _ShareBottomSheet({required this.hadith});

  @override
  State<_ShareBottomSheet> createState() => _ShareBottomSheetState();
}

class _ShareBottomSheetState extends State<_ShareBottomSheet> {
  _ShareFormat _format       = _ShareFormat.square;
  bool         _isGenerating = false;

  Future<Uint8List> _renderCard() async {
    final isStory = _format == _ShareFormat.story;
    return ScreenshotController().captureFromWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: HadithShareCard(hadith: widget.hadith, format: _format),
      ),
      pixelRatio: 3.0,
      targetSize: Size(360, isStory ? 640 : 360),
    );
  }

  Future<void> _share() async {
    setState(() => _isGenerating = true);
    try {
      final bytes = await _renderCard();
      final dir   = await getTemporaryDirectory();
      final file  = File('${dir.path}/deenly_hadith_${DateTime.now().millisecondsSinceEpoch}.png');
      await file.writeAsBytes(bytes);
      if (mounted) {
        await Share.shareXFiles(
          [XFile(file.path, mimeType: 'image/png')],
          subject: 'Deenly · Lumière sur ta foi',
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Erreur lors du partage : $e'),
          backgroundColor: _kRed,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ));
      }
    } finally {
      if (mounted) setState(() => _isGenerating = false);
    }
  }

  Future<void> _save() async {
    setState(() => _isGenerating = true);
    try {
      final bytes  = await _renderCard();
      final dir    = await getDownloadsDirectory() ?? await getTemporaryDirectory();
      final name   = 'deenly_hadith_${DateTime.now().millisecondsSinceEpoch}.png';
      final file   = File('${dir.path}/$name');
      await file.writeAsBytes(bytes);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Image sauvegardée dans : ${dir.path}'),
          backgroundColor: _kGreenPrimary,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Erreur lors de la sauvegarde : $e'),
          backgroundColor: _kRed,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ));
      }
    } finally {
      if (mounted) setState(() => _isGenerating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isStory = _format == _ShareFormat.story;
    return Container(
      decoration: const BoxDecoration(
        color: _kBeigeCard,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
      child: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          // Handle
          Center(child: Container(
            margin: const EdgeInsets.only(top: 12, bottom: 20),
            width: 40, height: 4,
            decoration: BoxDecoration(
              color: _kBeigeBorder,
              borderRadius: BorderRadius.circular(99),
            ),
          )),

          // Titre
          const Text('Partager ce hadith',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: _kTextDark)),
          const SizedBox(height: 4),
          const Text('Génère une belle carte à partager sur les réseaux',
              style: TextStyle(fontSize: 12, color: _kTextLight)),

          const SizedBox(height: 20),

          // Sélecteur de format
          Row(children: [
            Expanded(child: _ShareFormatButton(
              label:      'Carré',
              sublabel:   '1080 × 1080',
              icon:       Icons.crop_square_rounded,
              isSelected: _format == _ShareFormat.square,
              onTap:      () => setState(() => _format = _ShareFormat.square),
            )),
            const SizedBox(width: 12),
            Expanded(child: _ShareFormatButton(
              label:      'Story',
              sublabel:   '1080 × 1920',
              icon:       Icons.crop_portrait_rounded,
              isSelected: _format == _ShareFormat.story,
              onTap:      () => setState(() => _format = _ShareFormat.story),
            )),
          ]),

          const SizedBox(height: 20),

          // Aperçu de la carte
          Container(
            height: isStory ? 280 : 230,
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: FittedBox(
                fit: BoxFit.contain,
                child: SizedBox(
                  width: 360,
                  height: isStory ? 640 : 360,
                  child: HadithShareCard(hadith: widget.hadith, format: _format),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Boutons d'action
          Row(children: [
            // Sauvegarder
            GestureDetector(
              onTap: _isGenerating ? null : _save,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                decoration: BoxDecoration(
                  color: _kBeige,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: _kBeigeBorder),
                ),
                child: Row(mainAxisSize: MainAxisSize.min, children: const [
                  Icon(Icons.download_rounded, color: _kGreenPrimary, size: 18),
                  SizedBox(width: 6),
                  Text('Sauvegarder',
                      style: TextStyle(
                          color: _kGreenPrimary,
                          fontSize: 12, fontWeight: FontWeight.w800)),
                ]),
              ),
            ),
            const SizedBox(width: 10),
            // Partager
            Expanded(
              child: GestureDetector(
                onTap: _isGenerating ? null : _share,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF0A2018), _kGreenPrimary],
                    ),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                          color: _kGreenPrimary.withOpacity(0.28),
                          blurRadius: 12,
                          offset: const Offset(0, 4)),
                    ],
                  ),
                  child: _isGenerating
                      ? const Center(child: SizedBox(
                          width: 18, height: 18,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2)))
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.ios_share_rounded,
                                color: Colors.white, size: 17),
                            SizedBox(width: 7),
                            Text('Partager l\'image',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w800)),
                          ]),
                ),
              ),
            ),
          ]),
        ]),
      ),
    );
  }
}

class _ShareFormatButton extends StatelessWidget {
  final String     label;
  final String     sublabel;
  final IconData   icon;
  final bool       isSelected;
  final VoidCallback onTap;

  const _ShareFormatButton({
    required this.label,
    required this.sublabel,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
        decoration: BoxDecoration(
          color: isSelected ? _kGreenPrimary.withOpacity(0.09) : _kBeige,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? _kGreenPrimary : _kBeigeBorder,
            width: isSelected ? 2.0 : 1.5,
          ),
        ),
        child: Column(children: [
          Icon(icon, color: isSelected ? _kGreenPrimary : _kTextLight, size: 26),
          const SizedBox(height: 5),
          Text(label,
              style: TextStyle(
                  color: isSelected ? _kGreenPrimary : _kTextDark,
                  fontWeight: FontWeight.w800, fontSize: 12)),
          Text(sublabel,
              style: const TextStyle(color: _kTextLight, fontSize: 10)),
        ]),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// SAGESSE ALÉATOIRE (Bottom Sheet)
// ══════════════════════════════════════════════════════════════════════════════
class _SagesseSheet extends StatefulWidget {
  final HadithModel  hadith;
  final bool         isFavori;
  final VoidCallback onToggleFavori;
  final VoidCallback onVoirDetails;

  const _SagesseSheet({
    required this.hadith,
    required this.isFavori,
    required this.onToggleFavori,
    required this.onVoirDetails,
  });

  @override
  State<_SagesseSheet> createState() => _SagesseSheetState();
}

class _SagesseSheetState extends State<_SagesseSheet> {
  late bool _isFavori;

  @override
  void initState() {
    super.initState();
    _isFavori = widget.isFavori;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: _kBeigeCard,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        // Handle
        Center(
          child: Container(
            margin: const EdgeInsets.only(top: 12, bottom: 20),
            width: 40, height: 4,
            decoration: BoxDecoration(color: _kBeigeBorder, borderRadius: BorderRadius.circular(99)),
          ),
        ),

        // Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: _kGoldLight,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: _kGold.withOpacity(0.4)),
          ),
          child: const Row(mainAxisSize: MainAxisSize.min, children: [
            Text('🌟', style: TextStyle(fontSize: 13)),
            SizedBox(width: 6),
            Text('Sagesse du Prophète ﷺ',
                style: TextStyle(color: _kGold, fontSize: 12, fontWeight: FontWeight.w800)),
          ]),
        ),

        const SizedBox(height: 20),

        // Arabe
        Text(widget.hadith.arabe,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            style: const TextStyle(color: _kTextDark, fontSize: 20, height: 1.9)),

        const SizedBox(height: 8),

        // Phonétique
        Text(widget.hadith.phonetique,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: _kTextLight,
                fontSize: 11,
                height: 1.55,
                fontStyle: FontStyle.italic)),

        const SizedBox(height: 14),
        const Divider(color: _kBeigeBorder),
        const SizedBox(height: 14),

        // Traduction
        Text(widget.hadith.traduction,
            textAlign: TextAlign.center,
            style: const TextStyle(color: _kTextMid, fontSize: 14, height: 1.6, fontStyle: FontStyle.italic)),

        const SizedBox(height: 10),

        Text('— ${widget.hadith.narrateur}',
            textAlign: TextAlign.center,
            style: const TextStyle(color: _kGreenPrimary, fontSize: 12, fontWeight: FontWeight.w700)),
        Text(widget.hadith.source,
            textAlign: TextAlign.center,
            style: const TextStyle(color: _kTextLight, fontSize: 11)),

        const SizedBox(height: 24),

        // Boutons
        Row(children: [
          // Favori
          GestureDetector(
            onTap: () { setState(() => _isFavori = !_isFavori); widget.onToggleFavori(); },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              decoration: BoxDecoration(
                color: _isFavori ? _kRedLight : _kBeige,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: _isFavori ? _kRed.withOpacity(0.4) : _kBeigeBorder),
              ),
              child: Row(children: [
                Icon(_isFavori ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
                    color: _isFavori ? _kRed : _kTextLight, size: 18),
                const SizedBox(width: 6),
                Text(_isFavori ? 'Favori' : 'Ajouter',
                    style: TextStyle(color: _isFavori ? _kRed : _kTextMid, fontSize: 12, fontWeight: FontWeight.w700)),
              ]),
            ),
          ),
          const SizedBox(width: 10),
          // Voir détail
          Expanded(
            child: GestureDetector(
              onTap: widget.onVoirDetails,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [_kGreenPrimary, _kGreenMedium]),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text('Voir l\'explication', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w800)),
                  SizedBox(width: 6),
                  Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 14),
                ]),
              ),
            ),
          ),
        ]),
      ]),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// QUIZ HADITHS
// ══════════════════════════════════════════════════════════════════════════════
class _QuizQuestion {
  final String       arabe;
  final String       question;
  final String       correctAnswer;
  final List<String> options;

  _QuizQuestion({
    required this.arabe,
    required this.question,
    required this.correctAnswer,
    required this.options,
  });
}

class HadithQuizScreen extends StatefulWidget {
  final List<HadithModel> hadiths;
  const HadithQuizScreen({Key? key, required this.hadiths}) : super(key: key);

  @override
  State<HadithQuizScreen> createState() => _HadithQuizScreenState();
}

class _HadithQuizScreenState extends State<HadithQuizScreen>
    with SingleTickerProviderStateMixin {
  late final List<_QuizQuestion> _questions;
  int     _current     = 0;
  int     _score       = 0;
  bool    _showFeedback = false;
  bool    _lastCorrect  = false;
  String? _selected;
  bool    _done        = false;

  late AnimationController _feedCtrl;
  late Animation<Offset>   _feedSlide;

  @override
  void initState() {
    super.initState();
    _questions = _buildQuestions();
    _feedCtrl  = AnimationController(vsync: this, duration: const Duration(milliseconds: 280));
    _feedSlide = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(CurvedAnimation(parent: _feedCtrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _feedCtrl.dispose();
    super.dispose();
  }

  List<_QuizQuestion> _buildQuestions() {
    final rng     = Random();
    final indices = List.generate(widget.hadiths.length, (i) => i)..shuffle(rng);
    final picked  = indices.take(5).toList();

    return picked.asMap().entries.map((entry) {
      final qIdx   = entry.key;
      final hIdx   = entry.value;
      final h      = widget.hadiths[hIdx];
      final others = (List<int>.from(indices.where((i) => i != hIdx))..shuffle(rng)).take(3).toList();
      final type   = qIdx % 3;

      String question;
      String correct;
      List<String> opts;

      if (type == 0) {
        question = 'Qui a rapporté ce hadith ?';
        correct  = h.narrateur;
        opts     = [correct, ...others.map((i) => widget.hadiths[i].narrateur)];
      } else if (type == 1) {
        question = 'Quelle est la traduction de ce hadith ?';
        correct  = h.traduction;
        opts     = [correct, ...others.map((i) => widget.hadiths[i].traduction)];
      } else {
        question = 'Quelle est la meilleure explication ?';
        String shorten(String s) => s.length > 90 ? '${s.substring(0, 87)}...' : s;
        correct  = shorten(h.explication);
        opts     = [correct, ...others.map((i) => shorten(widget.hadiths[i].explication))];
      }
      opts.shuffle(rng);

      return _QuizQuestion(
        arabe:         h.arabe,
        question:      question,
        correctAnswer: correct,
        options:       opts,
      );
    }).toList();
  }

  void _onAnswer(String answer) {
    if (_showFeedback) return;
    final correct = answer == _questions[_current].correctAnswer;
    if (correct) _score++;
    setState(() { _selected = answer; _lastCorrect = correct; _showFeedback = true; });
    _feedCtrl.forward(from: 0);
  }

  void _next() {
    _feedCtrl.reverse();
    Future.delayed(const Duration(milliseconds: 180), () {
      if (!mounted) return;
      setState(() {
        _showFeedback = false;
        _selected     = null;
        if (_current + 1 >= _questions.length) { _done = true; }
        else { _current++; }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_done) return _buildResult(context);

    final q        = _questions[_current];
    final progress = _current / _questions.length;

    return Scaffold(
      backgroundColor: _kBeige,
      body: SafeArea(
        child: Stack(children: [
          Column(children: [
            // Top bar
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [_kGreenDeep, Color(0xFF112B1E)],
                    begin: Alignment.topLeft, end: Alignment.bottomRight),
              ),
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
              child: Column(children: [
                Row(children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.14),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.close_rounded, color: Colors.white, size: 18),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text('Quiz Hadiths',
                        style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w800)),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: _kGold.withOpacity(0.22),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text('⚡ $_score / ${_questions.length}',
                        style: const TextStyle(color: _kGold, fontSize: 12, fontWeight: FontWeight.w800)),
                  ),
                ]),
                const SizedBox(height: 14),
                ClipRRect(
                  borderRadius: BorderRadius.circular(99),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 6,
                    backgroundColor: Colors.white.withOpacity(0.18),
                    valueColor: const AlwaysStoppedAnimation(_kGold),
                  ),
                ),
              ]),
            ),

            // Question
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),
                child: Column(children: [
                  // Badge question
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: _kGold.withOpacity(0.13),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: _kGold.withOpacity(0.35)),
                    ),
                    child: Text(q.question,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: _kGold, fontSize: 12, fontWeight: FontWeight.w700)),
                  ),
                  const SizedBox(height: 18),

                  // Arabe
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF0D3A25), Color(0xFF1B5E40)],
                        begin: Alignment.topLeft, end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [BoxShadow(color: _kGreenPrimary.withOpacity(0.28), blurRadius: 16, offset: const Offset(0, 5))],
                    ),
                    child: Text(q.arabe,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: _kGold, fontSize: 18, height: 1.9)),
                  ),
                  const SizedBox(height: 20),

                  // Options
                  ...q.options.map((opt) => _buildOption(opt, q.correctAnswer)),
                ]),
              ),
            ),
          ]),

          // Feedback
          if (_showFeedback)
            Positioned(
              bottom: 0, left: 0, right: 0,
              child: SlideTransition(
                position: _feedSlide,
                child: _buildFeedback(q),
              ),
            ),
        ]),
      ),
    );
  }

  Widget _buildOption(String opt, String correct) {
    Color bg     = _kBeigeCard;
    Color border = _kBeigeBorder;
    Color text   = _kTextDark;
    Widget? icon;

    if (_showFeedback) {
      if (opt == _selected) {
        if (_lastCorrect) {
          bg = _kGreenLight; border = _kGreen; text = const Color(0xFF1B6B2B);
          icon = const Icon(Icons.check_circle_rounded, color: _kGreen, size: 20);
        } else {
          bg = _kRedLight; border = _kRed; text = const Color(0xFF9B1A1A);
          icon = const Icon(Icons.cancel_rounded, color: _kRed, size: 20);
        }
      } else if (opt == correct && !_lastCorrect) {
        bg = _kGreenLight; border = _kGreen; text = const Color(0xFF1B6B2B);
        icon = const Icon(Icons.check_circle_rounded, color: _kGreen, size: 20);
      }
    }

    return GestureDetector(
      onTap: _showFeedback ? null : () => _onAnswer(opt),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: border, width: 1.5),
        ),
        child: Row(children: [
          Expanded(child: Text(opt, style: TextStyle(color: text, fontSize: 13, fontWeight: FontWeight.w600, height: 1.4))),
          if (icon != null) icon,
        ]),
      ),
    );
  }

  Widget _buildFeedback(_QuizQuestion q) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 30),
      decoration: BoxDecoration(
        color: _lastCorrect ? _kGreenLight : _kRedLight,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(top: BorderSide(color: _lastCorrect ? _kGreen : _kRed, width: 2)),
      ),
      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text(_lastCorrect ? '✅' : '❌', style: const TextStyle(fontSize: 22)),
          const SizedBox(width: 10),
          Text(_lastCorrect ? 'Correct ! +1 ⚡' : 'Pas tout à fait...',
              style: TextStyle(
                color: _lastCorrect ? const Color(0xFF1B6B2B) : const Color(0xFF9B1A1A),
                fontSize: 16, fontWeight: FontWeight.w800,
              )),
        ]),
        if (!_lastCorrect) ...[
          const SizedBox(height: 8),
          Text('Bonne réponse :', style: TextStyle(color: Colors.grey[600], fontSize: 11)),
          const SizedBox(height: 3),
          Text(q.correctAnswer,
              style: const TextStyle(color: _kTextDark, fontSize: 12, fontWeight: FontWeight.w700)),
        ],
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _next,
            style: ElevatedButton.styleFrom(
              backgroundColor: _lastCorrect ? _kGreen : _kRed,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              padding: const EdgeInsets.symmetric(vertical: 14), elevation: 0,
            ),
            child: const Text('Continuer →', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
          ),
        ),
      ]),
    );
  }

  Widget _buildResult(BuildContext context) {
    final total  = _questions.length;
    final pct    = _score / total;
    final passed = pct >= 0.60;

    return Scaffold(
      backgroundColor: _kBeige,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(children: [
            const SizedBox(height: 24),
            Text(pct >= 0.80 ? '🏆' : pct >= 0.60 ? '⭐' : '📚',
                style: const TextStyle(fontSize: 80)),
            const SizedBox(height: 16),
            Text(passed ? 'Bien joué !' : 'Encore un effort !',
                style: TextStyle(
                  color: passed ? _kGreenPrimary : _kOrange,
                  fontSize: 26, fontWeight: FontWeight.w900,
                )),
            const SizedBox(height: 8),
            Text(
              'Tu as obtenu $_score/$total bonnes réponses (${(pct * 100).round()}%).',
              textAlign: TextAlign.center,
              style: const TextStyle(color: _kTextMid, fontSize: 14, height: 1.5),
            ),
            const SizedBox(height: 30),

            // Score bar
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: _kBeigeCard,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: _kBeigeBorder),
              ),
              child: Column(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(99),
                  child: LinearProgressIndicator(
                    value:           pct,
                    minHeight:       10,
                    backgroundColor: _kBeigeBorder,
                    valueColor:      AlwaysStoppedAnimation(passed ? _kGreenPrimary : _kOrange),
                  ),
                ),
                const SizedBox(height: 20),
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                  _stat('✅', '$_score', 'Corrects'),
                  _stat('❌', '${total - _score}', 'Erreurs'),
                  _stat('📊', '${(pct * 100).round()}%', 'Score'),
                ]),
              ]),
            ),

            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _kGreenPrimary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  padding: const EdgeInsets.symmetric(vertical: 14), elevation: 0,
                ),
                child: const Text('Retour aux hadiths 📖',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () => setState(() {
                _done = false; _current = 0; _score = 0;
                _showFeedback = false; _selected = null;
                _questions.shuffle(Random());
              }),
              child: const Text('Recommencer le quiz',
                  style: TextStyle(color: _kTextLight, fontSize: 13)),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _stat(String emoji, String val, String label) {
    return Column(children: [
      Text(emoji, style: const TextStyle(fontSize: 20)),
      const SizedBox(height: 4),
      Text(val, style: const TextStyle(color: _kTextDark, fontSize: 17, fontWeight: FontWeight.w900)),
      Text(label, style: const TextStyle(color: _kTextLight, fontSize: 10)),
    ]);
  }
}
