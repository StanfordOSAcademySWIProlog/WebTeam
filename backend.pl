:- module(backend,[data/1]).

:- use_module(db,[course/1]).

data(List) :-
    findall(C, course(C), Courses).


