import 'package:get_it/get_it.dart';

import '../repository/note_repository.dart';

final getIt = GetIt.instance;

void setupLocator() {
  if (!getIt.isRegistered<NoteRepository>()) {
    getIt.registerLazySingleton<NoteRepository>(() => NoteRepository());
  }
}
