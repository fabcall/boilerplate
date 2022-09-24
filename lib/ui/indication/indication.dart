import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/constants/dimens.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class IndicationScreen extends StatefulWidget {
  @override
  _IndicationScreenState createState() => _IndicationScreenState();
}

class _IndicationScreenState extends State<IndicationScreen> {
  //text controllers:-----------------------------------------------------------
  TextEditingController _nameController = TextEditingController();
  TextEditingController _contactNameController = TextEditingController();
  TextEditingController _contactPhoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  //focus node:-----------------------------------------------------------------
  late FocusNode _nameNode;
  late FocusNode _contactNameNode;
  late FocusNode _phoneNode;
  late FocusNode _addressNode;

  @override
  void initState() {
    super.initState();
    _nameNode = FocusNode();
    _contactNameNode = FocusNode();
    _phoneNode = FocusNode();
    _addressNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: ModalScrollController.of(context),
      padding: EdgeInsets.only(
        top: 24,
        left: 24,
        right: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      shrinkWrap: true,
      children: [
        Center(
          child: Text(
            'Sugerir um estabelecimento',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        SizedBox(height: Dimens.dp24.h),
        SvgPicture.asset(Assets.beerIllustration, height: 188.0.h),
        SizedBox(height: Dimens.dp12.h),
        Center(
          child: Text(
            'E ganhe 6 meses de assinatura gratuita no Barpass quando ele se cadastrar',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.caption,
          ),
        ),
        SizedBox(height: Dimens.dp24.h),
        TextFormField(
          autofocus: true,
          autofillHints: [AutofillHints.name],
          controller: _nameController,
          decoration: InputDecoration(
            labelText: 'labels_establishment_name'.tr(),
            hintText: 'placeholders_establishment_name'.tr(),
          ),
          focusNode: _nameNode,
          keyboardType: TextInputType.name,
          onFieldSubmitted: (_) {
            FocusScope.of(context).requestFocus(_contactNameNode);
          },
          textInputAction: TextInputAction.next,
        ),
        SizedBox(height: Dimens.dp24.h),
        TextFormField(
          autofillHints: [AutofillHints.name],
          controller: _contactNameController,
          decoration: InputDecoration(
            labelText: 'labels_contact_name'.tr(),
            hintText: 'placeholders_contact_name'.tr(),
          ),
          focusNode: _contactNameNode,
          keyboardType: TextInputType.name,
          onFieldSubmitted: (_) {
            FocusScope.of(context).requestFocus(_phoneNode);
          },
          textInputAction: TextInputAction.next,
        ),
        SizedBox(height: Dimens.dp24.h),
        InternationalPhoneNumberInput(
          autofillHints: [AutofillHints.telephoneNumber],
          countries: ['BR', 'US'],
          focusNode: _phoneNode,
          inputDecoration: InputDecoration(
            labelText: 'labels_phone'.tr(),
            hintText: 'placeholders_phone'.tr(),
          ),
          keyboardAction: TextInputAction.next,
          keyboardType: TextInputType.phone,
          onFieldSubmitted: (_) {
            FocusScope.of(context).requestFocus(_addressNode);
          },
          onInputChanged: (PhoneNumber number) {},
          onInputValidated: (bool value) {},
          searchBoxDecoration: const InputDecoration(
            labelText: "Pesquisar país",
          ),
          selectorConfig: SelectorConfig(
            selectorType: PhoneInputSelectorType.DIALOG,
          ),
          textFieldController: _contactPhoneController,
        ),
        SizedBox(height: Dimens.dp24.h),
        TextFormField(
          autofillHints: [AutofillHints.fullStreetAddress],
          controller: _addressController,
          decoration: InputDecoration(
            labelText: 'labels_address'.tr(),
            hintText: 'placeholders_address'.tr(),
          ),
          focusNode: _addressNode,
          keyboardType: TextInputType.streetAddress,
          textInputAction: TextInputAction.done,
        ),
        SizedBox(height: Dimens.dp18.h),
        ElevatedButton(
          onPressed: () {},
          child: Text('Salvar indicação'),
        ),
        SizedBox(height: Dimens.dp24.h)
      ],
    );
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    _nameController.dispose();
    _contactNameController.dispose();
    _contactPhoneController.dispose();
    _addressController.dispose();
    _nameNode.dispose();
    _contactNameNode.dispose();
    _phoneNode.dispose();
    _addressNode.dispose();
    super.dispose();
  }
}
