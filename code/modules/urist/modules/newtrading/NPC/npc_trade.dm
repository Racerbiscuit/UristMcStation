
/mob/living/simple_animal/hostile/npc/proc/check_tradeable(var/obj/O)
	. = 0

	if(!O)
		return 0

	if(O.trader_category && O.trader_category in trade_categories_by_name)
		return 1

	if(O.type in trade_items_by_type)
		return 1

/mob/living/simple_animal/hostile/npc/proc/get_trade_value(var/obj/O)
	if(!O)
		return 0

	//this uses the default SS13 item_worth procs so its a good fallback
	. = get_value(O)

	//see if we are already selling the item
	var/datum/trade_item/T = trade_items_inventory_by_type[O.type]
	if(T)
		return T.value

	//check if its an accepted item
	T = trade_items_by_type[O.type]
	if(T)
		//this is in the accepted trade categories initialise the trade item but keep it hidden for now
		//note: spawn_trade_item() will slightly randomise the sale value to make it different per NPC
		spawn_trade_item(T, 1)
		return T.value

	//try and find it via the global controller
	T = trade_controller.trade_items_by_type[O.type]
	if(T)
		return T.value

	//try and find it via the global categories
	/*
	var/obj_category = O.trader_category
	if(obj_category)
		var/datum/trade_category/C = trade_categories_by_name[obj_category]
		var/init_hidden_trade_item = 0
		if(C)
			init_hidden_trade_item = 1
		else
			//we'll have to get the global value
			//dont initialise a hidden trade item because we probably wont be trading it
			C = trade_controller.get_trade_category(obj_category)

		T = C.trade_items_by_type[O.type]
		if(T)
			if(init_hidden_trade_item)
				//this is in the accepted trade categories initialise the trade item but keep it hidden for now
				//note: spawn_trade_item() will slightly randomise the sale value to make it different per NPC
				spawn_trade_item(T, 1)

			. = T.value
			*/
