import 'package:equatable/equatable.dart';

import '../../data/model/home_category_model.dart';

class HomeCategoryEntity extends Equatable {
  const HomeCategoryEntity({required this.id, required this.name});

  factory HomeCategoryEntity.fromModel(HomeCategoryModel model) =>
      HomeCategoryEntity(id: model.id, name: model.name);

  final int id;
  final String name;

  @override
  List<Object?> get props => <Object?>[id, name];
}
