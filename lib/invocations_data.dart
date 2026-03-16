import 'app_locale.dart';

class Invocation {
  final String arabic;
  final String phonetic;
  final String translation;
  final String translationEn;
  final String source;
  const Invocation({required this.arabic, required this.phonetic, required this.translation, this.translationEn = '', required this.source});
  String get displayTranslation => AppLocale().isFrench ? translation : (translationEn.isNotEmpty ? translationEn : translation);
}

class InvocationCategory {
  final String id;
  final String title;
  final String titleEn;
  final String emoji;
  final String description;
  final String descriptionEn;
  final List<Invocation> invocations;

  const InvocationCategory({
    required this.id,
    required this.title,
    required this.titleEn,
    required this.emoji,
    required this.description,
    required this.descriptionEn,
    required this.invocations,
  });

  String get displayTitle => AppLocale().isFrench ? title : titleEn;
  String get displayDescription => AppLocale().isFrench ? description : descriptionEn;
}

const List<InvocationCategory> kInvocations = [
  InvocationCategory(
    id: 'quotidien',
    title: 'Quotidien',
    titleEn: 'Daily',
    emoji: '☀️',
    description: 'Du\'as pour les moments quotidiens',
    descriptionEn: 'Du\'as for daily moments',
    invocations: [
      Invocation(
        arabic: 'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
        phonetic: 'Bismillah ar-Rahman ar-Rahim',
        translation: 'Au nom d\'Allah, le Miséricordieux, le Très Miséricordieux',
        translationEn: 'In the name of Allah, the Most Gracious, the Most Merciful',
        source: 'Surah Al-Fatiha 1:1',
      ),
      Invocation(
        arabic: 'اللَّهُمَّ بِكَ أَمْسَيْنَا وَبِكَ أَصْبَحْنَا وَبِكَ نَحْيَا وَبِكَ نَمُوتُ وَإِلَيْكَ النُّشُورُ',
        phonetic: 'Allahumma bika amsayna wa bika asbahna wa bika nahya wa bika namutu wa ilaykal nushur',
        translation: 'Ô Allah, par Toi nous entrons la nuit et par Toi nous entrons le matin, par Toi nous vivons et par Toi nous mourons, et vers Toi est la résurrection',
        translationEn: 'O Allah, by You we enter the night and by You we enter the morning, by You we live and by You we die, and to You is the resurrection',
        source: 'Tirmidhi 3391',
      ),
      Invocation(
        arabic: 'الحَمْدُ لِلَّهِ الَّذِي أَحْيَانَا بَعْدَ مَا أَمَاتَنَا وَإِلَيْهِ النُّشُورُ',
        phonetic: 'Al-hamdu lillahi alladhi ahyana ba\'da ma amatana wa ilayhi al-nushur',
        translation: 'Louange à Allah qui nous a ramenés à la vie après nous avoir donné la mort, et vers Lui est la résurrection',
        translationEn: 'Praise be to Allah who gave us life after He had caused us to die, and to Him is the resurrection',
        source: 'Bukhari 6312',
      ),
      Invocation(
        arabic: 'بِسْمِ اللَّهِ، اللَّهُمَّ بَارِكْ لَنَا فِيهِ',
        phonetic: 'Bismillah, Allahumma barik lana fihi',
        translation: 'Au nom d\'Allah, Ô Allah, bénis-le pour nous',
        translationEn: 'In the name of Allah, O Allah, bless it for us',
        source: 'Abu Dawud 3735',
      ),
      Invocation(
        arabic: 'الحَمْدُ لِلَّهِ حَمْدًا كَثِيرًا طَيِّبًا مُبَارَكًا فِيهِ',
        phonetic: 'Al-hamdu lillahi hamdan kathira tayyiba mubarak fihi',
        translation: 'Louange à Allah, une louange nombreuse, bonne et bénie',
        translationEn: 'Praise be to Allah, a praise that is abundant, good, and blessed',
        source: 'Muslim 2734',
      ),
    ],
  ),
  InvocationCategory(
    id: 'voyage',
    title: 'Voyage',
    titleEn: 'Journey',
    emoji: '✈️',
    description: 'Du\'as pour les voyages et les trajets',
    descriptionEn: 'Du\'as for travels and trips',
    invocations: [
      Invocation(
        arabic: 'اللَّهُمَّ إِنَّا نَسْأَلُكَ فِي سَفَرِنَا هَذَا الْبِرَّ وَالتَّقْوَىٰ',
        phonetic: 'Allahumma inna nasaluka fi safarinA hadha al-birr wa at-taqwa',
        translation: 'Ô Allah, nous Te demandons dans ce voyage la piété et la crainte de Toi',
        translationEn: 'O Allah, we ask You in this journey for righteousness and God-consciousness',
        source: 'Muslim 1342',
      ),
      Invocation(
        arabic: 'سُبْحَانَ الَّذِي سَخَّرَ لَنَا هَٰذَا وَمَا كُنَّا لَهُ مُقْرِنِينَ',
        phonetic: 'Subhan alladhi sakhkhara lana hadha wa ma kunna lahu muqrineen',
        translation: 'Gloire à Celui qui nous a soumis cela alors que nous n\'en étions pas capables',
        translationEn: 'Glory be to the One who has made this subservient to us, whereas we were not capable of it',
        source: 'Surah Az-Zukhruf 43:13',
      ),
      Invocation(
        arabic: 'اللَّهُمَّ احْفَظْنَا فِي سَفَرِنَا هَذَا وَآبْ بِنَا آبَةً مَحْمُودَةً',
        phonetic: 'Allahumma ihfazna fi safarinA hadha wa ab bina abatan mahmuda',
        translation: 'Ô Allah, protège-nous dans ce voyage et ramène-nous avec un retour loué',
        translationEn: 'O Allah, protect us in this journey and bring us back safely with a praiseworthy return',
        source: 'Muslim 1342',
      ),
      Invocation(
        arabic: 'آيِبُون تَائِبُون عَابِدُون لِرَبِّنَا حَامِدُون',
        phonetic: 'Ayibun tawibun \'abidun li rabina hamidun',
        translation: 'Nous retournons repentants, adorateurs, louant notre Seigneur',
        translationEn: 'We return repentant, worshiping, and praising our Lord',
        source: 'Muslim 1342',
      ),
    ],
  ),
  InvocationCategory(
    id: 'maladie',
    title: 'Maladie & Guérison',
    titleEn: 'Illness & Healing',
    emoji: '🏥',
    description: 'Du\'as pour la santé et la guérison',
    descriptionEn: 'Du\'as for health and healing',
    invocations: [
      Invocation(
        arabic: 'لَا إِلَٰهَ إِلَّا أَنْتَ سُبْحَانَكَ إِنِّي كُنْتُ مِنَ الظَّالِمِينَ',
        phonetic: 'La ilaha illa anta subhanaka inni kuntu min az-zalimin',
        translation: 'Il n\'y a point de divinité excepté Toi, Gloire à Toi! J\'ai été du nombre des injustes',
        translationEn: 'There is no deity except You, glory be to You! I was indeed among the wrongdoers',
        source: 'Surah Al-Anbiya 21:87',
      ),
      Invocation(
        arabic: 'أَسْأَلُ اللَّهَ الْعَظِيمَ رَبَّ الْعَرْشِ الْعَظِيمِ أَنْ يَشْفِيَكَ',
        phonetic: 'As\'alu Allah al-\'azim rabba al-\'arsh al-\'azim an yashfiyak',
        translation: 'Je demande à Allah le Grand, Seigneur du Trône grandiose, de te guérir',
        translationEn: 'I ask Allah the Magnificent, Lord of the Magnificent Throne, to cure you',
        source: 'Tirmidhi 2087',
      ),
      Invocation(
        arabic: 'بِسْمِ اللَّهِ، تُرْبَةُ أَرْضِنَا بِرِيقَةِ بَعْضِنَا، يُشْفَىٰ بِهِ سَقِيمُنَا بِإِذْنِ رَبِّنَا',
        phonetic: 'Bismillah, turbatu ardina bi riqati ba\'dina, yushfa bihi saqimuna bi idhn rabbina',
        translation: 'Au nom d\'Allah, la terre de notre pays avec la salive d\'entre nous, guérit nos malades par la permission de notre Seigneur',
        translationEn: 'In the name of Allah, the earth of our land with the saliva of one of us heals our sick by the permission of our Lord',
        source: 'Bukhari 5745',
      ),
      Invocation(
        arabic: 'اللَّهُمَّ رَبَّ النَّاسِ أَذْهِبِ الْبَاسَ اشْفِ وَأَنْتَ الشَّافِي لَا شِفَاءَ إِلَّا شِفَاؤُكَ شِفَاءً لَا يُغَادِرُ سَقَمًا',
        phonetic: 'Allahumma rabba an-nas adhhib al-bas ashshifi wa anta ash-shafi la shifa\' illa shifa\'uka shifa\'an la yughadiru saqama',
        translation: 'Ô Allah, Seigneur des hommes, éloigne le mal, guéris car Tu es le Guérisseur et il n\'y a de guérison que la Tienne, une guérison qui ne laisse aucune maladie',
        translationEn: 'O Allah, Lord of mankind, remove the affliction, heal, for You are the Healer; there is no healing except Yours, a healing that leaves no illness behind',
        source: 'Bukhari 5656',
      ),
    ],
  ),
  InvocationCategory(
    id: 'argent',
    title: 'Argent & Subsistance',
    titleEn: 'Money & Provision',
    emoji: '💰',
    description: 'Du\'as pour la richesse et le bien-être',
    descriptionEn: 'Du\'as for wealth and well-being',
    invocations: [
      Invocation(
        arabic: 'اللَّهُمَّ إِنِّي أَسْأَلُكَ عِلْمًا نَافِعًا وَرِزْقًا طَيِّبًا وَعَمَلًا مُتَقَبَّلًا',
        phonetic: 'Allahumma inni as\'aluka \'ilman nafi\'an wa rizqan tayyiba wa \'amalan mutaqabbala',
        translation: 'Ô Allah, je Te demande une science utile, une subsistance bonne et une action agréée',
        translationEn: 'O Allah, I ask You for beneficial knowledge, good provision, and accepted deeds',
        source: 'Ibn Majah 3846',
      ),
      Invocation(
        arabic: 'اللَّهُمَّ لَا تَجْعَلْ مُعِيشَتَنَا كِدًّا وَلَا تَجْعَلْ أَكْثَرَ عَيْشِنَا هَمًّا',
        phonetic: 'Allahumma la taj\'al mu\'ishatana kidda wa la taj\'al akthara \'ayshina hamma',
        translation: 'Ô Allah, ne fais pas notre subsistance une peine, et ne fais pas l\'essentiel de notre vie une inquiétude',
        translationEn: 'O Allah, do not make our livelihood a hardship, and do not make most of our life a worry',
        source: 'Saheeh at-Tirmidhi 3502',
      ),
      Invocation(
        arabic: 'اللَّهُمَّ بَارِكْ لَهُ فِي مَا آتَيْتَهُ',
        phonetic: 'Allahumma barik lahu fi ma ataytahu',
        translation: 'Ô Allah, bénis-le dans ce que Tu lui as donné',
        translationEn: 'O Allah, bless him in what You have given him',
        source: 'Surah Al-Ahqaf 46:15',
      ),
      Invocation(
        arabic: 'اللَّهُمَّ أَغْنِنِي بِحِلَالِكَ عَنْ حَرَامِكَ وَأَغْنِنِي بِفَضْلِكَ عَمَّنْ سِوَاكَ',
        phonetic: 'Allahumma aghnini bi hilalika \'an haramik wa aghnini bi fadlika \'amman siwak',
        translation: 'Ô Allah, enrichis-moi par Ton halal contre Ton haram et enrichis-moi par Ta grâce de quiconque excepté Toi',
        translationEn: 'O Allah, enrich me through Your lawful against Your forbidden, and make me independent of all others through Your grace',
        source: 'Tirmidhi 3563',
      ),
    ],
  ),
  InvocationCategory(
    id: 'famille',
    title: 'Parents & Famille',
    titleEn: 'Parents & Family',
    emoji: '👨‍👩‍👧‍👦',
    description: 'Du\'as pour la famille et les proches',
    descriptionEn: 'Du\'as for family and loved ones',
    invocations: [
      Invocation(
        arabic: 'رَّبِ اغْفِرْ لِي وَلِوَالِدَيَّ وَلِمَن دَخَلَ بَيْتِيَ مُؤْمِنًا وَلِلْمُؤْمِنِينَ وَالْمُؤْمِنَاتِ',
        phonetic: 'Rabbi ighfir li wa li walidayya wa li man dakhala bayti mu\'minan wa lil mu\'minin wa al-mu\'minat',
        translation: 'Seigneur, pardonne-moi, pardonne à mes parents et à celui qui entre dans ma maison croyant, ainsi qu\'aux croyants et aux croyantes',
        translationEn: 'Lord, forgive me, my parents, and those who enter my house as believers, as well as all believing men and women',
        source: 'Surah Nouh 71:28',
      ),
      Invocation(
        arabic: 'اللَّهُمَّ اغْفِرْ لِوَالِدَيَّ وَارْحَمْهُمَا كَمَا رَبَّيَانِي صَغِيرًا',
        phonetic: 'Allahumma ighfir li walidayya wa arhamhuma kama rabbayani saghira',
        translation: 'Ô Allah, pardonne à mes parents et sois miséricordieux avec eux comme ils l\'ont été pour moi quand j\'étais petit',
        translationEn: 'O Allah, forgive my parents and be merciful to them as they raised me when I was young',
        source: 'Surah Al-Isra 17:24',
      ),
      Invocation(
        arabic: 'اللَّهُمَّ آتِنَا فِي الدُّنْيَا حَسَنَةً وَفِي الْآخِرَةِ حَسَنَةً وَقِنَا عَذَابَ النَّارِ',
        phonetic: 'Allahumma atina fi ad-dunya hasana wa fi al-akhira hasana wa qina \'adhab an-nar',
        translation: 'Ô Allah, accorde-nous une belle vie en ce monde et une belle vie dans l\'au-delà, et protège-nous du châtiment du feu',
        translationEn: 'O Allah, grant us good in this world and good in the hereafter, and protect us from the punishment of the Fire',
        source: 'Surah Al-Baqarah 2:201',
      ),
      Invocation(
        arabic: 'رَبِّ اجْعَلْ أَهْلِي وَمَالِي وَذُرِّيَّتِي فِي أَحْسَنِ حَالٍ',
        phonetic: 'Rabbi ij\'al ahli wa mali wa dhuriyyati fi ahsan hal',
        translation: 'Seigneur, fais que ma famille, mes biens et ma descendance soient dans le meilleur état',
        translationEn: 'Lord, make my family, my wealth, and my offspring be in the best of states',
        source: 'Surah Ibrahim 14:35-36',
      ),
    ],
  ),
  InvocationCategory(
    id: 'mariage',
    title: 'Mariage',
    titleEn: 'Marriage',
    emoji: '💍',
    description: 'Du\'as pour le mariage et les couples',
    descriptionEn: 'Du\'as for marriage and couples',
    invocations: [
      Invocation(
        arabic: 'اللَّهُمَّ إِنِّي أَسْأَلُكَ خَيْرَهَا وَخَيْرَ مَا جَبَلْتَهَا عَلَيْهِ وَأَعُوذُ بِكَ مِنْ شَرِّهَا وَشَرِّ مَا جَبَلْتَهَا عَلَيْهِ',
        phonetic: 'Allahumma inni as\'aluka khayraha wa khayra ma jabalthaha \'alayhi wa a\'udhu bika min sharriha wa sharri ma jabalthaha \'alayhi',
        translation: 'Ô Allah, je Te demande le bien en elle et le bien sur lequel elle a été créée, et je me réfugie auprès de Toi contre le mal en elle et le mal sur lequel elle a été créée',
        translationEn: 'O Allah, I ask You for the good in her and the good upon which she was created, and I seek refuge in You from the evil in her and the evil upon which she was created',
        source: 'Abu Dawud 2160',
      ),
      Invocation(
        arabic: 'بَارَكَ اللَّهُ لَكَ وَبَارَكَ عَلَيْكَ وَجَمَعَ بَيْنَكُمَا فِي خَيْرٍ',
        phonetic: 'Baraka Allahu laka wa baraka \'alayka wa jama\'a baynakouma fi khayrin',
        translation: 'Qu\'Allah te bénisse et te donne sa bénédiction, et vous réunisse dans le bien',
        translationEn: 'May Allah bless you and bestow His blessings upon you, and unite you both in goodness',
        source: 'Tirmidhi 3388',
      ),
      Invocation(
        arabic: 'اللَّهُمَّ وَفِّقْ بَيْنَهُمَا وَأَلِّفْ بَيْنَ قُلُوبِهِمَا وَبَارِكْ لَهُمَا فِي بَيْتِهِمَا',
        phonetic: 'Allahumma waafiq baynahuma wa allif bayna qulubihima wa barik lahuma fi baytihima',
        translation: 'Ô Allah, accorde-leur l\'harmonie, réunis leurs cœurs, et bénis-les dans leur maison',
        translationEn: 'O Allah, grant them harmony, unite their hearts, and bless them in their home',
        source: 'Ad-Daraqutni',
      ),
      Invocation(
        arabic: 'اللَّهُمَّ ارْزُقْهُمَا وِلْدًا صَالِحًا وَاجْعَلْهُ قُرَّةَ عَيْنٍ لَهُمَا',
        phonetic: 'Allahumma urzuqhuma waladan salihan wa ij\'alhu qurrata \'aynin lahuma',
        translation: 'Ô Allah, donne-leur un enfant pieux et fais-le la joie de leurs yeux',
        translationEn: 'O Allah, grant them a righteous child and make him the joy of their eyes',
        source: 'Surah Al-Furqan 25:74',
      ),
    ],
  ),
  InvocationCategory(
    id: 'protection',
    title: 'Protection',
    titleEn: 'Protection',
    emoji: '🛡️',
    description: 'Du\'as pour se protéger du mal',
    descriptionEn: 'Du\'as to protect from evil',
    invocations: [
      Invocation(
        arabic: 'أَعُوذُ بِاللَّهِ مِنْ شَرِّ مَا خَلَقَ',
        phonetic: 'A\'udhu billahi min sharri ma khalaq',
        translation: 'Je me réfugie auprès d\'Allah contre le mal de ce qu\'Il a créé',
        translationEn: 'I seek refuge in Allah from the evil of what He has created',
        source: 'Surah Al-Falaq 113:1',
      ),
      Invocation(
        arabic: 'أَعُوذُ بِاللَّهِ السَّمِيعِ الْعَلِيمِ مِنَ الشَّيْطَانِ الرَّجِيمِ',
        phonetic: 'A\'udhu billahi as-sami\'i al-\'alim min ash-shaytan ar-rajim',
        translation: 'Je me réfugie auprès d\'Allah l\'Entendant, l\'Omniscient, contre le Diable maudit',
        translationEn: 'I seek refuge in Allah the All-Hearing, the All-Knowing, from the accursed devil',
        source: 'Surah An-Nahl 16:98',
      ),
      Invocation(
        arabic: 'اللَّهُمَّ احْفَظْنِي بِالْإِسْلَامِ قَائِمًا وَاحْفَظْنِي بِالْإِسْلَامِ قَاعِدًا وَاحْفَظْنِي بِالْإِسْلَامِ رَاقِدًا',
        phonetic: 'Allahumma ihfazni bil-islam qaimman wa ihfazni bil-islam qa\'idan wa ihfazni bil-islam raqidan',
        translation: 'Ô Allah, protège-moi par l\'Islam debout, protège-moi par l\'Islam assis, protège-moi par l\'Islam couché',
        translationEn: 'O Allah, protect me through Islam while standing, protect me through Islam while sitting, protect me through Islam while lying down',
        source: 'Ad-Daraqutni',
      ),
      Invocation(
        arabic: 'بِسْمِ اللَّهِ الَّذِي لَا يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الْأَرْضِ وَلَا فِي السَّمَاءِ وَهُوَ السَّمِيعُ الْعَلِيمُ',
        phonetic: 'Bismillahi alladhi la yadurru ma\'a ism hu shay\'in fi al-ard wa la fi as-sama\'i wa huwa as-sami\'u al-\'alim',
        translation: 'Au nom d\'Allah, avec Qui rien ne peut nuire sur terre ni dans le ciel, et Il est l\'Entendant, l\'Omniscient',
        translationEn: 'In the name of Allah, with Whose name nothing on earth or in heaven can cause harm, and He is the All-Hearing, the All-Knowing',
        source: 'Tirmidhi 3388',
      ),
      Invocation(
        arabic: 'أَسْأَلُ اللَّهَ الْعَظِيمَ أَنْ يُجِيرَنِي مِنْ جَهَنَّمَ',
        phonetic: 'As\'alu Allah al-\'azim an yujirni min jahannam',
        translation: 'Je demande à Allah le Grand de me protéger de l\'Enfer',
        translationEn: 'I ask Allah the Magnificent to protect me from Hellfire',
        source: 'Tirmidhi 2577',
      ),
    ],
  ),
  InvocationCategory(
    id: 'souhait',
    title: 'Souhait & Besoin',
    titleEn: 'Wish & Need',
    emoji: '🤲',
    description: 'Du\'as pour ses besoins et ses désirs',
    descriptionEn: 'Du\'as for your needs and desires',
    invocations: [
      Invocation(
        arabic: 'لَا إِلَٰهَ إِلَّا أَنْتَ سُبْحَانَكَ إِنِّي كُنْتُ مِنَ الظَّالِمِينَ',
        phonetic: 'La ilaha illa anta subhanaka inni kuntu min az-zalimin',
        translation: 'Il n\'y a point de divinité excepté Toi, Gloire à Toi! J\'ai été du nombre des injustes',
        translationEn: 'There is no deity except You, glory be to You! I was indeed among the wrongdoers',
        source: 'Surah Al-Anbiya 21:87',
      ),
      Invocation(
        arabic: 'اللَّهُمَّ إِنِّي أَسْتَخِيرُكَ بِعِلْمِكَ وَأَسْتَقْدِرُكَ بِقُدْرَتِكَ وَأَسْأَلُكَ مِنْ فَضْلِكَ الْعَظِيمِ',
        phonetic: 'Allahumma inni astakhiruka bi\'ilmika wa astaqdiruka bi qudratika wa as\'aluka min fadlika al-\'azim',
        translation: 'Ô Allah, je Te demande de choisir pour moi par Ton savoir, je Te demande de me donner puissance par Ta puissance, et je Te demande de Ta grande grâce',
        translationEn: 'O Allah, I seek Your guidance through Your knowledge, I seek Your empowerment through Your power, and I ask of Your great bounty',
        source: 'Bukhari 6382',
      ),
      Invocation(
        arabic: 'رَّبِّ اشْرَحْ لِي صَدْرِي وَيَسِّرْ لِي أَمْرِي وَاحْلُلْ عُقْدَةً مِّن لِّسَانِي يَفْقَهُوا قَوْلِي',
        phonetic: 'Rabbi ishrah li sadri wa yassir li amri wa ahlul \'uqdatan min lisani yafqahu qawli',
        translation: 'Seigneur, élargis ma poitrine, facilite-moi mes affaires, et dénoue le nœud de ma langue pour qu\'on comprenne ma parole',
        translationEn: 'Lord, expand my breast, make my affairs easy, and untie the knot of my tongue so they may understand my speech',
        source: 'Surah Taha 20:25-28',
      ),
      Invocation(
        arabic: 'حَسْبُنَا اللَّهُ وَنِعْمَ الْوَكِيلُ',
        phonetic: 'Hasbunallahu wa ni\'ma al-wakil',
        translation: 'Allah nous suffit et quel excellent protecteur',
        translationEn: 'Allah is sufficient for us, and He is the best Disposer of affairs',
        source: 'Surah Al-Imran 3:173',
      ),
    ],
  ),
  InvocationCategory(
    id: 'repentir',
    title: 'Repentir & Pardon',
    titleEn: 'Repentance & Forgiveness',
    emoji: '🕊️',
    description: 'Du\'as pour le repentir et le pardon',
    descriptionEn: 'Du\'as for repentance and forgiveness',
    invocations: [
      Invocation(
        arabic: 'أَسْتَغْفِرُ اللَّهَ الْعَظِيمَ الَّذِي لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ وَأَتُوبُ إِلَيْهِ',
        phonetic: 'Astaghfir Allah al-\'azim alladhi la ilaha illa huwa al-hayyu al-qayyum wa atubu ilayhi',
        translation: 'Je demande pardon à Allah le Grand, il n\'y a de divinité que Lui, le Vivant, le Subsistant, et je me repens auprès de Lui',
        translationEn: 'I seek forgiveness from Allah the Magnificent; there is no deity except Him, the Ever-Living, the Self-Sustaining, and I repent to Him',
        source: 'Tirmidhi 3393',
      ),
      Invocation(
        arabic: 'اللَّهُمَّ أَنْتَ رَبِّي لَا إِلَٰهَ إِلَّا أَنْتَ خَلَقْتَنِي وَأَنَا عَبْدُكَ وَأَنَا عَلَىٰ عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ أَعُوذُ بِكَ مِنْ شَرِّ مَا صَنَعْتُ',
        phonetic: 'Allahumma anta rabbi la ilaha illa anta khalaqtani wa ana \'abduka wa ana \'ala \'ahdika wa wa\'dika ma istata\'tu a\'udhu bika min sharri ma sana\'tu',
        translation: 'Ô Allah, Tu es mon Seigneur, il n\'y a de divinité que Toi, Tu m\'as créé et je suis Ton serviteur, je suis attaché à Ton pacte et à Ta promesse autant que je peux, je me réfugie auprès de Toi contre le mal que j\'ai commis',
        translationEn: 'O Allah, You are my Lord, there is no deity except You, You created me and I am Your servant, I abide by Your covenant and promise as best I can, I seek refuge in You from the evil I have committed',
        source: 'Bukhari 6306',
      ),
      Invocation(
        arabic: 'سَيِّدُ الِاسْتِغْفَارِ أَنْ تَقُولَ اللَّهُمَّ أَنْتَ رَبِّي لَا إِلَٰهَ إِلَّا أَنْتَ ظَلَمْتُ نَفْسِي فَاغْفِرْ لِي',
        phonetic: 'Sayyid al-istighfar an taqula Allahumma anta rabbi la ilaha illa anta zalamtu nafsi faghfir li',
        translation: 'Le meilleur de la demande de pardon c\'est que tu dises: Ô Allah, Tu es mon Seigneur, il n\'y a de divinité que Toi, j\'ai été injuste envers moi-même, pardonne-moi',
        translationEn: 'The master supplication for forgiveness is to say: O Allah, You are my Lord, there is no deity except You, I have wronged myself, so forgive me',
        source: 'Muslim 2705',
      ),
      Invocation(
        arabic: 'رَبِّ إِنِّي ظَلَمْتُ نَفْسِي فَاغْفِرْ لِي إِنَّهُ لَا يَغْفِرُ الذُّنُوبَ إِلَّا أَنْتَ',
        phonetic: 'Rabbi inni zalamtu nafsi faghfir li innahu la yaghfiru adh-dhunuba illa anta',
        translation: 'Seigneur, j\'ai été injuste envers moi-même, pardonne-moi car nul ne pardonne les péchés excepté Toi',
        translationEn: 'Lord, I have wronged myself, so forgive me, for none forgives sins except You',
        source: 'Surah An-Nisa 4:106',
      ),
    ],
  ),
  InvocationCategory(
    id: 'deuil',
    title: 'Mort & Deuil',
    titleEn: 'Death & Grief',
    emoji: '🕯️',
    description: 'Du\'as pour les défunts et le deuil',
    descriptionEn: 'Du\'as for the deceased and grief',
    invocations: [
      Invocation(
        arabic: 'إِنَّا لِلَّهِ وَإِنَّا إِلَيْهِ رَاجِعُونَ',
        phonetic: 'Inna lillahi wa inna ilayhi raji\'un',
        translation: 'Certes, nous appartenons à Allah et c\'est à Lui que nous retournerons',
        translationEn: 'Verily, we belong to Allah and verily to Him we shall return',
        source: 'Surah Al-Baqarah 2:156',
      ),
      Invocation(
        arabic: 'اللَّهُمَّ اغْفِرْ لَهُ وَارْحَمْهُ وَعَافِهِ وَاعْفُ عَنْهُ وَأَكْرِمْ نُزُلَهُ وَوَسِّعْ مَدْخَلَهُ',
        phonetic: 'Allahumma ighfir lahu wa arhamhu wa \'afihi wa a\'fu \'anhu wa akrim nuzulahu wa wassi\' madkhalaahu',
        translation: 'Ô Allah, pardonne-lui, sois miséricordieux avec lui, accorde-lui l\'immunité, pardonne-lui, honore sa demeure et élargis son entrée',
        translationEn: 'O Allah, forgive him, be merciful to him, grant him well-being, pardon him, honor his reception, and widen his entrance',
        source: 'Muslim 920',
      ),
      Invocation(
        arabic: 'اللَّهُمَّ آتِ آلَ مُحَمَّدٍ الْخَيْرَ',
        phonetic: 'Allahumma ati al Muhammad al-khayrah',
        translation: 'Ô Allah, accorde le bien à la famille de Muhammad',
        translationEn: 'O Allah, grant good to the family of Muhammad',
        source: 'Muslim 915',
      ),
      Invocation(
        arabic: 'أَحْسِنْ ثَوَابَنَا فِي مُصِيبَتِنَا',
        phonetic: 'Ahsin thawabana fi musibatina',
        translation: 'Rends notre récompense belle dans notre malheur',
        translationEn: 'Make our reward beautiful in our calamity',
        source: 'Muslim 918',
      ),
    ],
  ),
  InvocationCategory(
    id: 'travail',
    title: 'Examen & Travail',
    titleEn: 'Exam & Work',
    emoji: '📚',
    description: 'Du\'as pour les études et le travail',
    descriptionEn: 'Du\'as for studies and work',
    invocations: [
      Invocation(
        arabic: 'رَبِّ اشْرَحْ لِي صَدْرِي وَيَسِّرْ لِي أَمْرِي',
        phonetic: 'Rabbi ishrah li sadri wa yassir li amri',
        translation: 'Seigneur, élargis ma poitrine et facilite-moi mes affaires',
        translationEn: 'Lord, expand my breast and make my affairs easy for me',
        source: 'Surah Taha 20:25',
      ),
      Invocation(
        arabic: 'اللَّهُمَّ إِنِّي أَسْأَلُكَ فِهْمَ النَّبِيِّينَ وَحِفْظَ الْمُرْسَلِينَ',
        phonetic: 'Allahumma inni as\'aluka fihm an-nabiyyin wa hifz al-mursilin',
        translation: 'Ô Allah, je Te demande la compréhension des prophètes et la mémorisation des messagers',
        translationEn: 'O Allah, I ask You for the understanding of the prophets and the memorization of the messengers',
        source: 'Ibn Majah 3286',
      ),
      Invocation(
        arabic: 'اللَّهُمَّ لَا سَهْلَ إِلَّا مَا جَعَلْتَهُ سَهْلًا وَأَنْتَ تَجْعَلُ الْحَزْنَ إِذَا شِئْتَ سَهْلًا',
        phonetic: 'Allahumma la sahla illa ma ja\'altahu sahla wa anta taj\'alu al-hazn idha shi\'ta sahla',
        translation: 'Ô Allah, il n\'y a de facilité que ce que Tu as rendu facile, et Tu peux rendre le difficile facile si Tu le veux',
        translationEn: 'O Allah, there is no ease except what You make easy, and You can make the difficult easy if You will',
        source: 'Ibn Hibban',
      ),
      Invocation(
        arabic: 'اللَّهُمَّ أَعِنِّي عَلَىٰ ذِكْرِكَ وَشُكْرِكَ وَحُسْنِ عِبَادَتِكَ',
        phonetic: 'Allahumma a\'inni \'ala dhikrika wa shukrika wa husn \'ibadatik',
        translation: 'Ô Allah, aide-moi à Te commémorer, à Te remercier, et à T\'adorer de la plus belle façon',
        translationEn: 'O Allah, help me to remember You, to thank You, and to worship You in the best manner',
        source: 'Abu Dawud 1522',
      ),
    ],
  ),
  InvocationCategory(
    id: 'pluie',
    title: 'Pluie & Climat',
    titleEn: 'Rain & Weather',
    emoji: '🌧️',
    description: 'Du\'as pour la pluie et la météo',
    descriptionEn: 'Du\'as for rain and weather',
    invocations: [
      Invocation(
        arabic: 'اللَّهُمَّ اسْقِنَا غَيْثًا مُغِيثًا مَرِيعًا نَافِعًا غَيْرَ ضَارٍّ',
        phonetic: 'Allahumma asqina ghaythan mughithan mari\'an nafi\'an ghayra dari',
        translation: 'Ô Allah, donne-nous une pluie salvatrice, abondante, bénéfique et non nuisible',
        translationEn: 'O Allah, send us saving rain, abundant, beneficial, and not harmful',
        source: 'Sunan Abu Dawud 1168',
      ),
      Invocation(
        arabic: 'اللَّهُمَّ اسْقِ عِبَادَكَ وَأَنْعَامَكَ وَانْشُرْ رَحْمَتَكَ وَأَحْيِ بِلَادَكَ الْمَيْتَةَ',
        phonetic: 'Allahumma asqi \'ibadaka wa an\'amaka wa anshur rahmataka wa ahyi biladaka al-maytah',
        translation: 'Ô Allah, donne à boire à Tes serviteurs et à Tes bêtes, répands Ta miséricorde et redonne vie à Tes terres mortes',
        translationEn: 'O Allah, give drink to Your servants and livestock, spread Your mercy, and revive Your dead lands',
        source: 'Sunan At-Tirmidhi 1752',
      ),
      Invocation(
        arabic: 'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ عَدَدَ خَلْقِهِ وَرِضَا نَفْسِهِ وَزِنَةَ عَرْشِهِ وَمِدَادَ كَلِمَاتِهِ',
        phonetic: 'Subhan Allah wa bihamdih \'adad khalqih wa rida nafsih wa zinah \'arshih wa midaad kalimatihi',
        translation: 'Gloire à Allah et louange à Lui, en nombre de Sa création, à la satisfaction de Lui-même, du poids de Son Trône et de l\'encre de Ses paroles',
        translationEn: 'Glory be to Allah and praise be to Him, equal to the number of His creation, to His own pleasure, the weight of His Throne, and the ink of His words',
        source: 'Muslim 2726',
      ),
    ],
  ),
];
