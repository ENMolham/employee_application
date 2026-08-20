import 'dart:async';

import 'package:employee_application/Core/constant/colors_constant.dart';
import 'package:employee_application/Core/error/network_exceptions.dart';
import 'package:employee_application/Core/extension/navigation_service.dart';
import 'package:employee_application/Core/extension/screen_size_extension.dart';
import 'package:employee_application/Features/User/transactions_page/Data/Model/transactions_page_entity.dart';
import 'package:employee_application/Features/User/transactions_page/cubit/transactions_page_cubit.dart';
import 'package:employee_application/Features/Widgets/custom_error.dart';
import 'package:employee_application/Features/Widgets/custom_text.dart';
import 'package:employee_application/Features/Widgets/transactions_page/custom_container_row_titel.dart';
import 'package:employee_application/Features/Widgets/transactions_page/custom_row_appbar.dart';
import 'package:employee_application/Features/Widgets/transactions_page/custom_row_container_value.dart';
import 'package:employee_application/Features/Widgets/transactions_page/custom_row_filter_search_transaction.dart';
import 'package:employee_application/Features/Widgets/filter/filter_options_data.dart';
import 'package:employee_application/app_router.dart';
import 'package:employee_application/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsPage extends StatefulWidget {
  final String nameUser;
  final String imageUserUrl;
  final String governmentEntityUser;
  const TransactionsPage({
    super.key,
    required this.nameUser,
    required this.imageUserUrl,
    required this.governmentEntityUser,
  });
  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  late final TransactionsPageCubit cubit;
  Timer? _searchDebounce;
  @override
  void initState() {
    super.initState();
    cubit = getIt<TransactionsPageCubit>();
    cubit.emittransactionsPage(
      searchController.text,
      selectedStatus == "الكل" ? null : selectedStatus,
      selectedDay == "الكل" ? null : selectedDay,
      selectedMonth == "الكل" ? null : selectedMonth,
      selectedYear == "الكل" ? null : selectedYear,
    );
  }

  @override
  void dispose() {
    cubit.close();
    searchController.dispose();
    _searchDebounce!.cancel();
    super.dispose();
  }

  final TextEditingController searchController = TextEditingController();
  String selectedStatus = FilterOptionsData.statusOptions.keys.first;
  String selectedDay = FilterOptionsData.dayOptions.keys.first;
  String selectedMonth = FilterOptionsData.monthOptions.keys.first;
  String selectedYear = FilterOptionsData.yearOptions().keys.first;

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomRowAppbar(
                    nameUser: widget.nameUser,
                    imageUserUrl: widget.imageUserUrl,
                    governmentEntityUser: widget.governmentEntityUser,
                  ),
                  CustomRowFilterSearchTransaction(
                    searchController: searchController,
                    selectedStatus: selectedStatus,
                    selectedDay: selectedDay,
                    selectedMonth: selectedMonth,
                    selectedYear: selectedYear,
                    onStatusChanged: (value) {
                      setState(() => selectedStatus = value);
                      context
                          .read<TransactionsPageCubit>()
                          .emittransactionsPage(
                            searchController.text,
                            selectedStatus == "الكل" ? null : selectedStatus,
                            selectedDay == "الكل" ? null : selectedDay,
                            selectedMonth == "الكل" ? null : selectedMonth,
                            selectedYear == "الكل" ? null : selectedYear,
                          );
                    },
                    onDayChanged: (value) {
                      setState(() => selectedDay = value);
                      context
                          .read<TransactionsPageCubit>()
                          .emittransactionsPage(
                            searchController.text,
                            selectedStatus == "الكل" ? null : selectedStatus,
                            selectedDay == "الكل" ? null : selectedDay,
                            selectedMonth == "الكل" ? null : selectedMonth,
                            selectedYear == "الكل" ? null : selectedYear,
                          );
                    },
                    onMonthChanged: (value) {
                      setState(() => selectedMonth = value);
                      context
                          .read<TransactionsPageCubit>()
                          .emittransactionsPage(
                            searchController.text,
                            selectedStatus == "الكل" ? null : selectedStatus,
                            selectedDay == "الكل" ? null : selectedDay,
                            selectedMonth == "الكل" ? null : selectedMonth,
                            selectedYear == "الكل" ? null : selectedYear,
                          );
                    },
                    onYearChanged: (value) {
                      setState(() => selectedYear = value);
                      context
                          .read<TransactionsPageCubit>()
                          .emittransactionsPage(
                            searchController.text,
                            selectedStatus == "الكل" ? null : selectedStatus,
                            selectedDay == "الكل" ? null : selectedDay,
                            selectedMonth == "الكل" ? null : selectedMonth,
                            selectedYear == "الكل" ? null : selectedYear,
                          );
                    },
                    onSearchChanged: (String value) {
                      _searchDebounce?.cancel();
                      _searchDebounce = Timer(
                        const Duration(milliseconds: 700),
                        () {
                          if (!mounted) return;
                          context
                              .read<TransactionsPageCubit>()
                              .emittransactionsPage(
                                searchController.text,
                                selectedStatus == "الكل"
                                    ? null
                                    : selectedStatus,
                                selectedDay == "الكل" ? null : selectedDay,
                                selectedMonth == "الكل" ? null : selectedMonth,
                                selectedYear == "الكل" ? null : selectedYear,
                              );
                        },
                      );
                    },
                  ),
                  CustomContainerRowTitel(
                    items: [
                      "رقم المعاملة",
                      "اسم المعاملة",
                      "اسم مقدم المعاملة",
                      "الرقم الوطني",
                      "تاريخ تقديم المعاملة",
                      "تاريخ&وقت الوصول",
                      "تاريخ الإنتهاء",
                      "حالة المعاملة",
                      "الإجراءات",
                    ],
                  ),
                  BlocBuilder<TransactionsPageCubit, TransactionsPageState>(
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
                                  .read<TransactionsPageCubit>()
                                  .emittransactionsPage(
                                    searchController.text,
                                    selectedStatus == "الكل"
                                        ? null
                                        : selectedStatus,
                                    selectedDay == "الكل" ? null : selectedDay,
                                    selectedMonth == "الكل"
                                        ? null
                                        : selectedMonth,
                                    selectedYear == "الكل"
                                        ? null
                                        : selectedYear,
                                  );
                            },
                            errorTextSize: context.fontSize(12),
                          );
                        },
                        initial: () => SizedBox(),
                        loading: () {
                          return SizedBox(
                            height: context.height(745),
                            child: Center(
                              child: CircularProgressIndicator(
                                strokeWidth: context.width(4),
                              ),
                            ),
                          );
                        },
                        success: (TransactionsPageEntity transactionsPageEntity) {
                          return transactionsPageEntity.data.isNotEmpty
                              ? Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: context.width(18),
                                      right: context.width(18),
                                      top: context.height(8),
                                    ),
                                    child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      itemCount:
                                          transactionsPageEntity.data.length,
                                      itemBuilder: (context, index) {
                                        final item =
                                            transactionsPageEntity.data[index];
                                        return CustomRowContainerValue(
                                          items: [
                                            RowItem(text: item.transactionID),
                                            RowItem(text: item.transactionName),
                                            RowItem(
                                              text: item
                                                  .nameUserSubmaitTransaction,
                                            ),
                                            RowItem(
                                              text: item.nationalId,
                                              type: 0,
                                            ),
                                            RowItem(
                                              text: item.dateSubmaitTransaction,
                                            ),
                                            RowItem(
                                              text: item.dateReceiveTransaction,
                                            ),
                                            RowItem(
                                              text:
                                                  item.dateEndTransaction ??
                                                  "---",
                                            ),
                                            RowItem(
                                              text:
                                                  item.statusTransaction ==
                                                      "1".trim()
                                                  ? "جديدة"
                                                  : item.statusTransaction ==
                                                        "2".trim()
                                                  ? "قيد الدراسة"
                                                  : item.statusTransaction ==
                                                        "3".trim()
                                                  ? "معلقة"
                                                  : item.statusTransaction ==
                                                        "4".trim()
                                                  ? "محولة"
                                                  : item.statusTransaction ==
                                                        "5".trim()
                                                  ? "محولة استثنائياً"
                                                  : item.statusTransaction ==
                                                        "6".trim()
                                                  ? "مرفوضة"
                                                  : "منتهية",
                                              colortext:
                                                  item.statusTransaction ==
                                                      "1".trim()
                                                  ? ColorConstant.blue
                                                  : item.statusTransaction ==
                                                        "2".trim()
                                                  ? ColorConstant.yellow
                                                  : item.statusTransaction ==
                                                        "3".trim()
                                                  ? ColorConstant.orange
                                                  : item.statusTransaction ==
                                                        "4".trim()
                                                  ? ColorConstant.green
                                                  : item.statusTransaction ==
                                                        "5".trim()
                                                  ? ColorConstant.bronze
                                                  : item.statusTransaction ==
                                                        "6".trim()
                                                  ? ColorConstant.red
                                                  : ColorConstant.khaki,
                                            ),
                                            RowItem(type: 1),
                                          ],
                                          onTap: () {
                                            context.pushTo(
                                              AppRoutes.transactionDetails(
                                                item.transactionID.toString(),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  height: context.height(760),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.file_copy,
                                          size: context.iconSize(42),
                                          color: ColorConstant.grey,
                                        ),
                                        CustomText(
                                          text: "لا يوجد معاملات مقدمة حالياً",
                                          color: ColorConstant.grey,
                                          size: context.fontSize(12),
                                          fontWeight: FontWeight.bold,
                                          paddingTop: context.height(8),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
