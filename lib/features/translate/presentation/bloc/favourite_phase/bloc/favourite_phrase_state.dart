part of 'favourite_phrase_bloc.dart';

@immutable
sealed class FavouritePhraseState {}

final class FavouritePhraseInitial extends FavouritePhraseState {}

final class FavouritePhraseAdded extends FavouritePhraseState {
  final String phrase;

  FavouritePhraseAdded({required this.phrase});
}
