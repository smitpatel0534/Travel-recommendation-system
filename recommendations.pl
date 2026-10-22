:- module(recommendations,
          [ matching_destinations/2,
            top_recommendations/3,
            recommendation_score/3,
            recommendation_score_breakdown/3,
            recommendation_reasons/2,
            destination_details/2,
            destination_name/2
          ]).

:- use_module(destinations,
              [ destination/1,
                place/2,
                estimated_cost/2,
                best_season/2,
                activity/2,
                recommended_duration/2,
                categories/1,
                seasons/1,
                activities/1,
                destination_details/2
              ]).

% A criteria term is criteria(Category, MaximumCost, Season, Activity).
% Use 'any' for a preference the user does not want to constrain.
matching_destinations(Criteria, Destinations) :-
    findall(Name,
            ( destination(Name),
              matches_criteria(Name, Criteria)
            ),
            Unsorted),
    sort(Unsorted, Destinations).

matches_criteria(Name, criteria(Category, MaximumCost, Season, Activity)) :-
    categories(Categories),
    seasons(Seasons),
    activities(Activities),
    valid_criterion(Category, Categories),
    valid_budget(MaximumCost),
    valid_criterion(Season, Seasons),
    valid_criterion(Activity, Activities),
    matches_category(Name, Category),
    matches_budget(Name, MaximumCost),
    matches_season(Name, Season),
    matches_activity(Name, Activity).

valid_criterion(any, _).
valid_criterion(Value, Allowed) :-
    memberchk(Value, Allowed).

valid_budget(any).
valid_budget(Budget) :-
    number(Budget),
    Budget >= 0.

matches_category(_, any).
matches_category(Name, Category) :-
    Category \= any,
    place(Name, Category).

matches_budget(_, any).
matches_budget(Name, Budget) :-
    number(Budget),
    estimated_cost(Name, Cost),
    Cost =< Budget.

matches_season(_, any).
matches_season(Name, Season) :-
    Season \= any,
    best_season(Name, Season).

matches_activity(_, any).
matches_activity(Name, Activity) :-
    Activity \= any,
    activity(Name, Activity).

recommendation_score(Name, Criteria, Score) :-
    recommendation_score_breakdown(Name, Criteria, Breakdown),
    score_components(Breakdown, Score).

recommendation_score_breakdown(Name, Criteria, Breakdown) :-
    destination(Name),
    matches_criteria(Name, Criteria),
    Criteria = criteria(Category, MaximumCost, Season, Activity),
    preference_component(Category, matches_category(Name, Category), category, CategoryScore),
    preference_component(MaximumCost, matches_budget(Name, MaximumCost), budget, BudgetScore),
    preference_component(Season, matches_season(Name, Season), season, SeasonScore),
    preference_component(Activity, matches_activity(Name, Activity), activity, ActivityScore),
    budget_component(Name, MaximumCost, BudgetComponent),
    append([CategoryScore, BudgetScore, SeasonScore, ActivityScore, BudgetComponent],
           Breakdown).

preference_component(any, _, _, []).
preference_component(_, Goal, Label, [preference_match(Label, 10)]) :-
    call(Goal).

budget_component(Name, Budget, [budget_headroom(Bonus)]) :-
    number(Budget),
    Budget > 0,
    estimated_cost(Name, Cost),
    Cost =< Budget,
    Bonus is ((Budget - Cost) * 10) // Budget,
    !.
budget_component(Name, any, [cost_efficiency(Bonus)]) :-
    estimated_cost(Name, Cost),
    findall(Amount, estimated_cost(_, Amount), Costs),
    max_list(Costs, MaximumCost),
    Bonus is ((MaximumCost - Cost) * 10) // MaximumCost.

score_components([], 0).
score_components([Component|Components], Score) :-
    component_points(Component, Points),
    score_components(Components, Remaining),
    Score is Points + Remaining.

component_points(preference_match(_, Points), Points).
component_points(budget_headroom(Points), Points).
component_points(cost_efficiency(Points), Points).

top_recommendations(Criteria, Limit, Results) :-
    integer(Limit),
    Limit >= 0,
    matching_destinations(Criteria, Names),
    findall(key(NegativeScore, Duration, Cost, Name)-Name,
            ( member(Name, Names),
              recommendation_score(Name, Criteria, Score),
              NegativeScore is -Score,
              recommended_duration(Name, Duration),
              estimated_cost(Name, Cost)
            ),
            Pairs),
    keysort(Pairs, Sorted),
    take(Limit, Sorted, Limited),
    ranked_names(Limited, Results).

take(0, _, []) :- !.
take(_, [], []) :- !.
take(Count, [Head|Tail], [Head|Rest]) :-
    Count > 0,
    Remaining is Count - 1,
    take(Remaining, Tail, Rest).

ranked_names([], []).
ranked_names([key(_, _, _, _)-Name|Pairs], [Name|Names]) :-
    ranked_names(Pairs, Names).

recommendation_reasons(Name, Reasons) :-
    destination(Name),
    findall(Reason, recommendation_reason(Name, Reason), Reasons).

recommendation_reason(Name, matches_category(Category)) :-
    place(Name, Category).
recommendation_reason(Name, estimated_cost(Cost)) :-
    estimated_cost(Name, Cost).
recommendation_reason(Name, suitable_season(Season)) :-
    best_season(Name, Season).
recommendation_reason(Name, suitable_activity(Activity)) :-
    activity(Name, Activity).

destination_name(Name, DisplayName) :-
    atom(Name),
    atomic_list_concat(Parts, '_', Name),
    maplist(capitalize_atom, Parts, Capitalized),
    atomic_list_concat(Capitalized, ' ', DisplayName).

capitalize_atom(Atom, Capitalized) :-
    atom_chars(Atom, [First|Rest]),
    upcase_atom(First, Upper),
    atom_chars(Capitalized, [Upper|Rest]).
