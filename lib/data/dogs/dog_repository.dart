import 'package:dog_sports_diary/core/di/serivce_provider.dart';
import 'package:dog_sports_diary/domain/entities/dog.dart';
import 'package:hive/hive.dart';

class DogRepository {
  Future<void> saveDog(Dog dog) async {
    final dogBox = Hive.box<Dog>('dogBox');
    dog.setId();

    await dogBox.put(dog.id, dog);
  }

  Future<Dog?> getDog(int id) async {
    final dogBox = Hive.box<Dog>('dogBox');
    return dogBox.get(id);
  }

  Future<List<Dog>> getAllDogs() async {
    final dogBox = Hive.box<Dog>('dogBox');
    return dogBox.values.toList();
  }

  Future<void> deleteDog(int id) async {
    final dogBox = Hive.box<Dog>('dogBox');
    await dogBox.delete(id);
  }

  Future<bool> hasAnyDog() async{
    final dogBox = Hive.box<Dog>('dogBox');
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