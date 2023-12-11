import 'package:flutter/material.dart';
import 'package:marcacion_admin/src/modules/auth/viewmodel/provider_auth.dart';
import 'package:marcacion_admin/src/common/const/const.dart';
import 'package:marcacion_admin/src/common/helpers/helpers.dart';
import 'package:marcacion_admin/src/common/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getTheme(context).primary,
      body: const Stack(
        children: [
          _BackgroundLoginWidget(),
          _FormLoginWidget(),
        ],
      ),
    );
  }
}

class _FormLoginWidget extends StatefulWidget {
  const _FormLoginWidget();

  @override
  State<_FormLoginWidget> createState() => _FormLoginWidgetState();
}

class _FormLoginWidgetState extends State<_FormLoginWidget> {
  final _formKey = GlobalKey<FormState>();
  final userCode = TextEditingController();
  final password = TextEditingController();

  bool isReady = false;

  bool loading = false;

  validarInput() {
    isReady = userCode.text.isNotEmpty && password.text.isNotEmpty;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final providerAuth = Provider.of<AuthProvider>(context, listen: false);
    return Center(
      child: SizedBox(
        width: 360,
        height: 700,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                ),
                child: Image.asset(
                  "assets/images/icon_letter.png",
                  width: 200,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                "Sistema de marcación tercerizado",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontFamily: museoSans,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Ingresa tus datos",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                  fontSize: 22,
                  fontFamily: museoSans,
                ),
              ),
              const SizedBox(height: 20),
              TextFormFieldCustomWidget(
                autofocus: true,
                onFieldSubmitted: (_) => onFormSubmit(providerAuth),
                cursorColor: Colors.white,
                label: "Código de empleado",
                controller: userCode,
                keyboardType: TextInputType.number,
                onChange: (valor) {
                  validarInput();
                },
              ),
              const SizedBox(height: 30),
              TextFormFieldCustomWidget(
                onFieldSubmitted: (_) => onFormSubmit(providerAuth),
                cursorColor: Colors.white,
                label: "Contraseña",
                controller: password,
                isPassword: true,
                onChange: (valor) {
                  validarInput();
                },
              ),
              const SizedBox(height: 25),
              _BtnWidget(
                title: 'Ingresar',
                disable: !isReady,
                loading: loading,
                onPress: () => onFormSubmit(providerAuth),
              ),
              const SizedBox(height: 40),
              const _InfoFooterWidget()
            ],
          ),
        ),
      ),
    );
  }

  void onFormSubmit(providerAuth) async {
    if (_formKey.currentState?.validate() ?? false) {
      if (loading) return;
      loading = true;
      setState(() {});
      await providerAuth.login(userCode.text, password.text);
      loading = false;
      setState(() {});
    }
  }
}

class _InfoFooterWidget extends StatelessWidget {
  const _InfoFooterWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: infoBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Row(
        children: [
          SizedBox(width: 10),
          Icon(
            Icons.info_outline,
            color: Colors.white,
          ),
          SizedBox(width: 10),
          Text(
            "Si olvidaste tu contraseña, por favor,\ncomunícate al área de Sistemas\nal número  0000-0000",
            style: TextStyle(
              fontWeight: FontWeight.w100,
              color: Colors.white,
              fontFamily: museoSans,
            ),
          )
        ],
      ),
    );
  }
}

class _BtnWidget extends StatelessWidget {
  const _BtnWidget({
    required this.title,
    required this.onPress,
    this.disable = false,
    this.loading = false,
  });
  final bool disable;
  final bool loading;

  final String title;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: disable ? primario.withOpacity(0.6) : activeBtn,
          padding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        onPressed: () {
          onPress();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!loading)
              Text(
                title,
                style: TextStyle(
                  color: disable ? primarioText.withOpacity(0.5) : primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            if (loading) ...[
              const SizedBox(width: 10),
              const SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator(),
              )
            ]
          ],
        ),
      ),
    );
  }
}

class _BackgroundLoginWidget extends StatelessWidget {
  const _BackgroundLoginWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset("assets/images/background_login.png"),
    );
  }
}
