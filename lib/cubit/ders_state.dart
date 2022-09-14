part of 'ders_cubit.dart';

@immutable
abstract class DersState extends Equatable {
  const DersState();
}

class DersInitial extends DersState {
  const DersInitial();

  @override
  List<Object?> get props => [];
}

class DersLoading extends DersState {
  @override
  List<Object?> get props => [];
}

class DersLoaded extends DersState {
  const DersLoaded({
    this.ders,
  });

  final List<DersModel>? ders;

  DersLoaded copyWith({
    List<DersModel>? ders,
  }) {
    return DersLoaded(
      ders: ders ?? this.ders,
    );
  }

  @override
  List<Object?> get props => [ders];
}

class DersFailure extends DersState {
  const DersFailure();

  @override
  List<Object?> get props => [];
}
