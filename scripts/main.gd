extends Node

func _ready():
	$Onceler.queue_event(EventStartCreatePlayers.new(96))
	$Onceler.queue_event(EventTourneyStart.new())
	$Onceler.start_loop()
