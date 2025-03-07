import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fal_hafez/data/repository/fal_hafez_repository.dart';
import 'package:fal_hafez/model/fai_hafez_model.dart';

part 'fal_hafez_event.dart';
part 'fal_hafez_state.dart';

class FalHafezBloc extends Bloc<FalHafezEvent, FalHafezState> {
  final FalHafezRepository falHafezRepository;
  FalHafezBloc(this.falHafezRepository) : super(FalHafezInitialState()) {
    on<FalHafezGetEvent>((event, emit) async {
      emit(FalHafezLoadingState());
      final Either<String, FalHafezModel> result =
          await falHafezRepository.getFalHafez();
      result.fold(
        (l) => emit(FalHafezErrorState(l)),
        (r) => emit(FalHafezLoadedState(r)),
      );
    });
  }
}
