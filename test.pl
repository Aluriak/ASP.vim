%*
 * A small ASP file to test ASP.vim
 * Mainly found these lines on Wikipedia
 *%


% graph colouring
c(1..n).                                           
1 {color(X,I) : c(I)} 1 :- v(X).             
:- color(X,I), color(Y,I), e(X,Y), c(I).


% hamiltonian circle
{in(X,Y)} :- e(X,Y).
 
:- 2 {in(X,Y) : e(X,Y)}, v(X).
:- 2 {in(X,Y) : e(X,Y)}, v(Y).

r(X) :- in(0,X), v(X).
r(Y) :- r(X), in(X,Y), e(X,Y).

:- not r(X), v(X).

