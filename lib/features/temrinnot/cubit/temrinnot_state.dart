import 'package:equatable/equatable.dart';
import 'package:temrinnotuygulamasiiki/features/temrinnot/model/temrinnot_model.dart';


class TemrinNotState extends Equatable {
  final bool isLoading;
  final List<TemrinNotModel>?  temrinNotModel;
  final bool isCompleted;
  const TemrinNotState({this.temrinNotModel, this.isLoading=false,this.isCompleted=false});

  @override
  List<Object?> get props => [isLoading,temrinNotModel];

    TemrinNotState copyWith({
    bool? isLoading,
   List<TemrinNotModel>? temrinNotModel,
    bool? isCompleted,
  }) {
    return TemrinNotState(
      isLoading: isLoading??false,
      temrinNotModel: temrinNotModel ?? this.temrinNotModel,
      isCompleted: isCompleted??false,
    );
  }
}


