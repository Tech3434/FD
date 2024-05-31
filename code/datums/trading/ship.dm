//Ships are on a time limit as far as being around goes.
//They are ALSO the only ones that can appear after round start
/datum/trader/ship
	var/duration_of_stay = 0
	var/typical_duration = 30 //minutes (since trader processes only tick once a minute)

	overmap_object_type = /obj/overmap/trading/ship

/datum/trader/ship/New()
	..()
	duration_of_stay = rand(typical_duration,typical_duration * 2)

/datum/trader/ship/tick()
	..()
	if(prob(-min(list_values(disposition))))
		duration_of_stay -= 5
	return --duration_of_stay > 0

/datum/trader/ship/bribe_to_stay_longer(amt, ship_z)
	if(prob(-disposition[map_sectors["[ship_z]"]]))
		return ..()

	var/length = round(amt/100)
	duration_of_stay += length
	var/datum/trade_response/tr = make_response(TRADER_BRIBE_SUCCESS, "Sure, I'll stay for TIME more minutes.", -amt, TRUE)
	tr.text = replacetext(tr.text, "TIME", length)
	return tr
