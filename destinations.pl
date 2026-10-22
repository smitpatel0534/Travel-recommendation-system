:- module(destinations,
          [ destination/1,
            place/2,
            location/2,
            estimated_cost/2,
            recommended_duration/2,
            best_season/2,
            activity/2,
            description/2,
            destination_details/2,
            categories/1,
            seasons/1,
            activities/1
          ]).

:- discontiguous destination/1,
                 place/2,
                 location/2,
                 estimated_cost/2,
                 best_season/2,
                 activity/2,
                 description/2.

% The cost is an approximate per-person trip budget in Indian rupees.
% Categories, seasons, and activities are shared identifiers used by the UI.
categories([beach, mountain, heritage, nature_wildlife, religious, adventure, hill_station, cultural]).
seasons([winter, summer, monsoon]).
activities([trekking, sightseeing, wildlife_exploration, relaxation, water_sports, rafting, pilgrimage, cultural_experiences, photography]).

recommended_duration(goa, 3).
recommended_duration(kerala, 5).
recommended_duration(andaman_islands, 6).
recommended_duration(manali, 4).
recommended_duration(shimla, 3).
recommended_duration(darjeeling, 3).
recommended_duration(jaipur, 3).
recommended_duration(udaipur, 3).
recommended_duration(agra, 2).
recommended_duration(varanasi, 3).
recommended_duration(rishikesh, 3).
recommended_duration(amritsar, 2).
recommended_duration(kaziranga, 3).
recommended_duration(jim_corbett, 3).
recommended_duration(leh_ladakh, 6).
recommended_duration(pondicherry, 3).
recommended_duration(khajuraho, 2).
recommended_duration(mysuru, 2).
recommended_duration(coorg, 3).
recommended_duration(jaisalmer, 3).
recommended_duration(vaishno_devi, 3).
recommended_duration(lakshadweep, 6).
recommended_duration(mumbai, 3).
recommended_duration(hampi, 3).
recommended_duration(bodh_gaya, 2).
recommended_duration(shillong, 4).
recommended_duration(ooty, 3).
recommended_duration(ranthambore, 3).
recommended_duration(auli, 4).
recommended_duration(gangtok, 4).
recommended_duration(konark, 2).

destination(goa).
place(goa, beach).
place(goa, cultural).
location(goa, goa).
estimated_cost(goa, 18000).
best_season(goa, winter).
best_season(goa, summer).
activity(goa, relaxation).
activity(goa, water_sports).
activity(goa, sightseeing).
description(goa, 'Sunny beaches, Portuguese heritage, lively markets, and coastal cuisine.').

destination(kerala).
place(kerala, beach).
place(kerala, nature_wildlife).
place(kerala, cultural).
location(kerala, kerala).
estimated_cost(kerala, 26000).
best_season(kerala, winter).
best_season(kerala, monsoon).
activity(kerala, relaxation).
activity(kerala, wildlife_exploration).
activity(kerala, sightseeing).
activity(kerala, cultural_experiences).
description(kerala, 'A relaxed mix of backwaters, beaches, tea gardens, and rich local traditions.').

destination(andaman_islands).
place(andaman_islands, beach).
place(andaman_islands, nature_wildlife).
place(andaman_islands, adventure).
location(andaman_islands, andaman_and_nicobar_islands).
estimated_cost(andaman_islands, 42000).
best_season(andaman_islands, winter).
best_season(andaman_islands, summer).
activity(andaman_islands, relaxation).
activity(andaman_islands, water_sports).
activity(andaman_islands, wildlife_exploration).
description(andaman_islands, 'Clear island waters, coral reefs, tropical forests, and historic Cellular Jail.').

destination(manali).
place(manali, mountain).
place(manali, adventure).
place(manali, hill_station).
location(manali, himachal_pradesh).
estimated_cost(manali, 22000).
best_season(manali, summer).
best_season(manali, winter).
activity(manali, trekking).
activity(manali, sightseeing).
activity(manali, relaxation).
description(manali, 'A Himalayan town known for mountain scenery, temples, and outdoor adventures.').

destination(shimla).
place(shimla, mountain).
place(shimla, hill_station).
place(shimla, heritage).
location(shimla, himachal_pradesh).
estimated_cost(shimla, 20000).
best_season(shimla, summer).
best_season(shimla, winter).
activity(shimla, sightseeing).
activity(shimla, relaxation).
activity(shimla, photography).
description(shimla, 'A historic hill town with colonial architecture, ridge walks, and views of the Himalayas.').

destination(darjeeling).
place(darjeeling, mountain).
place(darjeeling, hill_station).
place(darjeeling, cultural).
location(darjeeling, west_bengal).
estimated_cost(darjeeling, 24000).
best_season(darjeeling, summer).
best_season(darjeeling, winter).
activity(darjeeling, sightseeing).
activity(darjeeling, photography).
activity(darjeeling, cultural_experiences).
description(darjeeling, 'Famous for tea gardens, Himalayan views, monasteries, and its heritage railway.').

destination(jaipur).
place(jaipur, heritage).
place(jaipur, cultural).
location(jaipur, rajasthan).
estimated_cost(jaipur, 16000).
best_season(jaipur, winter).
best_season(jaipur, monsoon).
activity(jaipur, sightseeing).
activity(jaipur, cultural_experiences).
activity(jaipur, photography).
description(jaipur, 'The Pink City offers grand forts, royal palaces, crafts, and Rajasthani food.').

destination(udaipur).
place(udaipur, heritage).
place(udaipur, cultural).
location(udaipur, rajasthan).
estimated_cost(udaipur, 21000).
best_season(udaipur, winter).
best_season(udaipur, monsoon).
activity(udaipur, sightseeing).
activity(udaipur, relaxation).
activity(udaipur, cultural_experiences).
description(udaipur, 'Lakeside palaces, historic streets, and Mewar arts make this a graceful heritage city.').

destination(agra).
place(agra, heritage).
place(agra, cultural).
location(agra, uttar_pradesh).
estimated_cost(agra, 14000).
best_season(agra, winter).
best_season(agra, monsoon).
activity(agra, sightseeing).
activity(agra, photography).
description(agra, 'Home to the Taj Mahal and other remarkable Mughal-era monuments.').

destination(varanasi).
place(varanasi, religious).
place(varanasi, heritage).
place(varanasi, cultural).
location(varanasi, uttar_pradesh).
estimated_cost(varanasi, 12000).
best_season(varanasi, winter).
best_season(varanasi, monsoon).
activity(varanasi, pilgrimage).
activity(varanasi, sightseeing).
activity(varanasi, cultural_experiences).
description(varanasi, 'One of India’s oldest living cities, celebrated for its riverfront and spiritual traditions.').

destination(rishikesh).
place(rishikesh, religious).
place(rishikesh, adventure).
place(rishikesh, nature_wildlife).
location(rishikesh, uttarakhand).
estimated_cost(rishikesh, 15000).
best_season(rishikesh, winter).
best_season(rishikesh, summer).
activity(rishikesh, pilgrimage).
activity(rishikesh, rafting).
activity(rishikesh, trekking).
description(rishikesh, 'A Himalayan riverside destination combining yoga, sacred sites, and outdoor adventure.').

destination(amritsar).
place(amritsar, religious).
place(amritsar, cultural).
location(amritsar, punjab).
estimated_cost(amritsar, 13000).
best_season(amritsar, winter).
best_season(amritsar, monsoon).
activity(amritsar, pilgrimage).
activity(amritsar, sightseeing).
activity(amritsar, cultural_experiences).
description(amritsar, 'Visit the Golden Temple, historic landmarks, and vibrant Punjabi food markets.').

destination(kaziranga).
place(kaziranga, nature_wildlife).
location(kaziranga, assam).
estimated_cost(kaziranga, 28000).
best_season(kaziranga, winter).
best_season(kaziranga, summer).
activity(kaziranga, wildlife_exploration).
activity(kaziranga, photography).
description(kaziranga, 'A wildlife-rich national park known for the greater one-horned rhinoceros.').

destination(jim_corbett).
place(jim_corbett, nature_wildlife).
location(jim_corbett, uttarakhand).
estimated_cost(jim_corbett, 25000).
best_season(jim_corbett, winter).
best_season(jim_corbett, summer).
activity(jim_corbett, wildlife_exploration).
activity(jim_corbett, photography).
description(jim_corbett, 'Forests, river landscapes, and wildlife safaris in India’s oldest national park.').

destination(leh_ladakh).
place(leh_ladakh, mountain).
place(leh_ladakh, adventure).
place(leh_ladakh, nature_wildlife).
location(leh_ladakh, ladakh).
estimated_cost(leh_ladakh, 38000).
best_season(leh_ladakh, summer).
activity(leh_ladakh, trekking).
activity(leh_ladakh, sightseeing).
activity(leh_ladakh, photography).
description(leh_ladakh, 'High-altitude deserts, dramatic passes, monasteries, and unforgettable road journeys.').

destination(pondicherry).
place(pondicherry, beach).
place(pondicherry, cultural).
location(pondicherry, puducherry).
estimated_cost(pondicherry, 17000).
best_season(pondicherry, winter).
best_season(pondicherry, summer).
activity(pondicherry, relaxation).
activity(pondicherry, sightseeing).
activity(pondicherry, water_sports).
description(pondicherry, 'A coastal town with French-inspired streets, quiet beaches, and a distinctive food scene.').

destination(khajuraho).
place(khajuraho, heritage).
place(khajuraho, cultural).
location(khajuraho, madhya_pradesh).
estimated_cost(khajuraho, 15000).
best_season(khajuraho, winter).
best_season(khajuraho, monsoon).
activity(khajuraho, sightseeing).
activity(khajuraho, photography).
activity(khajuraho, cultural_experiences).
description(khajuraho, 'A UNESCO-listed group of temples admired for their intricate stone carvings.').

destination(mysuru).
place(mysuru, heritage).
place(mysuru, cultural).
location(mysuru, karnataka).
estimated_cost(mysuru, 14000).
best_season(mysuru, winter).
best_season(mysuru, monsoon).
activity(mysuru, sightseeing).
activity(mysuru, cultural_experiences).
description(mysuru, 'A historic Karnataka city known for its palace, gardens, and celebrated festivals.').

destination(coorg).
place(coorg, mountain).
place(coorg, nature_wildlife).
place(coorg, hill_station).
location(coorg, karnataka).
estimated_cost(coorg, 23000).
best_season(coorg, winter).
best_season(coorg, monsoon).
activity(coorg, trekking).
activity(coorg, relaxation).
activity(coorg, wildlife_exploration).
description(coorg, 'A green highland region of coffee estates, forest trails, and cascading waterfalls.').

destination(jaisalmer).
place(jaisalmer, heritage).
place(jaisalmer, cultural).
place(jaisalmer, adventure).
location(jaisalmer, rajasthan).
estimated_cost(jaisalmer, 19000).
best_season(jaisalmer, winter).
activity(jaisalmer, sightseeing).
activity(jaisalmer, cultural_experiences).
activity(jaisalmer, photography).
description(jaisalmer, 'A golden sandstone fort city with desert camps, havelis, and camel safaris.').

destination(vaishno_devi).
place(vaishno_devi, religious).
place(vaishno_devi, mountain).
location(vaishno_devi, jammu_and_kashmir).
estimated_cost(vaishno_devi, 16000).
best_season(vaishno_devi, summer).
best_season(vaishno_devi, winter).
activity(vaishno_devi, pilgrimage).
activity(vaishno_devi, trekking).
description(vaishno_devi, 'A revered Himalayan shrine reached by a mountain pilgrimage route.').

destination(lakshadweep).
place(lakshadweep, beach).
place(lakshadweep, adventure).
place(lakshadweep, nature_wildlife).
location(lakshadweep, lakshadweep).
estimated_cost(lakshadweep, 48000).
best_season(lakshadweep, winter).
best_season(lakshadweep, summer).
activity(lakshadweep, relaxation).
activity(lakshadweep, water_sports).
activity(lakshadweep, wildlife_exploration).
description(lakshadweep, 'A remote archipelago with coral lagoons, island beaches, and snorkeling opportunities.').

destination(mumbai).
place(mumbai, beach).
place(mumbai, heritage).
place(mumbai, cultural).
location(mumbai, maharashtra).
estimated_cost(mumbai, 24000).
best_season(mumbai, winter).
best_season(mumbai, monsoon).
activity(mumbai, sightseeing).
activity(mumbai, cultural_experiences).
activity(mumbai, photography).
description(mumbai, 'A coastal metropolis of historic landmarks, lively neighborhoods, and celebrated food.').

destination(hampi).
place(hampi, heritage).
place(hampi, cultural).
location(hampi, karnataka).
estimated_cost(hampi, 18000).
best_season(hampi, winter).
best_season(hampi, monsoon).
activity(hampi, sightseeing).
activity(hampi, cultural_experiences).
activity(hampi, photography).
description(hampi, 'Explore the monumental ruins, temples, and boulder landscapes of the Vijayanagara capital.').

destination(bodh_gaya).
place(bodh_gaya, religious).
place(bodh_gaya, heritage).
location(bodh_gaya, bihar).
estimated_cost(bodh_gaya, 13000).
best_season(bodh_gaya, winter).
best_season(bodh_gaya, monsoon).
activity(bodh_gaya, pilgrimage).
activity(bodh_gaya, sightseeing).
activity(bodh_gaya, cultural_experiences).
description(bodh_gaya, 'A major Buddhist pilgrimage site associated with the Buddha’s enlightenment.').

destination(shillong).
place(shillong, hill_station).
place(shillong, nature_wildlife).
place(shillong, cultural).
location(shillong, meghalaya).
estimated_cost(shillong, 22000).
best_season(shillong, winter).
best_season(shillong, summer).
activity(shillong, sightseeing).
activity(shillong, trekking).
activity(shillong, cultural_experiences).
description(shillong, 'A highland city known for Khasi culture, waterfalls, and nearby forested landscapes.').

destination(ooty).
place(ooty, hill_station).
place(ooty, mountain).
place(ooty, nature_wildlife).
location(ooty, tamil_nadu).
estimated_cost(ooty, 20000).
best_season(ooty, winter).
best_season(ooty, summer).
activity(ooty, sightseeing).
activity(ooty, trekking).
activity(ooty, relaxation).
description(ooty, 'A Nilgiri hill station with tea gardens, mountain rail journeys, and botanical gardens.').

destination(ranthambore).
place(ranthambore, nature_wildlife).
place(ranthambore, adventure).
location(ranthambore, rajasthan).
estimated_cost(ranthambore, 26000).
best_season(ranthambore, winter).
best_season(ranthambore, summer).
activity(ranthambore, wildlife_exploration).
activity(ranthambore, photography).
description(ranthambore, 'A wildlife reserve combining forest safaris with the historic Ranthambore Fort.').

destination(auli).
place(auli, mountain).
place(auli, adventure).
place(auli, hill_station).
location(auli, uttarakhand).
estimated_cost(auli, 27000).
best_season(auli, winter).
best_season(auli, summer).
activity(auli, trekking).
activity(auli, sightseeing).
activity(auli, photography).
description(auli, 'A Himalayan resort area known for mountain views, winter sports, and trekking routes.').

destination(gangtok).
place(gangtok, mountain).
place(gangtok, nature_wildlife).
place(gangtok, cultural).
location(gangtok, sikkim).
estimated_cost(gangtok, 28000).
best_season(gangtok, winter).
best_season(gangtok, summer).
activity(gangtok, trekking).
activity(gangtok, sightseeing).
activity(gangtok, cultural_experiences).
description(gangtok, 'A mountain capital with monasteries, local markets, and views of the eastern Himalayas.').

destination(konark).
place(konark, heritage).
place(konark, cultural).
place(konark, beach).
location(konark, odisha).
estimated_cost(konark, 16000).
best_season(konark, winter).
best_season(konark, monsoon).
activity(konark, sightseeing).
activity(konark, cultural_experiences).
activity(konark, photography).
description(konark, 'Visit the sculpted Sun Temple and nearby coastal scenery in Odisha.').

% Return a single structured record, or fail when the name is not in the KB.
destination_details(Name, details(Name, Categories, State, Cost, Duration, Seasons, Activities, Description)) :-
    destination(Name),
    findall(Category, place(Name, Category), Categories),
    location(Name, State),
    estimated_cost(Name, Cost),
    recommended_duration(Name, Duration),
    findall(Season, best_season(Name, Season), Seasons),
    findall(Activity, activity(Name, Activity), Activities),
    description(Name, Description).
