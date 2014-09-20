var findMatchesIn;

findMatchesIn = function(text) {
  var match, matches, regex, searchTerms, type;
  matches = [];
  searchTerms = {
    direction: /\b(north|east|south|west)\b/gi,
    distance: /\b\d+ (feet|mile|kilometer|meter)s?\b/gi
  };
  for (type in searchTerms) {
    regex = searchTerms[type];
    while ((match = regex.exec(text))) {
      matches.push({
        type: type,
        value: match[0],
        length: match[0].length,
        position: match.index
      });
    }
  }
  return matches;
};

exports.findMatchesIn = findMatchesIn;
