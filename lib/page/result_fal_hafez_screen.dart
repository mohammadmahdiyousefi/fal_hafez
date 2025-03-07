import 'package:fal_hafez/bloc/fal_hafez_bloc/fal_hafez_bloc.dart';
import 'package:fal_hafez/tapsell_ad/tapsell_native_ad_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ResultFalHafezScreen extends StatelessWidget {
  const ResultFalHafezScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff87562d),
      appBar: AppBar(
        title: Text(
          'نتیجه فال حافظ',
          style: TextStyle(fontFamily: 'lale', color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff87562d),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<FalHafezBloc, FalHafezState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case const (FalHafezLoadingState):
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(color: Color(0xffe4bf92)),
                    Gap(8),
                    Text(
                      ' لطفا صبر کنید',
                      style: TextStyle(fontFamily: 'lale', color: Colors.white),
                    ),
                  ],
                ),
              );
            case const (FalHafezLoadedState):
              final falHafezLoadedState = state as FalHafezLoadedState;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color(0xffe4bf92),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        'غزل شماره: ${falHafezLoadedState.falHafezModel.result!.sHOMARE}',
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontFamily: 'lale',
                          color: Colors.black,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    Divider(height: 20, endIndent: 32, indent: 32),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.symmetric(horizontal: 32.0),
                      decoration: BoxDecoration(
                        color: Color(0xffe4bf92),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        '${falHafezLoadedState.falHafezModel.result!.rHYME}',
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontFamily: 'lale',
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Divider(height: 20, endIndent: 32, indent: 32),
                    TapsellNativeAdWidget(size: TapsellNativeAdSize.standard),
                    Gap(8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.symmetric(horizontal: 32.0),
                      decoration: BoxDecoration(
                        color: Color(0xffe4bf92),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'تفسیر فال شما ',
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontFamily: 'lale',
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          Gap(16),
                          Text(
                            '${falHafezLoadedState.falHafezModel.result!.mEANING}',
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontFamily: 'lale',
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(16),
                  ],
                ),
              );
            case const (FalHafezErrorState):
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "مشکلی پیش آمد مجدد تلاش کنید",
                      style: TextStyle(
                        fontFamily: 'lale',
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    Gap(8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffe4bf92),
                        foregroundColor: Colors.black,
                      ),
                      onPressed: () {
                        context.read<FalHafezBloc>().add(FalHafezGetEvent());
                      },
                      child: Text(
                        'تلاش مجدد',
                        style: TextStyle(
                          fontFamily: 'lale',
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            default:
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "مشکلی پیش آمد مجدد تلاش کنید",
                      style: TextStyle(
                        fontFamily: 'lale',
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    Gap(8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffe4bf92),
                        foregroundColor: Colors.black,
                      ),
                      onPressed: () {
                        context.read<FalHafezBloc>().add(FalHafezGetEvent());
                      },
                      child: Text(
                        'تلاش مجدد',
                        style: TextStyle(
                          fontFamily: 'lale',
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              );
          }
        },
      ),
    );
  }
}
