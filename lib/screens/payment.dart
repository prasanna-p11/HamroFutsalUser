import 'package:flutter/material.dart';
import 'package:hamro_futsal/utils/custom_snackbar.dart';
import 'package:hamro_futsal/widget/custom_button.dart';
import 'package:hamro_futsal/widget/custom_textform.dart';
import 'package:khalti/khalti.dart';

class KhaltiPayment extends StatefulWidget {
  const KhaltiPayment({Key? key, required this.onPaid}) : super(key: key);
  final Function onPaid;

  @override
  State<KhaltiPayment> createState() => _KhaltiPaymentState();
}

class _KhaltiPaymentState extends State<KhaltiPayment> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Payment'),
            iconTheme: const IconThemeData(color: Colors.black)),
        body: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: const BoxDecoration(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'Pay With Khalti',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 24,
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w600,
                  ),
                  softWrap: false,
                ),
                const SizedBox(height: 20),
                const Image(image: NetworkImage('https://seeklogo.com/images/K/khalti-logo-F0B049E67E-seeklogo.com.png'), height: 100, width: 200,),
                const SizedBox(height: 20),
                CustomTextFormField(
                  prefixIcon: const Icon(Icons.phone),
                  hint: 'Phone Number',
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  prefixIcon: const Icon(Icons.key),
                  hint: 'Pin Code',
                  obscureText: true,
                  controller: pinCodeController,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                CustomButton(
                    title: "Make Payment",
                    onPressed: () async {
                      if (phoneController.text.isEmpty) {
                        customSnackbar(
                            'Error', 'Phone number is required', 'error');
                        return;
                      }
                      if (pinCodeController.text.isEmpty) {
                        customSnackbar('Error', 'Pin code is required', 'error');
                        return;
                      }
                      final initiationModel =
                          await Khalti.service.initiatePayment(
                        request: PaymentInitiationRequestModel(
                          amount: 1000,
                          mobile: phoneController.text,
                          productIdentity: 'pID',
                          productName: 'Product Name',
                          transactionPin: pinCodeController.text,
                          productUrl: '',
                          additionalData: {},
                        ),
                      );
          
                      final otp = await showDialog(
                          context: (context),
                          barrierDismissible: false,
                          builder: (context) {
                            String? _opt;
                            return AlertDialog(
                              title: const Text('Enter OTP'),
                              content: TextField(
                                onChanged: (v) => _opt = v,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  label: Text('OTP'),
                                ),
                              ),
                              actions: [
                                SimpleDialogOption(
                                    child: const Text('Submit'),
                                    onPressed: () {
                                      Navigator.pop(context, _opt);
                                    })
                              ],
                            );
                          });
          
                      if (otp != null) {
                        try {
                          final model = await Khalti.service.confirmPayment(
                            request: PaymentConfirmationRequestModel(
                              confirmationCode: otp,
                              token: initiationModel.token,
                              transactionPin: pinCodeController.text,
                            ),
                          );
                          widget.onPaid();
          
                          Navigator.pop(context, model.token);
                        } catch (e) {
                          ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                            SnackBar(content: Text(e.toString())),
                          );
                        }
                      }
                    }),
              ],
            ),
          ),
        ));
  }
}
