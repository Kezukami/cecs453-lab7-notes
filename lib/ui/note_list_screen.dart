import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/note_model.dart';
import '../providers/note_provider.dart';
import 'add_note_screen.dart';

class NoteListScreen extends StatelessWidget {
  const NoteListScreen({super.key});

  Future<void> _openEditor(BuildContext context, [Note? note]) async {
    await Navigator.push<void>(
      context,
      MaterialPageRoute<void>(builder: (_) => AddNoteScreen(note: note)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Notes')),
      body: Consumer<NoteProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.error != null) {
            return Center(child: Text(provider.error!));
          }
          if (provider.notes.isEmpty) {
            return const Center(child: Text('No notes yet. Tap + to add one.'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: provider.notes.length,
            itemBuilder: (context, index) {
              final note = provider.notes[index];
              return Card(
                child: ListTile(
                  title: Text(note.title),
                  subtitle: Text(note.description),
                  isThreeLine: note.description.length > 55,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        tooltip: 'Edit note',
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _openEditor(context, note),
                      ),
                      IconButton(
                        tooltip: 'Delete note',
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () =>
                            context.read<NoteProvider>().deleteNote(note.id!),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add note',
        onPressed: () => _openEditor(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
