import 'package:get/get.dart';

import '../../generated/assets.dart';

class MoodController extends GetxController {
  final RxDouble moodValue = 50.0.obs;


  final RxString moodLabel = 'Calm'.obs;


  final RxString emojiAsset = 'assets/images/calm.png'.obs;

  void onSliderChanged(double value) {
    moodValue.value = value;
    _updateMoodForValue(value);
  }

  void _updateMoodForValue(double value) {
    if (value < 25) {
      moodLabel.value = 'Calm';
      emojiAsset.value = Assets.imagesCalm;
    } else if (value < 50) {
      moodLabel.value = 'Content';
      emojiAsset.value = Assets.imagesContent;
    } else if (value < 75) {
      moodLabel.value = 'Peaceful';
      emojiAsset.value = Assets.imagesPeaceful;
    } else if (value > 75){
      moodLabel.value = 'Happy';
      emojiAsset.value = Assets.imagesHappy;
    }
  }
}
