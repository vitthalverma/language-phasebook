import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:saathi_assignment/core/app/app_colors.dart';
import 'package:saathi_assignment/core/app/app_router.dart';
import 'package:saathi_assignment/features/translate/presentation/bloc/favourite_phase/bloc/favourite_phrase_bloc.dart';
import 'package:saathi_assignment/features/translate/presentation/widgets/custom_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _favouritePhases = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        height: 18.h,
        child: Column(
          children: [
            CustomButton(
              height: 6.h,
              width: double.infinity,
              name: 'Translate to text',
              onTap: () => Navigator.pushNamed(context, textTranslateRoute),
            ),
            SizedBox(height: 2.h),
            CustomButton(
              height: 6.h,
              width: double.infinity,
              name: 'Translate to speech',
              onTap: () => Navigator.pushNamed(context, speechTranslateRoute),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
        title: Text(
          'Favourite Phases',
          style: TextStyle(
            fontSize: 19.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocListener<FavouritePhraseBloc, FavouritePhraseState>(
        listener: (context, state) {
          if (state is FavouritePhraseAdded) {
            setState(() {
              _favouritePhases.add(state.phrase);
            });
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 2.h),
            Expanded(
              child: _favouritePhases.isEmpty
                  ? const Center(
                      child: Text('Save some phases for future use!'))
                  : ListView.builder(
                      itemCount: _favouritePhases.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 4.w),
                          title: Text(_favouritePhases[index]),
                          trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                _favouritePhases.removeAt(index);
                              });
                            },
                            icon: const Icon(Icons.delete,
                                color: AppColors.red700),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, textTranslateRoute,
                                arguments: _favouritePhases[index]);
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
