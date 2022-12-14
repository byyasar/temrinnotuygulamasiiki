import 'package:equatable/equatable.dart';
import 'package:temrinnotuygulamasiiki/features/ders/model/ders_model.dart';

class DersState extends Equatable {
  final bool isLoading;
  final List<DersModel>? dersModel;
  final DersModel? dersModeli;
  final bool isCompleted;

  const DersState({
    this.dersModel,
    this.dersModeli,
    this.isLoading = false,
    this.isCompleted = false,
  });

  @override
  List<Object?> get props => [isLoading, dersModel, dersModeli];

  DersState copyWith({
    bool? isLoading,
    List<DersModel>? dersModel,
    DersModel? dersModeli,
    bool? isCompleted,
  }) {
    return DersState(
        isLoading: isLoading ?? false,
        dersModel: dersModel ?? this.dersModel,
        isCompleted: isCompleted ?? false,
        dersModeli: dersModeli ?? this.dersModeli);
  }
}







// class DersInitial extends DersState {
//   const DersInitial();

//   @override
//   List<Object?> get props => [];
// }



// class DersLoading extends DersState {
//   @override
//   List<Object?> get props => [];
// }

// class DersLoaded extends DersState {
//   const DersLoaded({
//     this.ders,
//   });

//   final List<DersModel>? ders;

//   @override
//   List<Object?> get props => [ders];

//   DersLoaded copyWith({
//     List<DersModel>? ders,
//   }) {
//     return DersLoaded(
//       ders: ders ?? this.ders,
//     );
//   }
// }

// class DersFailure extends DersState {
//   const DersFailure();

//   @override
//   List<Object?> get props => [];
// }
