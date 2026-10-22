:- begin_tests(travel_recommendations).

:- use_module(destinations).
:- use_module(recommendations).
:- use_module(main, [parse_menu_choice/2]).

test(beach_recommendations_include_goa_and_kerala) :-
    matching_destinations(criteria(beach, any, any, any), Names),
    memberchk(goa, Names),
    memberchk(kerala, Names),
    memberchk(pondicherry, Names).

test(heritage_recommendations_include_multiple_destinations) :-
    matching_destinations(criteria(heritage, any, any, any), Names),
    memberchk(jaipur, Names),
    memberchk(udaipur, Names),
    memberchk(agra, Names),
    length(Names, Count),
    Count >= 4.

test(budget_filter_excludes_over_budget_destination) :-
    matching_destinations(criteria(any, 15000, any, any), Names),
    memberchk(agra, Names),
    \+ memberchk(goa, Names),
    \+ memberchk(manali, Names).

test(season_filter) :-
    matching_destinations(criteria(any, any, monsoon, any), Names),
    memberchk(kerala, Names),
    \+ memberchk(goa, Names).

test(activity_filter) :-
    matching_destinations(criteria(any, any, any, wildlife_exploration), Names),
    memberchk(kaziranga, Names),
    memberchk(kerala, Names),
    \+ memberchk(jaipur, Names).

test(combined_preferences) :-
    matching_destinations(criteria(heritage, 15000, winter, sightseeing), Names),
    Names == [agra, bodh_gaya, khajuraho, mysuru, varanasi].

test(unknown_destination_returns_no_details, [fail]) :-
    destination_details(atlantis, _).

test(invalid_category_has_no_matches) :-
    matching_destinations(criteria(invalid_category, any, any, any), []).

test(all_destinations_have_complete_details) :-
    forall(destination(Name),
           ( destination_details(Name,
                                 details(Name, Categories, State, Cost, Duration,
                                         Seasons, Activities, Description)),
             Categories \= [],
             atom(State),
             integer(Cost),
             integer(Duration),
             Duration > 0,
             Seasons \= [],
             Activities \= [],
             atom(Description)
           )).

test(knowledge_base_contains_31_destinations) :-
    findall(Name, destination(Name), Names),
    sort(Names, UniqueNames),
    length(UniqueNames, 31).

test(reasons_report_estimated_cost_not_an_unchecked_budget) :-
    recommendation_reasons(goa, Reasons),
    memberchk(estimated_cost(18000), Reasons),
    \+ memberchk(within_budget(18000), Reasons).

test(valid_menu_input) :-
    parse_menu_choice("9", 9).

test(invalid_menu_input_is_rejected, [fail]) :-
    parse_menu_choice("99", _).

test(top_recommendations_rank_all_selected_preferences) :-
    Criteria = criteria(heritage, 15000, winter, sightseeing),
    top_recommendations(Criteria, 2, Names),
    Names == [varanasi, bodh_gaya].

test(score_breakdown_is_transparent) :-
    Criteria = criteria(heritage, 15000, winter, sightseeing),
    recommendation_score_breakdown(varanasi, Criteria, Breakdown),
    Breakdown == [preference_match(category, 10),
                  preference_match(budget, 10),
                  preference_match(season, 10),
                  preference_match(activity, 10),
                  budget_headroom(2)],
    recommendation_score(varanasi, Criteria, 42).

test(unconstrained_ranking_prefers_lower_cost_and_shorter_trips) :-
    top_recommendations(criteria(any, any, any, any), 3, Names),
    Names == [amritsar, bodh_gaya, agra].

test(new_destinations_are_recommendable) :-
    matching_destinations(criteria(beach, any, any, any), BeachPlaces),
    memberchk(lakshadweep, BeachPlaces),
    memberchk(konark, BeachPlaces),
    matching_destinations(criteria(hill_station, any, any, any), HillStations),
    memberchk(ooty, HillStations),
    memberchk(shillong, HillStations).

test(new_destination_includes_duration) :-
    destination_details(hampi, details(hampi, _, karnataka, 18000, 3, _, _, _)).

:- end_tests(travel_recommendations).

:- initialization(main, main).

main :-
    run_tests,
    halt.
