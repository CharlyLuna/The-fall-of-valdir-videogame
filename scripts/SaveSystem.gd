extends Node2D

var savePath = "res://save/save-file.cfg"
var config = ConfigFile.new()
var loadResponse = config.load(savePath)

func loadValue(section,key,points):
	points = config.get_value(section, key, points)
		
func saveValue(section,key,points):
	config.set_value(section, key, points)
	config.save(savePath)
