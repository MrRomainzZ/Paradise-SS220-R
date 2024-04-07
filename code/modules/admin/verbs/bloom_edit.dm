/client/proc/debug_bloom()
	set name = "Bloom Edit"
	set category = "Debug"

	if(!check_rights(R_VAREDIT))
		return
	if(!holder.edit_bloom)
		holder.edit_bloom = new /datum/bloom_edit(src)
	holder.edit_bloom.ui_interact(usr)

	message_admins("[key_name(src)] opened Bloom Edit panel.")
	log_admin("[key_name(src)] opened Bloom Edit panel.")

/datum/bloom_edit

/datum/bloom_edit/ui_interact(mob/user, datum/tgui/ui = null)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "BloomEdit", "Bloom Edit")
		ui.open()

/datum/bloom_edit/ui_data(mob/user)
	var/list/data = list()

	data["glow_brightness_base"] = GLOB.configuration.lighting_effects.glow_brightness_base
	data["glow_brightness_power"] = GLOB.configuration.lighting_effects.glow_brightness_power
	data["glow_contrast_base"] = GLOB.configuration.lighting_effects.glow_contrast_base
	data["glow_contrast_power"] = GLOB.configuration.lighting_effects.glow_contrast_power
	data["exposure_brightness_base"] = GLOB.configuration.lighting_effects.exposure_brightness_base
	data["exposure_brightness_power"] = GLOB.configuration.lighting_effects.exposure_brightness_power
	data["exposure_contrast_base"] = GLOB.configuration.lighting_effects.exposure_contrast_base
	data["exposure_contrast_power"] = GLOB.configuration.lighting_effects.exposure_contrast_power
	return data

/datum/bloom_edit/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	switch(action)
		if("glow_brightness_base")
			GLOB.configuration.lighting_effects.glow_brightness_base = clamp(params["value"], -10, 10)
		if("glow_brightness_power")
			GLOB.configuration.lighting_effects.glow_brightness_power = clamp(params["value"], -10, 10)
		if("glow_contrast_base")
			GLOB.configuration.lighting_effects.glow_contrast_base = clamp(params["value"], -10, 10)
		if("glow_contrast_power")
			GLOB.configuration.lighting_effects.glow_contrast_power = clamp(params["value"], -10, 10)
		if("exposure_brightness_base")
			GLOB.configuration.lighting_effects.exposure_brightness_base = clamp(params["value"], -10, 10)
		if("exposure_brightness_power")
			GLOB.configuration.lighting_effects.exposure_brightness_power = clamp(params["value"], -10, 10)
		if("exposure_contrast_base")
			GLOB.configuration.lighting_effects.exposure_contrast_base = clamp(params["value"], -10, 10)
		if("exposure_contrast_power")
			GLOB.configuration.lighting_effects.exposure_contrast_power = clamp(params["value"], -10, 10)
		if("default")
			GLOB.configuration.lighting_effects.glow_brightness_base = initial(GLOB.configuration.lighting_effects.glow_brightness_base)
			GLOB.configuration.lighting_effects.glow_brightness_power = initial(GLOB.configuration.lighting_effects.glow_brightness_power)
			GLOB.configuration.lighting_effects.glow_contrast_base = initial(GLOB.configuration.lighting_effects.glow_contrast_base)
			GLOB.configuration.lighting_effects.glow_contrast_power = initial(GLOB.configuration.lighting_effects.glow_contrast_power)
			GLOB.configuration.lighting_effects.exposure_brightness_base = initial(GLOB.configuration.lighting_effects.exposure_brightness_base)
			GLOB.configuration.lighting_effects.exposure_brightness_power = initial(GLOB.configuration.lighting_effects.exposure_brightness_power)
			GLOB.configuration.lighting_effects.exposure_contrast_base = initial(GLOB.configuration.lighting_effects.exposure_contrast_base)
			GLOB.configuration.lighting_effects.exposure_contrast_power = initial(GLOB.configuration.lighting_effects.exposure_contrast_power)
		if("update_lamps")
			for(var/obj/machinery/light/L in GLOB.machines)
				if(L.glow_overlay || L.exposure_overlay)
					// We would use L.update_light() here, but it doesn't work, so we do this instead.
					L.set_light(0)
					L.update(FALSE, TRUE, FALSE)
	return TRUE

/datum/bloom_edit/ui_state(mob/user)
	return GLOB.admin_state
