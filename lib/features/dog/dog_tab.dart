import 'package:flutter/material.dart';

import 'dog_tab_state.dart';

class DogTab extends StatefulWidget {

  final String? idStr;

  const DogTab({
    this.idStr,
    super.key
  });

  @override
  State<DogTab> createState() => DogTabState();
}
