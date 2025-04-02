@tool
extends ProgrammaticTheme


func setup() -> void: 
	set_save_path("res://themes/default_theme.tres")


func round_corners():
	return corner_radius(100)
	

func define_theme() -> void: 
	var circle_outline = stylebox_flat({
		corners_ = round_corners(),
		border_color = ThemeManager.color_secondary,
		borders_ = border_width(2), 
		bg_color = ThemeManager.transparent, 
	})
	
	var panel = stylebox_flat({
		bg_color = ThemeManager.color_primary, 
	})
	
	var rounded_panel = inherit(panel, {
		corners_ = round_corners(), 
	})
	
	define_variant_style("CircleOutlineButton", "Button", {
		normal=circle_outline
	})
	
	define_style("PanelContainer", {
		panel = rounded_panel
	})
	
	define_style("Panel", {
		panel = panel
	})
	
	var margin_x: int = 30
	var margin_y: int = 60
	
	define_variant_style("ScreenMargin", "MarginContainer", {
		margin_right=margin_x, 
		margin_left=margin_x, 
		margin_bottom=margin_y,
		margin_top=margin_y
	})
	
	var button_normal = stylebox_flat({
		bg_color=ThemeManager.color_secondary, 
		corners_ = round_corners(),
		
	})
	
	define_style("Button", {
		normal=button_normal
	})
