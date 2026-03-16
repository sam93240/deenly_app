// audio_player_state.dart
// État unifié du player audio — partagé entre web et native.

enum AudioPlayerState {
  idle,      // Aucune lecture en cours
  loading,   // Chargement/buffering
  playing,   // Lecture active
  paused,    // En pause (reprise possible)
  completed, // Lecture terminée naturellement
  error,     // Erreur — voir AudioPlayerError
}

class AudioPlayerError {
  final String message; // Affiché à l'utilisateur
  final dynamic cause;  // Cause technique (pour logs)

  const AudioPlayerError({required this.message, this.cause});

  @override
  String toString() => 'AudioPlayerError: $message (cause: $cause)';
}
