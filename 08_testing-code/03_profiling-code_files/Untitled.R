



## Continuous Integration

The last Your Turn resulted in...
![](travis_is_depressing.png)

.center[![:scale 70%](travis_is_depressing2.png)]
???
This is my email inbox after setting Travis up for my test repository...
The Still Failing message hits you right in the feels every time.

---
class:middle,center
# Code Coverage: `covr`
???
Once you get travis set up, you can set up covr, which is a pretty sweet little package.
---

## Code Coverage

> How many unit tests are enough? Is everything tested?

- `covr` is a package that will:
    1. build your package in a clean environment (using TravisCI)
    2. run your tests
    3. determine how many times each line was evaluated (through [magic](https://cran.r-project.org/web/packages/covr/vignettes/how_it_works.html))
    4. launch a Shiny app to show you line-by-line coverage reports

- 100% coverage is good, but unit tests aren't everything
- Some lines aren't worth testing
    - Integration testing matters too!

```{r, eval = F}
covr::report() # Run a local code coverage report

# Enable codecov.io with your github account
# This requires travis integration, but generates coverage reports
#   automatically with every change you push to the github repo
usethis::use_coverage(type = "codecov")
```
It is so sweet to see this: ![](https://github.com/heike/worldle/workflows/R-CMD-check/badge.svg)

???
Covr is pretty nice because it will tell you (using magic!) exactly which lines were run during your test suite. So if you have an if statement that isn't tested, it will let you know. It'll also tell you how many times a line of code has been run. It's pretty amazing.
---
  class:inverse
## Your Turn

1. Run a code coverage report locally for your helloR package using `covr::report()`

2. Stretch goal: Try to get coverage configured using [codecov.io](https://codecov.io/github/srvanderplas/helloR?branch=master)

## Package Checking

Unit tests test specific functions you've written. Package checks test the whole package, including

- the package has the correct file structure

- the package is installable

- there is a recognized license

- there is an author/maintaner (with contact information)

- documentation exists and is correctly structured

- imports and dependencies are correctly specified

- examples can be run

- all of your tests work correctly

- and more...
???
In the package slides, we talked briefly about CRAN and package checks. In addition to running your tests after code changes, `check()` will also run your unit tests to make sure your package is functioning correctly. It will also check for a number of other problems and generally try to make sure your package is correctly set up and specified.
---

## Package Checking

`devtools::check()` or `Ctrl/CMD-Shift-E` will check your package

To submit to CRAN, you must not have any warnings or errors.

Workflow:

- `Ctrl/CMD-Shift-E` (builds documentation, compiles package, runs checks)

- Fix the first problem

- Repeat until there are no more problems

???
The workflow for `check` is pretty simple - run it, fix the first issue, rerun, and repeat until there are no issues.


---
class:inverse
## Your Turn

Get your package working with `devtools::check()`. You may have to:

- add documentation
(Build menu -> Generate documentation with roxygen, then Ctrl/Cmd-Shift-D)

- add a license: `usethis::use_gpl3_license(name="your name")`

- make sure your tests pass

???
In this your turn, go ahead and make sure your package passes check(). You'll have to make sure your function is documented correctly, add a license, and make sure all of your tests pass.

If you're having trouble, raise your hand and flag one of us down, because it's pretty important to get things working before we go on to the next stage.



