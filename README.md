# scrontroll
Small lib to monitor scroll events and running methods.

## Usage

### Testing
Great, you are ready to write awesome code! But off course, you want to run tests, lots and lots of tests. Start Karma by running the 'grunt karma' command in the terminal.

```
grunt karma
```

> This project uses the grunt-karma module. It works right away! Info about customization can be found at [grunt-karma](https://github.com/karma-runner/grunt-karma).

Karma shows the test reports directly in the terminal. If you prefer a html based test report go to 'server/port/debug.html' while 'grunt karma' is running. Most likely this url is;

```
http://localhost:9876/debug.html
```

> It is possible you have to refresh to get the last report

At this moment, only chrome comes out of the box. If you would like to use another browser-launchers, install the launcher with [npm](http://www.npmjs.com) and edit the 'browsers' registration method in the 'karma.config.coffee' file.

[Find more browser launchers](https://npmjs.org/browse/keyword/karma-launcher)

### Compiling
You could run 'grunt' in the terminal to compile & uglify the CoffeeScript files manually.

```
grunt
```

If you would like to compile & uglify coffeeScript automatically on file change, activate the grunt watcher. This is easily done by running the 'grunt watch' command in the terminal.

```
grunt watch
```

### Building & Deploying
If your code is ready for production, simply run 'grunt:patch', 'grunt:minor' or 'grunt:major' in your terminal to deploy on github. This will do a few things;

 1. Compile CoffeeScript to JavaScript.
 2. Build 'scrontroll.js' & 'scrontroll.min.js' and save it in './dist'.
 3. Update the version number and create an new release.
 4. Commit & push new release to https://github.com/LesleyDuyndam/scrontroll.git repository.

#### For a patch commit & push, just run 'grunt patch'. (v0.0.1 to v0.0.2)

```
grunt patch
```

#### For a minor commit & push, run 'grunt minor'. (v0.0.2 to v0.1.0)

```
grunt minor
```

#### for a major commit & push, run 'grunt major'. (v0.1.0 to v1.0.0)

```
grunt major
```

## Copyright 2015 Lesley Duyndam

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.