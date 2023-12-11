import 'package:flutter/material.dart';
import 'package:marcacion_admin/src/common/services/services.dart';
import 'package:marcacion_admin/src/common/helpers/helpers.dart';
import 'package:marcacion_admin/src/modules/contract/model/index.dart';
import 'package:marcacion_admin/src/modules/employees/model/hours_ctr_mode.dart';
import 'package:marcacion_admin/src/routes/router.dart';

class ContractsProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  String? uuid;

  var contractName = TextEditingController();
  var contractsNumber = TextEditingController();
  var startDate = TextEditingController();
  var endDate = TextEditingController();
  var company = TextEditingController();
  var extraHours = TextEditingController(text: "0");
  bool isExtendable = false;
  var startDateExtendable = TextEditingController();
  var endDateExtendable = TextEditingController();

  bool isReady = false;
  bool loading = false;
  int total = 0;

  changeIsExtendable(valor) {
    isExtendable = valor;
    notifyListeners();
  }

  notifyListens() {
    notifyListeners();
  }

  updatePassword() async {
    var data = {
      "curren_password": "password.text",
    };

    try {
      loading = true;
      notifyListeners();
      final resp = await DioConexion.post_('/users/update/password', data);

      notifyListeners();
      if (resp['status'] != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // NotificationsService.showSnackbarError('Usuario / Password no válidos');
      return false;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  List<Contract> contracts = [];
  Future<bool> getContracts([load = false]) async {
    try {
      if (load) {
        loading = true;
        notifyListeners();
      }
      final resp = await DioConexion.get_('/contracts');
      final response = ContractsResponse.fromJson(resp);
      contracts = response.data;
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

  List<EmpSchedule> emplContract = [];
  Future<bool> getEmpContracts([load = false]) async {
    try {
      if (load) {
        loading = true;
        notifyListeners();
      }
      final resp = await DioConexion.get_(
        '/contracts/list/employes/${contract!.ctrCodigo}',
      );
      final response = EmployesScheduleResponse.fromJson(resp);
      emplContract = response.data;
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

  loadData(uui) async {
    uuid = uui;
    await getCompanies();
    if (uuid != null) await getRegister();
    if (uuid == null) await cleanForm();
  }

  agregarItem(codeEmp) async {
    try {
      await DioConexion.post_(
        '/contracts/employe/${contract!.ctrCodigo}/$codeEmp',
        {},
      );
      await getEmpContracts();
    } catch (e) {
      return;
    } finally {
      employes = [];
      query = '';
      notifyListeners();
    }
  }

  Future<bool> deleteEmploye(String id) async {
    try {
      await DioConexion.delete_('/contracts/employe/$id');
      NotificationsService.showSnackbarSuccess("Empleado Eliminado");
      await getEmpContracts();
      return true;
    } catch (e) {
      return false;
    } finally {
      notifyListeners();
    }
  }

  loadToSchedules(uui) async {
    uuid = uui;
    if (uuid == null) NavigationService.replaceTo(Flurorouter.contractsRoute);
    await getRegister();
    if (contract == null) {
      NavigationService.replaceTo(Flurorouter.contractsRoute);
    }
    await getDays();
  }

  loadToEmployes(uui) async {
    uuid = uui;
    if (uuid == null) NavigationService.replaceTo(Flurorouter.contractsRoute);
    await getRegister();
    await getEmpContracts();
    await getHoursContracts(uuid ?? '');
    employes = [];
    if (contract == null) {
      NavigationService.replaceTo(Flurorouter.contractsRoute);
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

  String query = '';

  List<EmployesContract> employes = [];
  Future<bool> getEmployes([load = false]) async {
    if (query.length < 3) {
      employes = [];
      notifyListeners();
      return false;
    }
    try {
      if (load) {
        loading = true;
        notifyListeners();
      }
      final resp = await DioConexion.get_(
        '/contracts/get/employes/${contract!.ctrCodigo}',
        {
          "page": 1,
          "quantity": 10,
          "query": query,
          "company": company,
        },
      );
      final response = EmployesContractResponse.fromJson(resp);
      employes = response.data;
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

  List<Day> days = [];
  List<Schedule> schedule = [];
  Future<bool> getDays() async {
    try {
      final resp = await DioConexion.get_('/contracts/get/days');
      final response = DaysResponse.fromJson(resp);
      days = response.data;
      schedule = [];
      for (var day in days) {
        schedule.add(Schedule(
          day: day,
          entrada1: TextEditingController(),
          salida1: TextEditingController(),
          entrada2: TextEditingController(),
          salida2: TextEditingController(),
        ));
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> cleanForm() async {
    try {
      contractName.text = '';
      contractsNumber.text = '';
      startDate.text = '';
      endDate.text = '';
      company.text = '';
      extraHours.text = '0';
      isExtendable = false;
      startDateExtendable.text = '';
      endDateExtendable.text = '';
      return true;
    } catch (e) {
      return false;
    } finally {
      notifyListeners();
    }
  }

  Contract? contract;
  Future<bool> getRegister() async {
    try {
      final resp = await DioConexion.get_('/contracts/$uuid');
      final response = Contract.fromJson(resp['data']);
      contract = response;
      contractName.text = response.ctrNombre;
      contractsNumber.text = response.ctrNumContrato;
      startDate.text = response.ctrFechaInicio;
      endDate.text = response.ctrFechaFin;
      company.text = response.marEprEmpresas.eprCodigo;
      extraHours.text = response.ctrHorasExtras.toString();
      isExtendable = response.ctrFechaFinpro.isNotEmpty &&
          response.ctrFechaFinpro.isNotEmpty;
      startDateExtendable.text = response.ctrFechaFinpro;
      endDateExtendable.text = response.ctrFechaFinpro;
      return true;
    } catch (e) {
      return false;
    }
  }

  List<ContractCompanies> companies = [];
  Future<bool> getCompanies() async {
    try {
      final resp = await DioConexion.get_('/contracts/get/companies');
      final response = CompaniesResponse.fromJson(resp);
      companies = response.data;
      return true;
    } catch (e) {
      return false;
    } finally {
      notifyListeners();
    }
  }

  Future saveContract() async {
    try {
      if (loading) return;
      loading = true;
      notifyListeners();

      var horasExtras = int.tryParse(extraHours.text) ?? 0;
      var data = {
        "ctr_nombre": contractName.text,
        "ctr_numero_contrato": contractsNumber.text,
        "horas_extras": horasExtras,
        "ctr_fecha_inicio": startDate.text,
        "ctr_fecha_fin": endDate.text,
        "ctr_fecha_inicio_pro": isExtendable ? startDateExtendable.text : null,
        "ctr_fecha_fin_pro": isExtendable ? endDateExtendable.text : null,
        "marca_ctr_empre": company.text,
      };
      if (uuid != null) {
        await DioConexion.put_('/contracts/$uuid', data);
        NotificationsService.showSnackbarSuccess("Contrato Actualizado");
        NavigationService.goBack();
      } else {
        var respo = await DioConexion.post_('/contracts', data);
        NotificationsService.showSnackbarSuccess("Contrato creado");
        NavigationService.navigateTo(
          "/contracts/schedules/${respo["data"]["ctr_codigo"]}",
        );
      }
      await getContracts();
      return true;
    } catch (e) {
      return false;
    } finally {
      loading = false;
      // limpiar();
    }
  }

  Future saveScheduleContract() async {
    try {
      if (loading) return;
      loading = true;
      notifyListeners();
      var data = RequestSchedule(list: schedule).toJson();
      await DioConexion.post_(
        '/contracts/schedule/${contract?.ctrCodigo}',
        data,
      );
      NavigationService.navigateTo(
        "/contracts/employes/${contract?.ctrCodigo}",
      );
      return true;
    } catch (e) {
      return false;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  updateScheduleEmpCtr(asiCode, codHor) async {
    try {
      await DioConexion.put_(
        '/contracts/schedule/$asiCode/$codHor',
        {},
      );
    } catch (e) {
      return;
    } finally {
      return;
    }
  }

  Future<bool> deleteContracts(String id) async {
    try {
      await DioConexion.delete_('/contracts/$id');
      NotificationsService.showSnackbarSuccess("Contrato Eliminado");
      await getContracts();
      return true;
    } catch (e) {
      return false;
    } finally {
      notifyListeners();
    }
  }
}
