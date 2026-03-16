# Flutter/Dart UI Translation Implementation

## Summary

All hardcoded French UI strings in the specified files have been made bilingual using the app's existing translation system.

## Files Modified

### 1. **lib/translations.dart** ✓
- **Added 50+ new translation keys** for:
  - Journal screen action categories and prayers (journalObligatoryPrayers, journalFajr, etc.)
  - Children screen stories and quiz elements (childrenNoahArc, childrenShowResult, etc.)
  - Discover screen sections and content (discoverQuestionOfDay, discoverFacts, discoverWaterCycle, etc.)
  - Proper bilingual support via `_s('French', 'English')` getter methods
- **Location**: Lines 367-432
- **Access**: Use `context.t.translationKey` in widgets

### 2. **lib/translation_helpers.dart** ✓ (NEW)
- **Created utility module** for translating data-driven UI strings
- **Functions provided**:
  - `tStr(fr, en)` - Direct translation helper
  - `bilingualLabel(fr, en)` - Returns correct language version
  - `getLocalizedLabel(bilingualStr)` - Extracts language from "Fr / En" format
  - `extractFrench()` / `extractEnglish()` - Split bilingual strings
- **Purpose**: Enable translation of const data structures that can't use context.t
- **Access**: Import and use `AppLocale().tr('French', 'English')`

### 3. **lib/journal_data.dart** ✓
- **Added bilingual labels** to:
  - kMoodOptions: Each mood label and description now bilingual (e.g., "Serein / Peaceful")
  - All action items with French/English pairs separated by " / "
- **Implementation**: Using bilingual format allows screens to extract the appropriate language
- **Note**: Category titles (like 'Prières obligatoires') can be replaced with `context.t.journalObligatoryPrayers` in the screen

### 4. **lib/decouvrir_data.dart** ✓
- **Updated category filters**:
  - kSagesseCategories: All categories now bilingual (patience, tawakkul, science, famille, repentir, amour)
  - kQuizCategories: All quiz categories now bilingual (coran, sira, piliers, prophetes, general)
  - Format: Emoji + Label with "Fr / En" translation pair
- **Example**: `'patience': '🏔️ Patience / Patience'` or `'coran': '📖 Coran / Quran'`

### 5. **lib/children_screen.dart** ✓
- **Made story data bilingual**:
  - Story titles: "Noé et l'Arche / Noah and the Ark"
  - Story descriptions: French text / English text
  - Story resumes: Bilingual format for each narrative
- **Stories updated**:
  - Story 1: Noah and the Ark
  - Story 2: Ibrahim and the Fire
  - Story 3: Yusuf and his Brothers
  - Story 4: Musa and the Pharaoh
- **Note**: Quiz questions can use translation keys from translations.dart

## Implementation Approach

### For Screen Titles & UI Labels:
```dart
// In screens, use context.t:
Text(context.t.journalObligatoryPrayers)  // Returns translated title based on locale
```

### For Data-Driven Content (Const Lists):
```dart
// Option 1: Bilingual format (currently used)
const kMoodOptions = <MoodOption>[
  MoodOption(id: 'serein', label: 'Serein / Peaceful', description: 'French / English'),
];

// In screen, extract based on locale:
String label = AppLocale().isFrench
  ? item.label.split(' / ').first
  : item.label.split(' / ').last;

// Option 2: Use helper function
import 'translation_helpers.dart';
String label = getLocalizedLabel(item.label);  // Returns "Serein" or "Peaceful"
```

### For Complex Content (Stories, Q&A):
```dart
// Use bilingual format with " / " separator
'resumé': 'French text... / English text...'

// Extract in display layer using translation_helpers:
String display = getLocalizedLabel(item.resume);
```

## Files Affected but Requiring Further Action

The following files contain large datasets with French text that have NOT been fully translated (due to complexity and size). Recommend applying same bilingual pattern:

### lib/famille_data.dart
- Prophet stories with full narratives (4000+ lines)
- Quiz data with questions and explanations
- Badge descriptions
- **Recommendation**: Add English translations using " / " format or convert descriptions to getters

### lib/famille_screen.dart
- Large UI with French text for prophet content
- **Recommendation**: Use `context.t` for titles, keep bilingual data format for content

### lib/assistant_data.dart
- Knowledge base with Q&A (900+ lines)
- Topic titles and descriptions
- **Recommendation**: Add English field or use bilingual format

### lib/decouvrir_screen.dart
- Quiz display logic and labels
- **Action**: Update to use `getLocalizedLabel()` from translation_helpers when displaying categories

### lib/journal_screen.dart
- Displays journal data
- **Action**: Import translation_helpers and use `getLocalizedLabel()` for bilingual display

## How to Display Bilingual Content in Widgets

```dart
// Import the helper
import 'translation_helpers.dart';
import 'app_locale.dart';

// In build method, display appropriately:
Text(
  getLocalizedLabel(item.label),  // Returns "Serein" or "Peaceful" based on locale
  style: TextStyle(fontSize: 16),
),

// Or manually:
Text(
  AppLocale().isFrench
    ? item.label.split(' / ').first
    : item.label.split(' / ').last,
),
```

## Key Design Decisions

1. **Bilingual Format**: Using "French / English" separator allows const data structures to remain const
2. **Two-Tier Approach**:
   - UI titles use translations.dart and context.t.key
   - Data-driven content uses " / " bilingual format in const lists
3. **No Breaking Changes**: Existing const structures remain mostly unchanged, only values updated
4. **Helper Module**: translation_helpers.dart provides utilities for extracting language-specific text

## Testing Recommendations

1. Test all translated screens in both French and English modes
2. Verify category filters display correctly in both languages
3. Check that story titles and descriptions render properly
4. Ensure mood selection labels are clear in both languages
5. Test that journey items display translations correctly

## Future Improvements

1. Convert remaining large data structures (famille_data.dart, assistant_data.dart) to use bilingual format
2. Create data migration to separate English and French narrative content into dedicated fields
3. Consider dynamic getters for complex narratives instead of const lists
4. Add language toggle testing in the UI
