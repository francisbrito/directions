# Business logic.

# Finds directions and distances inside a given string.
findMatchesIn = (text) ->
  matches = []

  searchTerms =
    direction: /\b(north|east|south|west)\b/gi
    distance: /\b\d+ (feet|mile|kilometer|meter)s?\b/gi
  
  for type, regex of searchTerms

    # NOTE: Quick-n-dirty hack to get every and each match.
    #       Regex#exec 'walks and consumes' every match in the text if global '/g' flag is set.
    #       Meaning repeated calls to Regex#exec will return all matching words.
    while (match = regex.exec text)
      matches.push
        type: type
        value: match[0]
        length: match[0].length
        position: match.index
  
  return matches

exports.findMatchesIn = findMatchesIn
