import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:temrinnotuygulamasiiki/features/ders/cubit/ders_state.dart';
import 'package:temrinnotuygulamasiiki/features/ders/model/ders_model.dart';
import 'package:temrinnotuygulamasiiki/features/ders/service/ders_database_provider.dart';

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
   }
    
  Future<void> dersKaydet({int? id, required DersModel dersModel}) async {
     emit(state.copyWith(isLoading: true));
   
      if (id == null) {
        await _databaseProvider.insertItem(dersModel);
      } else {
        await _databaseProvider.updateItem(id, dersModel);
      }
      final dersList = await _databaseProvider.getList();
     emit(state.copyWith(dersModel: dersList, isLoading: false, isCompleted: true));
  }

  Future<void> dersSil({required int id}) async {
    emit(state.copyWith(isLoading: true));
      await _databaseProvider.removeItem(id);
      final dersList = await _databaseProvider.getList();
     emit(state.copyWith(dersModel: dersList, isLoading: false, isCompleted: true));
  }
}
