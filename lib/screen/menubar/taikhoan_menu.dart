// import 'dart:js_util';

import 'package:flutter/material.dart';

import 'package:flutter_login/custom/custom_button_submit.dart';
import 'package:flutter_login/custom/custom_dropdow.dart';
import 'package:flutter_login/custom/custom_text_field.dart';
import 'package:flutter_login/custom/style.dart';
import 'package:flutter_login/custom/validate.dart';
import 'package:flutter_login/models/profile.dart';
import 'package:flutter_login/providers/diachi_viewmodel.dart';
import 'package:flutter_login/providers/taikhoan_viewmodel.dart';
import 'package:flutter_login/repositoties/user_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

// ignore: must_be_immutable
class TaiKhoanMenu extends StatelessWidget {
  TaiKhoanMenu({super.key});

  Future<void> init(DiachiViewModel dcmodel) async {
    Profile profile = Profile();
    if (dcmodel.listCity.isEmpty ||
        dcmodel.CurCityID != profile.user.provinceid ||
        dcmodel.CurDistrictID != profile.user.districtid ||
        dcmodel.CurWardID != profile.user.wardid) {
      await dcmodel.initialize(profile.user.provinceid, profile.user.districtid,
          profile.user.wardid);
    }
  }

  bool _isEnabled = false;
  XFile? image;

  @override
  Widget build(BuildContext context) {
    final profile = Profile();
    final size = MediaQuery.of(context).size;
    final tkmodel = Provider.of<TaiKhoanViewModel>(context);
    final dcmodel = Provider.of<DiachiViewModel>(context);
    final user = UserRepository();
    Future.delayed(Duration.zero, () => init(dcmodel));
    if (profile.user.phone.isEmpty ||
        profile.user.birthday.isEmpty ||
        profile.user.provinceid == 0 ||
        profile.user.districtid == 0 ||
        profile.user.wardid == 0 ||
        profile.user.address.isEmpty) {
      _isEnabled = false;
    } else {
      _isEnabled = true;
    }
    void showAlertDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            title: Text(
              'Thông báo',
              style: TextStyle(
                color: Colors.pink,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              'Cập nhật thành công',
              style: StyleGlobal.h3,
            ),
          );
        },
      );
    }

    return Column(
      children: [
        Container(
          width: double.infinity,
          height: size.height * 0.25,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 38, 39, 138),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          profile.student.diem.toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: ClipOval(
                              child: tkmodel.updateAvatar == 1
                                  ? Image.network(
                                      image!.path,
                                      fit: BoxFit.cover,
                                      height: 100,
                                      width: 100,
                                    )
                                  : Image.network(
                                      profile.user.avatar,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: InkWell(
                                  onTap: () async {
                                    final ImagePicker picker = ImagePicker();
                                    image = await picker.pickImage(
                                        source: ImageSource.gallery);

                                    // await UserRepository()
                                    //     .uploadAvatar(image!);
                                    // tkmodel.uploadAvatar(image!);

                                    tkmodel.setUpdateAvatar();
                                  },
                                  child: const Icon(
                                    Icons.camera,
                                    size: 30,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profile.user.firstName,
                      style: const TextStyle(
                        color: Colors.yellow,
                        fontSize: 24,
                        fontWeight: StyleGlobal.fontWeight,
                      ),
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 100,
                          child: Text(
                            'Mssv : ',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 18,
                              fontWeight: StyleGlobal.fontWeight,
                            ),
                          ),
                        ),
                        Text(
                          profile.student.mssv,
                          style: const TextStyle(
                            color: Colors.yellow,
                            fontSize: 18,
                            fontWeight: StyleGlobal.fontWeight,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 60,
                          child: Text(
                            'Lớp : ',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 18,
                              fontWeight: StyleGlobal.fontWeight,
                            ),
                          ),
                        ),
                        Text(
                          profile.student.tenlop,
                          style: const TextStyle(
                            color: Colors.yellow,
                            fontSize: 18,
                            fontWeight: StyleGlobal.fontWeight,
                          ),
                        ),
                        profile.student.duyet == 0
                            ? Text(
                                ' (Chưa duyệt)',
                                style: TextStyle(
                                  color: Colors.red[300],
                                ),
                              )
                            : const Text(''),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 100,
                          child: Text(
                            'Vai trò : ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: StyleGlobal.fontWeight,
                            ),
                          ),
                        ),
                        profile.user.role_id == 4
                            ? const Text(
                                'Sinh viên ',
                                style: TextStyle(
                                  color: Colors.yellow,
                                  fontSize: 18,
                                  fontWeight: StyleGlobal.fontWeight,
                                ),
                              )
                            : const Text(
                                'Giảng Viên',
                                style: TextStyle(
                                  color: Colors.yellow,
                                  fontSize: 18,
                                  fontWeight: StyleGlobal.fontWeight,
                                ),
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.pink[100],
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CusTom_TextField(
                        width: 200,
                        title: 'Điện thoại',
                        value: profile.user.phone,
                        callback: (output) => {
                          profile.user.phone = output,
                          tkmodel.updateScreen()
                        },
                      ),
                    ),
                    Expanded(
                      child: CusTom_TextField(
                        width: 200,
                        title: 'Ngày sinh',
                        value: profile.user.birthday,
                        callback: (output) => {
                          if (CusTom_Validate.isDate(output))
                            {
                              profile.user.birthday = DateFormat('yyyy-MM-dd')
                                  .format(
                                      DateFormat('dd/MM/yyyy').parse(output)),
                            },
                          tkmodel.updateScreen()
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CusTom_DropDown_Place(
                          width: size.width * 0.70,
                          title: 'Tỉnh/Thành Phố ',
                          valueId: profile.user.provinceid,
                          valueName: profile.user.provincename,
                          callback: (outputID, inputName) async {
                            tkmodel.displaySpinner();
                            profile.user.provinceid = outputID;
                            profile.user.provincename = inputName;
                            await dcmodel.setCity(outputID);
                            profile.user.districtid = 0;
                            profile.user.districtname = '';
                            profile.user.wardid = 0;
                            profile.user.wardname = '';
                            tkmodel.hideSpinner();
                          },
                          list: dcmodel.listCity),
                    ),
                    Expanded(
                      child: CusTom_DropDown_Place(
                          width: size.width * 0.70,
                          title: 'Quận/Huyện ',
                          valueId: profile.user.districtid,
                          valueName: profile.user.districtname,
                          callback: (outputID, inputName) async {
                            tkmodel.displaySpinner();
                            profile.user.districtid = outputID;
                            profile.user.districtname = inputName;
                            await dcmodel.setDistrict(outputID);
                            profile.user.wardid = 0;
                            profile.user.wardname = '';
                            tkmodel.hideSpinner();
                          },
                          list: dcmodel.listDistrict),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CusTom_DropDown_Place(
                          width: size.width * 0.70,
                          title: 'Xã',
                          valueId: profile.user.wardid,
                          valueName: profile.user.wardname,
                          callback: (outputId, outputName) async {
                            profile.user.wardid = outputId;
                            profile.user.wardname = outputName;
                            await dcmodel.setWard(outputId);
                            tkmodel.updateScreen();
                          },
                          list: dcmodel.listWard),
                    ),
                    Expanded(
                      child: CusTom_TextField(
                        width: 200,
                        title: 'Tên đường/Số nhà',
                        value: profile.user.address,
                        callback: (output) => {
                          profile.user.address = output,
                          tkmodel.updateScreen()
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () async {
            if (_isEnabled) {
              await user.updateProfile();
              // ignore: use_build_context_synchronously
              showAlertDialog(context);
              Future.delayed(const Duration(seconds: 2), () {
                Navigator.of(context).pop();
              });
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CusTom_ButtonSubmit(
              textButton: 'Cập Nhật Thông Tin',
              isEnabled: _isEnabled,
            ),
          ),
        ),
      ],
    );
  }
}
