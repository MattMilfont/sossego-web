import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sossego_web/modules/home/states/actions/error_finish_report.dart';
import 'package:sossego_web/modules/home/states/actions/finish_report.dart';
import 'package:sossego_web/modules/home/states/atoms/finish_report_atom.dart';
import 'package:sossego_web/utils/app_colors.dart';

class FinishReportPage extends StatefulWidget {
  const FinishReportPage({super.key});

  @override
  State<FinishReportPage> createState() => _FinishReportPageState();
}

class _FinishReportPageState extends State<FinishReportPage>
    with HookStateMixin {
  final TextEditingController solutionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = useAtomState(finishReportState);
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          color: AppColors.primaryColor,
          child: IconButton(
            onPressed: () {
              Modular.to.popAndPushNamed('/home');
            },
            icon: Icon(Icons.arrow_back),
            color: AppColors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: SizedBox(
                width: 800,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        'Finalizar Denúncia',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 40),
                      TextFormField(
                        controller: solutionController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Descrição da Solução',
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 20),
                      state.when(
                        init: () => Column(),
                        selected: (s) {
                          return ElevatedButton(
                            onPressed: () {
                              if (solutionController.text.isNotEmpty) {
                                finishReport(
                                  s.selectedReport.reportId!,
                                  solutionController.text,
                                );
                              } else {
                                errorFinishReport(
                                  'Você deve indicar a solução encontrada!',
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              padding: EdgeInsets.symmetric(
                                horizontal: 70,
                                vertical: 15,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Finalizar',
                              style: TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          state.when(
            init: () => Column(),
            error:
                (e) => Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: Text(
                        e.erroMsg,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
          ),
        ],
      ),
    );
  }
}
