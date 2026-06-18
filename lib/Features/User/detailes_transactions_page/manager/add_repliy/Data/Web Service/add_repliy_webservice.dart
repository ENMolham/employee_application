import 'package:dio/dio.dart';
import 'package:employee_application/Core/api/api_consumer.dart';
import 'package:employee_application/Core/api/end_points.dart';
import 'package:employee_application/Features/User/detailes_transactions_page/manager/add_repliy/Data/Model/add_repliy_entity.dart';
import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';

abstract class AddRepliyWebService {
  Future<AddRepliyEntity> addRepliy(
    String idTransaction,
    List<PlatformFile>? files,
    String? text,
  );
}

@Singleton(as: AddRepliyWebService)
class AddRepliyWebServiceImpl implements AddRepliyWebService {
  final ApiConsumer _apiConsumer;

  AddRepliyWebServiceImpl(this._apiConsumer);

  @override
  Future<AddRepliyEntity> addRepliy(
    String idTransaction,
    List<PlatformFile>? files,
    String? text,
  ) async {
    final Map<String, dynamic> data = {'idTransaction': idTransaction};
    if (text != null && text.trim().isNotEmpty) {
      data['text'] = text.trim();
    }
    if (files != null && files.isNotEmpty) {
      for (int i = 0; i < files.length; i++) {
        final file = files[i];
        if (file.bytes != null) {
          data['attashments[$i]'] = MultipartFile.fromBytes(
            file.bytes!,
            filename: file.name,
          );
        }
      }
    }

    final formData = FormData.fromMap(data);
    final response = await _apiConsumer.post(
      EndPoints.addRepliyUrl,
      formData: formData,
    );
    return AddRepliyEntity.fromJson(response);
  }
}
