import 'package:dev_hampter/utils/uni_vars.dart';

String mouCondition() {
  if (budgetProg >= 0.7 && budgetProg <= 1) {
    return 'Feeling Happy!';
  } else if (budgetProg >= 0.4 && budgetProg < 0.7) {
    return 'Doing Well!';
  } else if (budgetProg >= 0.1 && budgetProg < 0.4) {
    return 'A bit concerned...';
  } else if (budgetProg == 0) {
    return 'Dead';
  } else {
    return 'Invalid value';
  }
}

String mouState() {
  if (budgetProg >= 0.7 && budgetProg <= 1) {
    return 'assets/images/mous/mouA.png';
  } else if (budgetProg >= 0.4 && budgetProg < 0.7) {
    return 'assets/images/mous/mouB.png';
  } else if (budgetProg >= 0.1 && budgetProg < 0.4) {
    return 'assets/images/mous/mouC.png';
  } else if (budgetProg == 0) {
    return 'assets/images/mous/mouD.png';
  } else {
    return 'Invalid value';
  }
}
