import 'package:flutter/material.dart';

import '../../utils/pref_utils.dart';
import '../../utils/state_manager.dart';
import '../model/CatalogModel.dart';

class CatalogViewModel {
  var listData = <CatalogModel>[];

  Future<List<CatalogModel>> loadData(BuildContext context) async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/data_sample.json");
    String dataFromLocal = PrefUtils().getString("list_data_from_local") ?? "";
    if (dataFromLocal.isEmpty) {
      PrefUtils().setString("list_data_from_local", data);
    }
    dataFromLocal = data;
    var catalogModelData = catalogFromJson(dataFromLocal);
    listData.clear();
    listData.addAll(catalogModelData);
    await Future.delayed(const Duration(seconds: 2));
    return listData;
  }
}
