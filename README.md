smashr
======

Small package for turning deep nested lists into tidy data tables.

## Installation

```r
devtools::install_github("SimonLarsen/smashr")
```

## Example

```r
library(smashr)

x <- list(
  cars = list(
    sedan = list(topspeed=300, weight=1300, wheels=4),
    truck = list(topspeed=130, weight=5000, wheels=6)
  ),
  planes  = list(
    boeing747 = list(topspeed=988, weight=440000),
    concorde = list(topspeed=2180, weight=78700)
  )
)

smash(x, c("type","model"))
#> # A tibble: 4 x 5
#>   type   model     topspeed weight wheels
#>   <chr>  <chr>        <dbl>  <dbl>  <dbl>
#> 1 cars   sedan          300   1300      4
#> 2 cars   truck          130   5000      6
#> 3 planes boeing747      988 440000     NA
#> 4 planes concorde      2180  78700     NA
```
