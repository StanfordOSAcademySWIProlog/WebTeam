:- module(load, []).
/** <module> Load this to start the production environment

*/

% A bit of possibly excessive abstraction, we load the
% server but don't run it in strangeloop.pl
:-use_module(strangeloop).
% make sure the handlers get loaded
:- ensure_loaded(html_handlers).
:- ensure_loaded(resourcedemo).




