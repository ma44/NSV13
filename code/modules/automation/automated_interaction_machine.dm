//A machine that can interact with things that enter it with specific interactions or with tools, endless possibilities for automation

/obj/structure/machinery/automated_interaction_machine
	name = "Automated Interaction Machine"
	desc = "Also known as AIM, this piece of machinery can interact with things in various ways, including using various other items like tools."
	icon = 'icons/obj/recycling.dmi'
	icon_state = "grinder-o0"
	layer = ABOVE_ALL_MOB_LAYER
	///The machine will try to attack the inserted thing every [delayed_action_cooldown] deciseconds
	var/delayed_action_cooldown
	///The machine will try to attack the inserted thing this many times
	var/this_many_actions_per_insert
	///How many actions are left to do before expelling the item being worked on
	var/how_many_actions_left
	///If a thing crosses this and is a mob, this machine won't attempt to hit the thing
	var/ignore_mobs = TRUE
	///Reference to the atom that's currently being worked on by this machine
	var/atom/movable/working_on_this_atom
	///The current thing to try attacking the inserted thing with
	var/atom/thing_to_attack_with
	///The dir to output atoms that are done being worked
	var/output_dir = SOUTH

/obj/structure/machinery/automated_interaction_machine/Initialize()
	. = ..()

/obj/structure/machinery/automated_interation_machine/Bumped(atom/movable/AM)

	if(stat && (BROKEN|NOPOWER))
		return

	if(!anchored)
		return

	if(working_on_this_atom)
		return

	if(ismob(AM) && ignore_mobs)
		return

	working_on_this_atom = AM
	start_working()

/obj/structure/machinery/automated_interaction_machine/proc/start_working()

