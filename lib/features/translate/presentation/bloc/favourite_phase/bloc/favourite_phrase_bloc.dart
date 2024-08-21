import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'favourite_phrase_event.dart';
part 'favourite_phrase_state.dart';

class FavouritePhraseBloc
    extends Bloc<FavouritePhraseEvent, FavouritePhraseState> {
  FavouritePhraseBloc() : super(FavouritePhraseInitial()) {
    //
    on<AddFavouritePhraseEvent>((event, emit) {
      emit(FavouritePhraseAdded(phrase: event.phrase));
    });
  }
}
