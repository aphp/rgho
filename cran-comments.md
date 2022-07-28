## Resubmission
This is a resubmission, after the package has been removed from CRAN for policy violation.
The former version of this package was relying on a non maintained API which led to 
a numerous of problems, notably 503 Server Unavailable errors.
I completely modify this package, now using the new API. I also added tests when no 
internet connection or http errors occurred, to make sure that it fails gracefully.
I also disconnected my PC and performed R CMD CHECK --as-cran

## Test environments
* local ubuntu 2020.04 R 4.2.0
* Windows Server 2008 R2 SP1, R-devel, 32/64 bit
* win-builder (devel and release)
* Fedora Linux, R-devel, clang, gfortran, solaris-patched

## R CMD check results
There were no ERRORs or WARNINGs, 1 NOTE :
  Package was archived on CRAN
  
  CRAN repository db overrides:
    X-CRAN-Comment: Archived on 2022-02-28 for repeated policy violation.
  

