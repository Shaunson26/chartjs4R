
<!-- README.md is generated from README.Rmd. Please edit that file -->

# chartjs4R

<!-- badges: start -->
<!-- badges: end -->

An implementation of [chartjs](https://www.chartjs.org/) for R.

## Installation

``` r
library(devtools)
#> Loading required package: usethis
```

### main branch

Alpha version. Expect changes.

``` r
install_github(...)
```

### use_dots branch

See the branch `use_dots` that simply passes a list of data and options
to a chartjs instance This is the first, and simplest, implementation to
get chartjs working as a htmlwidget in R.

You can install the this version of :

``` r
install_github(...)
```

## Example

Alpha version. Expect changes.

``` r
iris %>% 
  chartjs(x = Species, y = Sepal.Length)
```
