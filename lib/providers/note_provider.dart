import 'package:flutter/foundation.dart';

import '../data/note_model.dart';
import '../di/service_locator.dart';
import '../repository/note_repository.dart';

class NoteProvider extends ChangeNotifier {
  final NoteRepository _repository = getIt<NoteRepository>();
  List<Note> _notes = [];
  bool _isLoading = false;
  String? _error;

  List<Note> get notes => List.unmodifiable(_notes);
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchNotes() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _notes = await _repository.getNotes();
    } catch (error) {
      _error = 'Could not load notes: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addNote(Note note) async {
    await _repository.insertNote(note);
    await fetchNotes();
  }

  Future<void> updateNote(Note note) async {
    await _repository.updateNote(note);
    await fetchNotes();
  }

  Future<void> deleteNote(int id) async {
    await _repository.deleteNote(id);
    await fetchNotes();
  }
}
