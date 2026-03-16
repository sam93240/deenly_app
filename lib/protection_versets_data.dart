// protection_versets_data.dart — Versets de protection

import 'app_locale.dart';

class VersetProtection {
  final String id;
  final String title;
  final String titleEn;
  final String emoji;
  final String arabic;
  final String phonetic;
  final String translation;
  final String translationEn;
  final String reference;
  final String power;
  final String powerEn;
  final String whenToRecite;
  final String whenToReciteEn;
  final int repeat;
  const VersetProtection({
    required this.id,
    required this.title,
    required this.titleEn,
    required this.emoji,
    required this.arabic,
    required this.phonetic,
    required this.translation,
    required this.translationEn,
    required this.reference,
    required this.power,
    required this.powerEn,
    required this.whenToRecite,
    required this.whenToReciteEn,
    this.repeat = 1,
  });
  String get displayTitle => AppLocale().isFrench ? title : titleEn;
  String get displayTranslation => AppLocale().isFrench ? translation : translationEn;
  String get displayPower => AppLocale().isFrench ? power : powerEn;
  String get displayWhenToRecite => AppLocale().isFrench ? whenToRecite : whenToReciteEn;
}

const kVersetsProtection = <VersetProtection>[
  // 1 — AYAT AL-KURSI
  VersetProtection(
    id: 'ayat_kursi',
    title: 'Ayat al-Kursi',
    titleEn: 'Ayat al-Kursi (The Throne Verse)',
    emoji: '👑',
    arabic: 'اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ ۚ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ ۚ لَهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الْأَرْضِ ۚ مَن ذَا الَّذِي يَشْفَعُ عِندَهُ إِلَّا بِإِذْنِهِ ۚ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ ۚ وَلَا يُحِيطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلَّا بِمَا شَاءَ ۚ وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالْأَرْضَ ۖ وَلَا يَئُودُهُ حِفْظُهُمَا ۖ وَهُوَ الْعَلِيُّ الْعَظِيمُ',
    phonetic: 'Allahu la ilaha illa Huwal-Hayyul-Qayyum. La ta\'khudhuh sinatun wa la nawm. Lahu ma fis-samawati wa ma fil-ard. Man dhal-ladhi yashfa\'u \'indahu illa bi-idhnih. Ya\'lamu ma bayna aydihim wa ma khalfahum. Wa la yuhituna bi-shay\'in min \'ilmihi illa bima sha\'. Wasi\'a kursiyyuhus-samawati wal-ard. Wa la ya\'uduhu hifdhuhuma. Wa Huwal-\'Aliyyul-\'Adhim.',
    translation: 'Allah ! Point de divinité à part Lui, le Vivant, Celui qui subsiste par Lui-même. Ni somnolence ni sommeil ne Le saisissent. A Lui appartient tout ce qui est dans les cieux et sur la terre. Qui peut intercéder auprès de Lui sans Sa permission ? Il connaît leur passé et leur futur. Et de Sa science, ils n\'embrassent que ce qu\'Il veut. Son Trône déborde les cieux et la terre dont la garde ne Lui coûte aucune peine. Et Il est le Très-Haut, le Très-Grand.',
    translationEn: 'Allah - there is no deity except Him, the Ever-Living, the Sustainer of existence. Neither drowsiness overtakes Him nor sleep. To Him belongs whatever is in the heavens and whatever is on the earth. Who is it that can intercede with Him except by His permission? He knows what is before them and what will be after them, and they encompass not a thing of His knowledge except for what He wills. His Kursi extends over the heavens and the earth, and their preservation tires Him not. And He is the Most High, the Most Great.',
    reference: 'Al-Baqara, 2:255',
    power: 'Le plus grand verset du Coran. Le Prophète ﷺ a dit : celui qui le récite le soir, un gardien d\'Allah le protège et aucun démon ne l\'approche jusqu\'au matin (Bukhari). Abu Hurayra a rapporté qu\'un jinn lui a révélé ce secret et le Prophète ﷺ l\'a confirmé.',
    powerEn: 'The greatest verse in the Quran. The Prophet said: whoever recites it in the evening, Allah protects him and no demon approaches him until morning (Bukhari). Abu Hurayrah reported that a jinn revealed this secret to him and the Prophet confirmed it.',
    whenToRecite: 'Après chaque prière obligatoire, avant de dormir, matin et soir, en entrant dans un lieu.',
    whenToReciteEn: 'After every obligatory prayer, before sleep, morning and evening, when entering a place.',
  ),

  // 2 — SOURATE AL-FATIHA
  VersetProtection(
    id: 'fatiha',
    title: 'Sourate Al-Fatiha',
    titleEn: 'Surah Al-Fatiha (The Opening)',
    emoji: '📖',
    arabic: 'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ · الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ · الرَّحْمَٰنِ الرَّحِيمِ · مَالِكِ يَوْمِ الدِّينِ · إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ · اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ · صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ',
    phonetic: 'Bismillahir-Rahmanir-Rahim. Al-hamdu lillahi Rabbil-\'alamin. Ar-Rahmanir-Rahim. Maliki yawmid-din. Iyyaka na\'budu wa iyyaka nasta\'in. Ihdinas-siratal-mustaqim. Siratal-ladhina an\'amta \'alayhim ghayril-maghdubi \'alayhim wa lad-dallin.',
    translation: 'Au nom d\'Allah, le Tout Miséricordieux, le Très Miséricordieux. Louange à Allah, Seigneur des mondes. Le Tout Miséricordieux, le Très Miséricordieux. Maître du Jour de la Rétribution. C\'est Toi seul que nous adorons, et c\'est Toi seul dont nous implorons secours. Guide-nous dans le droit chemin. Le chemin de ceux que Tu as comblé de faveurs, non pas de ceux qui ont encouru Ta colère, ni des égarés.',
    translationEn: 'In the name of Allah, the Most Gracious, the Most Merciful. All praise is due to Allah, Lord of all the worlds. The Most Gracious, the Most Merciful. Master of the Day of Judgment. It is You alone we worship, and it is You alone we seek help from. Guide us on the straight path. The path of those upon whom You have bestowed favor, not of those who have earned [Your] anger or of those who are astray.',
    reference: 'Al-Fatiha, 1:1-7',
    power: 'Appelée « la Guérisseuse » (Ash-Shafiya) et « la Mère du Livre » (Umm al-Kitab). Le Prophète ﷺ a dit : « Al-Fatiha est une guérison pour toute maladie ». Abu Sa\'id al-Khudri l\'a utilisée comme roqya sur un chef de tribu piqué par un scorpion, et il a guéri (Bukhari).',
    powerEn: 'Called "the Healer" (Ash-Shafiya) and "the Mother of the Book" (Umm al-Kitab). The Prophet said: "Al-Fatiha is a healing for every disease." Abu Sa\'id al-Khudri used it as roqya on a tribe leader stung by a scorpion, and he recovered (Bukhari).',
    whenToRecite: 'Pendant la roqya (7 fois), en cas de douleur, pour toute demande de guérison.',
    whenToReciteEn: 'During roqya (7 times), in case of pain, for any healing request.',
    repeat: 7,
  ),

  // 3 — LES DEUX DERNIERS VERSETS DE AL-BAQARA
  VersetProtection(
    id: 'baqara_fin',
    title: 'Fin de Sourate Al-Baqara',
    titleEn: 'Last Verses of Surah Al-Baqara',
    emoji: '🌙',
    arabic: 'آمَنَ الرَّسُولُ بِمَا أُنزِلَ إِلَيْهِ مِن رَّبِّهِ وَالْمُؤْمِنُونَ ۚ كُلٌّ آمَنَ بِاللَّهِ وَمَلَائِكَتِهِ وَكُتُبِهِ وَرُسُلِهِ لَا نُفَرِّقُ بَيْنَ أَحَدٍ مِّن رُّسُلِهِ',
    phonetic: 'Amanar-rasulu bima unzila ilayhi mir-rabbihi wal-mu\'minun. Kullun amana billahi wa mala\'ikatihi wa kutubihi wa rusulihi la nufarriqu bayna ahadin mir-rusulih...',
    translation: 'Le Messager a cru en ce qu\'on a fait descendre vers lui venant de son Seigneur, et aussi les croyants. Tous ont cru en Allah, en Ses anges, à Ses livres et en Ses messagers (en disant) : « Nous ne faisons aucune distinction entre Ses messagers »...',
    translationEn: 'The Messenger has believed in what was revealed to him from his Lord, and [so have] the believers. All of them have believed in Allah and His angels and His books and His messengers, [saying], "We make no distinction between any of His messengers."',
    reference: 'Al-Baqara, 2:285-286',
    power: 'Le Prophète ﷺ a dit : « Quiconque récite les deux derniers versets de Sourate Al-Baqara la nuit, cela lui suffira » (Bukhari et Muslim). Les savants ont expliqué que « cela lui suffira » signifie : suffira comme protection contre tout mal pendant la nuit.',
    powerEn: 'The Prophet said: "Whoever recites the last two verses of Surah Al-Baqara at night, it will suffice him" (Bukhari and Muslim). Scholars explained that "it will suffice" means: it is sufficient protection against all evil during the night.',
    whenToRecite: 'Chaque soir avant de dormir.',
    whenToReciteEn: 'Every evening before sleep.',
  ),

  // 4 — SOURATE AL-IKHLAS
  VersetProtection(
    id: 'ikhlas',
    title: 'Sourate Al-Ikhlas',
    titleEn: 'Surah Al-Ikhlas (Sincerity)',
    emoji: '✨',
    arabic: 'قُلْ هُوَ اللَّهُ أَحَدٌ · اللَّهُ الصَّمَدُ · لَمْ يَلِدْ وَلَمْ يُولَدْ · وَلَمْ يَكُن لَّهُ كُفُوًا أَحَدٌ',
    phonetic: 'Qul Huwa Allahu Ahad. Allahus-Samad. Lam yalid wa lam yulad. Wa lam yakun lahu kufuwan ahad.',
    translation: 'Dis : Il est Allah, Unique. Allah, Le Seul à être imploré pour ce que nous désirons. Il n\'a jamais engendré, n\'a pas été engendré non plus. Et nul n\'est égal à Lui.',
    translationEn: 'Say, "He is Allah, [who is] One, Allah, the Eternal Refuge. He neither begets nor is born, Nor is there to Him any equivalent."',
    reference: 'Al-Ikhlas, 112:1-4',
    power: 'Équivaut à un tiers du Coran. Le Prophète ﷺ la récitait 3 fois matin et soir comme protection. Associée aux Mu\'awwidhat, elle forme le bouclier le plus puissant.',
    powerEn: 'Equals one-third of the Quran. The Prophet recited it 3 times morning and evening as protection. Associated with the Mu\'awwidhat, it forms the most powerful shield.',
    whenToRecite: '3 fois matin et soir, après chaque prière, avant de dormir.',
    whenToReciteEn: '3 times morning and evening, after every prayer, before sleep.',
    repeat: 3,
  ),

  // 5 — SOURATE AL-FALAQ
  VersetProtection(
    id: 'falaq',
    title: 'Sourate Al-Falaq',
    titleEn: 'Surah Al-Falaq (The Daybreak)',
    emoji: '🌅',
    arabic: 'قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ · مِن شَرِّ مَا خَلَقَ · وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ · وَمِن شَرِّ النَّفَّاثَاتِ فِي الْعُقَدِ · وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ',
    phonetic: 'Qul a\'udhu bi-Rabbil-falaq. Min sharri ma khalaq. Wa min sharri ghasiqin idha waqab. Wa min sharrin-naffathati fil-\'uqad. Wa min sharri hasidin idha hasad.',
    translation: 'Dis : Je cherche protection auprès du Seigneur de l\'aube naissante, contre le mal de ce qu\'Il a créé, contre le mal de l\'obscurité quand elle s\'étend, contre le mal de celles qui soufflent sur les noeuds, et contre le mal de l\'envieux quand il envie.',
    translationEn: 'Say, "I seek refuge in the Lord of daybreak From the evil of that which He has created And from the evil of darkness when it settles And from the evil of the blowers in knots And from the evil of an envier when he envies."',
    reference: 'Al-Falaq, 113:1-5',
    power: 'Protection directe contre la sorcellerie (les souffleuses dans les noeuds = les sorcières) et la jalousie. Le verset 4 vise spécifiquement le sihr. Le Prophète ﷺ a dit qu\'il n\'y a rien de meilleur pour se protéger que les Mu\'awwidhat.',
    powerEn: 'Direct protection against sorcery (the blowers in knots = sorceresses) and envy. Verse 4 specifically targets sihr. The Prophet said there is nothing better for protection than the Mu\'awwidhat.',
    whenToRecite: '3 fois matin et soir, après chaque prière, en cas de peur ou de menace.',
    whenToReciteEn: '3 times morning and evening, after every prayer, in case of fear or threat.',
    repeat: 3,
  ),

  // 6 — SOURATE AN-NAS
  VersetProtection(
    id: 'nas',
    title: 'Sourate An-Nas',
    titleEn: 'Surah An-Nas (Mankind)',
    emoji: '🤲',
    arabic: 'قُلْ أَعُوذُ بِرَبِّ النَّاسِ · مَلِكِ النَّاسِ · إِلَٰهِ النَّاسِ · مِن شَرِّ الْوَسْوَاسِ الْخَنَّاسِ · الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ · مِنَ الْجِنَّةِ وَالنَّاسِ',
    phonetic: 'Qul a\'udhu bi-Rabbin-nas. Malikin-nas. Ilahin-nas. Min sharril-waswasil-khannas. Alladhi yuwaswisu fi sudurin-nas. Minal-jinnati wan-nas.',
    translation: 'Dis : Je cherche protection auprès du Seigneur des hommes, le Souverain des hommes, le Dieu des hommes, contre le mal du chuchoteur furtif, qui chuchote dans les poitrines des gens, qu\'il soit parmi les jinn ou parmi les hommes.',
    translationEn: 'Say, "I seek refuge in the Lord of mankind, The Sovereign of mankind, The God of mankind, From the evil of the retreating whisperer Who whispers [evil] in the breasts of mankind From among the jinn and mankind."',
    reference: 'An-Nas, 114:1-6',
    power: 'Protection contre le waswas (chuchotements) des jinn ET des humains. Le mot « khannas » (furtif) signifie que le Shaytan recule quand on mentionne Allah et revient quand on oublie. Cette sourate est l\'antidote au waswas.',
    powerEn: 'Protection against waswas (whispers) from both jinn and humans. The word "khannas" (retreating) means Satan withdraws when Allah is mentioned and returns when forgotten. This surah is the antidote to waswas.',
    whenToRecite: '3 fois matin et soir, quand on ressent du waswas, avant de dormir.',
    whenToReciteEn: '3 times morning and evening, when experiencing waswas, before sleep.',
    repeat: 3,
  ),

  // 7 — VERSETS ANTI-SIHR (A'raf)
  VersetProtection(
    id: 'araf_sihr',
    title: 'Versets anti-sihr (Al-A\'raf)',
    titleEn: 'Anti-Sihr Verses (Al-Araf)',
    emoji: '⚔️',
    arabic: 'وَأَوْحَيْنَا إِلَىٰ مُوسَىٰ أَنْ أَلْقِ عَصَاكَ ۖ فَإِذَا هِيَ تَلْقَفُ مَا يَأْفِكُونَ · فَوَقَعَ الْحَقُّ وَبَطَلَ مَا كَانُوا يَعْمَلُونَ',
    phonetic: 'Wa awhayna ila Musa an alqi \'asak. Fa-idha hiya talqafu ma ya\'fikun. Fawaqa\'al-haqqu wa batala ma kanu ya\'malun.',
    translation: 'Et Nous révélâmes à Moïse : « Jette ton bâton ». Et voilà que celui-ci se mit à engloutir ce qu\'ils avaient fabriqué. Ainsi la vérité se manifesta et ce qu\'ils firent fut vain.',
    translationEn: 'And We revealed to Moses, "Throw your staff." And thereupon it swallowed up what they had crafted. So the truth was established, and abolished was what they were producing.',
    reference: 'Al-A\'raf, 7:117-118',
    power: 'Ces versets racontent la défaite des sorciers de Pharaon devant Moussa (عليه السلام). Ils sont utilisés dans la roqya pour annuler les effets de la sorcellerie. Le Coran a vaincu la sorcellerie à l\'époque de Moussa et continue de la vaincre aujourd\'hui.',
    powerEn: 'These verses narrate the defeat of Pharaoh\'s sorcerers by Moses (upon him be peace). They are used in roqya to nullify sorcery\'s effects. The Quran defeated sorcery in Moses\'s time and continues to defeat it today.',
    whenToRecite: 'Pendant la roqya, en cas de suspicion de sihr, sur l\'eau coranisée.',
    whenToReciteEn: 'During roqya, in case of sihr suspicion, on Quranic water.',
  ),

  // 8 — VERSETS ANTI-SIHR (Yunus)
  VersetProtection(
    id: 'yunus_sihr',
    title: 'Versets anti-sihr (Yunus)',
    titleEn: 'Anti-Sihr Verses (Yunus)',
    emoji: '⚔️',
    arabic: 'فَلَمَّا أَلْقَوْا قَالَ مُوسَىٰ مَا جِئْتُم بِهِ السِّحْرُ ۖ إِنَّ اللَّهَ سَيُبْطِلُهُ ۖ إِنَّ اللَّهَ لَا يُصْلِحُ عَمَلَ الْمُفْسِدِينَ',
    phonetic: 'Falamma alqaw qala Musa ma ji\'tum bihis-sihr. Innallaha sayubtiluhu. Innallaha la yuslihu \'amalal-mufsidin.',
    translation: 'Puis quand ils eurent jeté (leurs sortilèges), Moïse dit : « Ce que vous avez produit est de la magie ! Allah l\'annulera. Car Allah ne fait pas prospérer l\'œuvre des corrupteurs. »',
    translationEn: 'But when the magicians cast [their spell], Moses said, "What you have brought is [but] magic. Indeed, Allah will render it worthless. Indeed, Allah does not amend the work of corruptors."',
    reference: 'Yunus, 10:81',
    power: 'Parole directe du prophète Moussa (عليه السلام) contre les sorciers. La promesse divine est claire : Allah annulera la sorcellerie. Ce verset est essentiel dans tout programme de roqya.',
    powerEn: 'Direct speech of prophet Moses (upon him be peace) against sorcerers. Allah\'s promise is clear: He will nullify sorcery. This verse is essential in any roqya program.',
    whenToRecite: 'Pendant la roqya, sur l\'eau coranisée, en cas de suspicion de sihr.',
    whenToReciteEn: 'During roqya, on Quranic water, in case of sihr suspicion.',
  ),

  // 9 — VERSETS ANTI-SIHR (Ta-Ha)
  VersetProtection(
    id: 'taha_sihr',
    title: 'Versets anti-sihr (Ta-Ha)',
    titleEn: 'Anti-Sihr Verses (Ta-Ha)',
    emoji: '⚔️',
    arabic: 'قُلْنَا لَا تَخَفْ إِنَّكَ أَنتَ الْأَعْلَىٰ · وَأَلْقِ مَا فِي يَمِينِكَ تَلْقَفْ مَا صَنَعُوا ۖ إِنَّمَا صَنَعُوا كَيْدُ سَاحِرٍ ۖ وَلَا يُفْلِحُ السَّاحِرُ حَيْثُ أَتَىٰ',
    phonetic: 'Qulna la takhaf innaka antal-a\'la. Wa alqi ma fi yaminika talqaf ma sana\'u. Innama sana\'u kaydu sahir. Wa la yuflihus-sahiru haythu ata.',
    translation: 'Nous dîmes : « N\'aie pas peur, c\'est toi qui auras le dessus. Jette ce qu\'il y a dans ta main droite ; cela avalera ce qu\'ils ont fabriqué. Ce qu\'ils ont fabriqué n\'est que ruse de sorcier ; et le sorcier ne réussira pas, où qu\'il soit. »',
    translationEn: 'We said, "Do not fear. Indeed, it is you who will have the upper hand. Cast down that which is in your right hand; it will swallow up what they have crafted. What they have crafted is but the trick of a magician, and the magician will not succeed wherever he is."',
    reference: 'Ta-Ha, 20:68-69',
    power: 'La promesse divine ultime contre la sorcellerie : « le sorcier ne réussira pas, où qu\'il soit ». Ce verset est un pilier de la roqya. Il brise le désespoir et rappelle que la vérité d\'Allah triomphera toujours sur la ruse des sorciers.',
    powerEn: 'The ultimate divine promise against sorcery: "the magician will not succeed wherever he is." This verse is a cornerstone of roqya. It breaks despair and reminds us that Allah\'s truth always triumphs over sorcerers\' tricks.',
    whenToRecite: 'Pendant la roqya, sur l\'eau coranisée, en cas de suspicion de sihr.',
    whenToReciteEn: 'During roqya, on Quranic water, in case of sihr suspicion.',
  ),

  // 10 — VERSET DE GUÉRISON (AL-ISRA)
  VersetProtection(
    id: 'isra_shifa',
    title: 'Verset de la Guérison',
    titleEn: 'Verse of Healing',
    emoji: '💚',
    arabic: 'وَنُنَزِّلُ مِنَ الْقُرْآنِ مَا هُوَ شِفَاءٌ وَرَحْمَةٌ لِّلْمُؤْمِنِينَ',
    phonetic: 'Wa nunazzilu minal-Qur\'ani ma huwa shifa\'un wa rahmatun lil-mu\'minin.',
    translation: 'Nous faisons descendre du Coran ce qui est une guérison et une miséricorde pour les croyants.',
    translationEn: 'And We send down of the Quran that which is a healing and a mercy for the believers.',
    reference: 'Al-Isra, 17:82',
    power: 'Allah décrit Lui-même le Coran comme « shifa » (guérison). Ce n\'est pas une métaphore : le Coran guérit réellement les maladies du corps et de l\'âme par la permission d\'Allah. Ce verset est fondamental dans toute roqya.',
    powerEn: 'Allah Himself describes the Quran as "shifa" (healing). This is not metaphorical: the Quran truly heals diseases of body and soul by Allah\'s permission. This verse is fundamental in all roqya.',
    whenToRecite: 'Pendant la roqya, en cas de maladie, sur l\'eau coranisée.',
    whenToReciteEn: 'During roqya, in case of illness, on Quranic water.',
  ),
];
