import 'package:equatable/equatable.dart';
import 'package:temrinnotuygulamasiiki/features/sinif/model/sinif_model.dart';


class SinifState extends Equatable {
  final bool isLoading;
  final List<SinifModel>?  sinifModel;
  final bool isCompleted;
  const SinifState({this.sinifModel, this.isLoading=false,this.isCompleted=false});

  @override
  List<Object?> get props => [isLoading,sinifModel];

    SinifState copyWith({
    bool? isLoading,
   List<SinifModel>? sinifModel,
    bool? isCompleted,
  }) {
    return SinifState(
      isLoading: isLoading??false,
      sinifModel: sinifModel ?? this.sinifModel,
      isCompleted: isCompleted??false,
    );
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
