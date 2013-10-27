Notes on Reference Classes for rClr
===================================

# Rcpp11

Figured out from John Chambers' email that exposeClass is at Romain's rcpp11 git repo.

# Rcpp

the package created by rcpp.package.skeleton loads modules via loadModule()

RCPP__PREPROCESSOR_GENERATED_H: surely this is generated. What from?? what tools? Ask mailing list.

The Module creation gets the information about the classes at the line
classes <- .Call( Module__classes_info, xp )

This is not clear what Module__classes_info is; it probably is a "RegisteredNativeSymbol". It is created in the C++ layer I think with quite a bit of macros stuff, which makes it difficult to follow.
There we go:
```
dlls <- getLoadedDLLs()
getDLLRegisteredRoutines(dlls[['Rcpp']])
```
