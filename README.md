# Directions

> Build an application that highlights directions (east, north, south, west) and distances (miles, kilometers, feet, etc.) inside a text body.

From [Tim Caswell's Play by Play session][pbp].

## Getting started

In order to get hacking into `Directions` you'll need:

- [Node.js][node]
- [CoffeeScript][coffee]
- A descent browser.

### Setting things up

Once you have Node.js installed and NPM (which is when you install Node) then run:

```bash
npm install -g coffee-script
```

And you're done. :)

### Running the application

As simple as running `coffee app.coffee`.

You can run the application on a different port by running `PORT=8000 coffee app.coffee`.

**Pro-Tip**: 
Want to restart your server each time code changes? Use `nodemon`! 
Install it with `npm install -g nodemon`, then do `nodemon app.coffee`.

## Lessons learned

Here are some take-aways from my experience building this little side-project.

- Vanilla Node.js is both daunting and **exciting**.
- Always keep JavaScript docs at hand.

[pbp]: http://beta.pluralsight.com/courses/play-by-play-tim-caswell
[node]: http://nodejs.org/download/
[coffee]: http://coffeescript.org/
