import 'dart:typed_data';

import 'package:climb/pages/my_profile_page.dart';
import 'package:climb/pages/sign_up_page.dart';
import 'package:climb/pages/sign_up_second_page.dart';
import 'package:climb/styles/app_colors.dart';
import 'package:climb/constants/routes.dart';
import 'package:climb/providers/user_auth_provider.dart';
import 'package:climb/utils/check.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class MyProfileEditPage extends StatefulWidget {
  static String routerName = 'MyProfileEdit';

  const MyProfileEditPage({
    super.key,
  });

  @override
  State<MyProfileEditPage> createState() => _MyProfileEditPageState();
}

class _MyProfileEditPageState extends State<MyProfileEditPage> {
  late int _selectedIndex;

  Uint8List? _profileImg;

  NickNameInputStatus _nickNameInputStatus = NickNameInputStatus.empty;
  final TextEditingController _nickNameEditingController =
      TextEditingController();
  final FocusNode _nickNameFocusNode = FocusNode();

  final TextEditingController _profileIntroductionEditingController =
      TextEditingController();
  final FocusNode _profileIntroductionFocusNode = FocusNode();

  final TextEditingController _heightEditingController =
      TextEditingController();
  final FocusNode _heightFocusNode = FocusNode();

  final TextEditingController _armReachEditingController =
      TextEditingController();
  final FocusNode _armReachFocusNode = FocusNode();

  final TextEditingController _weightEditingController =
      TextEditingController();
  final FocusNode _weightFocusNode = FocusNode();

  late UserAuthProvider _userAuthProvider;

  @override
  void initState() {
    super.initState();
    _userAuthProvider = context.read<UserAuthProvider>();

    // 기본값 할당
    _profileImg = _userAuthProvider.userProfile!.profileImg;
    _nickNameEditingController.text = _userAuthProvider.userProfile!.nickName;
    _profileIntroductionEditingController.text =
        _userAuthProvider.userProfile!.profileIntroduction ?? '';
    _selectedIndex = _userAuthProvider.userProfile!.profileDifficultyIndex;
    _heightEditingController.text =
        _userAuthProvider.userProfile!.height.toString();
    _armReachEditingController.text =
        _userAuthProvider.userProfile!.armReach.toString();
    _weightEditingController.text =
        _userAuthProvider.appUser!.weight.toString();

    _nickNameFocusNode.addListener(() {
      if (!_nickNameFocusNode.hasFocus) {
        _checkDuplicated(_nickNameEditingController.text);
      }
    });
    _heightFocusNode.addListener(() {
      if (!_heightFocusNode.hasFocus) {
        translateTextToDoubleForm(_heightEditingController);
        setState(() {});
      }
    });
    _armReachFocusNode.addListener(() {
      if (!_armReachFocusNode.hasFocus) {
        translateTextToDoubleForm(_armReachEditingController);
        setState(() {});
      }
    });
    _weightFocusNode.addListener(() {
      if (!_weightFocusNode.hasFocus) {
        translateTextToDoubleForm(_weightEditingController);
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _nickNameFocusNode.dispose();
    _heightFocusNode.dispose();
    _armReachFocusNode.dispose();
    _weightFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          '프로필 수정',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '프로필',
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          const Gap(4),
                          GestureDetector(
                            onTap: () async {
                              await _onTapProfileImage(context);
                            },
                            child: SizedBox(
                              width: 113,
                              height: 108,
                              child: Stack(
                                children: [
                                  ClipOval(
                                    clipBehavior: Clip.hardEdge,
                                    child: _profileImg != null
                                        ? Image.memory(
                                            _profileImg!,
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            'assets/images/default_profile.png',
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: colorLightGray,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: const Icon(
                                          Icons.camera_alt,
                                          size: 36,
                                        )),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      const Gap(28),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '닉네임 *',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: colorGray,
                                width: 1,
                              ),
                            ),
                            height: 54,
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: TextField(
                                    maxLength: 9,
                                    focusNode: _nickNameFocusNode,
                                    controller: _nickNameEditingController,
                                    onChanged: (value) {
                                      if (value == "") {
                                        _nickNameInputStatus =
                                            NickNameInputStatus.empty;
                                      } else if (checkNickNamePattern(value)) {
                                        _nickNameInputStatus =
                                            NickNameInputStatus.patternPossible;
                                      } else {
                                        _nickNameInputStatus =
                                            NickNameInputStatus
                                                .patternImpossible;
                                      }
                                      setState(() {});
                                    },
                                    onSubmitted: (value) =>
                                        _checkDuplicated(value),
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      counterText: '',
                                      isDense: true,
                                    ),
                                    textAlignVertical: TextAlignVertical.center,
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          SizedBox(
                            height: 18,
                            child: NickNameGuide(status: _nickNameInputStatus),
                          ),
                        ],
                      ),
                      const Gap(28),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '한줄소개',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: colorGray,
                                width: 1,
                              ),
                            ),
                            height: 92,
                            padding: const EdgeInsets.all(12),
                            child: TextField(
                              maxLines: 2,
                              maxLength: 35,
                              focusNode: _profileIntroductionFocusNode,
                              controller: _profileIntroductionEditingController,
                              style: Theme.of(context).textTheme.bodyMedium,
                              decoration: InputDecoration(
                                hintText: "한 줄로 자신을 소개해보세요.",
                                hintStyle:
                                    Theme.of(context).textTheme.labelMedium,
                                border: InputBorder.none,
                                isDense: true,
                              ),
                              textAlignVertical: TextAlignVertical.top,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('35자 이내',
                                  style: Theme.of(context).textTheme.labelSmall)
                            ],
                          )
                        ],
                      ),
                      const Gap(28),
                      SizedBox(
                        width: 200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '난이도 *',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            GestureDetector(
                              onTap: () {
                                showDialog<int>(
                                  context: context,
                                  builder: (context) => Dialog(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      width: 260,
                                      height: 254,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8,
                                          horizontal: 4,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              '프로필에 표시할 난이도를 선택해요.',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            SizedBox(
                                              width: 240,
                                              height: 200,
                                              child: GridView.builder(
                                                itemCount:
                                                    profileDifficultyColors
                                                        .length,
                                                gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  mainAxisSpacing: 4,
                                                  crossAxisSpacing: 4,
                                                  childAspectRatio: 25 / 6,
                                                ),
                                                itemBuilder: (context, index) {
                                                  return ElevatedButton(
                                                    onPressed: () =>
                                                        context.pop(index),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      elevation: 0,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                    ),
                                                    child: SvgPicture.asset(
                                                      'assets/icons/tape.svg',
                                                      width: 100,
                                                      height: 24,
                                                      colorFilter: ColorFilter.mode(
                                                          profileDifficultyColors[
                                                              index],
                                                          BlendMode.srcIn),
                                                    ),
                                                  );
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ).then((colorIndex) {
                                  if (colorIndex != null &&
                                      _selectedIndex != colorIndex) {
                                    setState(() {
                                      _selectedIndex = colorIndex;
                                    });
                                  }
                                });
                              },
                              child: SvgPicture.asset(
                                'assets/icons/tape.svg',
                                width: 100,
                                height: 24,
                                colorFilter: ColorFilter.mode(
                                    profileDifficultyColors[_selectedIndex],
                                    BlendMode.srcIn),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(16),
                      SizedBox(
                        width: 200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '키(cm) *',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: colorGray,
                                  width: 1,
                                ),
                              ),
                              width: 100,
                              height: 36,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              child: TextField(
                                maxLength: 5,
                                focusNode: _heightFocusNode,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                onSubmitted: (value) {
                                  translateTextToDoubleForm(
                                      _heightEditingController);
                                  setState(() {});
                                },
                                controller: _heightEditingController,
                                style: Theme.of(context).textTheme.bodyMedium,
                                decoration: InputDecoration(
                                  hintText: "174.4",
                                  hintStyle:
                                      Theme.of(context).textTheme.labelMedium,
                                  border: InputBorder.none,
                                  counterText: '',
                                  isDense: true,
                                ),
                                textAlignVertical: TextAlignVertical.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(16),
                      SizedBox(
                        width: 200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '암리치(cm)',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: colorGray,
                                  width: 1,
                                ),
                              ),
                              width: 100,
                              height: 36,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              child: TextField(
                                maxLength: 5,
                                focusNode: _armReachFocusNode,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                onSubmitted: (value) {
                                  translateTextToDoubleForm(
                                      _armReachEditingController);
                                  setState(() {});
                                },
                                controller: _armReachEditingController,
                                style: Theme.of(context).textTheme.bodyMedium,
                                decoration: InputDecoration(
                                  hintText: "171.3",
                                  hintStyle:
                                      Theme.of(context).textTheme.labelMedium,
                                  border: InputBorder.none,
                                  counterText: '',
                                  isDense: true,
                                ),
                                textAlignVertical: TextAlignVertical.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(16),
                      SizedBox(
                        width: 200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '몸무게(kg)',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: colorGray,
                                  width: 1,
                                ),
                              ),
                              width: 100,
                              height: 36,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              child: TextField(
                                maxLength: 5,
                                focusNode: _weightFocusNode,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                onSubmitted: (value) {
                                  translateTextToDoubleForm(
                                      _weightEditingController);
                                },
                                controller: _weightEditingController,
                                style: Theme.of(context).textTheme.bodyMedium,
                                decoration: InputDecoration(
                                  hintText: "79",
                                  hintStyle:
                                      Theme.of(context).textTheme.labelMedium,
                                  border: InputBorder.none,
                                  counterText: '',
                                  isDense: true,
                                ),
                                textAlignVertical: TextAlignVertical.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Gap(
                    screenHeight - 872 >= 20 ? screenHeight - 872 : 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: _canGoNext()
                              ? () async => _onTapSave(context)
                              : null,
                          style: ButtonStyle(
                            alignment: Alignment.center,
                            backgroundColor:
                                WidgetStateProperty.resolveWith((states) {
                              if (states.contains(WidgetState.disabled)) {
                                return colorGray;
                              }
                              return colorOrange;
                            }),
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            padding: const WidgetStatePropertyAll(
                              EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                            ),
                          ),
                          child: Text(
                            '저장',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _canGoNext() {
    if (_heightEditingController.text == '' ||
        _heightEditingController.text == '0.0') {
      return false;
    }
    if (_nickNameEditingController.text !=
            _userAuthProvider.userProfile!.nickName &&
        _nickNameInputStatus != NickNameInputStatus.possible) {
      return false;
    }
    return true;
  }

  _checkDuplicated(String nickName) {
    try {
      // 패턴을 만족하지 못하였을 때
      if (_nickNameInputStatus != NickNameInputStatus.patternPossible) {
        return;
      }
      // 자신의 닉네임일 경우
      if (nickName == _userAuthProvider.userProfile!.nickName) {
        return;
      }

      var userCollection =
          FirebaseFirestore.instance.collection("user_profiles");
      userCollection.where('nickName', isEqualTo: nickName).get().then(
        (querySnapshot) {
          if (querySnapshot.size > 0) {
            _nickNameInputStatus = NickNameInputStatus.duplicated;
          } else {
            _nickNameInputStatus = NickNameInputStatus.possible;
          }
          setState(() {});
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  _onTapSave(BuildContext context) async {
    List<Future> futures = [];
    futures.add(
      _userAuthProvider.updateUserProfile(
        UserProfile(
          profileImg: _profileImg,
          nickName: _nickNameEditingController.text,
          profileIntroduction: _profileIntroductionEditingController.text,
          profileDifficultyIndex: _selectedIndex,
          height: double.parse(_heightEditingController.text),
          armReach: double.tryParse(_armReachEditingController.text),
        ),
        _userAuthProvider.user!.uid,
      ),
    );

    if (double.tryParse(_weightEditingController.text) != null) {
      var appUser = _userAuthProvider.appUser!;
      appUser.weight = double.tryParse(_weightEditingController.text);
      futures.add(
        _userAuthProvider.updateAppUser(
          appUser,
          _userAuthProvider.user!.uid,
        ),
      );
    }

    var results = Future.wait(futures);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    results.then(
      (futures) {
        if (context.mounted) {
          context.goNamed(MyProfilePage.routerName);
        }
      },
    );
  }

  _onTapProfileImage(BuildContext context) async {
    var modalResult = await showModalBottomSheet(
      enableDrag: false,
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => context.pop(0),
                        style: ButtonStyle(
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          backgroundColor: const WidgetStatePropertyAll(
                            colorLightGray,
                          ),
                          padding: const WidgetStatePropertyAll(
                            EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                          ),
                        ),
                        child: Text(
                          '앨범에서 선택',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(4),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => context.pop(1),
                        style: ButtonStyle(
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          backgroundColor: const WidgetStatePropertyAll(
                            colorLightGray,
                          ),
                          padding: const WidgetStatePropertyAll(
                            EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                          ),
                        ),
                        child: Text(
                          '프로필 사진 삭제',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Gap(20),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => context.pop(),
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      backgroundColor: const WidgetStatePropertyAll(
                        colorLightGray,
                      ),
                      padding: const WidgetStatePropertyAll(
                        EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                    ),
                    child: Text(
                      '닫기',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    if (modalResult == 0) {
      final ImagePicker picker = ImagePicker();
      var profileImgXFile = await picker.pickImage(source: ImageSource.gallery);
      if (profileImgXFile != null) {
        _profileImg = await profileImgXFile.readAsBytes();
      }
      setState(() {});
    }
    if (modalResult == 1) {
      _profileImg = null;
      setState(() {});
    }
  }
}
