part of 'fal_hafez_bloc.dart';

sealed class FalHafezState extends Equatable {
  const FalHafezState();

  @override
  List<Object> get props => [];
}

final class FalHafezInitialState extends FalHafezState {}

final class FalHafezLoadingState extends FalHafezState {}

final class FalHafezLoadedState extends FalHafezState {
  final FalHafezModel falHafezModel;
  const FalHafezLoadedState(this.falHafezModel);
}

final class FalHafezErrorState extends FalHafezState {
  final String message;
  const FalHafezErrorState(this.message);
}
