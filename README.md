# Node.js/Javascript Testing
## Test extension to provide general support for testing with Javascript and Nodejs. 

This extension supports unit testing with Mocha and browser (UI) testing with Selenium and Mocha as well as headless testing with PhantomJS.

### Usage
In order to automatically run tests against the URL generated in the build stage, ensure that tests are configured to pull a URL from environment variables. Add two environment variables `CF_APP_NAME` with a blank value (delete any pre-filled data) and one with the key that the test code looks for (ie, `TEST_URL`) with no value as before.

The extension will check for the existance of a Gruntfile.js file and if found will attempt to run either `grunt test` or `grunt` if `grunt test` is not detected. 

If no Gruntfile.js is detected then it will default to `npm test`. 

Ensure that at least one of these commands kicks off tests or the job will fail.

#### Note:
If the project is not configured in Node.js then a set of general testing tools will be automatically installed and run with the command provided in the text box in the UI. These tools include:
-   selenium-webdriver 
-   selenium-standalone
-   wd-sync
-   wd 
-   mocha
-   mocha-phantomjs
-   chai
-   chai-as-promised
-   webdriverio 
-   chromedriver