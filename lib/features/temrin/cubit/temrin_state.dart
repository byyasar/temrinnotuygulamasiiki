import 'package:equatable/equatable.dart';
import 'package:temrinnotuygulamasiiki/features/temrin/model/temrin_model.dart';


class TemrinState extends Equatable {
  final bool isLoading;
  final List<TemrinModel>?  temrinModel;
  final bool isCompleted;
  const TemrinState({this.temrinModel, this.isLoading=false,this.isCompleted=false});

  @override
  List<Object?> get props => [isLoading,temrinModel];

    TemrinState copyWith({
    bool? isLoading,
   List<TemrinModel>? temrinModel,
    bool? isCompleted,
  }) {
    return TemrinState(
      isLoading: isLoading??false,
      temrinModel: temrinModel ?? this.temrinModel,
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
