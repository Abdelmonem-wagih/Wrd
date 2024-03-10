import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'play_audio_state.dart';

class AudioPlayerCubit extends Cubit<AudioPlayerState> {
  final AssetsAudioPlayer _audioPlayer = AssetsAudioPlayer.newPlayer();

  AudioPlayerCubit() : super(AudioPlayerInitial());

  void playAudio(String audioUrl) {
    _audioPlayer.open(Audio.network(audioUrl));
    _audioPlayer.play();
    emit(AudioPlayerPlaying());
  }

  void pauseAudio() {
    _audioPlayer.pause();
    emit(AudioPlayerPaused());
  }

  void skipNext(String audioUrl) {
    _audioPlayer.open(Audio.network(audioUrl));
    _audioPlayer.next();
  }

  void skipPrevious(String audioUrl) {
    _audioPlayer.open(Audio.network(audioUrl));
    _audioPlayer.previous();
  }
}
