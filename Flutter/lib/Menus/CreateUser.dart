import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../Overlay/Overlay.dart';
import 'package:intl/intl.dart';
import '../Controller/PasswordField.dart';
import '../Controller/ZipCodeControler.dart';
import '../Controller/DataBaseConection.dart';
import 'package:flutter/services.dart';
import '../Controller/ChangePageOverlay.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({super.key});

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> with ErrorMessageOverlayMixin {
  //Variaveis para uso
  OverlayEntry? overlayErro;
  String dropdownValue = 'Masculino'; // Valor inicial

  //Controladores
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _healthNumberController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _doorNumberController = TextEditingController();
  final TextEditingController _floorNumberController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  String _selectedGender = 'Masculino';
  String _selectedAcountType = 'Paciente';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          // Fecha o teclado ao tocar fora do campo de texto
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
            backgroundColor: const Color(0xFFE8ECF9),
            body: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: SingleChildScrollView(
                  child: Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Gap(30),
                          Container(
                            width: 365,
                            height: 177,
                            decoration: const ShapeDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/Logo.png'),
                                fit: BoxFit.fill,
                              ),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(width: 0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(20),
                    const Text(
                      'Registo de Novo Utilizador',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            const Gap(10),
                            TextFormField(
                              controller: _firstNameController,
                              decoration: const InputDecoration(
                                  labelText: 'Primeiro Nome',
                                  border: OutlineInputBorder(),
                                  hintText: 'Insira o seu Primeiro Nome'),
                            ),
                            const Gap(10),
                            TextFormField(
                              controller: _lastNameController,
                              decoration: const InputDecoration(
                                  labelText: 'Ultimo Nome',
                                  border: OutlineInputBorder(),
                                  hintText: 'Insira o seu Ultimo Nome'),
                            ),
                            const Gap(10),
                            TextFormField(
                              controller: _healthNumberController,
                              keyboardType: TextInputType
                                  .number, // Define o teclado para tipo numérico
                              inputFormatters: [
                                FilteringTextInputFormatter
                                    .digitsOnly, // Permite apenas dígitos
                                LengthLimitingTextInputFormatter(
                                    9), // Limita a entrada a 9 dígitos
                              ],
                              decoration: const InputDecoration(
                                labelText: 'Número de Utente',
                                border: OutlineInputBorder(),
                                hintText: 'Insira o seu Número de Utente',
                              ),
                            ),
                            const Gap(10),
                            TextFormField(
                              controller: _birthDateController,
                              decoration: InputDecoration(
                                labelText: 'Data de Nascimento',
                                border: const OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.calendar_today),
                                  onPressed: _presentDatePicker,
                                ),
                              ),
                              readOnly: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Insira a sua Data de Nascimento';
                                }
                                return null;
                              },
                            ),
                            const Gap(10),
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                  labelText: 'Email',
                                  border: OutlineInputBorder(),
                                  hintText: 'Insira o seu Email'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 0, right: 0, top: 10, bottom: 0),
                              child: PasswordField(
                                  controller: _passwordController),
                            ),
                            const Gap(10),
                            DropdownButtonFormField<String>(
                              value: _selectedAcountType,
                              items: <String>[
                                'Médico',
                                'Paciente',
                                'Profissional de Saude',
                                'Familiar',
                                'Administrador'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedAcountType = newValue!;
                                });
                              },
                              decoration: InputDecoration(
                                labelText: 'Tipo de Conta',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 10),
                                // Removido suffixIcon: const Icon(Icons.arrow_drop_down),
                              ),
                            ),
                            const Gap(10),
                            DropdownButtonFormField<String>(
                              value: _selectedGender,
                              items: <String>[
                                'Masculino',
                                'Feminimo'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedGender = newValue!;
                                });
                              },
                              decoration: InputDecoration(
                                labelText: 'Gender',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 10),
                                // Removido suffixIcon: const Icon(Icons.arrow_drop_down),
                              ),
                            ),
                            const Gap(10),
                            TextFormField(
                              controller: _phoneNumberController,
                              keyboardType: TextInputType
                                  .phone, // Define o teclado para tipo telefone
                              decoration: const InputDecoration(
                                labelText: 'Telefone',
                                border: OutlineInputBorder(),
                                prefixText:
                                    '+351 ', // Define o texto de prefixo para o código de área
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter
                                    .digitsOnly, // Permite apenas dígitos
                                LengthLimitingTextInputFormatter(
                                    9), // Limita o comprimento (+351 123456789)
                              ],
                            ),
                            const Gap(10),
                            TextFormField(
                              controller: _addressController,
                              decoration: const InputDecoration(
                                  labelText: 'Morada',
                                  border: OutlineInputBorder(),
                                  hintText: 'Insira a sua Morada'),
                            ),
                            const Gap(10),
                            TextFormField(
                              controller: _doorNumberController,
                              keyboardType: TextInputType
                                  .number, // Define o teclado para tipo numérico
                              inputFormatters: [
                                FilteringTextInputFormatter
                                    .digitsOnly, // Permite apenas dígitos
                                LengthLimitingTextInputFormatter(
                                    8), // Limita a entrada a 9 dígitos
                              ],
                              decoration: const InputDecoration(
                                labelText: 'Número da Porta',
                                border: OutlineInputBorder(),
                                hintText: 'Insira o seu Número da Porta',
                              ),
                            ),
                            const Gap(10),
                            TextFormField(
                              controller: _floorNumberController,
                              keyboardType: TextInputType
                                  .number, // Define o teclado para tipo numérico
                              inputFormatters: [
                                FilteringTextInputFormatter
                                    .digitsOnly, // Permite apenas dígitos
                                LengthLimitingTextInputFormatter(
                                    8), // Limita a entrada a 9 dígitos
                              ],
                              decoration: const InputDecoration(
                                labelText: 'Número do andar',
                                border: OutlineInputBorder(),
                                hintText: 'Insira o Número do andar',
                              ),
                            ),
                            const Gap(10),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  PostalCodeFields(
                                      combinedPostalCodeController:
                                          _zipCodeController),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                var result = await createUser(
                                  email: _emailController.text.isNotEmpty
                                      ? _emailController.text
                                      : null,
                                  password: _passwordController.text.isNotEmpty
                                      ? _passwordController.text
                                      : null,
                                  healthNumber:
                                      _healthNumberController.text.isNotEmpty
                                          ? int.tryParse(
                                              _healthNumberController.text)
                                          : null,
                                  firstName:
                                      _firstNameController.text.isNotEmpty
                                          ? _firstNameController.text
                                          : null,
                                  lastName: _lastNameController.text.isNotEmpty
                                      ? _lastNameController.text
                                      : null,
                                  birthDate:
                                      _birthDateController.text.isNotEmpty
                                          ? _birthDateController.text
                                          : null,
                                  gender: _selectedGender,
                                  phoneNumber:
                                      _phoneNumberController.text.isNotEmpty
                                          ? _phoneNumberController.text
                                          : null,
                                  address: _addressController.text.isNotEmpty
                                      ? _addressController.text
                                      : null,
                                  doorNumber: _doorNumberController
                                          .text.isNotEmpty
                                      ? int.tryParse(_doorNumberController.text)
                                      : null,
                                  floorNumber:
                                      _floorNumberController.text.isNotEmpty
                                          ? int.tryParse(
                                              _floorNumberController.text)
                                          : null,
                                  zipCode: _zipCodeController.text.isNotEmpty
                                      ? _zipCodeController.text
                                      : null,
                                  role: _selectedAcountType,
                                );
                                if (result.success == true) {
                                  showErrorMessageOverlay(
                                      'Registo Efetuado com Sucesso', 2,
                                      action: ChangeToHome());
                                } else {
                                  showErrorMessageOverlay(
                                      result.errorMessage.toString(), 1);
                                }
                              },
                              child: const Text('Registar'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ))));
  }

  void _presentDatePicker() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      // Formatar a data para o formato aceito pelo PostgreSQL
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      // Atualizar o controlador com a data formatada
      _birthDateController.text = formattedDate;
    }
  }
}
