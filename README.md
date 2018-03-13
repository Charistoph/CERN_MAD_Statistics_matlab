# Load tracks from csv

`read_data.m`

# compute mode median

`compute_mode_median.m`

Computes mode & media for maxcomp 1,2,3,4,5,6,8,10,12

Residuals saved for

* mixtmean

* mixtmode

* mixtmedi

* baseline

* m3 - contains standard deviation, mean absolute deviation & median absolute deviation of the 4 above

saved as csv per maxcomp

# cov and trace

`cov_and_trace.m`

Covariance Matrix saved for

* covmean

* covmode

* covmedi

* covbase

# mad computation

`mad_computation.m`

calculates standard deviation, mean absolute deviation & median absolute deviation as `compute_mode_median.m` **WITHOUT** calculating residuals.
