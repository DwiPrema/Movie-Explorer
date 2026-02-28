import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) =>
      events.distinct().debounceTime(duration).switchMap(mapper);
}