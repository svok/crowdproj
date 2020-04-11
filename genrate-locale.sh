#!/bin/bash

for i in crowdproj-teams/front-teams crowdproj-front-private/crowdproj
do
  (
    echo "PROCESSING $i"
    cd $i
    flutter pub run intl_translation:extract_to_arb --output-dir=lib/l10n lib/translations/*.dart

    flutter pub run intl_translation:generate_from_arb \
        --output-dir=lib/l10n --no-use-deferred-loading \
        lib/translations/*.dart lib/l10n/intl_*.arb
  )
done