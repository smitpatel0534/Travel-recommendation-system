:- module(main, [run/0, parse_menu_choice/2]).

:- use_module(destinations).
:- use_module(recommendations).

run :-
    writeln('========== TRAVEL RECOMMENDATION SYSTEM =========='),
    catch(menu_loop, end_of_input,
          writeln('Input closed. Exiting the Travel Recommendation System.')).

menu_loop :-
    nl,
    writeln('1. Recommend by Travel Type'),
    writeln('2. Recommend by Budget'),
    writeln('3. Recommend by Season'),
    writeln('4. Recommend by Activity'),
    writeln('5. Combined Recommendations'),
    writeln('6. Search Destination'),
    writeln('7. Display All Destinations'),
    writeln('8. Top Recommendations'),
    writeln('9. Exit'),
    write('Enter your choice: '),
    read_input_line(Input),
    (   parse_menu_choice(Input, Choice)
    ->  handle_choice(Choice),
        (Choice =:= 9 -> true ; menu_loop)
    ;   writeln('Please enter a number from 1 to 9.'),
        menu_loop
    ).

parse_menu_choice(Input, Choice) :-
    string(Input),
    normalize_space(string(Trimmed), Input),
    (   catch(number_string(Number, Trimmed), _, fail),
        integer(Number),
        between(1, 9, Number)
    ->  Choice = Number
    ;   fail
    ).

handle_choice(1) :-
    choose_category(Category),
    show_matches(criteria(Category, any, any, any)).
handle_choice(2) :-
    read_nonnegative_integer('Maximum budget in INR: ', Budget),
    show_matches(criteria(any, Budget, any, any)).
handle_choice(3) :-
    choose_from('season', seasons, Season),
    show_matches(criteria(any, any, Season, any)).
handle_choice(4) :-
    choose_from('activity', activities, Activity),
    show_matches(criteria(any, any, any, Activity)).
handle_choice(5) :-
    choose_category_or_any(Category),
    read_budget_or_any(Budget),
    choose_from_or_any('season', seasons, Season),
    choose_from_or_any('activity', activities, Activity),
    show_matches(criteria(Category, Budget, Season, Activity)).
handle_choice(6) :-
    write('Enter a destination name (for example, Goa or Leh Ladakh): '),
    read_input_line(Input),
    destination_atom(Input, Name),
    (   destination_details(Name, Details)
    ->  print_details(Details)
    ;   writeln('Destination not found. Check the name and try again.')
    ).
handle_choice(7) :-
    matching_destinations(criteria(any, any, any, any), Names),
    print_destinations(Names).
handle_choice(8) :-
    choose_category_or_any(Category),
    read_budget_or_any(Budget),
    choose_from_or_any('season', seasons, Season),
    choose_from_or_any('activity', activities, Activity),
    write('How many results should be shown? '),
    read_nonnegative_integer('Number of results: ', Limit),
    Criteria = criteria(Category, Budget, Season, Activity),
    top_recommendations(Criteria, Limit, Names),
    show_ranked_results(Names, Criteria).
handle_choice(9) :-
    writeln('Thank you for using the Travel Recommendation System.').

choose_category(Category) :-
    categories(Categories),
    choose_indexed('travel category', Categories, Category).

choose_category_or_any(Category) :-
    categories(Categories),
    choose_indexed_or_any('travel category', Categories, Category).

choose_from(Label, Predicate, Value) :-
    call(Predicate, Values),
    choose_indexed(Label, Values, Value).

choose_from_or_any(Label, Predicate, Value) :-
    call(Predicate, Values),
    choose_indexed_or_any(Label, Values, Value).

choose_indexed(Label, Values, Value) :-
    format('Choose ~w:~n', [Label]),
    print_options(Values, 1),
    length(Values, Count),
    format('Enter a number (1-~d): ', [Count]),
    read_input_line(Input),
    (   parse_index(Input, Count, Index)
    ->  nth1(Index, Values, Value)
    ;   writeln('Invalid selection. Please try again.'),
        choose_indexed(Label, Values, Value)
    ).

choose_indexed_or_any(Label, Values, Value) :-
    format('Choose ~w (or 0 for any):~n', [Label]),
    print_options(Values, 1),
    write('0. Any'),
    nl,
    length(Values, Count),
    format('Enter a number (0-~d): ', [Count]),
    read_input_line(Input),
    (   parse_index(Input, Count, Index)
    ->  (Index =:= 0 -> Value = any ; nth1(Index, Values, Value))
    ;   writeln('Invalid selection. Please try again.'),
        choose_indexed_or_any(Label, Values, Value)
    ).

print_options([], _).
print_options([Value|Values], Index) :-
    destination_name(Value, Display),
    format('~d. ~w~n', [Index, Display]),
    Next is Index + 1,
    print_options(Values, Next).

parse_index(Input, Maximum, Index) :-
    string(Input),
    normalize_space(string(Trimmed), Input),
    catch(number_string(Number, Trimmed), _, fail),
    integer(Number),
    between(0, Maximum, Number),
    Index = Number.

read_nonnegative_integer(Prompt, Value) :-
    write(Prompt),
    read_input_line(Input),
    (   string(Input),
        normalize_space(string(Trimmed), Input),
        catch(number_string(Number, Trimmed), _, fail),
        integer(Number),
        Number >= 0
    ->  Value = Number
    ;   writeln('Please enter a whole number zero or greater.'),
        read_nonnegative_integer(Prompt, Value)
    ).

read_budget_or_any(Budget) :-
    write('Maximum budget in INR (0 for any budget): '),
    read_input_line(Input),
    (   string(Input),
        normalize_space(string(Trimmed), Input),
        catch(number_string(Number, Trimmed), _, fail),
        integer(Number),
        Number >= 0
    ->  (Number =:= 0 -> Budget = any ; Budget = Number)
    ;   writeln('Please enter a whole number zero or greater.'),
        read_budget_or_any(Budget)
    ).

destination_atom(Input, Name) :-
    string(Input),
    normalize_space(string(Trimmed), Input),
    (   Trimmed == ""
    ->  Name = ''
    ;   split_string(Trimmed, " ", " ", Words),
        atomic_list_concat(Words, '_', RawName),
        downcase_atom(RawName, Name)
    ).

read_input_line(Input) :-
    read_line_to_string(user_input, Input),
    (Input == end_of_file -> throw(end_of_input) ; true).

show_matches(Criteria) :-
    matching_destinations(Criteria, Names),
    show_results(Names, Criteria).

show_results([], _) :-
    writeln('No destinations match those preferences. Try relaxing one or more filters.').
show_results(Names, Criteria) :-
    forall(member(Name, Names),
           ( print_details_for(Name),
             explain_match(Name, Criteria)
           )).

show_ranked_results([], _) :-
    writeln('No destinations match those preferences. Try relaxing one or more filters.').
show_ranked_results(Names, Criteria) :-
    forall(member(Name, Names),
           ( recommendation_score_breakdown(Name, Criteria, Breakdown),
             recommendation_score(Name, Criteria, Score),
             format('Recommendation score: ~d (', [Score]),
             print_score_breakdown(Breakdown),
             writeln(')'),
             print_details_for(Name),
             explain_match(Name, Criteria)
           )).

print_score_breakdown([]) :-
    write('no selected preferences').
print_score_breakdown([Component|Components]) :-
    print_score_component(Component),
    print_remaining_score_components(Components).

print_remaining_score_components([]).
print_remaining_score_components([Component|Components]) :-
    write(', '),
    print_score_component(Component),
    print_remaining_score_components(Components).

print_score_component(preference_match(Preference, Points)) :-
    destination_name(Preference, Display),
    format('~w +~d', [Display, Points]).
print_score_component(budget_headroom(Points)) :-
    format('budget headroom +~d', [Points]).
print_score_component(cost_efficiency(Points)) :-
    format('cost efficiency +~d', [Points]).

print_destinations([]) :-
    writeln('No destinations are stored in the knowledge base.').
print_destinations(Names) :-
    forall(member(Name, Names), print_details_for(Name)).

print_details_for(Name) :-
    destination_details(Name, Details),
    print_details(Details).

print_details(details(Name, Categories, State, Cost, Duration, Seasons, Activities, Description)) :-
    destination_name(Name, DisplayName),
    maplist(destination_name, Categories, CategoryNames),
    maplist(destination_name, Seasons, SeasonNames),
    maplist(destination_name, Activities, ActivityNames),
    format('~n--- ~w ---~n', [DisplayName]),
    format('Category: ~w~n', [CategoryNames]),
    destination_name(State, StateName),
    format('State/Union territory: ~w~n', [StateName]),
    format('Estimated budget: INR ~D per person~n', [Cost]),
    format('Suggested trip duration: ~D days~n', [Duration]),
    format('Best seasons: ~w~n', [SeasonNames]),
    format('Activities: ~w~n', [ActivityNames]),
    format('About: ~w~n', [Description]).

explain_match(Name, Criteria) :-
    Criteria = criteria(Category, Budget, Season, Activity),
    destination_name(Name, DisplayName),
    format('Why recommended for ~w: ', [DisplayName]),
    findall(Reason,
            selected_reason(Name, Category, Budget, Season, Activity, Reason),
            Reasons),
    print_reason_list(Reasons),
    nl.

selected_reason(Name, Category, _, _, _, category(Category)) :-
    Category \= any,
    place(Name, Category).
selected_reason(Name, _, Budget, _, _, within_budget(Cost, Budget)) :-
    Budget \= any,
    estimated_cost(Name, Cost).
selected_reason(Name, _, _, Season, _, suitable_season(Season)) :-
    Season \= any,
    best_season(Name, Season).
selected_reason(Name, _, _, _, Activity, suitable_activity(Activity)) :-
    Activity \= any,
    activity(Name, Activity).
selected_reason(Name, any, any, any, any, destination_in_knowledge_base(Name)).

print_reason_list([]) :-
    write('included in the destination knowledge base').
print_reason_list([Reason|Reasons]) :-
    print_reason(Reason),
    print_remaining_reasons(Reasons).

print_remaining_reasons([]).
print_remaining_reasons([Reason|Reasons]) :-
    write('; '),
    print_reason(Reason),
    print_remaining_reasons(Reasons).

print_reason(category(Category)) :-
    destination_name(Category, Display),
    format('matches the ~w category', [Display]).
print_reason(within_budget(Cost, Budget)) :-
    format('estimated cost INR ~D is within INR ~D', [Cost, Budget]).
print_reason(suitable_season(Season)) :-
    destination_name(Season, Display),
    format('suitable for ~w', [Display]).
print_reason(suitable_activity(Activity)) :-
    destination_name(Activity, Display),
    format('offers ~w', [Display]).
print_reason(destination_in_knowledge_base(Name)) :-
    destination_name(Name, Display),
    format('~w is in the knowledge base', [Display]).
