import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgWrapper {
  static Widget getSVG({required String path}) {
    return SvgPicture.asset(
      path,
      package: 'loyalty_program_frontend',
    );
  }
}
