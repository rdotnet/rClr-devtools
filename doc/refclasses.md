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

Information: 
There is a reference-class tag on stackoverflow

Interesting search is http://www.rseek.org/?cx=010923144343702598753%3Aboaz1reyxd4&q=setRefClass&sa=Search+functions%2C+lists%2C+and+more&cof=FORID%3A11&siteurl=www.rseek.org%2F&ref=&ss=7036j2407444j37

http://adv-r.had.co.nz/R5.html

http://www.bioconductor.org/help/course-materials/2010/HeidelbergNovember2010/ReferenceClasses-Morgan.pdf

Notice some issues with tab completion on refclass methods. Known issues:
http://stackoverflow.com/questions/12543166/reference-classes-tab-completion-and-forced-method-definition