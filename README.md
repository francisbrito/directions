# Directions

> Build an application that highlights directions (east, north, south, west) and distances (miles, kilometers, feet, etc.) inside a text body.

From [Tim Caswell's Play by Play session][pbp].

## Install

```bash
$ npm install https://github.com/francisbrito/directions
```

## Usage

```javascript
var directions = require('directions');

var matches = directions.findMatchesIn('Head 5 meters north, then 10 meters east.');
```

## API

### directions.findMatchesIn(text)

Finds strings matching cardinal directions (north, west, east, south) and distances in `text`.

#### text
**Required**

Type: `string`

An arbitrary string.

#### returns

An array containing all matches.

[pbp]: http://beta.pluralsight.com/courses/play-by-play-tim-caswell
