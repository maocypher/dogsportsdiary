import 'package:darq/darq.dart';
import 'package:dog_sports_diary/core/di/serivce_provider.dart';
import 'package:dog_sports_diary/core/utils/constants.dart';
import 'package:dog_sports_diary/domain/entities/dog.dart';
import 'package:hive/hive.dart';

class DogRepository {
  Future<void> saveDogAsync(Dog dog) async {
    final dogBox = Hive.box<Dog>(Constants.dogBox);
    if(dog.id == null){
      dog.setId();
    }

    await dogBox.put(dog.id, dog);
  }

  Future<void> saveAllDogsAsync(List<Dog> dogs) async {
    final dogBox = Hive.box<Dog>(Constants.dogBox);
    await dogBox.addAll(dogs);
  }

  Future<Dog?> getDogAsync(int id) async {
    final dogBox = Hive.box<Dog>(Constants.dogBox);
    return dogBox.get(id);
  }

  Future<List<Dog>> getAllDogsAsync() async {
    final dogBox = Hive.box<Dog>(Constants.dogBox);
    return dogBox.values.orderBy((x) => x.name.toLowerCase()).toList();
  }

  Future<void> deleteDogAsync(int id) async {
    final dogBox = Hive.box<Dog>(Constants.dogBox);
    await dogBox.delete(id);
  }

  Future<void> deleteAllDogsAsync() async {
    final dogBox = Hive.box<Dog>(Constants.dogBox);
    await dogBox.clear();
  }

  Future<bool> hasAnyDogAsync() async{
    final dogBox = Hive.box<Dog>(Constants.dogBox);
    return dogBox.isNotEmpty;
  }

  static inject() {
    // injecting the viewmodel
    ServiceProvider.locator.registerFactory<DogRepository>(() => DogRepository());
  }

  static DogRepository get dogRepository {
    return ServiceProvider.locator<DogRepository>();
  }
}