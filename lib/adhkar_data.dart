class Dhikr {
  final String arabic;
  final String phonetic;
  final String translation;
  final String source;
  final int repeat;
  const Dhikr({required this.arabic, required this.phonetic, required this.translation, required this.source, required this.repeat});
}

class DhikrCategory {
  final String id;
  final String title;
  final String emoji;
  final String description;
  final List<Dhikr> adhkar;
  const DhikrCategory({required this.id, required this.title, required this.emoji, required this.description, required this.adhkar});
}

const List<DhikrCategory> kAdhkar = [
  DhikrCategory(
    id: 'matin',
    title: 'Adhkar du Matin',
    emoji: '🌅',
    description: 'Les invocations du matin à dire après le Fajr',
    adhkar: [
      Dhikr(
        arabic: 'اَلْحَمْدُ لِلَّهِ الَّذِي أَحْيَانَا بَعْدَ مَا أَمَاتَنَا وَإِلَيْهِ النُّشُورُ',
        phonetic: 'Al-hamdu lillahi alladhi ahyana ba\'da ma amatana wa ilayhi an-nusur',
        translation: 'Louange à Allah qui nous a ramenés à la vie après nous avoir fait mourir, et vers Lui sera notre retour',
        source: 'Quran 2:179',
        repeat: 1,
      ),
      Dhikr(
        arabic: 'أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلَّهِ رَبِّ الْعَالَمِينَ',
        phonetic: 'Asbahna wa asbaha al-mulku lillahi rabbi al-\'alamin',
        translation: 'Nous sommes arrivés au matin et la royauté appartient à Allah, le Seigneur de l\'univers',
        source: 'Tirmidhi 3488',
        repeat: 1,
      ),
      Dhikr(
        arabic: 'اللَّهُمَّ بِكَ أَصْبَحْنَا وَبِكَ أَمْسَيْنَا وَبِكَ نَحْيَا وَبِكَ نَمُوتُ وَإِلَيْكَ النُّشُورُ',
        phonetic: 'Allahumma bika asbahna wa bika amsayna wa bika nahya wa bika namut wa ilayika an-nusur',
        translation: 'Ô Allah ! C\'est par Toi que nous arrivons au matin et au soir, c\'est par Toi que nous vivons et mourons, et vers Toi est notre résurrection',
        source: 'Tirmidhi 3391',
        repeat: 1,
      ),
      Dhikr(
        arabic: 'اللَّهُمَّ إِنِّي أَسْأَلُكَ الْعَفْوَ وَالْعَافِيَةَ فِي الدُّنْيَا وَالْآخِرَةِ',
        phonetic: 'Allahumma inni as\'aluka al-\'afw wa al-\'afiya fi ad-dunya wa al-akhira',
        translation: 'Ô Allah ! Je Te demande le pardon et le bien-être en ce monde et dans l\'au-delà',
        source: 'Ibn Majah 3892',
        repeat: 1,
      ),
      Dhikr(
        arabic: 'اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْكُفْرِ وَالْفَقْرِ وَأَعُوذُ بِكَ مِنْ عَذَابِ الْقَبْرِ',
        phonetic: 'Allahumma inni a\'udhu bika min al-kufr wa al-faqr wa a\'udhu bika min \'adhab al-qabr',
        translation: 'Ô Allah ! Je cherche refuge auprès de Toi contre la mécréance et la pauvreté, et je cherche refuge auprès de Toi contre le châtiment de la tombe',
        source: 'Abu Dawud 5090',
        repeat: 1,
      ),
      Dhikr(
        arabic: 'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ سُبْحَانَ اللَّهِ الْعَظِيمِ',
        phonetic: 'Subhana llahi wa bihamdihi subhana llahi al-\'azim',
        translation: 'Gloire à Allah et louange à Lui, gloire à Allah le Puissant',
        source: 'Muslim 2694',
        repeat: 100,
      ),
      Dhikr(
        arabic: 'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ عَدَدَ خَلْقِهِ وَرِضَا نَفْسِهِ وَزِنَةَ عَرْشِهِ وَمِدَادَ كَلِمَاتِهِ',
        phonetic: 'Subhana llahi wa bihamdihi \'adada khalqihi wa rida nafsihi wa zinata \'arshihi wa midat kalimatihi',
        translation: 'Gloire à Allah et louange à Lui, autant que le nombre de Ses créations, la satisfaction de Lui-même, le poids de Son Trône et l\'encre de Ses paroles',
        source: 'Muslim 2726',
        repeat: 1,
      ),
      Dhikr(
        arabic: 'لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ',
        phonetic: 'La ilaha illa llahu wahdahu la sharika lahu lahu al-mulk wa lahu al-hamd wa huwa \'ala kulli shay\'in qadir',
        translation: 'Il n\'y a de divinité qu\'Allah seul, sans associé. À Lui appartient la royauté et à Lui la louange, et Il est Puissant sur toute chose',
        source: 'Bukhari 3293',
        repeat: 10,
      ),
      Dhikr(
        arabic: 'قُلْ هُوَ اللَّهُ أَحَدٌ. اللَّهُ الصَّمَدُ. لَمْ يَلِدْ وَلَمْ يُولَدْ. وَلَمْ يَكُنْ لَهُ كُفُوًا أَحَدٌ.',
        phonetic: 'Qul huwa llahu ahad. Allahu as-samad. Lam yalid wa lam yulad. Wa lam yakun lahu kufuwan ahad.',
        translation: 'Dis : "Il est Allah, Unique. Allah, le Maître Absolu. Il n\'a jamais engendré ni n\'a été engendré. Et nul n\'est égal à Lui."',
        source: 'Quran 112:1-4',
        repeat: 3,
      ),
      Dhikr(
        arabic: 'قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ. مِنْ شَرِّ مَا خَلَقَ. وَمِنْ شَرِّ غَسَّاقٍ إِذَا وَقَبَ. وَمِنْ شَرِّ النَّفَّاثَاتِ فِي الْعُقَدِ. وَمِنْ شَرِّ حَاسِدٍ إِذَا حَسَدَ.',
        phonetic: 'Qul a\'udhu bi rabbi al-falaq. Min sharri ma khalaqa. Wa min sharri ghassaqin idha waqab. Wa min sharri an-naffathat fi al-\'uqad. Wa min sharri hasid idha hasad.',
        translation: 'Dis : "Je cherche refuge auprès du Seigneur de l\'aube contre le mal de ce qu\'Il a créé, contre le mal de la nuit quand elle s\'étend, contre le mal de celles qui soufflent sur les nœuds, et contre le mal du jaloux quand il jalouse."',
        source: 'Quran 113:1-5',
        repeat: 3,
      ),
      Dhikr(
        arabic: 'قُلْ أَعُوذُ بِرَبِّ النَّاسِ. مَلِكِ النَّاسِ. إِلَهِ النَّاسِ. مِنْ شَرِّ الْوَسْوَاسِ الْخَنَّاسِ. الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ. مِنَ الْجِنَّةِ وَالنَّاسِ.',
        phonetic: 'Qul a\'udhu bi rabbi an-nas. Maliki an-nas. Ilahi an-nas. Min sharri al-waswas al-khanas. Alladhi yuwaswisu fi suduri an-nas. Mina al-jinna wa an-nas.',
        translation: 'Dis : "Je cherche refuge auprès du Seigneur des gens, du Roi des gens, du Dieu des gens, contre le mal du chuchoteur sournois qui s\'esquive quand on l\'invoque, qui souffle le mal dans les poitrines des gens, parmi les djinns et parmi les gens."',
        source: 'Quran 114:1-6',
        repeat: 3,
      ),
      Dhikr(
        arabic: 'اللَّهُمَّ بِسْمُكَ أَمُوتُ وَأَحْيَا',
        phonetic: 'Allahumma bismuka amutu wa ahya',
        translation: 'Ô Allah ! Au nom de Ton nom, je meurs et je vis',
        source: 'Bukhari 6314',
        repeat: 1,
      ),
      Dhikr(
        arabic: 'أَعُوذُ بِكَلِمَاتِ اللَّهِ التَّامَّةِ مِنْ شَرِّ مَا خَلَقَ',
        phonetic: 'A\'udhu bi kalimat illahi at-tammah min sharri ma khalaq',
        translation: 'Je cherche refuge dans les paroles complètes d\'Allah contre le mal de ce qu\'Il a créé',
        source: 'Muslim 2708',
        repeat: 3,
      ),
      Dhikr(
        arabic: 'اللَّهُمَّ أَنْتَ السَّلَامُ وَمِنْكَ السَّلَامُ تَبَارَكْتَ يَا ذَا الْجَلَالِ وَالْإِكْرَامِ',
        phonetic: 'Allahumma anta as-salam wa minka as-salam tabarakta ya dha al-jalal wa al-ikram',
        translation: 'Ô Allah ! Tu es la Paix et la Paix vient de Toi. Béni sois-Tu, Ô Seigneur de majesté et d\'honneur',
        source: 'Muslim 834',
        repeat: 1,
      ),
    ],
  ),
  DhikrCategory(
    id: 'soir',
    title: 'Adhkar du Soir',
    emoji: '🌙',
    description: 'Les invocations du soir à dire après le Maghreb',
    adhkar: [
      Dhikr(
        arabic: 'أَمْسَيْنَا وَأَمْسَى الْمُلْكُ لِلَّهِ رَبِّ الْعَالَمِينَ',
        phonetic: 'Amsayna wa amsa al-mulku lillahi rabbi al-\'alamin',
        translation: 'Nous sommes arrivés au soir et la royauté appartient à Allah, le Seigneur de l\'univers',
        source: 'Tirmidhi 3488',
        repeat: 1,
      ),
      Dhikr(
        arabic: 'اللَّهُمَّ بِكَ أَمْسَيْنَا وَبِكَ أَصْبَحْنَا وَبِكَ نَحْيَا وَبِكَ نَمُوتُ وَإِلَيْكَ الْمَصِيرُ',
        phonetic: 'Allahumma bika amsayna wa bika asbahna wa bika nahya wa bika namut wa ilayika al-masir',
        translation: 'Ô Allah ! C\'est par Toi que nous arrivons au soir et au matin, c\'est par Toi que nous vivons et mourons, et vers Toi est notre retour',
        source: 'Tirmidhi 3391',
        repeat: 1,
      ),
      Dhikr(
        arabic: 'اللَّهُمَّ إِنِّي أَسْأَلُكَ الْعَفْوَ وَالْعَافِيَةَ فِي الدُّنْيَا وَالْآخِرَةِ',
        phonetic: 'Allahumma inni as\'aluka al-\'afw wa al-\'afiya fi ad-dunya wa al-akhira',
        translation: 'Ô Allah ! Je Te demande le pardon et le bien-être en ce monde et dans l\'au-delà',
        source: 'Ibn Majah 3892',
        repeat: 1,
      ),
      Dhikr(
        arabic: 'اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْكُفْرِ وَالْفَقْرِ وَأَعُوذُ بِكَ مِنْ عَذَابِ الْقَبْرِ',
        phonetic: 'Allahumma inni a\'udhu bika min al-kufr wa al-faqr wa a\'udhu bika min \'adhab al-qabr',
        translation: 'Ô Allah ! Je cherche refuge auprès de Toi contre la mécréance et la pauvreté, et je cherche refuge auprès de Toi contre le châtiment de la tombe',
        source: 'Abu Dawud 5090',
        repeat: 1,
      ),
      Dhikr(
        arabic: 'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ سُبْحَانَ اللَّهِ الْعَظِيمِ',
        phonetic: 'Subhana llahi wa bihamdihi subhana llahi al-\'azim',
        translation: 'Gloire à Allah et louange à Lui, gloire à Allah le Puissant',
        source: 'Muslim 2694',
        repeat: 100,
      ),
      Dhikr(
        arabic: 'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ عَدَدَ خَلْقِهِ وَرِضَا نَفْسِهِ وَزِنَةَ عَرْشِهِ وَمِدَادَ كَلِمَاتِهِ',
        phonetic: 'Subhana llahi wa bihamdihi \'adada khalqihi wa rida nafsihi wa zinata \'arshihi wa midat kalimatihi',
        translation: 'Gloire à Allah et louange à Lui, autant que le nombre de Ses créations, la satisfaction de Lui-même, le poids de Son Trône et l\'encre de Ses paroles',
        source: 'Muslim 2726',
        repeat: 1,
      ),
      Dhikr(
        arabic: 'لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ',
        phonetic: 'La ilaha illa llahu wahdahu la sharika lahu lahu al-mulk wa lahu al-hamd wa huwa \'ala kulli shay\'in qadir',
        translation: 'Il n\'y a de divinité qu\'Allah seul, sans associé. À Lui appartient la royauté et à Lui la louange, et Il est Puissant sur toute chose',
        source: 'Bukhari 3293',
        repeat: 10,
      ),
      Dhikr(
        arabic: 'قُلْ هُوَ اللَّهُ أَحَدٌ. اللَّهُ الصَّمَدُ. لَمْ يَلِدْ وَلَمْ يُولَدْ. وَلَمْ يَكُنْ لَهُ كُفُوًا أَحَدٌ.',
        phonetic: 'Qul huwa llahu ahad. Allahu as-samad. Lam yalid wa lam yulad. Wa lam yakun lahu kufuwan ahad.',
        translation: 'Dis : "Il est Allah, Unique. Allah, le Maître Absolu. Il n\'a jamais engendré ni n\'a été engendré. Et nul n\'est égal à Lui."',
        source: 'Quran 112:1-4',
        repeat: 3,
      ),
      Dhikr(
        arabic: 'قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ. مِنْ شَرِّ مَا خَلَقَ. وَمِنْ شَرِّ غَسَّاقٍ إِذَا وَقَبَ. وَمِنْ شَرِّ النَّفَّاثَاتِ فِي الْعُقَدِ. وَمِنْ شَرِّ حَاسِدٍ إِذَا حَسَدَ.',
        phonetic: 'Qul a\'udhu bi rabbi al-falaq. Min sharri ma khalaq. Wa min sharri ghassaqin idha waqab. Wa min sharri an-naffathat fi al-\'uqad. Wa min sharri hasid idha hasad.',
        translation: 'Dis : "Je cherche refuge auprès du Seigneur de l\'aube contre le mal de ce qu\'Il a créé, contre le mal de la nuit quand elle s\'étend, contre le mal de celles qui soufflent sur les nœuds, et contre le mal du jaloux quand il jalouse."',
        source: 'Quran 113:1-5',
        repeat: 3,
      ),
      Dhikr(
        arabic: 'قُلْ أَعُوذُ بِرَبِّ النَّاسِ. مَلِكِ النَّاسِ. إِلَهِ النَّاسِ. مِنْ شَرِّ الْوَسْوَاسِ الْخَنَّاسِ. الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ. مِنَ الْجِنَّةِ وَالنَّاسِ.',
        phonetic: 'Qul a\'udhu bi rabbi an-nas. Maliki an-nas. Ilahi an-nas. Min sharri al-waswas al-khanas. Alladhi yuwaswisu fi suduri an-nas. Mina al-jinna wa an-nas.',
        translation: 'Dis : "Je cherche refuge auprès du Seigneur des gens, du Roi des gens, du Dieu des gens, contre le mal du chuchoteur sournois qui s\'esquive quand on l\'invoque, qui souffle le mal dans les poitrines des gens, parmi les djinns et parmi les gens."',
        source: 'Quran 114:1-6',
        repeat: 3,
      ),
      Dhikr(
        arabic: 'اللَّهُمَّ بِسْمُكَ أَمُوتُ وَأَحْيَا',
        phonetic: 'Allahumma bismuka amutu wa ahya',
        translation: 'Ô Allah ! Au nom de Ton nom, je meurs et je vis',
        source: 'Bukhari 6314',
        repeat: 1,
      ),
      Dhikr(
        arabic: 'أَعُوذُ بِكَلِمَاتِ اللَّهِ التَّامَّةِ مِنْ شَرِّ مَا خَلَقَ',
        phonetic: 'A\'udhu bi kalimat illahi at-tammah min sharri ma khalaq',
        translation: 'Je cherche refuge dans les paroles complètes d\'Allah contre le mal de ce qu\'Il a créé',
        source: 'Muslim 2708',
        repeat: 3,
      ),
      Dhikr(
        arabic: 'اللَّهُمَّ أَنْتَ السَّلَامُ وَمِنْكَ السَّلَامُ تَبَارَكْتَ يَا ذَا الْجَلَالِ وَالْإِكْرَامِ',
        phonetic: 'Allahumma anta as-salam wa minka as-salam tabarakta ya dha al-jalal wa al-ikram',
        translation: 'Ô Allah ! Tu es la Paix et la Paix vient de Toi. Béni sois-Tu, Ô Seigneur de majesté et d\'honneur',
        source: 'Muslim 834',
        repeat: 1,
      ),
      Dhikr(
        arabic: 'آمَنَ الرَّسُولُ بِمَا أُنْزِلَ إِلَيْهِ مِنْ رَبِّهِ وَالْمُؤْمِنُونَ ۚ كُلٌّ آمَنَ بِاللَّهِ وَمَلَائِكَتِهِ وَكُتُبِهِ وَرُسُلِهِ لَا نُفَرِّقُ بَيْنَ أَحَدٍ مِنْ رُسُلِهِ ۚ وَقَالُوا سَمِعْنَا وَأَطَعْنَا ۖ غُفْرَانَكَ رَبَّنَا وَإِلَيْكَ الْمَصِيرُ',
        phonetic: 'Amana ar-rasulu bima unzila ilayhi min rabbihi wa al-mu\'minun. Kullun amana billahi wa mala\'ikatihi wa kutubihi wa rusulihi la nufarriqu bayna ahad min rusulihi. Wa qalu sami\'na wa ata\'na. Ghufranaka rabbana wa ilayika al-masir.',
        translation: 'Le Messager a cru en ce qui lui a été révélé par son Seigneur, et aussi les croyants. Tous ont cru en Allah, à Ses anges, à Ses livres et à Ses messagers. "Nous ne faisons aucune différence entre Ses messagers." Et ils ont dit : "Nous avons entendu et obéi. Ô notre Seigneur ! Nous implorons Ton pardon et vers Toi est le retour."',
        source: 'Quran 2:285',
        repeat: 1,
      ),
    ],
  ),
  DhikrCategory(
    id: 'apres_priere',
    title: 'Adhkar après la Prière',
    emoji: '🕌',
    description: 'Les invocations à dire après la prière',
    adhkar: [
      Dhikr(
        arabic: 'أَسْتَغْفِرُ اللَّهَ',
        phonetic: 'Astaghfiru llah',
        translation: 'Je demande pardon à Allah',
        source: 'Bukhari 844',
        repeat: 3,
      ),
      Dhikr(
        arabic: 'اللَّهُمَّ أَنْتَ السَّلَامُ وَمِنْكَ السَّلَامُ تَبَارَكْتَ يَا ذَا الْجَلَالِ وَالْإِكْرَامِ',
        phonetic: 'Allahumma anta as-salam wa minka as-salam tabarakta ya dha al-jalal wa al-ikram',
        translation: 'Ô Allah ! Tu es la Paix et la Paix vient de Toi. Béni sois-Tu, Ô Seigneur de majesté et d\'honneur',
        source: 'Muslim 834',
        repeat: 1,
      ),
      Dhikr(
        arabic: 'سُبْحَانَ اللَّهِ',
        phonetic: 'Subhana llah',
        translation: 'Gloire à Allah',
        source: 'Bukhari 844',
        repeat: 33,
      ),
      Dhikr(
        arabic: 'الْحَمْدُ لِلَّهِ',
        phonetic: 'Al-hamdu llah',
        translation: 'Louange à Allah',
        source: 'Bukhari 844',
        repeat: 33,
      ),
      Dhikr(
        arabic: 'اللَّهُ أَكْبَرُ',
        phonetic: 'Allahu akbar',
        translation: 'Allah est le plus grand',
        source: 'Bukhari 844',
        repeat: 34,
      ),
      Dhikr(
        arabic: 'لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ',
        phonetic: 'La ilaha illa llahu wahdahu la sharika lahu lahu al-mulk wa lahu al-hamd wa huwa \'ala kulli shay\'in qadir',
        translation: 'Il n\'y a de divinité qu\'Allah seul, sans associé. À Lui appartient la royauté et à Lui la louange, et Il est Puissant sur toute chose',
        source: 'Muslim 595',
        repeat: 1,
      ),
      Dhikr(
        arabic: 'اللَّهُمَّ لَا مَانِعَ لِمَا أَعْطَيْتَ وَلَا مُعْطِيَ لِمَا مَنَعْتَ وَلَا يَنْفَعُ ذَا الْجَدِّ مِنْكَ الْجَدُّ',
        phonetic: 'Allahumma la mani\'a lima a\'tayta wa la mu\'ti lima mana\'ta wa la yanfa\'u dha al-jaddi minka al-jadd',
        translation: 'Ô Allah ! Nul ne peut retenir ce que Tu donnes et nul ne peut donner ce que Tu retiens, et la richesse et la puissance ne profitent à nul devant Toi',
        source: 'Bukhari 844',
        repeat: 1,
      ),
      Dhikr(
        arabic: 'الَّذِي بِيَدِهِ الْمُلْكُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ',
        phonetic: 'Alladhi bi yadihi al-mulk wa huwa \'ala kulli shay\'in qadir',
        translation: 'La royauté est dans Ses mains et Il est Puissant sur toute chose',
        source: 'Bukhari 844',
        repeat: 1,
      ),
      Dhikr(
        arabic: 'الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ',
        phonetic: 'Al-hamdu llahi rabbi al-\'alamin',
        translation: 'Louange à Allah, Seigneur de l\'univers',
        source: 'Quran 1:2',
        repeat: 1,
      ),
      Dhikr(
        arabic: 'آيَةُ الْكُرْسِيِّ: اللَّهُ لَا إِلَهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ ۚ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ ۚ لَهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الْأَرْضِ ۚ مَنْ ذَا الَّذِي يَشْفَعُ عِنْدَهُ إِلَّا بِإِذْنِهِ ۚ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ ۚ وَلَا يُحِيطُونَ بِشَيْءٍ مِنْ عِلْمِهِ إِلَّا بِمَا شَاءَ ۚ وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالْأَرْضَ ۖ وَلَا يَئُودُهُ حِفْظُهُمَا ۖ وَهُوَ الْعَلِيُّ الْعَظِيمُ',
        phonetic: 'Allahuhu la ilaha illa huwa al-hayy al-qayyum. La ta\'khudhuhu sinatun wa la nawm. Lahu ma fi as-samawat wa ma fi al-ard. Man dha alladhi yashfa\'u \'indahu illa bi idhnihi. Ya\'lamu ma bayna aydihim wa ma khalfahum. Wa la yuhitun bi shay\' min \'ilmihi illa bima sha\'. Wasi\'a kursiyyuhu as-samawat wa al-ard. Wa la ya\'uduhu hifzuhuma. Wa huwa al-\'aliyy al-\'azim.',
        translation: 'Allah ! Il n\'y a de divinité que Lui, le Vivant, Celui qui subsiste par Lui-même. Ni somnolence ni sommeil ne le saisissent. À Lui appartient tout ce qui est dans les cieux et sur la terre. Qui pourrait intercéder auprès de Lui sans Sa permission ? Il connaît leur passé et leur avenir. Et ils n\'embrassent de Son savoir que ce qu\'Il veut. Son Trône s\'étend sur les cieux et la terre, et leur conservation ne Lui coûte aucune peine. Et Il est le Très Haut, l\'Infiniment Grand.',
        source: 'Quran 2:255',
        repeat: 1,
      ),
      Dhikr(
        arabic: 'قُلْ هُوَ اللَّهُ أَحَدٌ. اللَّهُ الصَّمَدُ. لَمْ يَلِدْ وَلَمْ يُولَدْ. وَلَمْ يَكُنْ لَهُ كُفُوًا أَحَدٌ.',
        phonetic: 'Qul huwa llahu ahad. Allahu as-samad. Lam yalid wa lam yulad. Wa lam yakun lahu kufuwan ahad.',
        translation: 'Dis : "Il est Allah, Unique. Allah, le Maître Absolu. Il n\'a jamais engendré ni n\'a été engendré. Et nul n\'est égal à Lui."',
        source: 'Quran 112:1-4',
        repeat: 1,
      ),
      Dhikr(
        arabic: 'قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ. مِنْ شَرِّ مَا خَلَقَ. وَمِنْ شَرِّ غَسَّاقٍ إِذَا وَقَبَ. وَمِنْ شَرِّ النَّفَّاثَاتِ فِي الْعُقَدِ. وَمِنْ شَرِّ حَاسِدٍ إِذَا حَسَدَ.',
        phonetic: 'Qul a\'udhu bi rabbi al-falaq. Min sharri ma khalaq. Wa min sharri ghassaqin idha waqab. Wa min sharri an-naffathat fi al-\'uqad. Wa min sharri hasid idha hasad.',
        translation: 'Dis : "Je cherche refuge auprès du Seigneur de l\'aube contre le mal de ce qu\'Il a créé, contre le mal de la nuit quand elle s\'étend, contre le mal de celles qui soufflent sur les nœuds, et contre le mal du jaloux quand il jalouse."',
        source: 'Quran 113:1-5',
        repeat: 1,
      ),
      Dhikr(
        arabic: 'قُلْ أَعُوذُ بِرَبِّ النَّاسِ. مَلِكِ النَّاسِ. إِلَهِ النَّاسِ. مِنْ شَرِّ الْوَسْوَاسِ الْخَنَّاسِ. الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ. مِنَ الْجِنَّةِ وَالنَّاسِ.',
        phonetic: 'Qul a\'udhu bi rabbi an-nas. Maliki an-nas. Ilahi an-nas. Min sharri al-waswas al-khanas. Alladhi yuwaswisu fi suduri an-nas. Mina al-jinna wa an-nas.',
        translation: 'Dis : "Je cherche refuge auprès du Seigneur des gens, du Roi des gens, du Dieu des gens, contre le mal du chuchoteur sournois qui s\'esquive quand on l\'invoque, qui souffle le mal dans les poitrines des gens, parmi les djinns et parmi les gens."',
        source: 'Quran 114:1-6',
        repeat: 1,
      ),
    ],
  ),
];
