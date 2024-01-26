import 'package:flutter/material.dart';
import 'package:marcacion_admin/src/common/helpers/helpers.dart';
import 'package:marcacion_admin/src/common/services/services.dart';
import 'package:marcacion_admin/src/modules/companies/model/companies_model.dart';

class CompaniesProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  String? id;
  var companyName = TextEditingController(text: "");
  var companyAddress = TextEditingController(text: "");
  var companyContact = TextEditingController(text: "");
  var companyEmail = TextEditingController(text: "");
  var companyPhone = TextEditingController(text: "");
  bool isReady = false;
  bool loading = false;

  validInput() {
    var ready = companyName.text.isNotEmpty &&
        companyAddress.text.isNotEmpty &&
        companyContact.text.isNotEmpty &&
        companyEmail.text.isNotEmpty &&
        companyPhone.text.isNotEmpty;

    if (ready != isReady) {
      isReady = ready;
      notifyListeners();
    }
    return isReady;
  }

  edit(Companyitem company) {
    id = company.eprCode;
    companyName.text = company.eprName;
    companyAddress.text = company.eprAddress;
    companyContact.text = company.eprContactName;
    companyEmail.text = company.eprContactEmail;
    companyPhone.text = company.eprContactPhone;
    validInput();
  }

  crear() {
    id = null;
    companyName = TextEditingController(text: "");
    companyAddress = TextEditingController(text: "");
    companyContact = TextEditingController(text: "");
    companyEmail = TextEditingController(text: "");
    companyPhone = TextEditingController(text: "");
    isReady = !isReady;
    validInput();
  }

  List<Companyitem> companies = [];
  Future<bool> getCompanies() async {
    try {
      final resp = await DioConnection.get_('/companies');
      final response = CompaniesRes.fromJson(resp);
      companies = response.data;
      return true;
    } catch (e) {
      return false;
    } finally {
      notifyListeners();
    }
  }

  Future postCompanies() async {
    try {
      if (loading) return;
      loading = true;
      notifyListeners();
      var data = {
        "empre_nombre": companyName.text,
        "empre_direccion": companyAddress.text,
        "empre_contacto_nombre": companyContact.text,
        "empre_contacto_correo": companyEmail.text,
        "empre_contacto_telefono": companyPhone.text,
      };
      if (id != null) {
        var resp = await DioConnection.put_('/companies/$id', data);

        if (resp["status"] == 200) {
          crear();
          NotificationsService.showSnackbarSuccess("Empresa Actualizada");
          await getCompanies();
        }
      } else {
        var resp = await DioConnection.post_('/companies', data);
        if (resp["status"] == 201) {
          crear();
          NotificationsService.showSnackbarSuccess("Empresa Creada");
          await getCompanies();
        }
      }
      return true;
    } catch (e) {
      return false;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteEmployees(String id) async {
    try {
      await DioConnection.delete_('/companies/$id');
      NotificationsService.showSnackbarSuccess("Empresa Eliminada");
      await getCompanies();
      return true;
    } catch (e) {
      return false;
    } finally {
      notifyListeners();
    }
  }
}
