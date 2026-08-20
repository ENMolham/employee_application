import 'package:employee_application/Core/constant/colors_constant.dart';
import 'package:employee_application/Core/extension/screen_size_extension.dart';
import 'package:employee_application/Features/Widgets/filter/custom_container_filter.dart';
import 'package:employee_application/Features/Widgets/custom_text.dart';
import 'package:employee_application/Features/Widgets/custom_text_form_field.dart';
import 'package:employee_application/Features/Widgets/filter/filter_options_data.dart';
import 'package:flutter/material.dart';

class CustomRowFilterSearchTransaction extends StatelessWidget {
  final TextEditingController searchController;
  final String selectedStatus;
  final String selectedDay;
  final String selectedMonth;
  final String selectedYear;
  final ValueChanged<String> onStatusChanged;
  final ValueChanged<String> onDayChanged;
  final ValueChanged<String> onMonthChanged;
  final ValueChanged<String> onYearChanged;
  final ValueChanged<String> onSearchChanged;

  const CustomRowFilterSearchTransaction({
    super.key,
    required this.searchController,
    required this.selectedStatus,
    required this.selectedDay,
    required this.selectedMonth,
    required this.selectedYear,
    required this.onStatusChanged,
    required this.onDayChanged,
    required this.onMonthChanged,
    required this.onYearChanged,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: context.width(18),
        right: context.width(18),
        top: context.height(32),
      ),
      child: Row(
        children: [
          CustomText(
            text: "فلترة حسب :",
            color: ColorConstant.black,
            size: context.fontSize(18),
            fontWeight: FontWeight.w600,
            paddingBottom: context.height(8),
            paddingLeft: context.width(6),
          ),
          CustomContainerFilter(
            title: "الحالة",
            options: FilterOptionsData.statusOptions,
            initialValue: selectedStatus,
            onChanged: onStatusChanged,
          ),
          CustomContainerFilter(
            title: "اليوم",
            options: FilterOptionsData.dayOptions,
            initialValue: selectedDay,
            onChanged: onDayChanged,
          ),
          CustomContainerFilter(
            title: "الشهر",
            options: FilterOptionsData.monthOptions,
            initialValue: selectedMonth,
            onChanged: onMonthChanged,
          ),
          CustomContainerFilter(
            title: "السنة",
            options: FilterOptionsData.yearOptions(),
            initialValue: selectedYear,
            onChanged: onYearChanged,
          ),
          Spacer(),
          SizedBox(
            height: context.height(60),
            child: CustomTextFormField(
              widthFiled: context.width(500),
              radius: context.width(50),
              obscureText: false,
              keyboardType: TextInputType.text,
              readOnly: false,
              hintText: "البحث",
              fillColor: ColorConstant.greyLight,
              fontSizeInput: context.fontSize(16),
              colorBorder: ColorConstant.greyLight,
              controller: searchController,
              isDense: false,
              onChanged: onSearchChanged,
              prefix: ValueListenableBuilder<TextEditingValue>(
                valueListenable: searchController,
                builder: (context, value, _) {
                  final bool hasText = value.text.isNotEmpty;
                  return InkWell(
                    canRequestFocus: false,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    overlayColor: WidgetStatePropertyAll(Colors.transparent),
                    radius: context.width(50),
                    onTap: hasText
                        ? () {
                            searchController.clear();
                            onSearchChanged('');
                          }
                        : null,
                    child: hasText
                        ? Icon(
                            Icons.close_rounded,
                            size: context.iconSize(28),
                            color: ColorConstant.black,
                          )
                        : Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(3.1416),
                            child: Icon(
                              Icons.search_rounded,
                              size: context.iconSize(28),
                              color: ColorConstant.black,
                            ),
                          ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
