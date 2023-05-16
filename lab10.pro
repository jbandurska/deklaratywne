sil(X,N) :- sil(X,N,1).
sil(0,A,A).
sil(X,N,A) :- 
    X > 0, 
    A1 is A * X, 
    X1 is X - 1, 
    sil(X1,N,A1).

?- sil(5, N), write(N), nl.

myplus(A, B, X) :- myplusinner(A, B, X, 0).
myplusinner(0, 0, A, A).
myplusinner(A, B, X, Acc) :-
    Acc1 is A + B + Acc,
    myplusinner(0, 0, X, Acc1).

?- myplus(4, 5, N), write(N), nl.

mytimes(A, B, X) :- mytimesinner(A, B, X, 0).
mytimesinner(_, 0, Acc, Acc).
mytimesinner(A, B, X, Acc) :-
    B > 0,
    Bx is B - 1,
    Acc1 is Acc + A,
    mytimesinner(A, Bx, X, Acc1).

?- mytimes(3, 5, N), write(N), nl.

myfibonacci(N, X) :- myfibonacciinner(N, X, 0, 1).
myfibonacciinner(0, Acc1, Acc1, _).
myfibonacciinner(1, Acc2, _, Acc2).
myfibonacciinner(X, N, Acc1, Acc2) :- 
    X > 1,
    X1 is X - 1,
    Acc3 is Acc1 + Acc2,
    myfibonacciinner(X1, N, Acc2, Acc3).

?- myfibonacci(7, N), write(N), nl.

sum_up(N, X) :- sum_up_inner(N, X, 0).
sum_up_inner(0, Acc, Acc).
sum_up_inner(N, X, Acc) :-
    N > 0,
    Nx is N - 1,
    Acc1 is Acc + N,
    sum_up_inner(Nx, X, Acc1).

?- sum_up(5, N), write(N), nl.

q1(X,Y) :- 
    string_concat(X, Y, Var),
    string_concat("Wersja 1", Var, Print),
    write(Print),
    nl,
    p(X,Y).                
q1(X,Y) :- 
    string_concat(X, Y, Var),
    string_concat("Wersja 2", Var, Print),
    write(Print),
    nl,
    p(X,Z), q1(Z,Y).
 
q2(X,Y) :- p(X,Z), q2(Z,Y).
q2(X,Y) :- p(X,Y).  
 
q3(X,Y) :- p(X,Y).                  
q3(X,Y) :- q3(X,Z), p(Z,Y).       
    
q4(X,Y) :- q4(X,Z), p(Z,Y).
q4(X,Y) :- p(X,Y). 

p(tom,bob).
p(tom,liz).
p(bob,ann).      
p(bob,pat).     
p(pat,jim). 
