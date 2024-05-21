import 'package:dog_sports_diary/core/di/serivce_provider.dart';
import 'package:dog_sports_diary/domain/entities/dog.dart';
import 'package:hive/hive.dart';

class DogRepository {
  final Box<Dog> _dogBox;

  DogRepository() : _dogBox = Hive.box<Dog>('dogBox');

  Future<void> saveDog(Dog dog) async {
    await _dogBox.put(dog.name, dog);
  }

  Future<Dog?> getDog(String name) async {
    return _dogBox.get(name);
  }

  Future<List<Dog>> getAllDogs() async {
    return _dogBox.values.toList();
  }

  Future<void> deleteDog(int id) async {
    await _dogBox.delete(id);
  }

  Future<bool> hasAnyDog() async{
    return _dogBox.isNotEmpty;
  }

  Future<void> closeBox() async {
    await _dogBox.close();
  }

  static inject() {
    // injecting the viewmodel
    ServiceProvider.locator.registerFactory<DogRepository>(() => DogRepository());
  }

  static DogRepository get dogRepository {
    return ServiceProvider.locator<DogRepository>();
  }
}