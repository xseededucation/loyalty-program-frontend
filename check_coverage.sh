min_coverage=80
coverage_check=$(lcov --remove coverage/lcov.info 'lib/mock/*' 'lib/utils/l10n/*' 'lib/utils/colors.dart' -o coverage/new_lcov.info --ignore-errors unused | grep "lines......:" | grep -oe '\([0-9.]*\)' | sed -n '2p')
if (( $(echo "$min_coverage <= $coverage_check" |bc -l) ))
then 
  echo "Good coverage" 
  exit 0 
else 
  echo "Coverage less than $min_coverage" 
  exit 1 
fi