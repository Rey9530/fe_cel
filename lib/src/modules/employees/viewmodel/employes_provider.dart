import 'package:flutter/material.dart';
import 'package:marcacion_admin/src/common/helpers/helpers.dart';
import 'package:marcacion_admin/src/common/services/services.dart';
import 'package:marcacion_admin/src/modules/employees/model/models.dart';

class EmployesProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  String? uuid;
  var employeName = TextEditingController(text: "");
  var employeSurname = TextEditingController(text: "");
  var employeBirthdate = TextEditingController(text: "");
  var employeGender = TextEditingController(text: "0");
  var employeLocation = TextEditingController(text: "");
  var employeCompany = TextEditingController(text: "");
  var employeContact = TextEditingController(text: "");
  var employeHours = TextEditingController(text: "");
  var employeContratation = TextEditingController(text: "");
  var employeDateStart = TextEditingController(text: "");
  var employeDateEnd = TextEditingController(text: "");
  bool isReady = false;
  bool loading = false;

  List<Employe> employes = [];
  List<Sede> sedes = [];
  List<Company> companies = [];
  List<Contratation> contratations = [];
  List<Gender> genders = [];
  List<ContractsEmp> contractsEmp = [];

  int page = 1;
  int quantity = 10;
  int total = 0;
  String query = "";
  String company = "";
  Future<bool> getEmployes([load = false]) async {
    try {
      if (load) {
        loading = true;
        notifyListeners();
      }
      final resp = await DioConexion.get_(
        '/employes',
        {
          "page": page,
          "quantity": quantity,
          "query": query,
          "company": company,
        },
      );
      final response = EmployesResponse.fromJson(resp);
      if (load) {
        employes = [...employes, ...response.data.employes];
      } else {
        employes = response.data.employes;
      }
      quantity = response.data.pagination.quantity;
      page = response.data.pagination.page;
      total = response.data.pagination.total;
      return true;
    } catch (e) {
      return false;
    } finally {
      if (load) {
        loading = false;
      }
      notifyListeners();
    }
  }

  Future<bool> getEmploye() async {
    try {
      final resp = await DioConexion.get_('/employes/$uuid');
      final response = EmployeResponse.fromJson(resp).data;
      employeCode = response.empCodigoEmp;
      employeName = TextEditingController(text: response.empNombres);
      employeSurname = TextEditingController(text: response.empApellidos);
      employeBirthdate =
          TextEditingController(text: response.empFechaNacimiento);
      employeGender =
          TextEditingController(text: response.marGenGeneros.genCodigo);
      employeLocation =
          TextEditingController(text: response.marUbiUbicaciones.ubiCodigo);
      employeCompany = TextEditingController(text: response.empCodemp);
      await getContracts(response.empCodemp);
      if (response.marAsiAsignacion.isNotEmpty) {
        employeContact = TextEditingController(
            text: response.marAsiAsignacion[0]['mar_hor_horarios']
                ['mar_ctr_contratos']['ctr_codigo']);
      } else {
        employeContact = TextEditingController(text: "");
      }
      // employeHours = TextEditingController(text: "");//TODO: PENDIENTE
      employeContratation =
          TextEditingController(text: response.marConContrataciones.conCodigo);
      employeDateStart = TextEditingController(text: ""); //TODO: PENDIENTE
      employeDateEnd = TextEditingController(text: ""); //TODO: PENDIENTE
      // employes = response;
      return true;
    } catch (e) {
      return false;
    } finally {
      notifyListeners();
    }
  }

  Future saveEmploye() async {
    try {
      if (loading) return;
      loading = true;
      notifyListeners();
      var data = {
        "emp_codigo": employeCode,
        "emp_fecha_nacimiento": employeBirthdate.text,
        "emp_nombres": employeName.text,
        "emp_apellidos": employeSurname.text,
        "marca_emp_empre": employeCompany.text,
        "marca_emp_gen": employeGender.text,
        "marca_emp_ubi": employeLocation.text,
        "marca_emp_cn": employeContratation.text,
        "marca_asig_proy":
            employeContact.text.length > 10 ? employeContact.text : null,
        "marca_asig_hour":
            employeHours.text.length > 10 ? employeHours.text : null,
        "emp_fecha_pro_incio":
            employeDateStart.text.length > 5 ? employeDateStart.text : null,
        "emp_fecha_pro_fin":
            employeDateEnd.text.length > 5 ? employeDateEnd.text : null,
      };
      if (uuid != null) {
        var res = await DioConexion.put_('/employes/$uuid', data);
        if (res['status'] == 200) {
          NotificationsService.showSnackbarSuccess("Empleado Actualizada");
          NavigationService.goBack();
        }
      } else {
        var res = await DioConexion.post_('/employes', data);
        if (res['status'] == 200) {
          NotificationsService.showSnackbarSuccess("Empleado Creada");
          NavigationService.goBack();
        }
      }
      await getEmployes();
      return true;
    } catch (e) {
      return false;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  String employeCode = '000000';
  Future generateCode(String birthDate) async {
    try {
      if (loading) return;
      loading = true;
      notifyListeners();
      var data = {
        "emp_fecha_nacimiento": birthDate,
      };
      var resp = await DioConexion.post_('/employes/generatecode', data);
      var code = GenerateCodeResp.fromJson(resp);
      employeCode = code.data.code;
      return true;
    } catch (e) {
      return false;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future getCatalogs() async {
    try {
      if (loading) return;
      loading = true;
      // notifyListeners();
      var resp = await DioConexion.get_('/employes/get/catalogs');
      var code = CatalogResponse.fromJson(resp);
      companies = code.data.companies;
      genders = code.data.gender;
      sedes = code.data.sedes;
      contratations = code.data.contratation;
      return true;
    } catch (e) {
      return false;
    } finally {
      loading = false;
    }
  }

  Future getContracts(String idEmp) async {
    try {
      if (idEmp.length < 10) return;
      if (loading) return;
      loading = true;
      notifyListeners();
      var resp = await DioConexion.get_('/employes/get/contracts/$idEmp');
      var code = ContractsEmpResponse.fromJson(resp);
      contractsEmp = code.data;
      notifyListeners();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  List<HoursCtr> hoursCtr = [];
  bool loadingHours = false;
  Future getHoursContracts(String idCtr) async {
    try {
      if (idCtr.length < 10) return;
      if (loading) return;
      loadingHours = true;
      notifyListeners();
      var resp = await DioConexion.get_('/employes/get/contracts/hours/$idCtr');
      var code = HoursCtrResponse.fromJson(resp);
      hoursCtr = code.data;
      notifyListeners();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    } finally {
      loadingHours = false;
      notifyListeners();
    }
  }

  Future<List<Companie>> getCompanies() async {
    try {
      var resp = await DioConexion.get_('/companies');
      return CompaniesResponse.fromJson(resp).data;
    } catch (e) {
      return [];
    }
  }

  Future getCatalogos(String? uui) async {
    contractsEmp = [];
    hoursCtr = [];
    uuid = uui;
    await getCatalogs();
    if (uuid != null) {
      await getEmploye();
    } else {
      employeCode = '000000';
      employeName = TextEditingController(text: "");
      employeSurname = TextEditingController(text: "");
      employeBirthdate = TextEditingController(text: "");
      employeGender = TextEditingController(text: "0");
      employeLocation = TextEditingController(text: "");
      employeCompany = TextEditingController(text: "");
      employeContact = TextEditingController(text: "");
      employeHours = TextEditingController(text: "");
      employeContratation = TextEditingController(text: "");
      employeDateStart = TextEditingController(text: "");
      employeDateEnd = TextEditingController(text: "");
    }
  }

  Future<bool> deleteEmployes(String id) async {
    try {
      await DioConexion.delete_('/employes/$id');
      NotificationsService.showSnackbarSuccess("Empleado Eliminada");
      await getEmployes();
      return true;
    } catch (e) {
      return false;
    } finally {
      notifyListeners();
    }
  }
}
