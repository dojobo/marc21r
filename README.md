
<!-- README.md is generated from README.Rmd. Please edit that file -->

# marc21r

<!-- badges: start -->
<!-- badges: end -->

{marc21r} is an R package for examining and analyzing
[MARC21](https://www.loc.gov/marc/) files, a set of standards used to
describe library materials such as books and journals. Currently,
{marc21r} reads only MARC21 XML.

## Installation

You can install the development version of marc21r from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("dojobo/marc21r")
```

## Example

The basic use case is to load a MARC XML file as a tibble. Each tag
(001, 245, etc.) becomes a column whose name starts with `t`, e.g.,
`t001`, `t245`. Once so loaded, the dataset can be manipulated and
analyzed using standard tidyverse tools.

``` r
library(marc21r)
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
collection <- read_marcxml("collection.xml")
collection %>% 
  select(t245, t260, t500)
#> # A tibble: 2 × 3
#>   t245                                     t260                            t500 
#>   <chr>                                    <chr>                           <chr>
#> 1 The Great Ray Charles [sound recording]. New York, N.Y. : Atlantic, [19… Brie…
#> 2 The White House [computer file].         Washington, D.C. : White House… Titl…
```

For better readability, `tag_names()` can be applied to a MARC
dataframe:

``` r
collection %>% 
  select(t245, t260, t500) %>% 
  tag_names(style = "short")
#> # A tibble: 2 × 3
#>   t245_title_stmt                          t260_pub_dist                 t500_…¹
#>   <chr>                                    <chr>                         <chr>  
#> 1 The Great Ray Charles [sound recording]. New York, N.Y. : Atlantic, [… Brief …
#> 2 The White House [computer file].         Washington, D.C. : White Hou… Title …
#> # … with abbreviated variable name ¹​t500_general_note
```
