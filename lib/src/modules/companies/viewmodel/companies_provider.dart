import 'package:flutter/material.dart';
import 'package:marcacion_admin/src/common/helpers/helpers.dart';
import 'package:marcacion_admin/src/common/services/services.dart';
import 'package:marcacion_admin/src/modules/companies/model/companies_model.dart';

class CompaniesProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  String? id;
  var companyName = TextEditingController(text: "");
  var companyAdress = TextEditingController(text: "");
  var companyContact = TextEditingController(text: "");
  var companyEmail = TextEditingController(text: "");
  var companyPhone = TextEditingController(text: "");
  bool isReady = false;
  bool loading = false;

  validarInput() {
    var ready = companyName.text.isNotEmpty &&
        companyAdress.text.isNotEmpty &&
        companyContact.text.isNotEmpty &&
        companyEmail.text.isNotEmpty &&
        companyPhone.text.isNotEmpty;

    if (ready != isReady) {
      isReady = ready;
      notifyListeners();
    }
    return isReady;
  }

  edit(Companie companie) {
    id = companie.eprCodigo;
    companyName.text = companie.eprNombre;
    companyAdress.text = companie.eprDireccion;
    companyContact.text = companie.eprContactoNombre;
    companyEmail.text = companie.eprContactoCorreo;
    companyPhone.text = companie.eprContactoTelefono;
    validarInput();
  }

  limpiar() {
    id = null;
    companyName = TextEditingController(text: "");
    companyAdress = TextEditingController(text: "");
    companyContact = TextEditingController(text: "");
    companyEmail = TextEditingController(text: "");
    companyPhone = TextEditingController(text: "");
    isReady = !isReady;
    validarInput();
  }

  List<Companie> companies = [];
  Future<bool> getCompanies() async {
    try {
      final resp = await DioConexion.get_('/companies');
      final response = CompaniesResponse.fromJson(resp);
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
        "empre_direccion": companyAdress.text,
        "empre_contacto_nombre": companyContact.text,
        "empre_contacto_correo": companyEmail.text,
        "empre_contacto_telefono": companyPhone.text,
      };
      if (id != null) {
        await DioConexion.put_('/companies/$id', data);

        NotificationsService.showSnackbarSuccess("Empresa Actualizada");
      } else {
        await DioConexion.post_('/companies', data);
        NotificationsService.showSnackbarSuccess("Empresa Creada");
      }
      await getCompanies();
      return true;
    } catch (e) {
      return false;
    } finally {
      loading = false;
      limpiar();
    }
  }

  Future<bool> deleteEmployes(String id) async {
    try {
      await DioConexion.delete_('/companies/$id');
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
