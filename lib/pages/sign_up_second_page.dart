import 'package:climb/styles/app_colors.dart';
import 'package:climb/constants/routes.dart';
import 'package:climb/providers/user_auth_provider.dart';
import 'package:climb/utils/check.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SignUpSecondPage extends StatefulWidget {
  static String routerName = 'SignUpSecond';

  final String nickName;
  final DateTime birthDay;
  final int gender;
  final double height;

  const SignUpSecondPage({
    super.key,
    required this.nickName,
    required this.birthDay,
    required this.gender,
    required this.height,
  });

  @override
  State<SignUpSecondPage> createState() => _SignUpSecondPageState();
}

class _SignUpSecondPageState extends State<SignUpSecondPage> {
  int _selectedIndex = 4;

  final TextEditingController _profileIntroductionEditingController =
      TextEditingController();
  final FocusNode _profileIntroductionFocusNode = FocusNode();

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
    _armReachFocusNode.dispose();
    _weightFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${widget.nickName}님',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              Text(
                                ' 반가워요!',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                          Text(
                            '추가 정보를 받을게요.',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            '프로필과 기록 통계에 활용됩니다.',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ),
                      const Gap(36),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: colorGray,
                                    width: 1,
                                  ),
                                ),
                                height: 52,
                                padding: const EdgeInsets.all(12),
                                child: TextField(
                                  maxLength: 35,
                                  focusNode: _profileIntroductionFocusNode,
                                  controller:
                                      _profileIntroductionEditingController,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  decoration: InputDecoration(
                                    hintText: "한 줄로 자신을 소개해보세요.",
                                    hintStyle:
                                        Theme.of(context).textTheme.labelMedium,
                                    border: InputBorder.none,
                                    counterText: '',
                                    isDense: true,
                                  ),
                                  textAlignVertical: TextAlignVertical.center,
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('35자 이내',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall)
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 48,
                          ),
                          Column(
                            children: [
                              SizedBox(
                                width: 200,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '난이도',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showDialog<int>(
                                          context: context,
                                          builder: (context) => Dialog(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                              width: 260,
                                              height: 254,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
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
                                                          childAspectRatio:
                                                              25 / 6,
                                                        ),
                                                        itemBuilder:
                                                            (context, index) {
                                                          return ElevatedButton(
                                                            onPressed: () =>
                                                                context
                                                                    .pop(index),
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              elevation: 0,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                              ),
                                                            ),
                                                            child: SvgPicture
                                                                .asset(
                                                              'assets/icons/tape.svg',
                                                              width: 100,
                                                              height: 24,
                                                              colorFilter:
                                                                  ColorFilter.mode(
                                                                      profileDifficultyColors[
                                                                          index],
                                                                      BlendMode
                                                                          .srcIn),
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
                                            profileDifficultyColors[
                                                _selectedIndex],
                                            BlendMode.srcIn),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              SizedBox(
                                width: 200,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '암리치(cm)',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
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
                                        keyboardType: const TextInputType
                                            .numberWithOptions(decimal: true),
                                        onSubmitted: (value) {
                                          translateTextToDoubleForm(
                                              _armReachEditingController);
                                          setState(() {});
                                        },
                                        controller: _armReachEditingController,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                        decoration: InputDecoration(
                                          hintText: "171.3",
                                          hintStyle: Theme.of(context)
                                              .textTheme
                                              .labelMedium,
                                          border: InputBorder.none,
                                          counterText: '',
                                          isDense: true,
                                        ),
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              SizedBox(
                                width: 200,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '몸무게(kg)',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
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
                                        keyboardType: const TextInputType
                                            .numberWithOptions(decimal: true),
                                        onSubmitted: (value) {
                                          translateTextToDoubleForm(
                                              _weightEditingController);
                                        },
                                        controller: _weightEditingController,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                        decoration: InputDecoration(
                                          hintText: "79",
                                          hintStyle: Theme.of(context)
                                              .textTheme
                                              .labelMedium,
                                          border: InputBorder.none,
                                          counterText: '',
                                          isDense: true,
                                        ),
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 812,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () async {
                            await _userAuthProvider.signUp(
                              nickName: widget.nickName,
                              birthDay: widget.birthDay,
                              gender: widget.gender,
                              height: widget.height,
                              profileIntroduction:
                                  _profileIntroductionEditingController.text,
                              profileDifficultyIndex: _selectedIndex,
                              armReach: double.tryParse(
                                  _armReachEditingController.text),
                              weight: double.tryParse(
                                  _weightEditingController.text),
                            );

                            if (context.mounted) {
                              context.go(pathExerciseRecords);
                            }
                          },
                          style: ButtonStyle(
                            alignment: Alignment.center,
                            backgroundColor:
                                const WidgetStatePropertyAll(colorOrange),
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
                            '다음',
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
}

const List<Color> profileDifficultyColors = [
  dColorWhite,
  dColorYellow,
  dColorOrange,
  dColorGreen,
  dColorBlue,
  dColorRed,
  dColorPurple,
  dColorGray,
  dColorBlack,
  dColorBrown,
  dColorPink,
  dColorSodomy,
];
