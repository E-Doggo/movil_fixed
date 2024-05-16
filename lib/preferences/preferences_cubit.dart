import 'package:flutter_bloc/flutter_bloc.dart';

class PreferencesCubit extends Cubit<List<String>> {
  PreferencesCubit() : super([]);

  void togglePreference(String preference) {
    if (state.contains(preference)) {
      // Si la preferencia ya está seleccionada, la eliminamos de la lista
      emit(List.from(state)..remove(preference));
    } else {
      // Si la preferencia no está seleccionada, la agregamos a la lista
      emit(List.from(state)..add(preference));
    }
  }
}

