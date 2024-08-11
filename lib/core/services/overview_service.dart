import 'package:dog_sports_diary/core/di/service_provider.dart';
import 'package:dog_sports_diary/data/diary/diary_entry_repository.dart';
import 'package:dog_sports_diary/data/dogs/dog_repository.dart';

class OverviewService {
  //internal-directory: /storage/emulated/0/Android/data/com.anni.dog_sports_diary/files/downloads/
  static const String fileName = 'dgSptDryBak.json';

  final DogRepository dogRepository = DogRepository.dogRepository;
  final DiaryEntryRepository diaryEntryRepository =
      DiaryEntryRepository.diaryEntryRepository;



  static inject() {
    // injecting the viewmodel
    ServiceProvider.locator
        .registerFactory<OverviewService>(() => OverviewService());
  }

  static OverviewService get overviewService {
    return ServiceProvider.locator<OverviewService>();
  }
}