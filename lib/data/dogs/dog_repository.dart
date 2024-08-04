import 'package:darq/darq.dart';
import 'package:dog_sports_diary/core/di/service_provider.dart';
import 'package:dog_sports_diary/core/services/hive_service.dart';
import 'package:dog_sports_diary/domain/entities/dog.dart';
import 'package:multiple_result/multiple_result.dart';

class DogRepository {
  final HiveService _hiveService = HiveService.hiveService;

  Future<Result<Unit, Exception>> saveDogAsync(Dog dog) async {
    try {
      if (dog.id == null) {
        dog.setId();
      }

      await _hiveService.dogBox.put(dog.id, dog);

      return const Success(unit);
    } on Exception catch (e) {
      return Error(e);
    }
  }

  Future<Result<Unit, Exception>> saveAllDogsAsync(List<Dog> dogs) async {
    try {
      await _hiveService.dogBox
          .putAll(Map.fromEntries(dogs.map((x) => MapEntry(x.id, x))));

      return const Success(unit);
    } on Exception catch (e) {
      return Error(e);
    }
  }

  Result<Dog, Exception> getDog(int id) {
    try {
      var result = _hiveService.dogBox.get(id);

      if (result == null) {
        return Error(Exception('Dog not found'));
      }

      return Success(result);
    } on Exception catch (e) {
      return Error(e);
    }
  }

  Result<List<Dog>, Exception> getAllDogs() {
    try {
      var result = _hiveService.dogBox.values
          .orderBy((x) => x.name.toLowerCase())
          .toList();
      return Success(result);
    } on Exception catch (e) {
      return Error(e);
    }
  }

  Future<Result<Unit, Exception>> deleteDogAsync(int id) async {
    try {
      await _hiveService.dogBox.delete(id);

      return const Success(unit);
    } on Exception catch (e) {
      return Error(e);
    }
  }

  Future<Result<Unit, Exception>> deleteAllDogsAsync() async {
    try {
      await _hiveService.dogBox.clear();
      return const Success(unit);
    } on Exception catch (e) {
      return Error(e);
    }
  }

  Result<bool, Exception> hasAnyDogs() {
    try {
      return Success(_hiveService.dogBox.isNotEmpty);
    } on Exception catch (e) {
      return Error(e);
    }
  }

  static inject() {
    // injecting the viewmodel
    ServiceProvider.locator
        .registerFactory<DogRepository>(() => DogRepository());
  }

  static DogRepository get dogRepository {
    return ServiceProvider.locator<DogRepository>();
  }
}
