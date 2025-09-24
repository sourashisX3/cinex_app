import 'package:cinex_app/common/constants/size_constants.dart';
import 'package:cinex_app/common/constants/strings/app_string_constants.dart';
import 'package:cinex_app/presentation/libraries/AppContents/flutter_animator/widgets/fading_entrances/fade_in_down.dart';
import 'package:cinex_app/presentation/widgets/SearchBars/app_search_bar.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(AppStringConstants.searchMovies),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: Sizes.paddingAll16,
            child: Column(
              children: [
                FadeInDown(child: AppSearchBar()),
                const SizedBox(height: Sizes.dimen_30),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
