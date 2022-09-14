import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:temrinnotuygulamasiiki/cubit/ders_state.dart';
import 'package:temrinnotuygulamasiiki/models/ders/ders_database_provider.dart';
import 'package:temrinnotuygulamasiiki/models/ders/ders_model.dart';

class DersCubit extends Cubit<DersState> {
  DersCubit({required DersDatabaseProvider databaseProvider})
      : _databaseProvider = databaseProvider,
        super(const DersState()) {
    dersleriGetir();
  }

  final DersDatabaseProvider _databaseProvider;

  Future<void> dersleriGetir() async {
    emit(state.copyWith(isLoading: true));
    final dersList = await _databaseProvider.getList();
    emit(state.copyWith(dersModel: dersList, isLoading: false, isCompleted: true));
    // emit(DersState());
    // try {
    //   final dersList = await _databaseProvider.getList();
    //   emit(DersState(ders: dersList));
    // } on Exception {
    //   emit(const DersFailure());
    // }
  }

  // Future<void> dersSil({required int id}) async {
  //   emit(DersLoading());
  //   try {
  //     await _databaseProvider.removeItem(id);
  //     final dersList = await _databaseProvider.getList();
  //     emit(DersLoaded(ders: dersList));
  //   } on Exception {
  //     emit(const DersFailure());
  //   }
  // }

  // Future<void> dersKaydet({int? id, required DersModel dersModel}) async {
  //   emit(DersLoading());
  //   try {
  //     if (id == null) {
  //       await _databaseProvider.insertItem(dersModel);
  //     } else {
  //       await _databaseProvider.updateItem(id, dersModel);
  //     }
  //     final dersList = await _databaseProvider.getList();
  //     emit(DersLoaded(ders: dersList));
  //   } on Exception {
  //     emit(const DersFailure());
  //   }
  // }
}
