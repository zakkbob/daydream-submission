extends Area2D

func _on_body_entered(body: Node2D) -> void:
	print("e")
	get_tree().call_deferred("change_scene_to_file","res://level_two.tscn")
