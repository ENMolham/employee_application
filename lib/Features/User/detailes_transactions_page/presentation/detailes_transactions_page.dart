import 'package:employee_application/Core/constant/colors_constant.dart';
import 'package:employee_application/Core/error/network_exceptions.dart';
import 'package:employee_application/Core/extension/screen_size_extension.dart';
import 'package:employee_application/Features/User/detailes_transactions_page/Data/Model/detailes_transactions_page_entity.dart';
import 'package:employee_application/Features/User/detailes_transactions_page/cubit/detailes_transactions_page_cubit.dart';
import 'package:employee_application/Features/Widgets/custom_error.dart';
import 'package:employee_application/Features/Widgets/detailes_transactions_page/custom_container_attachments.dart';
import 'package:employee_application/Features/Widgets/detailes_transactions_page/custom_container_detailes.dart';
import 'package:employee_application/Features/Widgets/detailes_transactions_page/custom_container_logs_record.dart';
import 'package:employee_application/Features/Widgets/detailes_transactions_page/custom_container_replies.dart';
import 'package:employee_application/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailesTransactionsPage extends StatefulWidget {
  final String id;
  const DetailesTransactionsPage({super.key, required this.id});
  @override
  State<DetailesTransactionsPage> createState() =>
      _DetailesTransactionsPageState();
}

class _DetailesTransactionsPageState extends State<DetailesTransactionsPage> {
  late final DetailesTransactionsPageCubit cubit;
  @override
  void initState() {
    super.initState();
    cubit = getIt<DetailesTransactionsPageCubit>();
    cubit.emitdetailesTransactionsPage(widget.id);
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: ColorConstant.deepGreen,
            body: Container(
              width: context.width(1892),
              height: context.height(1045),
              margin: EdgeInsets.symmetric(
                horizontal: context.width(14),
                vertical: context.height(14),
              ),
              decoration: BoxDecoration(
                color: ColorConstant.white,
                borderRadius: BorderRadius.circular(context.width(24)),
              ),
              child:
                  BlocBuilder<
                    DetailesTransactionsPageCubit,
                    DetailesTransactionsPageState
                  >(
                    builder: (context, state) {
                      return state.when(
                        error: (NetworkExceptions networkExceptions) {
                          return CustomError(
                            width: context.screenWidth,
                            height: context.height(745),
                            iconsSize: context.iconSize(50),
                            error: NetworkExceptions.getErrorMessage(
                              networkExceptions,
                            ),
                            onPressed: () {
                              context
                                  .read<DetailesTransactionsPageCubit>()
                                  .emitdetailesTransactionsPage(widget.id);
                            },
                            errorTextSize: context.fontSize(12),
                          );
                        },
                        initial: () => SizedBox(),
                        loading: () {
                          return SizedBox(
                            child: Center(
                              child: CircularProgressIndicator(
                                strokeWidth: context.width(4),
                              ),
                            ),
                          );
                        },
                        success:
                            (
                              DetailesTransactionsPageEntity
                              detailesTransactionsPageEntity,
                            ) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomContainerDetailes(
                                    entity: detailesTransactionsPageEntity,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomContainerReplies(
                                        entity: detailesTransactionsPageEntity,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomContainerAttachments(
                                            entity:
                                                detailesTransactionsPageEntity,
                                          ),
                                          CustomContainerLogsRecord(
                                            entity:
                                                detailesTransactionsPageEntity,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                      );
                    },
                  ),
            ),
          );
        },
      ),
    );
  }
}
