// services/local_notif_service.dart
// Notifications locales schedulées — UpYourDeen
//
// Notifications programmées chaque jour :
//   ID 1  — 7h00  : Verset du jour
//   ID 2  — 6h00  : Adhkar du matin
//   ID 3  — 18h30 : Adhkar du soir
//   ID 4  — 20h00 : Rappel si l'utilisateur n'a pas ouvert l'app aujourd'hui
//
// Usage :
//   await LocalNotifService.instance.init();
//   await LocalNotifService.instance.scheduleDailyNotifications();

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:shared_preferences/shared_preferences.dart';
import '../user_profile.dart';

class LocalNotifService {
  static final LocalNotifService instance = LocalNotifService._();
  LocalNotifService._();

  final _plugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  static const _kScheduledKey = 'deenly_notifs_scheduled_date';

  // ── Initialisation ─────────────────────────────────────────────────────
  Future<void> init() async {
    if (kIsWeb || _initialized) return;

    tz.initializeTimeZones();

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios     = DarwinInitializationSettings(
      requestAlertPermission:  false, // on demandera manuellement
      requestBadgePermission:  false,
      requestSoundPermission:  false,
    );
    const settings = InitializationSettings(android: android, iOS: ios);

    await _plugin.initialize(
      settings,
      onDidReceiveNotificationResponse: _onTap,
    );
    _initialized = true;
  }

  // ── Demande de permission (iOS / Android 13+) ─────────────────────────
  Future<bool> requestPermission() async {
    if (kIsWeb) return false;
    final ios = _plugin.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>();
    if (ios != null) {
      return await ios.requestPermissions(alert: true, badge: true, sound: true) ?? false;
    }
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (android != null) {
      return await android.requestNotificationsPermission() ?? false;
    }
    return false;
  }

  // ── Programmer toutes les notifs quotidiennes ─────────────────────────
  /// N'appelle les méthodes de scheduling qu'une fois par jour.
  Future<void> scheduleDailyNotifications({UserProfile? profile}) async {
    if (kIsWeb || !_initialized) return;

    final prefs = await SharedPreferences.getInstance();
    final today = _dateKey(DateTime.now());
    if (prefs.getString(_kScheduledKey) == today) return; // déjà programmé aujourd'hui

    await _plugin.cancelAll();

    final prenom = profile?.prenom ?? '';

    // 1. Verset du jour — 7h00
    await _scheduleDailyAt(
      id:    1,
      hour:  7,
      minute: 0,
      title: '📖 Verset du jour',
      body:  prenom.isNotEmpty
          ? '$prenom, commence ta journée avec le Coran ✨'
          : 'Commence ta journée avec le Coran ✨',
    );

    // 2. Adhkar du matin — 6h00
    await _scheduleDailyAt(
      id:    2,
      hour:  6,
      minute: 0,
      title: '🌅 Adhkar du matin',
      body:  'Quelques dhikr pour protéger ta journée 🤲',
    );

    // 3. Adhkar du soir — 18h30
    await _scheduleDailyAt(
      id:    3,
      hour:  18,
      minute: 30,
      title: '🌙 Adhkar du soir',
      body:  'Termine la journée avec le souvenir d\'Allah 💚',
    );

    // 4. Rappel bonne action — 20h00
    await _scheduleDailyAt(
      id:    4,
      hour:  20,
      minute: 0,
      title: '✨ Bonne action du jour',
      body:  'As-tu fait ta bonne action aujourd\'hui ? Chaque petit geste compte.',
    );

    await prefs.setString(_kScheduledKey, today);
  }

  // ── Notification streak en danger (à appeler si absent depuis 1 jour) ─
  Future<void> scheduleStreakReminder({required int streak}) async {
    if (kIsWeb || !_initialized || streak < 3) return;
    // Demain à 10h si pas ouvert aujourd'hui
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    final scheduled = tz.TZDateTime(
      tz.local, tomorrow.year, tomorrow.month, tomorrow.day, 10, 0,
    );
    await _plugin.zonedSchedule(
      10,
      '🔥 Ton streak de $streak jours est en danger !',
      'Ouvre l\'app aujourd\'hui pour ne pas perdre ta série.',
      scheduled,
      _notifDetails(channelId: 'streak', channelName: 'Streak'),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  // ── Annuler le reminder streak (utilisateur a ouvert l'app) ──────────
  Future<void> cancelStreakReminder() async {
    if (kIsWeb || !_initialized) return;
    await _plugin.cancel(10);
  }

  // ── Privé : scheduler une notif quotidienne récurrente ────────────────
  Future<void> _scheduleDailyAt({
    required int    id,
    required int    hour,
    required int    minute,
    required String title,
    required String body,
  }) async {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    await _plugin.zonedSchedule(
      id,
      title,
      body,
      scheduled,
      _notifDetails(channelId: 'daily', channelName: 'Rappels quotidiens'),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time, // répète chaque jour
    );
  }

  // ── Détails de notification ────────────────────────────────────────────
  NotificationDetails _notifDetails({
    required String channelId,
    required String channelName,
  }) {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        channelId,
        channelName,
        importance: Importance.high,
        priority:   Priority.high,
        icon:       '@mipmap/ic_launcher',
      ),
      iOS: const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );
  }

  void _onTap(NotificationResponse response) {
    // À enrichir : naviguer vers l'écran concerné selon response.id
  }

  String _dateKey(DateTime dt) =>
      '${dt.year}-${dt.month.toString().padLeft(2, '0')}-'
      '${dt.day.toString().padLeft(2, '0')}';
}
