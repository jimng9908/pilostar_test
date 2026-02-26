import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/omboarding/business_omboarding.dart';
import 'package:rockstardata_apk/app/features/shared/shared.dart';
import 'package:rockstardata_apk/app/injection.dart';

class SourcesSelection extends StatelessWidget {
  const SourcesSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final sources = [
      DataSource(
        id: 1,
        name: 'LastApp',
        description: 'Sistema de punto de venta',
        icon: FontAwesomeIcons.shop,
        iconColor: const Color(0xFF673AB7),
        isRequired: true,
      ),
      DataSource(
        id: 3,
        name: 'Holded',
        description: 'Software de contabilidad',
        icon: FontAwesomeIcons.fileLines,
        iconColor: Colors.deepPurple,
        isRequired: true,
      ),
      DataSource(
        id: 2,
        name: 'CoverManager',
        description: 'Gestión de reservas',
        icon: FontAwesomeIcons.calendarCheck,
        iconColor: Colors.pink,
      ),
      DataSource(
        id: 4,
        name: 'Skello',
        description: 'Gestión de recursos laborales',
        icon: FontAwesomeIcons.users,
        iconColor: Colors.teal,
      ),
      DataSource(
        id: 5,
        name: 'Agora',
        description: 'Analytics y métricas avanzadas',
        icon: FontAwesomeIcons.chartLine,
        iconColor: Colors.teal.shade700,
      ),
      DataSource(
        id: 6,
        name: 'TspoonLab',
        description: 'Gestión de inventario y recetas',
        icon: FontAwesomeIcons.utensils,
        iconColor: Colors.pinkAccent,
      ),
    ];

    return BlocBuilder<BusinessOnboardingBloc, BusinessOnboardingState>(
      builder: (context, state) {
        // Safe access to state properties
        final List<DataSource> connectedList =
            (state is BusinessOnboardingLoaded) ? state.connectedSources : [];

        return Column(
          children: [
            Expanded(
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  overscroll: false,
                ),
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Conecta tus fuentes de datos',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF1A171C),
                          fontSize: 22,
                          fontFamily: 'SF Pro',
                          fontWeight: FontWeight.w500,
                          height: 1.30,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Conecta tus sistemas para obtener datos en tiempo real',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF4A5565),
                          fontSize: 16,
                          fontFamily: 'SF Pro',
                          fontWeight: FontWeight.w400,
                          height: 1.50,
                        ),
                      ),
                      const SizedBox(height: 24),
                      _buildRequirementsCard(context, connectedList),
                      const SizedBox(height: 24),
                      ...sources.map(
                          (source) => _buildSourceCard(context, source, state)),
                    ],
                  ),
                ),
              ),
            ),
            // Bottom buttons area
            SafeArea(
              bottom: true,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomButton(
                      text: 'Siguiente',
                      textColor: Colors.white,
                      onPressed: sources.where((s) => s.isRequired).every(
                              (req) => connectedList
                                  .any((conn) => conn.id == req.id))
                          ? () {
                              context
                                  .read<BusinessOnboardingBloc>()
                                  .add(ConfirmSources());
                            }
                          : null,
                    ),
                    const SizedBox(height: 8),
                    CustomButton(
                      text: 'Atrás',
                      textColor: AppColor.purple,
                      backgroundColor: AppColor.greyDark.withValues(alpha: 0.3),
                      onPressed: () => context
                          .read<BusinessOnboardingBloc>()
                          .add(BackToPrevious()),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildRequirementsCard(
      BuildContext context, List<DataSource> connectedSources) {
    bool isConnected(String nameChunk) {
      return connectedSources
          .any((s) => s.name.toLowerCase().contains(nameChunk.toLowerCase()));
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.primaryLight.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor.primary.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '📋 Requisitos para continuar',
            style: TextStyle(
              color: AppColor.primary /* Brand-Primary-800 */,
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              height: 1.50,
            ),
          ),
          _buildRequirementItem(
              "Sistema POS - LastApp (Obligatorio)", isConnected('LastApp')),
          _buildRequirementItem(
              "Reservas - Holded (Obligatorio)", isConnected('Holded')),
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Divider(
                color: AppColor.primary.withValues(alpha: 0.4), thickness: 0.5),
          ),
          Text(
            '💡 CoverManager y Skello son opcionales pero recomendados para métricas completas',
            style: TextStyle(
              color: const Color(0xFF540BA8) /* Brand-Primary-800 */,
              fontSize: 10.0.sp(context),
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              height: 1.50,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequirementItem(String text, bool completed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(
            completed ? Icons.check : Icons.radio_button_unchecked,
            size: 16,
            color: completed
                ? Colors.green
                : const Color(0xFF540BA8).withValues(alpha: 0.4),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: completed
                    ? const Color(0xFF2E7D32)
                    : const Color(0xFF540BA8),
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSourceCard(
      BuildContext context, DataSource source, BusinessOnboardingState state) {
    final bool isConnected = (state is BusinessOnboardingLoaded) &&
        state.connectedSources.any((s) => s.id == source.id);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: isConnected
                ? AppColor.primaryLight.withValues(alpha: 0.3)
                : Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 4),
            child: Icon(source.icon, size: 28, color: source.iconColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      source.name,
                      style: TextStyle(
                        color: Colors.black /* Brand-Black */,
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 1.50,
                      ),
                    ),
                    if (source.isRequired) ...[
                      const SizedBox(width: 8),
                      _buildBadge("Requerido", Colors.red),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  source.description,
                  style: TextStyle(
                    color: const Color(0xFF666666) /* Brand-Greyscale-600 */,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
                const SizedBox(height: 16),
                if (!isConnected)
                  SizedBox(
                    height: 36,
                    child: ElevatedButton(
                      onPressed: () =>
                          _showConnectSheet(context, source.name, source.id),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF540BA8),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18)),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                      child: const Text(
                        "Conectar",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                else
                  Row(
                    children: [
                      const Icon(Icons.check,
                          color: Color(0xFF388E3C), size: 18),
                      const SizedBox(width: 4),
                      const Text(
                        'Conectado',
                        style: TextStyle(
                          color: Color(0xFF2D9E68) /* Status-Green-600 */,
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          height: 1.50,
                        ),
                      ),
                      const SizedBox(width: 16),
                      GestureDetector(
                        onTap: () {
                          context
                              .read<BusinessOnboardingBloc>()
                              .add(DisconnectSources(sourceId: source.id));
                        },
                        child: const Text(
                          'Desconectar',
                          style: TextStyle(
                            color: Color(0xFFC93551) /* Status-Green-600 */,
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 1.50,
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(4)),
      child: Text(
        text,
        style: TextStyle(
          color: const Color(0xFFC93551) /* Status-Red-500 */,
          fontSize: 12,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
          height: 1.50,
        ),
      ),
    );
  }

  void _showConnectSheet(
      BuildContext context, String sourceName, int sourceId) {
    final TextEditingController apiKeyController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final bloc = context.read<BusinessOnboardingBloc>();

    // Dynamic strings based on requirement
    String credentialLabel = "Token";
    String secundaryLabel = "";
    String fieldHint = "Token";
    String secundaryFieldHint = "";
    String exampleValue = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...";
    String exampleDesc =
        "Tu ${fieldHint.toLowerCase()} debería tener un formato similar a:";

    if (sourceId == 3 || sourceId == 5) {
      credentialLabel = "API Key";
      fieldHint = "API Key";
      exampleValue = "sk_live_1234567890abcdefghijklmnopqrst...";
      exampleDesc =
          "Tu ${fieldHint.toLowerCase()} debería tener un formato similar a:";
    } else if (sourceId == 4) {
      credentialLabel = "X-API-Key";
      fieldHint = "X-API-Key";
      exampleValue = "sk_skello_1234567890abcdefghijk...";
      exampleDesc =
          "Tu ${fieldHint.toLowerCase()} debería tener un formato similar a:";
    } else if (sourceId == 6) {
      credentialLabel = "Correo electrónico";
      secundaryLabel = "Contraseña";
      fieldHint = "Correo electrónico";
      secundaryFieldHint = "Contraseña";
    }

    final isLastApp = sourceId == 1;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (modalContext) => BlocProvider.value(
        value: bloc,
        child: BlocBuilder<BusinessOnboardingBloc, BusinessOnboardingState>(
          builder: (context, state) {
            return SafeArea(
              bottom: true,
              child: Container(
                  constraints: BoxConstraints(
                    maxHeight: isLastApp
                        ? MediaQuery.of(context).size.height
                        : MediaQuery.of(context).size.height * 0.8,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  padding: isLastApp
                      ? EdgeInsets.zero
                      : const EdgeInsets.only(
                          left: 24,
                          right: 24,
                          top: 32,
                          bottom: 16,
                        ),
                  child: !isLastApp
                      ? Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Conectar $sourceName",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Ingresa tus credenciales para conectar esta integración",
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFF675C70),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Expanded(
                              child: Form(
                                key: formKey,
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (sourceId != 6)
                                        Column(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(16),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                    color: const Color(
                                                        0xFFF2F2F2)),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(Icons.lock_outline,
                                                          size: 18,
                                                          color: Colors
                                                              .grey.shade700),
                                                      const SizedBox(width: 8),
                                                      const Text(
                                                        "Formato de Ejemplo",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 26),
                                                    child: Text(
                                                      exampleDesc,
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xFF6B6B6B),
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 12),
                                                  Container(
                                                    width: double.infinity,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 12,
                                                        vertical: 10),
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xFFF4F4F4),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: Text(
                                                      exampleValue,
                                                      style: const TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 24),
                                          ],
                                        ),
                                      Text(
                                        credentialLabel,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      sourceId != 6
                                          ? _buildTextField(
                                              controller: apiKeyController,
                                              hint: fieldHint,
                                              keyboardType: TextInputType.text,
                                              validator: (value) {
                                                if (sourceId == 3 ||
                                                    sourceId == 4 ||
                                                    sourceId == 5) {
                                                  return FormValidator
                                                      .validateApiKey(value);
                                                }
                                                return FormValidator
                                                    .validateBearerToken(value);
                                              },
                                            )
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                _buildTextField(
                                                  controller: emailController,
                                                  hint: fieldHint,
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  validator: FormValidator
                                                      .validateEmail,
                                                ),
                                                if (secundaryLabel
                                                    .isNotEmpty) ...[
                                                  Text(
                                                    secundaryLabel,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                ],
                                                _buildTextField(
                                                  controller:
                                                      passwordController,
                                                  hint: secundaryFieldHint
                                                          .isNotEmpty
                                                      ? secundaryFieldHint
                                                      : fieldHint,
                                                  obscureText: true,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  validator: FormValidator
                                                      .validatePassword,
                                                ),
                                              ],
                                            ),
                                      const SizedBox(height: 16),
                                      // Help Card
                                      if (sourceId != 6)
                                        Container(
                                          padding: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFF2F2F2)
                                                .withValues(alpha: 0.5),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                                color: const Color(0xFFE0E0E0)),
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Icon(Icons.info_outline,
                                                  size: 20),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      "¿Dónde encuentro mi clave API?",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 8),
                                                    Text(
                                                      "- Inicia sesión en tu cuenta de $sourceName\n"
                                                      "- Ve a Configuración o Ajustes\n"
                                                      "- Busca la sección ${sourceId == 2 ? 'Token de Acceso' : 'API' ' o Integraciones'}\n"
                                                      "- Copia tu ${sourceId == 3 || sourceId == 5 ? 'clave API o API Key' : sourceId == 4 ? 'clave X-API-Key' : 'token de acceso'}",
                                                      style: const TextStyle(
                                                        fontSize: 13,
                                                        color:
                                                            Color(0xFF675C70),
                                                        height: 1.5,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      else
                                        SizedBox.shrink(),
                                      const SizedBox(height: 16),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SafeArea(
                              bottom: false,
                              child: Column(
                                children: [
                                  CustomButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        if (sourceId != 6) {
                                          bloc.add(ConnectSources(
                                            apiKey: apiKeyController.text,
                                            sourceName: sourceName,
                                            sourceId: sourceId,
                                          ));
                                          Navigator.pop(modalContext);
                                        } else {
                                          bloc.add(ConnectSources(
                                            email: emailController.text,
                                            password: passwordController.text,
                                            sourceName: sourceName,
                                            sourceId: sourceId,
                                          ));
                                          Navigator.pop(modalContext);
                                        }
                                      }
                                    },
                                    text: "Conectar $sourceName",
                                    textColor: AppColor.white,
                                  ),
                                  const SizedBox(height: 8),
                                  // Cancel Button
                                  CustomButton(
                                    onPressed: () =>
                                        Navigator.pop(modalContext),
                                    text: "Cancelar",
                                    textColor: AppColor.purple,
                                    backgroundColor: AppColor.greyDark
                                        .withValues(alpha: 0.3),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      : BlocProvider<WebViewBloc>(
                          create: (context) => sl<WebViewBloc>()
                            ..add(InitWebView(
                                'https://admin.last.app/integrations')),
                          child: BlocListener<WebViewBloc, WebViewState>(
                            listenWhen: (previous, current) =>
                                previous != current,
                            listener: (context, webViewState) {
                              debugPrint(
                                  'SourcesSelection: webViewState -> $webViewState');
                              if (webViewState is WebViewSuccess) {
                                debugPrint(
                                    'SourcesSelection: WebViewSuccess detected! Token: ${webViewState.token}');
                                if (webViewState.locationName != null) {
                                  debugPrint(
                                      'SourcesSelection: Marketplace Location: ${webViewState.locationName}');
                                }
                                Navigator.of(modalContext).pop();
                                bloc.add(ConnectSources(
                                  apiKey: webViewState.token,
                                  sourceName: 'LastApp',
                                  sourceId: 1,
                                  lastAppLocationId: webViewState.locationId,
                                  lastAppLocationName:
                                      webViewState.locationName,
                                  lastAppCallbackUrl: webViewState.callbackUrl,
                                ));
                              }
                            },
                            child: LastAppWebView(),
                          ),
                        )),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hint,
    required TextEditingController controller,
    required String? Function(String?) validator,
    required TextInputType keyboardType,
    bool obscureText = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFFCDC7D1)),
          filled: true,
          fillColor: const Color(0xFFF2F2F2).withValues(alpha: 0.5),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFCDC7D1), width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFCDC7D1), width: 1),
          ),
        ),
        validator: validator,
      ),
    );
  }
}
