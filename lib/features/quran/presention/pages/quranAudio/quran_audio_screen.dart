import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart' as justPlayer;
import 'package:just_audio_background/just_audio_background.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wrd/core/services/screen_size_helper.dart';
import 'package:wrd/core/utils/app_colors.dart';
import 'package:wrd/frosted_glass.dart';
import '../../../domain/entities/quranAudio/quran_audio.dart';
import '../../controller/quarn_constants.dart';
import '../../controller/surah_name.dart';

class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({
    Key? key,
    required this.urlMp3,
    required this.index,
    required this.quranAudioState,
    required this.numberUrls,
  }) : super(key: key);
  final String urlMp3;
  final int index;
  final QuranAudio quranAudioState;
  final List<int> numberUrls;

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  late justPlayer.AudioPlayer audioPlayer;
  late justPlayer.ConcatenatingAudioSource playList;
  var assetsAudioPlayer = AssetsAudioPlayer();

  // Function to initialize the playlist
  void initializePlayList() {
    List<String> audioUrls = widget.numberUrls.map((number) {
      String formattedNumber = number.toString().padLeft(3, '0');
      return "${widget.urlMp3}$formattedNumber.mp3";
    }).toList();
    playList = justPlayer.ConcatenatingAudioSource(
      children: List.generate(
        audioUrls.length,
        (index) {
          return justPlayer.AudioSource.uri(
            tag: MediaItem(
              id: '$index',
              title: AppConstants.surahName == ''
                  ? SurahNames.surah[widget.numberUrls[index] - 1]
                  : SurahNames.audioName[widget.numberUrls[index] - 1],
              artist: 'ش/  ${widget.quranAudioState.readersName}',
            ),
            Uri.parse(audioUrls[index]),
          );
        },
      ),
    );
  }

  Stream<PositionData> get positionDataStream => Rx.combineLatest3(
      audioPlayer.positionStream,
      audioPlayer.bufferedPositionStream,
      audioPlayer.durationStream,
      (position, bufferedPosition, duration) => PositionData(
          position: position,
          duration: duration ?? Duration.zero,
          bufferedPosition: bufferedPosition));

  @override
  void initState() {
    initializePlayList();
    super.initState();
    audioPlayer = justPlayer.AudioPlayer();
    init();
  }

  Future<void> init() async {
    await audioPlayer.setLoopMode(justPlayer.LoopMode.all);
    await audioPlayer.setAudioSource(playList, initialIndex: widget.index);
  }

  @override
  void dispose() {
    AppConstants.reciterName = '';
    AppConstants.surahName = '';
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: assetsAudioPlayer.builderIsPlaying(
        builder: (BuildContext context, bool isPlaying) {
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image/backgroundAudio.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 10.height),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.keyboard_arrow_right_sharp),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          color: Colors.white,
                          iconSize: 40.size,
                        ),
                        Text(
                          'السابق',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Almarai",
                              fontStyle: FontStyle.normal,
                              fontSize: 25.0.fontSize),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 50.height),
                      child: FrostedGlassBox(
                        theWidth: 350.width,
                        theHeight: 250.height,
                        theBoraderLeft: 30.radius,
                        theBoraderRight: 30.radius,
                        theChild: Column(
                          children: [
                            StreamBuilder(
                              stream: audioPlayer.sequenceStateStream,
                              builder: (context, snapshot) {
                                final state = snapshot.data;
                                if (state?.sequence.isEmpty ?? true) {
                                  return const SizedBox();
                                }
                                final metadata =
                                    state!.currentSource!.tag as MediaItem;
                                return MediaMetaData(
                                    title: metadata.title,
                                    reader: metadata.artist ?? '');
                              },
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: 20.0.width),
                              child: StreamBuilder<PositionData>(
                                  stream: positionDataStream,
                                  builder: (context, snapshot) {
                                    final positionData = snapshot.data;
                                    return ProgressBar(
                                      thumbRadius: 8.0.radius,
                                      barHeight: 4.height,
                                      baseBarColor: AppColors.primary,
                                      progressBarColor: AppColors.second,
                                      thumbColor: AppColors.white,
                                      timeLabelTextStyle: const TextStyle(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      progress: positionData?.position ??
                                          Duration.zero,
                                      total: positionData?.duration ??
                                          Duration.zero,
                                      buffered:
                                          positionData?.bufferedPosition ??
                                              Duration.zero,
                                      onSeek: audioPlayer.seek,
                                    );
                                  }),
                            ),
                            Controls(audioPlayer: audioPlayer),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class PositionData {
  final Duration position;
  final Duration duration;
  final Duration bufferedPosition;

  PositionData(
      {required this.position,
      required this.duration,
      required this.bufferedPosition});
}

class Controls extends StatefulWidget {
  final justPlayer.AudioPlayer audioPlayer;

  const Controls({Key? key, required this.audioPlayer}) : super(key: key);

  @override
  State<Controls> createState() => _ControlsState();
}

class _ControlsState extends State<Controls> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        loopButton(),
        IconButton(
          onPressed: widget.audioPlayer.seekToNext,
          icon: const Icon(
            Icons.skip_next,
          ),
          iconSize: 50,
          color: AppColors.second,
        ),
        playPauseButton(),
        IconButton(
          onPressed: widget.audioPlayer.seekToPrevious,
          icon: const Icon(
            Icons.skip_previous,
          ),
          iconSize: 50,
          color: AppColors.second,
        ),
        shuffleButton(),
      ],
    );
  }

  Widget loopButton() {
    return StreamBuilder(
        stream: widget.audioPlayer.loopModeStream,
        builder: (context, snapshot) {
          final bool isLoop =
              widget.audioPlayer.loopMode == justPlayer.LoopMode.all;
          return InkWell(
            onTap: () async {
              if (isLoop) {
                await widget.audioPlayer.setLoopMode(justPlayer.LoopMode.one);
              } else {
                await widget.audioPlayer.setLoopMode(justPlayer.LoopMode.all);
              }
            },
            child: SvgPicture.asset(
              isLoop == true
                  ? 'assets/svg/icon_repeat_normal.svg'
                  : 'assets/svg/icon_repeat_once_bold.svg',
            ),
          );
        });
  }

  StreamBuilder<justPlayer.PlayerState> playPauseButton() {
    final linearGradient =   LinearGradient(
      begin: Alignment(0.5, -3.0616171314629196e-17),
      end: Alignment(0.5, 0.9999999999999999),
      colors: [
        Color(0xffedad60),
        Color(0xff9c631d),
      ],
    );
    return StreamBuilder<justPlayer.PlayerState>(
      stream: widget.audioPlayer.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing = playerState?.playing;
        if (processingState == justPlayer.ProcessingState.loading ||
            processingState == justPlayer.ProcessingState.buffering) {
          return Container(
            margin: const EdgeInsets.all(8.0),
            width: 64.0,
            height: 64.0,
            child: const CircularProgressIndicator(
              color: AppColors.white,
            ),
          );
        } else if (playing == false) {
          return Container(
            decoration: BoxDecoration(
              gradient: linearGradient,
              borderRadius: BorderRadius.circular(50), // Adjust as needed
            ),
            child: IconButton(
              iconSize: 55.size,
              icon: const Icon(
                Icons.play_arrow,
                color: Colors.white, // Icon color
              ),
              onPressed: widget.audioPlayer.play,
            ),
          );
        } else if (processingState != justPlayer.ProcessingState.completed) {
          return
            Container(
              decoration: BoxDecoration(
                gradient: linearGradient,
                borderRadius: BorderRadius.circular(50), // Adjust as needed
              ),
              child: IconButton(
                iconSize: 55.size,
                icon: const Icon(
                  Icons.pause,
                  color: Colors.white, // Icon color
                ),
                onPressed: widget.audioPlayer.pause,
              ),
            );

        }
        return const Icon(
          Icons.play_arrow_rounded,
          size: 40,
          color: AppColors.second,
        );
      },
    );
  }

  Widget shuffleButton() {
    return StreamBuilder(
      stream: widget.audioPlayer.shuffleModeEnabledStream,
      builder: (context, snapshot) {
        final bool isShulffe = snapshot.data!;
        return InkWell(
          onTap: () async {
            await widget.audioPlayer.setShuffleModeEnabled(!isShulffe);
          },
          child: SvgPicture.asset(
            isShulffe == true
                ? 'assets/svg/icon_shuffle _bold.svg'
                : 'assets/svg/icon_shuffle.svg',
          ),
        );
      },
    );
  }
}

class MediaMetaData extends StatelessWidget {
  final String title;
  final String reader;

  const MediaMetaData({Key? key, required this.title, required this.reader})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          title,
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontFamily: "Almarai",
              fontStyle: FontStyle.normal,
              fontSize: 25.0),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          reader,
          style: const TextStyle(
              color: AppColors.lightYellow,
              fontWeight: FontWeight.w400,
              fontFamily: "Almarai",
              fontStyle: FontStyle.normal,
              fontSize: 16.0),
        ),
      ],
    );
  }
}
