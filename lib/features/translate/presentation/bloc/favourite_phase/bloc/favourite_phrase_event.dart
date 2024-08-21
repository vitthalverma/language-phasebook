part of 'favourite_phrase_bloc.dart';

@immutable
sealed class FavouritePhraseEvent {}

final class AddFavouritePhraseEvent extends FavouritePhraseEvent {
  final String phrase;

  AddFavouritePhraseEvent({required this.phrase});
}
