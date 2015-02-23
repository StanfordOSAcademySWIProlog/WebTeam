:- module(taken, []).
/** <module> Handler when the user updates what they've taken
 *
 */

% Needed for handler definitions
:- use_module(library(http/http_dispatch)).

% Needed to generate html
:- use_module(library(http/html_write)).

:- http_handler('/taken', taken_lander, [id(taken)]).

taken_lander(Request) :-
	memberchk(search(Search), Request),
	select(submit=_, Search, Courses),
	debug(ucsd(taken), 'Taken search is ~q', [Search]),
	reply_html_page(ucsd,
			title('Schedule'),
			\taken_body(Courses)).

taken_body(Courses) -->
	{ format(atom(S), '~q', [Courses]) },
	html(pre(S)).
