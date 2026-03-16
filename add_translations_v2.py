#!/usr/bin/env python3
"""
Add English translations for explicationEn and applicationQuotidienneEn
to hadiths 8-50 in hadith_screen.dart
"""

import re

# English translations for hadiths 8-50
translations = {
    8: {
        'explicationEn': 'This hadith teaches us to control our speech. Good words bring people closer to Allah, while harmful words destroy relationships and earn sins. Silence, when one cannot speak good, is itself an act of worship.',
        'applicationQuotidienneEn': 'Before speaking, ask yourself: is what I am about to say beneficial? If not, remain silent. Practice this especially on social media, where thoughtless words can cause great harm.'
    },
    9: {
        'explicationEn': 'Islam is not merely rituals — it is a complete way of life that includes how we treat others. True faith manifests in our relationships: a Muslim never harms others physically or verbally.',
        'applicationQuotidienneEn': 'Audit your words and actions today. Have you hurt anyone with your tongue — through gossip, sarcasm, or harsh words? Have you harmed anyone with your hand? Make amends and resolve to improve.'
    },
    10: {
        'explicationEn': 'Gratitude to Allah and gratitude to people are linked. One who cannot recognize human kindness has a heart closed to gratitude, making it difficult to truly thank Allah. Thankfulness is a spiritual quality cultivated through practice.',
        'applicationQuotidienneEn': 'Make it a habit to sincerely thank those who help you — family, colleagues, strangers. Say "jazakAllahu khayran" or "thank you" genuinely. Keep a gratitude journal noting three things you are thankful for each day.'
    },
    11: {
        'explicationEn': 'Anger is mentioned three times in this hadith because it is both common and dangerous. Anger clouds judgment, damages relationships, and leads to regret. The Prophet ﷺ gave this simple but profound advice as a key to wisdom in all matters.',
        'applicationQuotidienneEn': 'When you feel anger rising, sit if you are standing, lie down if you are sitting, make wudu, or simply leave the situation. Count to ten and recite "A\'udhu billahi min ash-Shaytan ir-rajim." Return to the matter only when calm.'
    },
    12: {
        'explicationEn': 'Rifq (gentleness) is a divine attribute that Allah loves and rewards. Whether in speech, leadership, parenting, or education, a gentle approach achieves better results and reflects a noble character. Harshness repels people while gentleness attracts them.',
        'applicationQuotidienneEn': 'Choose the gentle approach in your interactions today. When correcting someone, do it kindly. When making a request, do it softly. Notice how people respond more positively to gentleness than to force.'
    },
    13: {
        'explicationEn': 'This hadith establishes that good character (akhlaq) is an essential part of faith, not an optional extra. The Prophet ﷺ himself was described by Aisha as "walking Quran" — his character embodied his faith perfectly. Faith without good character is incomplete.',
        'applicationQuotidienneEn': 'Identify one aspect of your character to improve this week — patience, honesty, generosity, or kindness. Make a concrete plan: how will you practice this quality today? Track your progress at the end of each day.'
    },
    14: {
        'explicationEn': 'Islam elevates even the smallest act of kindness to the level of sadaqa (charity). A smile costs nothing yet brings joy to the receiver. This hadith opens the door to constant worship through simple, everyday gestures, making spirituality accessible to all.',
        'applicationQuotidienneEn': 'Smile consciously at the people you encounter today — family members, colleagues, the cashier at the store. Notice how a genuine smile changes the atmosphere of an interaction and brings warmth to both giver and receiver.'
    },
    15: {
        'explicationEn': 'The Prophet ﷺ made this personal by saying he is the best to his own family. This shows that closeness to Allah is measured not by outward piety alone but by how we treat those closest to us. Our families deserve our best — not what is left after everything else.',
        'applicationQuotidienneEn': 'Do something kind for a family member today that they do not expect — help with a task, express appreciation, listen attentively. The home should be where we show our best character, not where we relax our standards.'
    },
    16: {
        'explicationEn': 'This powerful metaphor places paradise in the service of mothers — meaning that honoring, serving, and obeying one\'s mother is a direct path to paradise. The mother\'s sacrifices, from pregnancy through childhood and beyond, earn her an extraordinary status in Islam.',
        'applicationQuotidienneEn': 'Call your mother today if you can, or visit her if possible. Express your gratitude. If she has passed, make du\'a for her. If your relationship is strained, take the first step toward reconciliation. No sacrifice for a mother is too great.'
    },
    17: {
        'explicationEn': 'When asked who deserves the best companionship, the Prophet ﷺ said "your mother" three times before saying "your father." This emphasis reflects the immense sacrifice a mother makes — pregnancy, childbirth, and years of nursing and care — which creates an extraordinary debt of gratitude.',
        'applicationQuotidienneEn': 'Reflect on what your mother sacrificed for you. Write down three specific things she did that shaped who you are. Express gratitude through actions, not just words — take care of her needs, be patient with her, and honor her in front of others.'
    },
    18: {
        'explicationEn': 'This comprehensive command includes all women — wives, daughters, mothers, sisters. Islam elevated the status of women at a time when they were oppressed in many societies. Good treatment means respect, justice, kindness, and recognition of their rights — in word and in deed.',
        'applicationQuotidienneEn': 'Examine how you treat the women in your life. Are you patient, respectful, and supportive? Do you acknowledge their contributions? Make a concrete effort today to show appreciation and respect to the women around you.'
    },
    19: {
        'explicationEn': 'Silat ar-rahim (maintaining family ties) brings divine blessings in this life and the next. Allah blessed the one who maintains family bonds with a longer life and greater provision. This shows that the social dimension of Islam — caring for family — has real, tangible benefits.',
        'applicationQuotidienneEn': 'Reach out to a family member you have not contacted in a while — an aunt, uncle, cousin, or sibling. A phone call, a message, or a visit is enough. Do not wait for the perfect moment; the act of reaching out itself is the worship.'
    },
    20: {
        'explicationEn': 'Anyone can maintain good relations with those who treat them well. The true test of silat ar-rahim is continuing to reach out to family members who have distanced themselves or caused harm. This requires a heart that seeks Allah\'s pleasure above personal comfort.',
        'applicationQuotidienneEn': 'Think of a family member who has hurt you or with whom you have lost contact. Make du\'a for them. Then take one small step — a brief message, a prayer for their wellbeing. You are not responsible for their response, only for your effort.'
    },
    21: {
        'explicationEn': 'This hadith gives extraordinary honor to honest merchants by placing them alongside prophets, the truthful, and martyrs on the Day of Judgment. Commerce itself is not lowly — it becomes noble when conducted with integrity. Honesty in business is an act of worship.',
        'applicationQuotidienneEn': 'Review your business or work practices. Are you fully honest in your dealings? Do you deliver what you promise? Do you disclose defects in what you sell? Commit to one improvement in your professional honesty today.'
    },
    22: {
        'explicationEn': 'Swearing oaths to increase sales is a form of deception that may temporarily work but removes the barakah (blessing) from the transaction. Business built on false oaths is fragile and spiritually harmful. Honest business, even if slower, carries divine blessing.',
        'applicationQuotidienneEn': 'In negotiations or sales, rely on the quality and honesty of what you offer rather than oaths or exaggeration. If you catch yourself embellishing or overstating, correct yourself. The long-term trust you build is worth far more than any short-term gain.'
    },
    23: {
        'explicationEn': 'This strong statement from the Prophet ﷺ shows that deception — whether in commerce, relationships, or any aspect of life — is fundamentally incompatible with Islamic values. A Muslim\'s word must be trustworthy. Cheating others is a betrayal of the brotherhood of faith.',
        'applicationQuotidienneEn': 'Audit your honesty in daily life. Do you sometimes exaggerate, hide information, or mislead others for personal gain? Commit to total transparency today, even when honesty is costly. Your integrity is your greatest asset.'
    },
    24: {
        'explicationEn': 'This hadith establishes both a legal right (to rescind a transaction before separation) and a spiritual principle — honesty in commerce brings barakah. Islam encourages transparency in business, ensuring both parties are satisfied and protected from exploitation.',
        'applicationQuotidienneEn': 'In your next transaction, practice full disclosure. Share any relevant information even if it is not in your favor. Build a reputation for trustworthiness. When people know you are honest, they will seek you out and bless you with their trust and loyalty.'
    },
    25: {
        'explicationEn': 'This vivid image — pay before the sweat dries — emphasizes the urgency of fulfilling workers\' rights. Withholding or delaying wages is a serious injustice. Employers have a sacred duty to pay fairly and promptly. Workers are not to be exploited, regardless of their status.',
        'applicationQuotidienneEn': 'If you employ anyone — a cleaner, a driver, a helper — ensure you pay them promptly and fairly, before they even ask. Appreciate the work others do for you. Advocate for fair wages in your workplace and community.'
    },
    26: {
        'explicationEn': 'The word "obligation" (farida) is striking — knowledge is not optional for a Muslim. This includes religious knowledge (what is halal and haram, how to pray, etc.) but also the knowledge needed to fulfill one\'s responsibilities in life, work, and family. Islam is a religion that honors the intellect.',
        'applicationQuotidienneEn': 'Dedicate at least 15 minutes daily to learning — read a page of Quran with tafsir, study a hadith, listen to a lecture, or read an Islamic book. Keep a learning journal. The pursuit of knowledge is itself an act of worship.'
    },
    27: {
        'explicationEn': 'The Quran is the word of Allah — learning it and teaching it is therefore the most noble of activities. This hadith promises an elevated status to those who engage with the Quran, not just by reading it, but by deepening their understanding and sharing that knowledge with others.',
        'applicationQuotidienneEn': 'Recite a portion of the Quran daily with understanding — even one verse with its meaning. Share what you learn with family or friends. If you can teach even one person to read the Quran correctly, you earn ongoing reward for every recitation they make.'
    },
    28: {
        'explicationEn': 'The path to knowledge — whether to a mosque, library, or class — is literally transformed into a path to paradise. This is the Islamic vision of education: not merely intellectual development but a spiritual journey. Allah honors every genuine effort to learn and grow.',
        'applicationQuotidienneEn': 'Start or continue a learning path today. Enroll in an Islamic studies course, join a Quran circle, or set a consistent daily reading habit. Every step taken for knowledge is a step toward paradise — even the commute to your class.'
    },
    29: {
        'explicationEn': 'Fiqh here means deep understanding — not just surface knowledge. When Allah wants good for someone, He opens their heart and mind to understand the religion deeply. This is both encouraging (pursue understanding) and humbling (it is a divine gift, not self-achievement).',
        'applicationQuotidienneEn': 'Ask Allah sincerely in your du\'a: "O Allah, grant me deep understanding of Your religion." Then pursue that understanding actively — study, ask scholars, reflect on verses. Combine supplication with action for the best results.'
    },
    30: {
        'explicationEn': 'Ibn Umar, who narrated this hadith, said: "When evening comes, do not expect to see the morning. When morning comes, do not expect to see the evening." This perspective on life — as a temporary passage — frees us from excessive attachment to worldly things and keeps our focus on the eternal.',
        'applicationQuotidienneEn': 'Declutter one area of your life today — materially or mentally. Identify something you are overly attached to. Ask yourself: if I left this world tomorrow, does this attachment serve my eternal wellbeing? Live lightly, give generously, and invest in what lasts.'
    },
    31: {
        'explicationEn': 'Haya (modesty and shame) is not weakness — it is a moral compass. When haya is present, it restrains a person from evil. When it is absent, nothing prevents misconduct. This saying, preserved from the earliest prophets, identifies haya as a foundational virtue of all divine guidance.',
        'applicationQuotidienneEn': 'Before each action, ask yourself: would I be embarrassed if Allah sees this? Would I be embarrassed if my loved ones saw this? Let that sense of haya guide your choices. Protect your modesty in dress, speech, and behavior.'
    },
    32: {
        'explicationEn': 'Ihsan means doing things beautifully and completely — not just adequately. Even when slaughtering an animal, Allah commands excellence: a sharp blade, minimal suffering. This principle extends to every domain: work, worship, relationships, and art. Islam is a religion of beauty and quality.',
        'applicationQuotidienneEn': 'Choose one task today and do it with ihsan — full attention, best effort, beautiful execution. Whether it is a prayer, a work assignment, or a meal prepared for your family, bring your best to it. Excellence in small things builds a character of excellence.'
    },
    33: {
        'explicationEn': 'The measure of a person\'s worth in Islam is not wealth, status, or lineage — it is service to others. The best Muslim is the one whose existence benefits those around them. This re-orients our definition of success from personal achievement to communal contribution.',
        'applicationQuotidienneEn': 'Ask yourself today: who did I benefit? Identify one concrete way you can be useful to someone — help with a task, share knowledge, offer emotional support, give charity. Make benefiting others a daily intention and measure of your day.'
    },
    34: {
        'explicationEn': 'Dhikr (remembrance of Allah) is the spiritual heartbeat. Without it, the heart is "dead" — functioning biologically but spiritually inert. Regular dhikr keeps the heart alive, connected to its Creator, and oriented toward meaning and purpose. The heart that remembers Allah is the heart that truly lives.',
        'applicationQuotidienneEn': 'Integrate dhikr into your daily routines: say "Bismillah" before each activity, "Alhamdulillah" after each blessing, "Subhanallah" when you witness beauty, "Astaghfirullah" when you err. Let your tongue be moist with the remembrance of Allah throughout the day.'
    },
    35: {
        'explicationEn': 'Two short phrases — requiring just seconds to say — carry immense weight on the scales of the Day of Judgment and are beloved to Allah. This shows that the value of an act is not measured by its length or complexity but by its sincerity and the names of Allah it glorifies.',
        'applicationQuotidienneEn': 'Add "Subhanallahi wabihamdih, Subhanallahi al-Adhim" to your daily dhikr. Say them 100 times in the morning, or whenever you have a free moment — commuting, waiting, resting. These few words, repeated consistently, build a mountain of good deeds.'
    },
    36: {
        'explicationEn': 'Qiyam al-Layl during Ramadan — the tarawih prayer — is one of the greatest acts of worship a Muslim can perform. The condition is sincere faith (iman) and seeking only Allah\'s reward (ihtisab), not social pressure or habit. When these conditions are met, past sins are erased.',
        'applicationQuotidienneEn': 'During Ramadan, commit to praying tarawih with full presence of heart. Before each prayer, renew your intention: "I pray this for Allah alone." Outside Ramadan, maintain a habit of night prayer — even two rak\'as of tahajjud keep the spiritual connection alive.'
    },
    37: {
        'explicationEn': 'La ilaha illallah is the foundation of faith — the declaration that no deity deserves worship except Allah. Alhamdulillah is the supreme expression of gratitude. Together, these two phrases encapsulate the essence of Islamic spirituality: tawḥid (divine oneness) and shukr (thankfulness).',
        'applicationQuotidienneEn': 'Make "La ilaha illallah" your most frequent phrase throughout the day. Begin and end your day with it. Pair it with "Alhamdulillah" as a constant gratitude practice. These are not mere words — they are the anchors of a faithful heart.'
    },
    38: {
        'explicationEn': 'Allah loves consistency above volume. A small deed done daily — even just two rak\'as of sunnah, or reading a few verses of Quran — is more beloved than a massive but irregular effort. This is profoundly encouraging: we do not need grand gestures, only faithful consistency.',
        'applicationQuotidienneEn': 'Choose one small act of worship to do consistently every day without exception: 10 minutes of Quran, 100 times of istighfar, two rak\'as of duha prayer. Start small, be consistent. After 40 days, that act will feel natural — and your relationship with Allah will deepen.'
    },
    39: {
        'explicationEn': 'The image of injustice as "layers of darkness" on the Day of Judgment is striking and terrifying. Every act of injustice — taking someone\'s rights, oppressing, exploiting — accumulates as darkness around the wrongdoer. Justice is not merely a social virtue but a spiritual imperative.',
        'applicationQuotidienneEn': 'Examine your life for any injustice you may have committed — financial, social, emotional. Have you taken someone\'s right? Restore it today. Apologize where you have wronged. Be an advocate for justice in your community. The just person walks in light.'
    },
    40: {
        'explicationEn': 'Brotherhood in Islam is not merely emotional — it carries concrete obligations. A Muslim cannot watch another Muslim suffer injustice or hardship without acting to help. "Abandoning" another Muslim — ignoring their need, cutting them off, refusing to support them — is a violation of Islamic brotherhood.',
        'applicationQuotidienneEn': 'Look around you — is there a Muslim in your circle who is struggling, lonely, or facing injustice? Reach out today. Offer concrete support — time, money, advocacy, or simply presence. Do not leave your brother or sister to face their difficulties alone.'
    },
    41: {
        'explicationEn': 'This brief hadith is one of the foundations of Islamic jurisprudence. It establishes two principles: the prohibition of initiating harm, and the prohibition of responding to harm with equal harm. Cycles of revenge and retaliation are broken by this divine principle. Harm must stop, not be returned.',
        'applicationQuotidienneEn': 'When someone harms you, resist the urge to retaliate in kind. Find a lawful, constructive way to address the harm — through dialogue, mediation, or simply forgiveness. Breaking cycles of harm takes strength, but it is the Islamic way and the path to peace.'
    },
    42: {
        'explicationEn': 'The metaphor of a shepherd is profound: a shepherd cannot abandon his flock. Every person in a position of responsibility — a leader, a parent, an employer, a teacher — will be asked about those in their care. Accountability is comprehensive and unavoidable on the Day of Judgment.',
        'applicationQuotidienneEn': 'Identify your "flock" — those for whom you are responsible. How are you fulfilling your duty to them today? A parent should check on their children\'s spiritual and emotional health. A leader should ensure their team is well-treated. A husband/wife should care for their spouse. Fulfill your trust.'
    },
    43: {
        'explicationEn': 'The Companions were puzzled: how do you help an oppressor? The Prophet ﷺ explained: by stopping him from oppressing. True brotherhood means caring for someone\'s eternal wellbeing, not just their immediate desires. Allowing someone to continue in wrong is not helping them — it is abandoning them to destruction.',
        'applicationQuotidienneEn': 'If you see someone you care about engaging in wrong — oppressing others, committing sins, harming themselves — speak truth with love. Do not look away to avoid conflict. Real love sometimes means a difficult conversation. Help your brother avoid the consequences of his wrongdoing.'
    },
    44: {
        'explicationEn': 'This hadith establishes three levels of responding to evil, each requiring less power than the previous. The first level (hand) is for those with authority. The second (tongue) is for those with voice and influence. The third (heart) is the minimum — rejecting evil internally — and is called "the weakest of faith." Remaining indifferent to evil is not an option in Islam.',
        'applicationQuotidienneEn': 'When you encounter something wrong today, ask yourself: what is my capacity to respond? Can I act? Speak? At minimum, reject it in your heart and make du\'a for change. Then look for one tangible action — however small — to work against the evil you have witnessed.'
    },
    45: {
        'explicationEn': 'This golden rule of Islam requires genuine empathy — not just avoiding harm to others, but actively wishing them the same good things you wish for yourself. Success, health, good children, guidance, paradise — everything you want for yourself should be wanted for your fellow believer. This transforms faith into love.',
        'applicationQuotidienneEn': 'When you feel envy or competition toward someone, stop and make du\'a for them: "O Allah, bless them with what they seek." Then wish for them what you wish for yourself. Practice this especially with those who receive what you want. Turn envy into a spiritual exercise of love.'
    },
    46: {
        'explicationEn': 'Divine mercy is not earned by ritual alone but by extending mercy to creation. Allah\'s rahmah (mercy) flows to those whose hearts are open to others. This hadith creates a direct link between our treatment of people and animals and the mercy we receive from Allah. Mercy is both given and received.',
        'applicationQuotidienneEn': 'Show active mercy today — to a person struggling, an animal in need, or someone who irritates you. Forgive someone. Feed a stray animal. Help someone in difficulty without expecting anything in return. Every act of mercy you show is an investment in the mercy Allah will show you.'
    },
    47: {
        'explicationEn': 'Allah rewards the relief of difficulty with divine relief on the most difficult day of all. This principle — that helping others in this world is repaid by Allah\'s help in the next — is one of the most motivating in all of Islam. No act of genuine help goes unrewarded by Allah.',
        'applicationQuotidienneEn': 'Look for someone in genuine difficulty today — financial, emotional, practical. Help relieve their burden, even partially. Give charity, offer your time, lend a skill, provide emotional support. You may not know how much your help means to them — or how much Allah will reward it.'
    },
    48: {
        'explicationEn': 'This hadith is both clarifying and sobering. Divine mercy is not unconditional in this sense — those who close their hearts to mercy toward others risk closing the door to mercy from Allah. Compassion is not optional; it is a prerequisite for receiving the highest divine gift.',
        'applicationQuotidienneEn': 'Cultivate compassion actively. When you are tempted to be harsh or indifferent, remember this hadith. The mercy you withhold from someone today could be the mercy withheld from you tomorrow. Practice mercy especially with those who have made mistakes or are weak.'
    },
    49: {
        'explicationEn': 'Islam broadens the concept of sadaqa (charity) to encompass any act of kindness, however small. A cheerful face, a kind word, a helping hand — nothing is too small to count before Allah. This generous vision of worship makes spirituality accessible to everyone, in every moment.',
        'applicationQuotidienneEn': 'Never underestimate a small act of kindness, regardless of its size. A smile, help carrying a bag, holding a door open — it all counts. Generosity is not only financial; it exists in every everyday gesture. Make it a daily intention to leave every interaction a little better than you found it.'
    },
    50: {
        'explicationEn': 'This architectural metaphor describes a brotherhood of solidarity and interdependence. As bricks in a wall support each other, Muslims must form a united community where each strengthens the other, rather than a collection of isolated individuals. Unity is strength; division is weakness.',
        'applicationQuotidienneEn': 'Reinforce those around you: an encouragement, moral support, practical help. Community solidarity begins with close relationships — family, neighbors, fellow believers. Ask yourself: who can I strengthen today? Be the brick that makes others stand stronger.'
    },
}

def add_translations():
    # Read the file
    with open('/sessions/relaxed-quirky-archimedes/mnt/deenly_app/lib/hadith_screen.dart', 'r', encoding='utf-8') as f:
        content = f.read()

    # Split into hadith blocks
    hadith_blocks = re.split(r'(  HadithModel\()', content)

    # Process only blocks 8-50 (skip first block and comments before hadith 1)
    # Note: blocks[0] is before first HadithModel, blocks[1] is 'HadithModel(', blocks[2] is first hadith content, etc.
    result_blocks = [hadith_blocks[0], hadith_blocks[1]]  # Keep the preamble and first 'HadithModel('

    hadith_num = 1
    for i in range(2, len(hadith_blocks), 2):
        if i + 1 < len(hadith_blocks):
            block = hadith_blocks[i]

            if hadith_num >= 8 and hadith_num <= 50 and hadith_num in translations:
                trans = translations[hadith_num]
                expl_en = trans['explicationEn']
                app_en = trans['applicationQuotidienneEn']

                # Add explicationEn after explication
                block = re.sub(
                    r"(    explication: '(?:[^'\\]|\\.)*',)\n(?!    explicationEn:)",
                    r"\1\n    explicationEn: '" + expl_en + "',\n",
                    block
                )

                # Add applicationQuotidienneEn after applicationQuotidienne
                block = re.sub(
                    r"(    applicationQuotidienne: '(?:[^'\\]|\\.)*',)\n(?!    applicationQuotidienneEn:)",
                    r"\1\n    applicationQuotidienneEn: '" + app_en + "',\n",
                    block
                )

            result_blocks.append(block)
            if i + 1 < len(hadith_blocks):
                result_blocks.append(hadith_blocks[i + 1])

            hadith_num += 1

    result = ''.join(result_blocks)

    # Write back to file
    with open('/sessions/relaxed-quirky-archimedes/mnt/deenly_app/lib/hadith_screen.dart', 'w', encoding='utf-8') as f:
        f.write(result)

    # Verify
    with open('/sessions/relaxed-quirky-archimedes/mnt/deenly_app/lib/hadith_screen.dart', 'r', encoding='utf-8') as f:
        final_content = f.read()

    expl_count = final_content.count('explicationEn:')
    app_count = final_content.count('applicationQuotidienneEn:')

    print(f"Verification:")
    print(f"Total explicationEn: {expl_count} (expected: 50)")
    print(f"Total applicationQuotidienneEn: {app_count} (expected: 50)")

if __name__ == '__main__':
    add_translations()
