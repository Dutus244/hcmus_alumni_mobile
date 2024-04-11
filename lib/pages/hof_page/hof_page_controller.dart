import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/hof_page_blocs.dart';

class HofPageController {
  final BuildContext context;

  const HofPageController({required this.context});

  Future<void> handleSearch() async {
    final state = context.read<HofPageBloc>().state;
    String name = state.name;
    String faculty = state.faculty;
    String graduationYear = state.graduationYear;
    print(name);
    print(faculty);
    print(graduationYear);
  }
}
