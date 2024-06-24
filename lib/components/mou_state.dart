//Mou state functions
String mouCondition(budget) {
  if (budget >= 0.7 && budget <= 1) {
    return 'Feeling Happy!';
  } else if (budget >= 0.4 && budget < 0.7) {
    return 'Doing Well!';
  } else if (budget >= 0.1 && budget < 0.4) {
    return 'A bit concerned...';
  } else if (budget == 0) {
    return 'Dead';
  } else {
    return 'Invalid value';
  }
}

String mouState(budget) {
  if (budget >= 0.7 && budget <= 1) {
    return 'assets/images/mous/mouA.png';
  } else if (budget >= 0.4 && budget < 0.7) {
    return 'assets/images/mous/mouB.png';
  } else if (budget >= 0.1 && budget < 0.4) {
    return 'assets/images/mous/mouC.png';
  } else if (budget == 0) {
    return 'assets/images/mous/mouD.png';
  } else {
    return 'Invalid value';
  }
}
