import { useState, useEffect } from "react";

// ─── Palette Nour ───────────────────────────────────────────────
const C = {
  gold: "#D4A843",
  goldLight: "#F0C96B",
  goldDark: "#A07830",
  bg: "#0D1117",
  card: "#161B22",
  cardLight: "#1E2630",
  border: "#2A3240",
  green: "#2ECC71",
  greenDark: "#27AE60",
  red: "#E74C3C",
  blue: "#3498DB",
  purple: "#9B59B6",
  text: "#E8EDF4",
  textMuted: "#8899AA",
  textDim: "#556070",
  white: "#FFFFFF",
};

// ─── Data ────────────────────────────────────────────────────────
const LESSONS = [
  {
    id: 1, title: "Al-Fatiha", subtitle: "L'Ouverture", icon: "🌟", xp: 20,
    locked: false, completed: true, type: "surah",
    versets: [
      { ar: "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ", ph: "Bismi llāhi r-raḥmāni r-raḥīm", fr: "Au nom d'Allah, le Très Miséricordieux, le Tout Miséricordieux" },
      { ar: "الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ", ph: "Al-ḥamdu lillāhi rabbi l-ʿālamīn", fr: "Louange à Allah, Seigneur des mondes" },
      { ar: "الرَّحْمَٰنِ الرَّحِيمِ", ph: "Ar-raḥmāni r-raḥīm", fr: "Le Très Miséricordieux, le Tout Miséricordieux" },
    ]
  },
  {
    id: 2, title: "Al-Ikhlas", subtitle: "La Pureté", icon: "💎", xp: 15,
    locked: false, completed: true, type: "surah",
    versets: [
      { ar: "قُلْ هُوَ اللَّهُ أَحَدٌ", ph: "Qul huwa llāhu aḥad", fr: "Dis : Il est Allah, Unique" },
      { ar: "اللَّهُ الصَّمَدُ", ph: "Allāhu ṣ-ṣamad", fr: "Allah, l'Impénétrable" },
    ]
  },
  {
    id: 3, title: "Al-Falaq", subtitle: "L'Aube", icon: "🌅", xp: 15,
    locked: false, completed: false, type: "surah",
    versets: [
      { ar: "قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ", ph: "Qul aʿūdhu bi-rabbi l-falaq", fr: "Dis : Je cherche refuge auprès du Seigneur de l'aube" },
    ]
  },
  {
    id: 4, title: "An-Nas", subtitle: "Les Hommes", icon: "👥", xp: 15,
    locked: true, completed: false, type: "surah", versets: []
  },
  {
    id: 5, title: "Al-Kawthar", subtitle: "L'Abondance", icon: "🌊", xp: 20,
    locked: true, completed: false, type: "surah", versets: []
  },
  {
    id: 6, title: "Al-Masad", subtitle: "La Fibre", icon: "🔥", xp: 20,
    locked: true, completed: false, type: "surah", versets: []
  },
];

const EXERCISES = [
  {
    type: "listen_choose",
    question: "Quel est le sens de ce verset ?",
    arabic: "الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ",
    phonetic: "Al-ḥamdu lillāhi rabbi l-ʿālamīn",
    correct: "Louange à Allah, Seigneur des mondes",
    options: [
      "Louange à Allah, Seigneur des mondes",
      "Au nom d'Allah le Miséricordieux",
      "C'est Toi que nous adorons",
      "Guide-nous sur la voie droite",
    ]
  },
  {
    type: "arrange",
    question: "Arrange les mots dans le bon ordre :",
    arabic: "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ",
    phonetic: "Bismi llāhi r-raḥmāni r-raḥīm",
    words: ["Allah", "Au nom de", "le Tout Miséricordieux", "le Très Miséricordieux"],
    correct: ["Au nom de", "Allah", "le Très Miséricordieux", "le Tout Miséricordieux"],
  },
  {
    type: "fill_blank",
    question: "Complète le verset :",
    before: "الرَّحْمَٰنِ",
    after: "الرَّحِيمِ",
    blank: "___",
    correct: "الرَّحْمَٰنِ الرَّحِيمِ",
    options: ["الرَّحْمَٰنِ الرَّحِيمِ", "رَبِّ الْعَالَمِينَ", "اللَّهُ أَحَدٌ", "الْفَاتِحَةِ"],
    display: "Le Très Miséricordieux, ___",
    answer: "le Tout Miséricordieux",
    displayOptions: ["le Tout Miséricordieux", "Seigneur des mondes", "le Seul", "l'Aube"],
  },
  {
    type: "listen_choose",
    question: "Traduis ce verset :",
    arabic: "إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ",
    phonetic: "Iyyāka naʿbudu wa iyyāka nastaʿīn",
    correct: "C'est Toi que nous adorons et c'est Toi dont nous implorons le secours",
    options: [
      "C'est Toi que nous adorons et c'est Toi dont nous implorons le secours",
      "Guide-nous sur le droit chemin",
      "Le chemin de ceux que Tu as comblés de bienfaits",
      "Pas celui des égarés",
    ]
  },
];

// ─── Icons ───────────────────────────────────────────────────────
const Icon = ({ name, size = 20, color = C.text }) => {
  const icons = {
    home: "🏠", learn: "📖", progress: "📊", profile: "👤",
    star: "⭐", fire: "🔥", lock: "🔒", check: "✅", close: "❌",
    arrow: "→", back: "←", play: "▶", heart: "❤️", zap: "⚡",
    trophy: "🏆", gem: "💎", target: "🎯", book: "📚",
    speaker: "🔊", shuffle: "🔀", skip: "⏭️",
  };
  return <span style={{ fontSize: size }}>{icons[name] || "•"}</span>;
};

// ─── Components ──────────────────────────────────────────────────
const ProgressBar = ({ value, max, color = C.gold, height = 8 }) => (
  <div style={{ background: C.border, borderRadius: 99, height, overflow: "hidden" }}>
    <div style={{
      width: `${Math.min(100, (value / max) * 100)}%`, height: "100%",
      background: `linear-gradient(90deg, ${color}, ${color}CC)`,
      borderRadius: 99, transition: "width 0.4s ease",
    }} />
  </div>
);

const HeartBar = ({ hearts }) => (
  <div style={{ display: "flex", gap: 4 }}>
    {[...Array(5)].map((_, i) => (
      <span key={i} style={{ fontSize: 18, opacity: i < hearts ? 1 : 0.25 }}>❤️</span>
    ))}
  </div>
);

const XPBadge = ({ xp }) => (
  <div style={{
    background: `${C.gold}22`, border: `1px solid ${C.gold}44`,
    borderRadius: 20, padding: "3px 10px", display: "flex", alignItems: "center", gap: 4,
    color: C.gold, fontSize: 13, fontWeight: 700,
  }}>
    ⚡ {xp} XP
  </div>
);

const StreakBadge = ({ streak }) => (
  <div style={{
    background: "#FF6B0022", border: "1px solid #FF6B0044",
    borderRadius: 20, padding: "3px 10px", display: "flex", alignItems: "center", gap: 4,
    color: "#FF6B00", fontSize: 13, fontWeight: 700,
  }}>
    🔥 {streak} jours
  </div>
);

const Btn = ({ children, onClick, style = {}, variant = "gold", disabled = false }) => {
  const variants = {
    gold: { background: `linear-gradient(135deg, ${C.gold}, ${C.goldDark})`, color: "#000", fontWeight: 800 },
    outline: { background: "transparent", border: `2px solid ${C.gold}`, color: C.gold, fontWeight: 700 },
    green: { background: `linear-gradient(135deg, ${C.green}, ${C.greenDark})`, color: "#fff", fontWeight: 800 },
    red: { background: `linear-gradient(135deg, ${C.red}, #C0392B)`, color: "#fff", fontWeight: 800 },
    ghost: { background: C.cardLight, color: C.text, fontWeight: 600 },
  };
  return (
    <button onClick={onClick} disabled={disabled} style={{
      padding: "14px 24px", borderRadius: 14, border: "none", cursor: disabled ? "not-allowed" : "pointer",
      fontSize: 15, transition: "all 0.15s", opacity: disabled ? 0.5 : 1,
      ...variants[variant], ...style,
    }}>{children}</button>
  );
};

// ─── Screens ─────────────────────────────────────────────────────

// HOME SCREEN
const HomeScreen = ({ onNavigate, stats }) => (
  <div style={{ padding: "20px 16px", overflowY: "auto", height: "100%" }}>
    {/* Header */}
    <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: 24 }}>
      <div>
        <div style={{ color: C.textMuted, fontSize: 13, marginBottom: 2 }}>بسم الله</div>
        <div style={{ color: C.text, fontSize: 20, fontWeight: 800 }}>Salam, Sam 👋</div>
      </div>
      <div style={{ display: "flex", gap: 8 }}>
        <StreakBadge streak={stats.streak} />
        <XPBadge xp={stats.xp} />
      </div>
    </div>

    {/* Daily Goal Card */}
    <div style={{
      background: `linear-gradient(135deg, ${C.gold}18, ${C.goldDark}08)`,
      border: `1px solid ${C.gold}33`, borderRadius: 18, padding: 20, marginBottom: 16,
    }}>
      <div style={{ display: "flex", justifyContent: "space-between", alignItems: "flex-start", marginBottom: 12 }}>
        <div>
          <div style={{ color: C.gold, fontWeight: 700, fontSize: 13, marginBottom: 4 }}>OBJECTIF DU JOUR</div>
          <div style={{ color: C.text, fontSize: 16, fontWeight: 700 }}>3 leçons • 60 XP</div>
        </div>
        <div style={{ fontSize: 36 }}>🎯</div>
      </div>
      <ProgressBar value={stats.dailyXP} max={60} />
      <div style={{ color: C.textMuted, fontSize: 12, marginTop: 6 }}>{stats.dailyXP}/60 XP aujourd'hui</div>
    </div>

    {/* Continue Learning */}
    <div style={{
      background: C.card, border: `1px solid ${C.border}`, borderRadius: 18, padding: 20, marginBottom: 16,
      cursor: "pointer",
    }} onClick={() => onNavigate("path")}>
      <div style={{ color: C.textMuted, fontSize: 12, fontWeight: 600, marginBottom: 8 }}>CONTINUER</div>
      <div style={{ display: "flex", alignItems: "center", gap: 12, marginBottom: 12 }}>
        <div style={{ fontSize: 36 }}>🌅</div>
        <div>
          <div style={{ color: C.text, fontWeight: 800, fontSize: 16 }}>Al-Falaq</div>
          <div style={{ color: C.textMuted, fontSize: 13 }}>Leçon 3 • L'Aube</div>
        </div>
        <div style={{ marginLeft: "auto" }}>
          <Btn onClick={() => onNavigate("lesson")} style={{ padding: "10px 20px", fontSize: 14 }}>▶ Commencer</Btn>
        </div>
      </div>
      <ProgressBar value={2} max={5} color={C.green} />
      <div style={{ color: C.textMuted, fontSize: 12, marginTop: 6 }}>2/5 versets maîtrisés</div>
    </div>

    {/* Stats Row */}
    <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr 1fr", gap: 12, marginBottom: 16 }}>
      {[
        { icon: "📖", label: "Sourates", value: `${stats.surahs}/114` },
        { icon: "⚡", label: "XP Total", value: stats.xp },
        { icon: "🏆", label: "Niveau", value: stats.level },
      ].map((s) => (
        <div key={s.label} style={{
          background: C.card, border: `1px solid ${C.border}`, borderRadius: 14,
          padding: "14px 10px", textAlign: "center",
        }}>
          <div style={{ fontSize: 24, marginBottom: 4 }}>{s.icon}</div>
          <div style={{ color: C.text, fontWeight: 800, fontSize: 18 }}>{s.value}</div>
          <div style={{ color: C.textMuted, fontSize: 11 }}>{s.label}</div>
        </div>
      ))}
    </div>

    {/* Recent achievements */}
    <div style={{ background: C.card, border: `1px solid ${C.border}`, borderRadius: 18, padding: 16 }}>
      <div style={{ color: C.text, fontWeight: 700, fontSize: 14, marginBottom: 12 }}>🏅 Badges récents</div>
      <div style={{ display: "flex", gap: 12 }}>
        {[
          { icon: "🔥", label: "7 jours" }, { icon: "⭐", label: "Parfait" }, { icon: "📖", label: "3 Sourates" }
        ].map(b => (
          <div key={b.label} style={{
            background: C.cardLight, borderRadius: 12, padding: "10px 14px", textAlign: "center", flex: 1,
          }}>
            <div style={{ fontSize: 24 }}>{b.icon}</div>
            <div style={{ color: C.textMuted, fontSize: 11, marginTop: 4 }}>{b.label}</div>
          </div>
        ))}
      </div>
    </div>
  </div>
);

// LEARNING PATH SCREEN
const PathScreen = ({ onNavigate }) => {
  const [selected, setSelected] = useState(null);

  return (
    <div style={{ padding: "20px 16px", overflowY: "auto", height: "100%" }}>
      <div style={{ color: C.text, fontSize: 22, fontWeight: 800, marginBottom: 4 }}>📚 Parcours</div>
      <div style={{ color: C.textMuted, fontSize: 14, marginBottom: 20 }}>Juz 30 — Les Courtes Sourates</div>

      {/* XP bar */}
      <div style={{ background: C.card, borderRadius: 14, padding: "12px 16px", marginBottom: 24 }}>
        <div style={{ display: "flex", justifyContent: "space-between", marginBottom: 8 }}>
          <span style={{ color: C.textMuted, fontSize: 12 }}>Niveau 3 · Récitant</span>
          <span style={{ color: C.gold, fontSize: 12, fontWeight: 700 }}>420/500 XP</span>
        </div>
        <ProgressBar value={420} max={500} />
      </div>

      {/* Lessons path */}
      <div style={{ display: "flex", flexDirection: "column", alignItems: "center", gap: 0 }}>
        {LESSONS.map((lesson, idx) => {
          const isLeft = idx % 2 === 0;
          return (
            <div key={lesson.id} style={{ display: "flex", flexDirection: "column", alignItems: "center", width: "100%" }}>
              <div style={{ display: "flex", justifyContent: isLeft ? "flex-start" : "flex-end", width: "100%", paddingLeft: isLeft ? 30 : 0, paddingRight: isLeft ? 0 : 30 }}>
                <div
                  onClick={() => !lesson.locked && setSelected(lesson.id === selected ? null : lesson.id)}
                  style={{
                    width: 72, height: 72, borderRadius: "50%", display: "flex", alignItems: "center",
                    justifyContent: "center", fontSize: 28, cursor: lesson.locked ? "not-allowed" : "pointer",
                    background: lesson.completed
                      ? `linear-gradient(135deg, ${C.gold}, ${C.goldDark})`
                      : lesson.locked
                        ? C.cardLight
                        : `linear-gradient(135deg, #2A3A4A, #1A2530)`,
                    border: lesson.id === 3 && !lesson.locked
                      ? `4px solid ${C.gold}`
                      : lesson.completed ? `3px solid ${C.goldDark}` : `3px solid ${C.border}`,
                    boxShadow: lesson.id === 3 ? `0 0 20px ${C.gold}44` : "none",
                    position: "relative", transition: "transform 0.15s",
                    transform: selected === lesson.id ? "scale(1.08)" : "scale(1)",
                  }}>
                  {lesson.locked ? "🔒" : lesson.completed ? "✅" : lesson.icon}
                  {lesson.id === 3 && (
                    <div style={{
                      position: "absolute", top: -8, left: "50%", transform: "translateX(-50%)",
                      background: C.gold, color: "#000", fontSize: 9, fontWeight: 800,
                      padding: "2px 7px", borderRadius: 99, whiteSpace: "nowrap",
                    }}>EN COURS</div>
                  )}
                </div>
              </div>

              {/* Lesson detail popup */}
              {selected === lesson.id && (
                <div style={{
                  background: C.card, border: `1px solid ${C.gold}44`, borderRadius: 16,
                  padding: "14px 16px", margin: "10px 0", width: "88%",
                  animation: "fadeIn 0.2s",
                }}>
                  <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: 8 }}>
                    <div>
                      <div style={{ color: C.text, fontWeight: 800 }}>{lesson.icon} {lesson.title}</div>
                      <div style={{ color: C.textMuted, fontSize: 12 }}>{lesson.subtitle}</div>
                    </div>
                    <XPBadge xp={lesson.xp} />
                  </div>
                  <Btn onClick={() => onNavigate("lesson")} style={{ width: "100%", textAlign: "center" }}>
                    ▶ Commencer la leçon
                  </Btn>
                </div>
              )}

              {/* Connector line */}
              {idx < LESSONS.length - 1 && (
                <div style={{
                  width: 3, height: 32, background: LESSONS[idx + 1].locked ? C.border : C.gold + "44",
                  marginLeft: isLeft ? "30%" : "-30%",
                }} />
              )}
            </div>
          );
        })}
      </div>
    </div>
  );
};

// LESSON SCREEN
const LessonScreen = ({ onNavigate }) => {
  const [step, setStep] = useState(0);
  const [selected, setSelected] = useState(null);
  const [answered, setAnswered] = useState(false);
  const [hearts, setHearts] = useState(5);
  const [score, setScore] = useState(0);
  const [showResult, setShowResult] = useState(false);
  const [wordOrder, setWordOrder] = useState([]);

  const exercise = EXERCISES[step];
  const total = EXERCISES.length;

  useEffect(() => {
    setSelected(null);
    setAnswered(false);
    if (exercise?.type === "arrange") {
      setWordOrder([...exercise.words].sort(() => Math.random() - 0.5));
    }
  }, [step]);

  const handleAnswer = (option) => {
    if (answered) return;
    setSelected(option);
    setAnswered(true);
    const isCorrect = option === exercise.correct;
    if (isCorrect) setScore(s => s + 1);
    else setHearts(h => Math.max(0, h - 1));
  };

  const next = () => {
    if (step + 1 >= total) setShowResult(true);
    else setStep(s => s + 1);
  };

  if (showResult) return (
    <div style={{ padding: "40px 24px", display: "flex", flexDirection: "column", alignItems: "center", textAlign: "center", height: "100%", justifyContent: "center" }}>
      <div style={{ fontSize: 72, marginBottom: 16 }}>{score >= 3 ? "🏆" : "📖"}</div>
      <div style={{ color: C.gold, fontSize: 26, fontWeight: 800, marginBottom: 8 }}>
        {score >= 3 ? "Excellent !" : "Continuez !"}
      </div>
      <div style={{ color: C.textMuted, fontSize: 15, marginBottom: 30 }}>
        {score}/{total} bonnes réponses
      </div>
      <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr", gap: 16, width: "100%", marginBottom: 24 }}>
        {[
          { icon: "⚡", label: "XP gagnés", value: `+${score * 5} XP` },
          { icon: "🎯", label: "Précision", value: `${Math.round(score / total * 100)}%` },
          { icon: "⏱️", label: "Temps", value: "1m 42s" },
          { icon: "❤️", label: "Vies restantes", value: `${hearts}/5` },
        ].map(s => (
          <div key={s.label} style={{ background: C.card, borderRadius: 14, padding: "14px 10px", textAlign: "center" }}>
            <div style={{ fontSize: 24 }}>{s.icon}</div>
            <div style={{ color: C.text, fontWeight: 800, fontSize: 18 }}>{s.value}</div>
            <div style={{ color: C.textMuted, fontSize: 11 }}>{s.label}</div>
          </div>
        ))}
      </div>
      <Btn onClick={() => onNavigate("path")} style={{ width: "100%" }}>Retour au parcours</Btn>
      <Btn onClick={() => { setStep(0); setScore(0); setHearts(5); setShowResult(false); }} variant="ghost" style={{ width: "100%", marginTop: 10 }}>Recommencer</Btn>
    </div>
  );

  const isCorrect = selected === exercise.correct;

  return (
    <div style={{ display: "flex", flexDirection: "column", height: "100%" }}>
      {/* Header */}
      <div style={{ padding: "16px 16px 10px", borderBottom: `1px solid ${C.border}` }}>
        <div style={{ display: "flex", alignItems: "center", gap: 12, marginBottom: 12 }}>
          <button onClick={() => onNavigate("path")} style={{ background: "none", border: "none", color: C.textMuted, fontSize: 20, cursor: "pointer" }}>✕</button>
          <div style={{ flex: 1 }}>
            <ProgressBar value={step} max={total} color={C.green} />
          </div>
          <HeartBar hearts={hearts} />
        </div>
        <div style={{ color: C.textMuted, fontSize: 12, textAlign: "center" }}>
          Question {step + 1}/{total}
        </div>
      </div>

      {/* Exercise */}
      <div style={{ flex: 1, padding: "20px 16px", overflowY: "auto" }}>
        {/* Type indicator */}
        <div style={{ color: C.gold, fontSize: 12, fontWeight: 700, marginBottom: 8, textTransform: "uppercase" }}>
          {exercise.type === "listen_choose" ? "🎵 Traduction" : exercise.type === "arrange" ? "🔀 Arrange" : "✏️ Complète"}
        </div>
        <div style={{ color: C.text, fontSize: 18, fontWeight: 700, marginBottom: 20 }}>{exercise.question}</div>

        {/* Arabic Card */}
        <div style={{
          background: `linear-gradient(135deg, ${C.gold}15, ${C.goldDark}08)`,
          border: `1px solid ${C.gold}33`, borderRadius: 18, padding: "24px 20px",
          textAlign: "center", marginBottom: 24,
        }}>
          <div style={{
            color: C.text, fontSize: 28, fontWeight: 700, lineHeight: 1.8,
            fontFamily: "serif", direction: "rtl", marginBottom: 10,
          }}>{exercise.arabic}</div>
          <div style={{ color: C.textMuted, fontSize: 13, fontStyle: "italic" }}>{exercise.phonetic}</div>
          <button style={{
            marginTop: 12, background: `${C.gold}22`, border: `1px solid ${C.gold}44`,
            borderRadius: 99, padding: "6px 16px", color: C.gold, fontSize: 12, cursor: "pointer",
          }}>🔊 Écouter</button>
        </div>

        {/* Options */}
        {exercise.type === "fill_blank" ? (
          <div>
            <div style={{ color: C.text, fontSize: 16, textAlign: "center", marginBottom: 16, padding: "12px", background: C.cardLight, borderRadius: 12 }}>
              {exercise.display}
            </div>
            <div style={{ display: "flex", flexDirection: "column", gap: 10 }}>
              {exercise.displayOptions.map((opt) => (
                <OptionButton key={opt} opt={opt} selected={selected} correct={exercise.answer} answered={answered} onSelect={() => handleAnswer(opt === exercise.answer ? exercise.correct : opt)} />
              ))}
            </div>
          </div>
        ) : (
          <div style={{ display: "flex", flexDirection: "column", gap: 10 }}>
            {exercise.options.map((opt) => (
              <OptionButton key={opt} opt={opt} selected={selected} correct={exercise.correct} answered={answered} onSelect={() => handleAnswer(opt)} />
            ))}
          </div>
        )}
      </div>

      {/* Bottom feedback */}
      {answered && (
        <div style={{
          padding: "16px", borderTop: `1px solid ${C.border}`,
          background: isCorrect ? `${C.green}18` : `${C.red}18`,
        }}>
          <div style={{ display: "flex", alignItems: "center", gap: 10, marginBottom: 10 }}>
            <span style={{ fontSize: 24 }}>{isCorrect ? "✅" : "❌"}</span>
            <div>
              <div style={{ color: isCorrect ? C.green : C.red, fontWeight: 800, fontSize: 15 }}>
                {isCorrect ? "Excellent !" : "Pas tout à fait..."}
              </div>
              {!isCorrect && <div style={{ color: C.textMuted, fontSize: 13 }}>Réponse : {exercise.correct}</div>}
            </div>
          </div>
          <Btn onClick={next} variant={isCorrect ? "green" : "red"} style={{ width: "100%" }}>
            {step + 1 >= total ? "Voir les résultats" : "Continuer →"}
          </Btn>
        </div>
      )}
    </div>
  );
};

const OptionButton = ({ opt, selected, correct, answered, onSelect }) => {
  const isSelected = selected === opt;
  const isCorrect = opt === correct;
  const bg = !answered ? (isSelected ? `${C.gold}22` : C.cardLight)
    : isCorrect ? `${C.green}22` : isSelected ? `${C.red}22` : C.cardLight;
  const border = !answered ? (isSelected ? C.gold : C.border)
    : isCorrect ? C.green : isSelected ? C.red : C.border;

  return (
    <button onClick={onSelect} disabled={answered} style={{
      background: bg, border: `2px solid ${border}`, borderRadius: 14,
      padding: "14px 16px", color: C.text, fontSize: 14, textAlign: "left",
      cursor: answered ? "default" : "pointer", transition: "all 0.15s", fontWeight: 600,
      display: "flex", alignItems: "center", gap: 10,
    }}>
      <span style={{ fontSize: 18 }}>
        {answered && isCorrect ? "✅" : answered && isSelected && !isCorrect ? "❌" : "○"}
      </span>
      {opt}
    </button>
  );
};

// PROGRESS SCREEN
const ProgressScreen = () => {
  const days = ["L", "M", "M", "J", "V", "S", "D"];
  const activity = [1, 1, 0, 1, 1, 0, 1];

  return (
    <div style={{ padding: "20px 16px", overflowY: "auto", height: "100%" }}>
      <div style={{ color: C.text, fontSize: 22, fontWeight: 800, marginBottom: 20 }}>📊 Progression</div>

      {/* Level card */}
      <div style={{
        background: `linear-gradient(135deg, ${C.gold}22, ${C.goldDark}11)`,
        border: `1px solid ${C.gold}44`, borderRadius: 20, padding: 20, marginBottom: 16, textAlign: "center",
      }}>
        <div style={{ fontSize: 48, marginBottom: 8 }}>🏆</div>
        <div style={{ color: C.gold, fontSize: 20, fontWeight: 800 }}>Niveau 3 — Récitant</div>
        <div style={{ color: C.textMuted, fontSize: 13, marginBottom: 12 }}>420 / 500 XP pour le niveau 4</div>
        <ProgressBar value={420} max={500} height={10} />
      </div>

      {/* Weekly activity */}
      <div style={{ background: C.card, border: `1px solid ${C.border}`, borderRadius: 18, padding: 16, marginBottom: 16 }}>
        <div style={{ color: C.text, fontWeight: 700, marginBottom: 14 }}>📅 Activité cette semaine</div>
        <div style={{ display: "flex", justifyContent: "space-between" }}>
          {days.map((d, i) => (
            <div key={d} style={{ display: "flex", flexDirection: "column", alignItems: "center", gap: 6 }}>
              <div style={{
                width: 36, height: 36, borderRadius: 10,
                background: activity[i] ? `linear-gradient(135deg, ${C.gold}, ${C.goldDark})` : C.cardLight,
                display: "flex", alignItems: "center", justifyContent: "center", fontSize: 16,
              }}>{activity[i] ? "🔥" : ""}</div>
              <div style={{ color: C.textMuted, fontSize: 11 }}>{d}</div>
            </div>
          ))}
        </div>
      </div>

      {/* Stats */}
      <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr", gap: 12, marginBottom: 16 }}>
        {[
          { icon: "⚡", label: "XP Total", value: "1 240", color: C.gold },
          { icon: "🔥", label: "Streak", value: "7 jours", color: "#FF6B00" },
          { icon: "📖", label: "Sourates", value: "3/114", color: C.green },
          { icon: "✅", label: "Exercices", value: "48", color: C.blue },
          { icon: "⏱️", label: "Temps total", value: "2h 14m", color: C.purple },
          { icon: "🎯", label: "Précision", value: "87%", color: C.green },
        ].map(s => (
          <div key={s.label} style={{ background: C.card, border: `1px solid ${C.border}`, borderRadius: 14, padding: "14px 12px" }}>
            <div style={{ fontSize: 22, marginBottom: 4 }}>{s.icon}</div>
            <div style={{ color: s.color, fontWeight: 800, fontSize: 20 }}>{s.value}</div>
            <div style={{ color: C.textMuted, fontSize: 11 }}>{s.label}</div>
          </div>
        ))}
      </div>

      {/* Surahs mastered */}
      <div style={{ background: C.card, border: `1px solid ${C.border}`, borderRadius: 18, padding: 16 }}>
        <div style={{ color: C.text, fontWeight: 700, marginBottom: 12 }}>📚 Sourates maîtrisées</div>
        {[
          { name: "Al-Fatiha", progress: 100, icon: "🌟" },
          { name: "Al-Ikhlas", progress: 100, icon: "💎" },
          { name: "Al-Falaq", progress: 60, icon: "🌅" },
        ].map(s => (
          <div key={s.name} style={{ marginBottom: 12 }}>
            <div style={{ display: "flex", justifyContent: "space-between", marginBottom: 6 }}>
              <span style={{ color: C.text, fontSize: 13, fontWeight: 600 }}>{s.icon} {s.name}</span>
              <span style={{ color: s.progress === 100 ? C.gold : C.textMuted, fontSize: 12, fontWeight: 700 }}>
                {s.progress === 100 ? "✅ Maîtrisée" : `${s.progress}%`}
              </span>
            </div>
            <ProgressBar value={s.progress} max={100} color={s.progress === 100 ? C.gold : C.green} height={6} />
          </div>
        ))}
      </div>
    </div>
  );
};

// ─── Navigation ──────────────────────────────────────────────────
const NavBar = ({ active, onNavigate }) => {
  const tabs = [
    { id: "home", icon: "🏠", label: "Accueil" },
    { id: "path", icon: "📚", label: "Parcours" },
    { id: "progress", icon: "📊", label: "Progrès" },
    { id: "profile", icon: "👤", label: "Profil" },
  ];
  return (
    <div style={{
      display: "flex", borderTop: `1px solid ${C.border}`,
      background: C.card, padding: "6px 0 2px",
    }}>
      {tabs.map(t => (
        <button key={t.id} onClick={() => onNavigate(t.id)} style={{
          flex: 1, background: "none", border: "none", cursor: "pointer",
          display: "flex", flexDirection: "column", alignItems: "center", padding: "6px 0",
        }}>
          <span style={{ fontSize: 22 }}>{t.icon}</span>
          <span style={{ fontSize: 10, color: active === t.id ? C.gold : C.textDim, fontWeight: active === t.id ? 700 : 400, marginTop: 2 }}>{t.label}</span>
          {active === t.id && <div style={{ width: 4, height: 4, borderRadius: "50%", background: C.gold, marginTop: 2 }} />}
        </button>
      ))}
    </div>
  );
};

// ─── App ─────────────────────────────────────────────────────────
export default function App() {
  const [screen, setScreen] = useState("home");
  const [stats] = useState({ streak: 7, xp: 1240, dailyXP: 40, surahs: 3, level: 3 });

  const navigate = (s) => setScreen(s);

  const renderScreen = () => {
    switch (screen) {
      case "home": return <HomeScreen onNavigate={navigate} stats={stats} />;
      case "path": return <PathScreen onNavigate={navigate} />;
      case "lesson": return <LessonScreen onNavigate={navigate} />;
      case "progress": return <ProgressScreen />;
      case "profile": return (
        <div style={{ padding: 24, textAlign: "center", color: C.textMuted }}>
          <div style={{ fontSize: 60 }}>👤</div>
          <div style={{ color: C.text, fontSize: 18, fontWeight: 700, marginTop: 12 }}>Sam</div>
          <div>skhouaja2@gmail.com</div>
        </div>
      );
      default: return null;
    }
  };

  return (
    <div style={{ background: C.bg, minHeight: "100vh", display: "flex", justifyContent: "center", alignItems: "center", fontFamily: "-apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif" }}>
      <style>{`* { box-sizing: border-box; margin: 0; padding: 0; } @keyframes fadeIn { from { opacity: 0; transform: translateY(8px); } to { opacity: 1; transform: translateY(0); } }`}</style>

      {/* Phone frame */}
      <div style={{
        width: 390, height: 844, background: C.bg,
        border: `2px solid ${C.border}`, borderRadius: 44,
        display: "flex", flexDirection: "column", overflow: "hidden",
        boxShadow: `0 40px 80px #000A, 0 0 0 1px ${C.border}`,
      }}>
        {/* Status bar */}
        <div style={{
          background: C.card, padding: "12px 24px 8px",
          display: "flex", justifyContent: "space-between",
          borderBottom: `1px solid ${C.border}`,
        }}>
          <span style={{ color: C.text, fontSize: 13, fontWeight: 700 }}>9:41</span>
          <div style={{ width: 80, height: 20, background: "#000", borderRadius: 99, border: `1px solid ${C.border}` }} />
          <span style={{ color: C.text, fontSize: 13 }}>📶 🔋</span>
        </div>

        {/* Screen content */}
        <div style={{ flex: 1, overflow: "hidden", display: "flex", flexDirection: "column" }}>
          {renderScreen()}
        </div>

        {/* Nav bar (hide during lesson) */}
        {screen !== "lesson" && <NavBar active={screen} onNavigate={navigate} />}
      </div>

      {/* Labels beside phone */}
      <div style={{ marginLeft: 32, color: C.textMuted, maxWidth: 200 }}>
        <div style={{ color: C.gold, fontWeight: 800, fontSize: 18, marginBottom: 8 }}>نور Nour</div>
        <div style={{ fontSize: 13, marginBottom: 16, color: C.text }}>Module Apprentissage</div>
        <div style={{ fontSize: 12, lineHeight: 1.8 }}>
          {["🏠 Accueil", "📚 Parcours Duolingo", "📖 Leçon interactive", "📊 Progression"].map(s => (
            <div key={s}>{s}</div>
          ))}
        </div>
        <div style={{ marginTop: 20, fontSize: 11, color: C.textDim }}>
          Navigue entre les écrans via la barre en bas
        </div>
      </div>
    </div>
  );
}
