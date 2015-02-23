:- module(html_handlers, []).
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
:- http_handler(/, course_page , []).

%%	course_page(+Request:request) is det
%
%	A simple page using the 'termerized html' form
%
course_page(_Request) :-
	reply_html_page(
	    ucsd,
	    title('UCSD CS Course Planner!'),
	    div([
		 p(['Check the courses you', &(apos), 've already taken']),
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
	html(form(action('/taken'), [
		   table(class(courses), [
	     \['<thead><tr><th>Taken</th><th>I.D.</th><th>Course Title</th><th>Units</th><th>Description</th><th>Prerequisites</th></tr></thead>'],
	     tbody(\showcourses(Courses))]),
	     input([type(submit),
		    name(submit),
		    value('Update')], [])
		   ])).

showcourses([])-->
	[].

showcourses([ course(ID, Title, Units, Descr, Reqs) | T]) -->
	html({|html(ID, Title, Units, Descr, Reqs)||
	         <tr><td><input type="checkbox" name="ID"></td><td>ID</td><td>Title</td><td>Units</td><td>Descr</td><td>Reqs</td></tr>
	     |}),
	showcourses(T).


