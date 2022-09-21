import 'package:equatable/equatable.dart';
import 'package:temrinnotuygulamasiiki/features/ogrenci/model/ogrenci_model.dart';


class OgrenciState extends Equatable {
  final bool isLoading;
  final List<OgrenciModel>?  ogrenciModel;
  final bool isCompleted;
  const OgrenciState({this.ogrenciModel, this.isLoading=false,this.isCompleted=false});

  @override
  List<Object?> get props => [isLoading,ogrenciModel];

    OgrenciState copyWith({
    bool? isLoading,
   List<OgrenciModel>? ogrenciModel,
    bool? isCompleted,
  }) {
    return OgrenciState(
      isLoading: isLoading??false,
      ogrenciModel: ogrenciModel ?? this.ogrenciModel,
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
