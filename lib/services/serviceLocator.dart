import 'package:get_it/get_it.dart';
import 'package:tk_notes/core/providers/NotesProvider.dart';
import 'package:tk_notes/services/fileStorageService.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  serviceLocator
      .registerLazySingleton<FileStorageService>(() => FileStorageService());
  serviceLocator.registerLazySingleton<NotesProvider>(() => NotesProvider());
}
