:- module(html_handlers, [an_inclusion//0]).
/** <module> Handlers that use the built in html generation

*/

% Needed for handler definitions
:- use_module(library(http/http_dispatch)).

% Needed to generate html
:- use_module(library(http/html_write)).

:-use_module(backend(backend)).

%
% this handler uses an abstract path. The absolute
% paths we've been using are not good practice
:- http_handler(/, page_demo , []).

%%	page_demo(+Request:request) is det
%
%	A simple page using the 'termerized html' form
%
page_demo(_Request) :-
	reply_html_page(
	    title('OS Academy Rocks!'),
	    div([h1('OS Academy Rocks'),
		 p('This page was generated from termerized html'),
		 \showcourses
		])).


%%	showcourses// is det
%
% show a list of courses
%
showcourses -->
	{
           courses(Courses)
        },
	html(table(class(courses), [
	     {|html||<tr><th>I.D.</th><th>Course Title</th><th>units</th><th>Prerequisites</th></tr>|},
		       \showcourses(Courses)])).


showcourses([])-->
	[].

showcourses([ course(ID, Title, Units, Descr, Reqs) | T]) -->
	html({|html(ID, Title, Units, Descr, Reqs)||
	         <tr><td>ID</td><td>Title</td><td>Units</td><td>Descr</td><td>Reqs</td></tr>
	     |}),
	showcourses(T).


