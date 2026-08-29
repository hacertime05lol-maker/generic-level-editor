class_name ModeManager extends Node

@export var main: Main
@export var editor_camera: Camera2D

var editor_mode: EditorMode = EditorMode.EDITOR

func switch_editor_mode() -> void:
	var new_mode: EditorMode
	if editor_mode == EditorMode.EDITOR:
		new_mode = EditorMode.GAME
	elif editor_mode == EditorMode.GAME:
		new_mode = EditorMode.EDITOR
	
	change_editor_mode(new_mode)

func change_editor_mode(mode: EditorMode) -> void:
	if mode == editor_mode:
		return
	
	if mode == EditorMode.EDITOR:
		main.destroy_player()
		editor_camera.enabled = true
	elif mode == EditorMode.GAME:
		main.spawn_player()
		editor_camera.enabled = false
	
	editor_mode = mode

enum EditorMode
{
	EDITOR, GAME
}
