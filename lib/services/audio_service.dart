import 'package:audioplayers/audioplayers.dart';

class AudioService {
  static final _player = AudioPlayer();

  static Future<void> correct() async {
    await _player.play(AssetSource('am_thanh/dung.mp3'));
  }

  static Future<void> wrong() async {
    await _player.play(AssetSource('am_thanh/sai.mp3'));
  }
}
