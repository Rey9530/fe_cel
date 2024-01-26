import 'package:flutter/material.dart';
import 'package:marcacion_admin/src/common/helpers/helpers.dart';
import 'package:marcacion_admin/src/common/services/services.dart';
import 'package:marcacion_admin/src/modules/contract/model/index.dart';
import 'package:marcacion_admin/src/modules/employees/model/models.dart';

class EmployeesProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  String? uuid;
  var employeeName = TextEditingController(text: "");
  var employeeSurname = TextEditingController(text: "");
  var employeeBirthDate = TextEditingController(text: "");
  var employeeGender = TextEditingController(text: "0");
  var employeeLocation = TextEditingController(text: "");
  var employeeCompany = TextEditingController(text: "");
  var employeeContact = TextEditingController(text: "");
  var employeeHours = TextEditingController(text: "");
  var employeeContratacion = TextEditingController(text: "");
  var employeeDateStart = TextEditingController(text: "");
  var employeeDateEnd = TextEditingController(text: "");

  final formKeyPermission = GlobalKey<FormState>();
  var permissionDateStart = TextEditingController(text: "");
  var motivoController = TextEditingController(text: "");
  var permissionDateEnd = TextEditingController(text: "");
  var employeeReplace = TextEditingController(text: "");
  var comment = TextEditingController(text: "");

  bool isReady = false;
  bool loading = false;

  List<Employee> employes = [];
  List<Sede> sedes = [];
  List<CompanyCat> companies = [];
  List<Contratation> contratations = [];
  List<Gender> genders = [];
  List<ContractsEmp> contractsEmp = [];
  List<PermissionsItem> permissions = [];

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
      final resp = await DioConnection.get_(
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

  Future getEmployeePermissions([load = true]) async {
    permissionDateStart = TextEditingController();
    permissionDateEnd = TextEditingController();
    employeeReplace = TextEditingController();
    comment = TextEditingController();
    motivoController = TextEditingController();
    if (load) await getMotivos();
    if (load) await getCatalogs();
    await getPermissions();
    if (load) await getEmployee();
  }

  late Employee employee;
  Future<bool> getEmployee() async {
    try {
      final resp = await DioConnection.get_('/employes/$uuid');
      final response = EmployeeResponse.fromJson(resp).data;
      employee = response;
      employeeCode = response.empCodigoEmp;
      employeeName = TextEditingController(text: response.empNombres);
      employeeSurname = TextEditingController(text: response.empApellidos);
      employeeBirthDate = TextEditingController(text: response.empBirthDate);
      employeeGender =
          TextEditingController(text: response.marGenGenders.genCodigo);
      employeeLocation =
          TextEditingController(text: response.marUbiLocations.ubiCodigo);
      employeeCompany = TextEditingController(text: response.empCodEmp);
      await getContracts(response.empCodEmp);
      if (response.marAsiAssignation.isNotEmpty) {
        employeeContact = TextEditingController(
            text: response.marAsiAssignation[0]['mar_hor_horarios']
                ['mar_ctr_contratos']['ctr_codigo']);
      } else {
        employeeContact = TextEditingController(text: "");
      }
      // employeHours = TextEditingController(text: "");//TODO: PENDIENTE
      employeeContratacion =
          TextEditingController(text: response.marConContractions.conCodigo);
      employeeDateStart = TextEditingController(text: ""); //TODO: PENDIENTE
      employeeDateEnd = TextEditingController(text: ""); //TODO: PENDIENTE
      // employes = response;
      return true;
    } catch (e) {
      return false;
    } finally {
      notifyListeners();
    }
  }

  List<EmployeesContract> employees = [];
  Future<List<EmployeesContract>> getEmployees(
    querySearch,
  ) async {
    if (querySearch.length < 3) {
      return [];
    }
    try {
      final resp = await DioConnection.get_(
        '/contracts/get/employes/${employeeContact.text}',
        {
          "page": 1,
          "quantity": 10,
          "query": querySearch,
          "company": employeeCompany.text,
        },
      );
      final response = EmployeesContractResponse.fromJson(resp);
      return response.data;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future saveEmploye() async {
    try {
      if (loading) return;
      loading = true;
      notifyListeners();
      var data = {
        "emp_codigo": employeeCode,
        "emp_fecha_nacimiento": employeeBirthDate.text,
        "emp_nombres": employeeName.text,
        "emp_apellidos": employeeSurname.text,
        "marca_emp_empre": employeeCompany.text,
        "marca_emp_gen": employeeGender.text,
        "marca_emp_ubi": employeeLocation.text,
        "marca_emp_cn": employeeContratacion.text,
        "marca_asig_proy":
            employeeContact.text.length > 10 ? employeeContact.text : null,
        "marca_asig_hour":
            employeeHours.text.length > 10 ? employeeHours.text : null,
        "emp_fecha_pro_incio":
            employeeDateStart.text.length > 5 ? employeeDateStart.text : null,
        "emp_fecha_pro_fin":
            employeeDateEnd.text.length > 5 ? employeeDateEnd.text : null,
      };
      if (uuid != null) {
        var res = await DioConnection.put_('/employes/$uuid', data);
        if (res['status'] == 200) {
          NotificationsService.showSnackbarSuccess("Empleado Actualizada");
          NavigationService.goBack();
        }
      } else {
        var res = await DioConnection.post_('/employes', data);
        if (res['status'] == 201) {
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

  String employeeCode = '000000';
  Future generateCode(String birthDate) async {
    try {
      if (loading) return;
      loading = true;
      notifyListeners();
      var data = {
        "emp_fecha_nacimiento": birthDate,
      };
      var resp = await DioConnection.post_('/employes/generatecode', data);
      var code = GenerateCodeResp.fromJson(resp);
      employeeCode = code.data.code;
      return true;
    } catch (e) {
      return false;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future generatePermision() async {
    try {
      if (loading) return;
      loading = true;
      notifyListeners();
      var data = {
        "per_codmop": motivoController.text,
        "per_codemp": employee.empCodigo,
        "per_codemp_reemplazo": employeeReplace.text,
        "per_fecha_inicio": permissionDateStart.text,
        "per_fecha_fin": permissionDateEnd.text,
        "per_comentario": comment.text
      };
      await DioConnection.post_('/permissions', data);

      permissionDateStart = TextEditingController();
      permissionDateEnd = TextEditingController();
      employeeReplace = TextEditingController();
      comment = TextEditingController();
      motivoController = TextEditingController();
      await getEmployeePermissions();
      return true;
    } catch (e) {
      return false;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  List<Motivo> listmotivos = [];
  Future getMotivos() async {
    try {
      if (loading) return;
      loading = true;
      // notifyListeners();
      var resp = await DioConnection.get_('/permissions/get/reasons');
      var code = RespMotivos.fromJson(resp);
      listmotivos = code.data;
      return true;
    } catch (e) {
      return false;
    } finally {
      loading = false;
    }
  }

  Future getPermissions() async {
    try {
      if (loading) return;
      loading = true;
      // notifyListeners();
      var resp = await DioConnection.get_('/permissions');
      var code = PermissionsResp.fromJson(resp);
      permissions = code.data;
      return true;
    } catch (e) {
      return false;
    } finally {
      loading = false;
    }
  }

  Future getCatalogs() async {
    try {
      if (loading) return;
      loading = true;
      // notifyListeners();
      var resp = await DioConnection.get_('/employes/get/catalogs');
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
      var resp = await DioConnection.get_('/employes/get/contracts/$idEmp');
      var code = ContractsEmpResponse.fromJson(resp);
      contractsEmp = code.data;
      notifyListeners();
      return true;
    } catch (e) {
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
      var resp =
          await DioConnection.get_('/employes/get/contracts/hours/$idCtr');
      var code = HoursCtrResponse.fromJson(resp);
      hoursCtr = code.data;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    } finally {
      loadingHours = false;
      notifyListeners();
    }
  }

  Future<List<Companyitem>> getCompanies() async {
    try {
      var resp = await DioConnection.get_('/companies');
      return CompaniesRes.fromJson(resp).data;
    } catch (e) {
      return [];
    }
  }

  Future getsCatalogs(String? uui) async {
    contractsEmp = [];
    hoursCtr = [];
    uuid = uui;
    await getCatalogs();
    if (uuid != null) {
      await getEmployee();
    } else {
      employeeCode = '000000';
      employeeName = TextEditingController(text: "");
      employeeSurname = TextEditingController(text: "");
      employeeBirthDate = TextEditingController(text: "");
      employeeGender = TextEditingController(text: "0");
      employeeLocation = TextEditingController(text: "");
      employeeCompany = TextEditingController(text: "");
      employeeContact = TextEditingController(text: "");
      employeeHours = TextEditingController(text: "");
      employeeContratacion = TextEditingController(text: "");
      employeeDateStart = TextEditingController(text: "");
      employeeDateEnd = TextEditingController(text: "");
    }
  }

  Future<bool> deleteEmployes(String id) async {
    try {
      await DioConnection.delete_('/employes/$id');
      NotificationsService.showSnackbarSuccess("Empleado Eliminada");
      await getEmployes();
      return true;
    } catch (e) {
      return false;
    } finally {
      notifyListeners();
    }
  }

  Future<bool> deleteEmployeePermission(String id) async {
    try {
      await DioConnection.delete_('/permissions/$id');
      NotificationsService.showSnackbarSuccess("Permiso Eliminada");
      await getPermissions();
      return true;
    } catch (e) {
      return false;
    } finally {
      notifyListeners();
    }
  }
}
