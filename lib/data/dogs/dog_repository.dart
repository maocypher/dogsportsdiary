import 'package:darq/darq.dart';
import 'package:dog_sports_diary/core/di/serivce_provider.dart';
import 'package:dog_sports_diary/core/services/hive_service.dart';
import 'package:dog_sports_diary/domain/entities/dog.dart';

class DogRepository {
  final HiveService _hiveService = HiveService.hiveService;

  Future<void> saveDogAsync(Dog dog) async {
    if(dog.id == null){
      dog.setId();
    }

    await _hiveService.dogBox.put(dog.id, dog);
  }

  Future<void> saveAllDogsAsync(List<Dog> dogs) async {
    await _hiveService.dogBox.putAll(Map.fromEntries(dogs.map((x) => MapEntry(x.id, x))));
  }

  Future<Dog?> getDogAsync(int id) async {
    return _hiveService.dogBox.get(id);
  }

  Future<List<Dog>> getAllDogsAsync() async {
    return _hiveService.dogBox.values.orderBy((x) => x.name.toLowerCase()).toList();
  }

  Future<void> deleteDogAsync(int id) async {
    await _hiveService.dogBox.delete(id);
  }

  Future<void> deleteAllDogsAsync() async {
    await _hiveService.dogBox.clear();
  }

  Future<bool> hasAnyDogAsync() async{
    return _hiveService.dogBox.isNotEmpty;
  }

  static inject() {
    // injecting the viewmodel
    ServiceProvider.locator.registerFactory<DogRepository>(() => DogRepository());
  }

  static DogRepository get dogRepository {
    return ServiceProvider.locator<DogRepository>();
  }
}