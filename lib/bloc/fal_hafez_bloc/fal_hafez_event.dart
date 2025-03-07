part of 'fal_hafez_bloc.dart';

sealed class FalHafezEvent extends Equatable {
  const FalHafezEvent();

  @override
  List<Object> get props => [];
}

class FalHafezGetEvent extends FalHafezEvent {}
