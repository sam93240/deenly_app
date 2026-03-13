// protection_versets_data.dart — Versets de protection

class VersetProtection {
  final String id;
  final String title;
  final String emoji;
  final String arabic;
  final String phonetic;
  final String translation;
  final String reference;
  final String power;
  final String whenToRecite;
  final int repeat;
  const VersetProtection({
    required this.id,
    required this.title,
    required this.emoji,
    required this.arabic,
    required this.phonetic,
    required this.translation,
    required this.reference,
    required this.power,
    required this.whenToRecite,
    this.repeat = 1,
  });
}

const kVersetsProtection = <VersetProtection>[
  // 1 — AYAT AL-KURSI
  VersetProtection(
    id: 'ayat_kursi',
    title: 'Ayat al-Kursi',
    emoji: '\uD83D\uDC51',
    arabic: '\u0627\u0644\u0644\u0651\u064E\u0647\u064F \u0644\u0627 \u0625\u0650\u0644\u064E\u0640\u0647\u064E \u0625\u0650\u0644\u0651\u064E\u0627 \u0647\u064F\u0648\u064E \u0627\u0644\u0652\u062D\u064E\u064A\u0651\u064F \u0627\u0644\u0652\u0642\u064E\u064A\u0651\u064F\u0648\u0645\u064F \u06DA \u0644\u064E\u0627 \u062A\u064E\u0623\u0652\u062E\u064F\u0630\u064F\u0647\u064F \u0633\u0650\u0646\u064E\u0629\u064C \u0648\u064E\u0644\u064E\u0627 \u0646\u064E\u0648\u0652\u0645\u064C \u06DA \u0644\u064E\u0647\u064F \u0645\u064E\u0627 \u0641\u0650\u064A \u0627\u0644\u0633\u0651\u064E\u0645\u064E\u0627\u0648\u064E\u0627\u062A\u0650 \u0648\u064E\u0645\u064E\u0627 \u0641\u0650\u064A \u0627\u0644\u0652\u0623\u064E\u0631\u0652\u0636\u0650 \u06DA \u0645\u064E\u0646 \u0630\u064E\u0627 \u0627\u0644\u0651\u064E\u0630\u0650\u064A \u064A\u064E\u0634\u0652\u0641\u064E\u0639\u064F \u0639\u0650\u0646\u0652\u062F\u064E\u0647\u064F \u0625\u0650\u0644\u0651\u064E\u0627 \u0628\u0650\u0625\u0650\u0630\u0652\u0646\u0650\u0647\u0650 \u06DA \u064A\u064E\u0639\u0652\u0644\u064E\u0645\u064F \u0645\u064E\u0627 \u0628\u064E\u064A\u0652\u0646\u064E \u0623\u064E\u064A\u0652\u062F\u0650\u064A\u0647\u0650\u0645\u0652 \u0648\u064E\u0645\u064E\u0627 \u062E\u064E\u0644\u0652\u0641\u064E\u0647\u064F\u0645\u0652 \u06DA \u0648\u064E\u0644\u064E\u0627 \u064A\u064F\u062D\u0650\u064A\u0637\u064F\u0648\u0646\u064E \u0628\u0650\u0634\u064E\u064A\u0652\u0621\u064D \u0645\u0650\u0646\u0652 \u0639\u0650\u0644\u0652\u0645\u0650\u0647\u0650 \u0625\u0650\u0644\u0651\u064E\u0627 \u0628\u0650\u0645\u064E\u0627 \u0634\u064E\u0627\u0621\u064E \u06DA \u0648\u064E\u0633\u0650\u0639\u064E \u0643\u064F\u0631\u0652\u0633\u0650\u064A\u0651\u064F\u0647\u064F \u0627\u0644\u0633\u0651\u064E\u0645\u064E\u0627\u0648\u064E\u0627\u062A\u0650 \u0648\u064E\u0627\u0644\u0652\u0623\u064E\u0631\u0652\u0636\u064E \u06DA \u0648\u064E\u0644\u064E\u0627 \u064A\u064E\u0626\u064F\u0648\u062F\u064F\u0647\u064F \u062D\u0650\u0641\u0652\u0638\u064F\u0647\u064F\u0645\u064E\u0627 \u06DA \u0648\u064E\u0647\u064F\u0648\u064E \u0627\u0644\u0652\u0639\u064E\u0644\u0650\u064A\u0651\u064F \u0627\u0644\u0652\u0639\u064E\u0638\u0650\u064A\u0645\u064F',
    phonetic: 'Allahu la ilaha illa Huwal-Hayyul-Qayyum. La ta\'khudhuh sinatun wa la nawm. Lahu ma fis-samawati wa ma fil-ard. Man dhal-ladhi yashfa\'u \'indahu illa bi-idhnih. Ya\'lamu ma bayna aydihim wa ma khalfahum. Wa la yuhituna bi-shay\'in min \'ilmihi illa bima sha\'. Wasi\'a kursiyyuhus-samawati wal-ard. Wa la ya\'uduhu hifdhuhuma. Wa Huwal-\'Aliyyul-\'Adhim.',
    translation: 'Allah ! Point de divinit\u00e9 \u00e0 part Lui, le Vivant, Celui qui subsiste par Lui-m\u00eame. Ni somnolence ni sommeil ne Le saisissent. A Lui appartient tout ce qui est dans les cieux et sur la terre. Qui peut interc\u00e9der aupr\u00e8s de Lui sans Sa permission ? Il conna\u00eet leur pass\u00e9 et leur futur. Et de Sa science, ils n\'embrassent que ce qu\'Il veut. Son Tr\u00f4ne d\u00e9borde les cieux et la terre dont la garde ne Lui co\u00fbte aucune peine. Et Il est le Tr\u00e8s-Haut, le Tr\u00e8s-Grand.',
    reference: 'Al-Baqara, 2:255',
    power: 'Le plus grand verset du Coran. Le Proph\u00e8te \u00a7 a dit : celui qui le r\u00e9cite le soir, un gardien d\'Allah le prot\u00e8ge et aucun d\u00e9mon ne l\'approche jusqu\'au matin (Bukhari). Abu Hurayra a rapport\u00e9 qu\'un jinn lui a r\u00e9v\u00e9l\u00e9 ce secret et le Proph\u00e8te \u00a7 l\'a confirm\u00e9.',
    whenToRecite: 'Apr\u00e8s chaque pri\u00e8re obligatoire, avant de dormir, matin et soir, en entrant dans un lieu.',
  ),

  // 2 — SOURATE AL-FATIHA
  VersetProtection(
    id: 'fatiha',
    title: 'Sourate Al-Fatiha',
    emoji: '\uD83D\uDCD6',
    arabic: '\u0628\u0650\u0633\u0652\u0645\u0650 \u0627\u0644\u0644\u0651\u064E\u0647\u0650 \u0627\u0644\u0631\u0651\u064E\u062D\u0652\u0645\u064E\u0640\u0646\u0650 \u0627\u0644\u0631\u0651\u064E\u062D\u0650\u064A\u0645\u0650 \u00b7 \u0627\u0644\u0652\u062D\u064E\u0645\u0652\u062F\u064F \u0644\u0650\u0644\u0651\u064E\u0647\u0650 \u0631\u064E\u0628\u0651\u0650 \u0627\u0644\u0652\u0639\u064E\u0627\u0644\u064E\u0645\u0650\u064A\u0646\u064E \u00b7 \u0627\u0644\u0631\u0651\u064E\u062D\u0652\u0645\u064E\u0640\u0646\u0650 \u0627\u0644\u0631\u0651\u064E\u062D\u0650\u064A\u0645\u0650 \u00b7 \u0645\u064E\u0627\u0644\u0650\u0643\u0650 \u064A\u064E\u0648\u0652\u0645\u0650 \u0627\u0644\u062F\u0651\u0650\u064A\u0646\u0650 \u00b7 \u0625\u0650\u064A\u0651\u064E\u0627\u0643\u064E \u0646\u064E\u0639\u0652\u0628\u064F\u062F\u064F \u0648\u064E\u0625\u0650\u064A\u0651\u064E\u0627\u0643\u064E \u0646\u064E\u0633\u0652\u062A\u064E\u0639\u0650\u064A\u0646\u064F \u00b7 \u0627\u0647\u0652\u062F\u0650\u0646\u064E\u0627 \u0627\u0644\u0635\u0651\u0650\u0631\u064E\u0627\u0637\u064E \u0627\u0644\u0652\u0645\u064F\u0633\u0652\u062A\u064E\u0642\u0650\u064A\u0645\u064E \u00b7 \u0635\u0650\u0631\u064E\u0627\u0637\u064E \u0627\u0644\u0651\u064E\u0630\u0650\u064A\u0646\u064E \u0623\u064E\u0646\u0652\u0639\u064E\u0645\u0652\u062A\u064E \u0639\u064E\u0644\u064E\u064A\u0652\u0647\u0650\u0645\u0652 \u063A\u064E\u064A\u0652\u0631\u0650 \u0627\u0644\u0652\u0645\u064E\u063A\u0652\u0636\u064F\u0648\u0628\u0650 \u0639\u064E\u0644\u064E\u064A\u0652\u0647\u0650\u0645\u0652 \u0648\u064E\u0644\u064E\u0627 \u0627\u0644\u0636\u0651\u064E\u0627\u0644\u0651\u0650\u064A\u0646\u064E',
    phonetic: 'Bismillahir-Rahmanir-Rahim. Al-hamdu lillahi Rabbil-\'alamin. Ar-Rahmanir-Rahim. Maliki yawmid-din. Iyyaka na\'budu wa iyyaka nasta\'in. Ihdinas-siratal-mustaqim. Siratal-ladhina an\'amta \'alayhim ghayril-maghdubi \'alayhim wa lad-dallin.',
    translation: 'Au nom d\'Allah, le Tout Mis\u00e9ricordieux, le Tr\u00e8s Mis\u00e9ricordieux. Louange \u00e0 Allah, Seigneur des mondes. Le Tout Mis\u00e9ricordieux, le Tr\u00e8s Mis\u00e9ricordieux. Ma\u00eetre du Jour de la R\u00e9tribution. C\'est Toi seul que nous adorons, et c\'est Toi seul dont nous implorons secours. Guide-nous dans le droit chemin. Le chemin de ceux que Tu as combl\u00e9 de faveurs, non pas de ceux qui ont encouru Ta col\u00e8re, ni des \u00e9gar\u00e9s.',
    reference: 'Al-Fatiha, 1:1-7',
    power: 'Appel\u00e9e \u00ab la Gu\u00e9risseuse \u00bb (Ash-Shafiya) et \u00ab la M\u00e8re du Livre \u00bb (Umm al-Kitab). Le Proph\u00e8te \u00a7 a dit : \u00ab Al-Fatiha est une gu\u00e9rison pour toute maladie \u00bb. Abu Sa\'id al-Khudri l\'a utilis\u00e9e comme roqya sur un chef de tribu piqu\u00e9 par un scorpion, et il a gu\u00e9ri (Bukhari).',
    whenToRecite: 'Pendant la roqya (7 fois), en cas de douleur, pour toute demande de gu\u00e9rison.',
    repeat: 7,
  ),

  // 3 — LES DEUX DERNIERS VERSETS DE AL-BAQARA
  VersetProtection(
    id: 'baqara_fin',
    title: 'Fin de Sourate Al-Baqara',
    emoji: '\uD83C\uDF19',
    arabic: '\u0622\u0645\u064E\u0646\u064E \u0627\u0644\u0631\u0651\u064E\u0633\u064F\u0648\u0644\u064F \u0628\u0650\u0645\u064E\u0627 \u0623\u064F\u0646\u0632\u0650\u0644\u064E \u0625\u0650\u0644\u064E\u064A\u0652\u0647\u0650 \u0645\u0650\u0646 \u0631\u0651\u064E\u0628\u0651\u0650\u0647\u0650 \u0648\u064E\u0627\u0644\u0652\u0645\u064F\u0624\u0652\u0645\u0650\u0646\u064F\u0648\u0646\u064E \u06DA \u0643\u064F\u0644\u0651\u064C \u0622\u0645\u064E\u0646\u064E \u0628\u0650\u0627\u0644\u0644\u0651\u064E\u0647\u0650 \u0648\u064E\u0645\u064E\u0644\u064E\u0627\u0626\u0650\u0643\u064E\u062A\u0650\u0647\u0650 \u0648\u064E\u0643\u064F\u062A\u064F\u0628\u0650\u0647\u0650 \u0648\u064E\u0631\u064F\u0633\u064F\u0644\u0650\u0647\u0650 \u0644\u064E\u0627 \u0646\u064F\u0641\u064E\u0631\u0651\u0650\u0642\u064F \u0628\u064E\u064A\u0652\u0646\u064E \u0623\u064E\u062D\u064E\u062F\u064D \u0645\u0650\u0646 \u0631\u064F\u0633\u064F\u0644\u0650\u0647\u0650',
    phonetic: 'Amanar-rasulu bima unzila ilayhi mir-rabbihi wal-mu\'minun. Kullun amana billahi wa mala\'ikatihi wa kutubihi wa rusulihi la nufarriqu bayna ahadin mir-rusulih...',
    translation: 'Le Messager a cru en ce qu\'on a fait descendre vers lui venant de son Seigneur, et aussi les croyants. Tous ont cru en Allah, en Ses anges, \u00e0 Ses livres et en Ses messagers (en disant) : \u00ab Nous ne faisons aucune distinction entre Ses messagers \u00bb...',
    reference: 'Al-Baqara, 2:285-286',
    power: 'Le Proph\u00e8te \u00a7 a dit : \u00ab Quiconque r\u00e9cite les deux derniers versets de Sourate Al-Baqara la nuit, cela lui suffira \u00bb (Bukhari et Muslim). Les savants ont expliqu\u00e9 que \u00ab cela lui suffira \u00bb signifie : suffira comme protection contre tout mal pendant la nuit.',
    whenToRecite: 'Chaque soir avant de dormir.',
  ),

  // 4 — SOURATE AL-IKHLAS
  VersetProtection(
    id: 'ikhlas',
    title: 'Sourate Al-Ikhlas',
    emoji: '\u2728',
    arabic: '\u0642\u064F\u0644\u0652 \u0647\u064F\u0648\u064E \u0627\u0644\u0644\u0651\u064E\u0647\u064F \u0623\u064E\u062D\u064E\u062F\u064C \u00b7 \u0627\u0644\u0644\u0651\u064E\u0647\u064F \u0627\u0644\u0635\u0651\u064E\u0645\u064E\u062F\u064F \u00b7 \u0644\u064E\u0645\u0652 \u064A\u064E\u0644\u0650\u062F\u0652 \u0648\u064E\u0644\u064E\u0645\u0652 \u064A\u064F\u0648\u0644\u064E\u062F\u0652 \u00b7 \u0648\u064E\u0644\u064E\u0645\u0652 \u064A\u064E\u0643\u064F\u0646 \u0644\u064E\u0647\u064F \u0643\u064F\u0641\u064F\u0648\u064B\u0627 \u0623\u064E\u062D\u064E\u062F\u064C',
    phonetic: 'Qul Huwa Allahu Ahad. Allahus-Samad. Lam yalid wa lam yulad. Wa lam yakun lahu kufuwan ahad.',
    translation: 'Dis : Il est Allah, Unique. Allah, Le Seul \u00e0 \u00eatre implor\u00e9 pour ce que nous d\u00e9sirons. Il n\'a jamais engendr\u00e9, n\'a pas \u00e9t\u00e9 engendr\u00e9 non plus. Et nul n\'est \u00e9gal \u00e0 Lui.',
    reference: 'Al-Ikhlas, 112:1-4',
    power: '\u00c9quivaut \u00e0 un tiers du Coran. Le Proph\u00e8te \u00a7 la r\u00e9citait 3 fois matin et soir comme protection. Associ\u00e9e aux Mu\'awwidhat, elle forme le bouclier le plus puissant.',
    whenToRecite: '3 fois matin et soir, apr\u00e8s chaque pri\u00e8re, avant de dormir.',
    repeat: 3,
  ),

  // 5 — SOURATE AL-FALAQ
  VersetProtection(
    id: 'falaq',
    title: 'Sourate Al-Falaq',
    emoji: '\uD83C\uDF05',
    arabic: '\u0642\u064F\u0644\u0652 \u0623\u064E\u0639\u064F\u0648\u0630\u064F \u0628\u0650\u0631\u064E\u0628\u0651\u0650 \u0627\u0644\u0652\u0641\u064E\u0644\u064E\u0642\u0650 \u00b7 \u0645\u0650\u0646 \u0634\u064E\u0631\u0651\u0650 \u0645\u064E\u0627 \u062E\u064E\u0644\u064E\u0642\u064E \u00b7 \u0648\u064E\u0645\u0650\u0646 \u0634\u064E\u0631\u0651\u0650 \u063A\u064E\u0627\u0633\u0650\u0642\u064D \u0625\u0650\u0630\u064E\u0627 \u0648\u064E\u0642\u064E\u0628\u064E \u00b7 \u0648\u064E\u0645\u0650\u0646 \u0634\u064E\u0631\u0651\u0650 \u0627\u0644\u0646\u0651\u064E\u0641\u0651\u064E\u0627\u062B\u064E\u0627\u062A\u0650 \u0641\u0650\u064A \u0627\u0644\u0652\u0639\u064F\u0642\u064E\u062F\u0650 \u00b7 \u0648\u064E\u0645\u0650\u0646 \u0634\u064E\u0631\u0651\u0650 \u062D\u064E\u0627\u0633\u0650\u062F\u064D \u0625\u0650\u0630\u064E\u0627 \u062D\u064E\u0633\u064E\u062F\u064E',
    phonetic: 'Qul a\'udhu bi-Rabbil-falaq. Min sharri ma khalaq. Wa min sharri ghasiqin idha waqab. Wa min sharrin-naffathati fil-\'uqad. Wa min sharri hasidin idha hasad.',
    translation: 'Dis : Je cherche protection aupr\u00e8s du Seigneur de l\'aube naissante, contre le mal de ce qu\'Il a cr\u00e9\u00e9, contre le mal de l\'obscurit\u00e9 quand elle s\'\u00e9tend, contre le mal de celles qui soufflent sur les noeuds, et contre le mal de l\'envieux quand il envie.',
    reference: 'Al-Falaq, 113:1-5',
    power: 'Protection directe contre la sorcellerie (les souffleuses dans les noeuds = les sorci\u00e8res) et la jalousie. Le verset 4 vise sp\u00e9cifiquement le sihr. Le Proph\u00e8te \u00a7 a dit qu\'il n\'y a rien de meilleur pour se prot\u00e9ger que les Mu\'awwidhat.',
    whenToRecite: '3 fois matin et soir, apr\u00e8s chaque pri\u00e8re, en cas de peur ou de menace.',
    repeat: 3,
  ),

  // 6 — SOURATE AN-NAS
  VersetProtection(
    id: 'nas',
    title: 'Sourate An-Nas',
    emoji: '\uD83D\uDE4F',
    arabic: '\u0642\u064F\u0644\u0652 \u0623\u064E\u0639\u064F\u0648\u0630\u064F \u0628\u0650\u0631\u064E\u0628\u0651\u0650 \u0627\u0644\u0646\u0651\u064E\u0627\u0633\u0650 \u00b7 \u0645\u064E\u0644\u0650\u0643\u0650 \u0627\u0644\u0646\u0651\u064E\u0627\u0633\u0650 \u00b7 \u0625\u0650\u0644\u064E\u0640\u0647\u0650 \u0627\u0644\u0646\u0651\u064E\u0627\u0633\u0650 \u00b7 \u0645\u0650\u0646 \u0634\u064E\u0631\u0651\u0650 \u0627\u0644\u0652\u0648\u064E\u0633\u0652\u0648\u064E\u0627\u0633\u0650 \u0627\u0644\u0652\u062E\u064E\u0646\u0651\u064E\u0627\u0633\u0650 \u00b7 \u0627\u0644\u0651\u064E\u0630\u0650\u064A \u064A\u064F\u0648\u064E\u0633\u0652\u0648\u0650\u0633\u064F \u0641\u0650\u064A \u0635\u064F\u062F\u064F\u0648\u0631\u0650 \u0627\u0644\u0646\u0651\u064E\u0627\u0633\u0650 \u00b7 \u0645\u0650\u0646\u064E \u0627\u0644\u0652\u062C\u0650\u0646\u0651\u064E\u0629\u0650 \u0648\u064E\u0627\u0644\u0646\u0651\u064E\u0627\u0633\u0650',
    phonetic: 'Qul a\'udhu bi-Rabbin-nas. Malikin-nas. Ilahin-nas. Min sharril-waswasil-khannas. Alladhi yuwaswisu fi sudurin-nas. Minal-jinnati wan-nas.',
    translation: 'Dis : Je cherche protection aupr\u00e8s du Seigneur des hommes, le Souverain des hommes, le Dieu des hommes, contre le mal du chuchoteur furtif, qui chuchote dans les poitrines des gens, qu\'il soit parmi les jinn ou parmi les hommes.',
    reference: 'An-Nas, 114:1-6',
    power: 'Protection contre le waswas (chuchotements) des jinn ET des humains. Le mot \u00ab khannas \u00bb (furtif) signifie que le Shaytan recule quand on mentionne Allah et revient quand on oublie. Cette sourate est l\'antidote au waswas.',
    whenToRecite: '3 fois matin et soir, quand on ressent du waswas, avant de dormir.',
    repeat: 3,
  ),

  // 7 — VERSETS ANTI-SIHR (A'raf)
  VersetProtection(
    id: 'araf_sihr',
    title: 'Versets anti-sihr (Al-A\'raf)',
    emoji: '\u2694\uFE0F',
    arabic: '\u0648\u064E\u0623\u064E\u0648\u0652\u062D\u064E\u064A\u0652\u0646\u064E\u0627 \u0625\u0650\u0644\u064E\u0649\u0670 \u0645\u064F\u0648\u0633\u064E\u0649\u0670 \u0623\u064E\u0646\u0652 \u0623\u064E\u0644\u0652\u0642\u0650 \u0639\u064E\u0635\u064E\u0627\u0643\u064E \u06DA \u0641\u064E\u0625\u0650\u0630\u064E\u0627 \u0647\u0650\u064A\u064E \u062A\u064E\u0644\u0652\u0642\u064E\u0641\u064F \u0645\u064E\u0627 \u064A\u064E\u0623\u0652\u0641\u0650\u0643\u064F\u0648\u0646\u064E \u00b7 \u0641\u064E\u0648\u064E\u0642\u064E\u0639\u064E \u0627\u0644\u0652\u062D\u064E\u0642\u0651\u064F \u0648\u064E\u0628\u064E\u0637\u064E\u0644\u064E \u0645\u064E\u0627 \u0643\u064E\u0627\u0646\u064F\u0648\u0627 \u064A\u064E\u0639\u0652\u0645\u064E\u0644\u064F\u0648\u0646\u064E',
    phonetic: 'Wa awhayna ila Musa an alqi \'asak. Fa-idha hiya talqafu ma ya\'fikun. Fawaqa\'al-haqqu wa batala ma kanu ya\'malun.',
    translation: 'Et Nous r\u00e9v\u00e9l\u00e2mes \u00e0 Mo\u00efse : \u00ab Jette ton b\u00e2ton \u00bb. Et voil\u00e0 que celui-ci se mit \u00e0 engloutir ce qu\'ils avaient fabriqu\u00e9. Ainsi la v\u00e9rit\u00e9 se manifesta et ce qu\'ils firent fut vain.',
    reference: 'Al-A\'raf, 7:117-118',
    power: 'Ces versets racontent la d\u00e9faite des sorciers de Pharaon devant Moussa (\u0639\u0644\u064A\u0647 \u0627\u0644\u0633\u0644\u0627\u0645). Ils sont utilis\u00e9s dans la roqya pour annuler les effets de la sorcellerie. Le Coran a vaincu la sorcellerie \u00e0 l\'\u00e9poque de Moussa et continue de la vaincre aujourd\'hui.',
    whenToRecite: 'Pendant la roqya, en cas de suspicion de sihr, sur l\'eau coranis\u00e9e.',
  ),

  // 8 — VERSETS ANTI-SIHR (Yunus)
  VersetProtection(
    id: 'yunus_sihr',
    title: 'Versets anti-sihr (Yunus)',
    emoji: '\u2694\uFE0F',
    arabic: '\u0641\u064E\u0644\u064E\u0645\u0651\u064E\u0627 \u0623\u064E\u0644\u0652\u0642\u064E\u0648\u0652\u0627 \u0642\u064E\u0627\u0644\u064E \u0645\u064F\u0648\u0633\u064E\u0649\u0670 \u0645\u064E\u0627 \u062C\u0650\u0626\u0652\u062A\u064F\u0645 \u0628\u0650\u0647\u0650 \u0627\u0644\u0633\u0651\u0650\u062D\u0652\u0631\u064F \u06DA \u0625\u0650\u0646\u0651\u064E \u0627\u0644\u0644\u0651\u064E\u0647\u064E \u0633\u064E\u064A\u064F\u0628\u0652\u0637\u0650\u0644\u064F\u0647\u064F \u06DA \u0625\u0650\u0646\u0651\u064E \u0627\u0644\u0644\u0651\u064E\u0647\u064E \u0644\u064E\u0627 \u064A\u064F\u0635\u0652\u0644\u0650\u062D\u064F \u0639\u064E\u0645\u064E\u0644\u064E \u0627\u0644\u0652\u0645\u064F\u0641\u0652\u0633\u0650\u062F\u0650\u064A\u0646\u064E',
    phonetic: 'Falamma alqaw qala Musa ma ji\'tum bihis-sihr. Innallaha sayubtiluhu. Innallaha la yuslihu \'amalal-mufsidin.',
    translation: 'Puis quand ils eurent jet\u00e9 (leurs sortil\u00e8ges), Mo\u00efse dit : \u00ab Ce que vous avez produit est de la magie ! Allah l\'annulera. Car Allah ne fait pas prosp\u00e9rer l\'\u0153uvre des corrupteurs. \u00bb',
    reference: 'Yunus, 10:81',
    power: 'Parole directe du proph\u00e8te Moussa (\u0639\u0644\u064A\u0647 \u0627\u0644\u0633\u0644\u0627\u0645) contre les sorciers. La promesse divine est claire : Allah annulera la sorcellerie. Ce verset est essentiel dans tout programme de roqya.',
    whenToRecite: 'Pendant la roqya, sur l\'eau coranis\u00e9e, en cas de suspicion de sihr.',
  ),

  // 9 — VERSETS ANTI-SIHR (Ta-Ha)
  VersetProtection(
    id: 'taha_sihr',
    title: 'Versets anti-sihr (Ta-Ha)',
    emoji: '\u2694\uFE0F',
    arabic: '\u0642\u064F\u0644\u0652\u0646\u064E\u0627 \u0644\u064E\u0627 \u062A\u064E\u062E\u064E\u0641\u0652 \u0625\u0650\u0646\u0651\u064E\u0643\u064E \u0623\u064E\u0646\u062A\u064E \u0627\u0644\u0652\u0623\u064E\u0639\u0652\u0644\u064E\u0649\u0670 \u00b7 \u0648\u064E\u0623\u064E\u0644\u0652\u0642\u0650 \u0645\u064E\u0627 \u0641\u0650\u064A \u064A\u064E\u0645\u0650\u064A\u0646\u0650\u0643\u064E \u062A\u064E\u0644\u0652\u0642\u064E\u0641\u0652 \u0645\u064E\u0627 \u0635\u064E\u0646\u064E\u0639\u064F\u0648\u0627 \u06DA \u0625\u0650\u0646\u0651\u064E\u0645\u064E\u0627 \u0635\u064E\u0646\u064E\u0639\u064F\u0648\u0627 \u0643\u064E\u064A\u0652\u062F\u064F \u0633\u064E\u0627\u062D\u0650\u0631\u064D \u06DA \u0648\u064E\u0644\u064E\u0627 \u064A\u064F\u0641\u0652\u0644\u0650\u062D\u064F \u0627\u0644\u0633\u0651\u064E\u0627\u062D\u0650\u0631\u064F \u062D\u064E\u064A\u0652\u062B\u064F \u0623\u064E\u062A\u064E\u0649\u0670',
    phonetic: 'Qulna la takhaf innaka antal-a\'la. Wa alqi ma fi yaminika talqaf ma sana\'u. Innama sana\'u kaydu sahir. Wa la yuflihus-sahiru haythu ata.',
    translation: 'Nous d\u00eemes : \u00ab N\'aie pas peur, c\'est toi qui auras le dessus. Jette ce qu\'il y a dans ta main droite ; cela avalera ce qu\'ils ont fabriqu\u00e9. Ce qu\'ils ont fabriqu\u00e9 n\'est que ruse de sorcier ; et le sorcier ne r\u00e9ussira pas, o\u00f9 qu\'il soit. \u00bb',
    reference: 'Ta-Ha, 20:68-69',
    power: 'La promesse divine ultime contre la sorcellerie : \u00ab le sorcier ne r\u00e9ussira pas, o\u00f9 qu\'il soit \u00bb. Ce verset est un pilier de la roqya. Il brise le d\u00e9sespoir et rappelle que la v\u00e9rit\u00e9 d\'Allah triomphera toujours sur la ruse des sorciers.',
    whenToRecite: 'Pendant la roqya, sur l\'eau coranis\u00e9e, en cas de suspicion de sihr.',
  ),

  // 10 — VERSET DE GUÉRISON (AL-ISRA)
  VersetProtection(
    id: 'isra_shifa',
    title: 'Verset de la Gu\u00e9rison',
    emoji: '\uD83D\uDC9A',
    arabic: '\u0648\u064E\u0646\u064F\u0646\u064E\u0632\u0651\u0650\u0644\u064F \u0645\u0650\u0646\u064E \u0627\u0644\u0652\u0642\u064F\u0631\u0652\u0622\u0646\u0650 \u0645\u064E\u0627 \u0647\u064F\u0648\u064E \u0634\u0650\u0641\u064E\u0627\u0621\u064C \u0648\u064E\u0631\u064E\u062D\u0652\u0645\u064E\u0629\u064C \u0644\u0650\u0644\u0652\u0645\u064F\u0624\u0652\u0645\u0650\u0646\u0650\u064A\u0646\u064E',
    phonetic: 'Wa nunazzilu minal-Qur\'ani ma huwa shifa\'un wa rahmatun lil-mu\'minin.',
    translation: 'Nous faisons descendre du Coran ce qui est une gu\u00e9rison et une mis\u00e9ricorde pour les croyants.',
    reference: 'Al-Isra, 17:82',
    power: 'Allah d\u00e9crit Lui-m\u00eame le Coran comme \u00ab shifa \u00bb (gu\u00e9rison). Ce n\'est pas une m\u00e9taphore : le Coran gu\u00e9rit r\u00e9ellement les maladies du corps et de l\'\u00e2me par la permission d\'Allah. Ce verset est fondamental dans toute roqya.',
    whenToRecite: 'Pendant la roqya, en cas de maladie, sur l\'eau coranis\u00e9e.',
  ),
];
