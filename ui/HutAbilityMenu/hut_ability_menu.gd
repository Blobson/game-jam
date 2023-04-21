extends CanvasLayer

@export var gold: int = 300 #ЗОЛОТО - перенести в states
var unlock_abilities = [] #Разблокированные улучшения - перенести в states


func _ready():
	for ability in get_tree().get_nodes_in_group("Abilities"):
		ability.get_child(1).disabled = true
		
	ability_available_test()


##Проверка доступности улучшений
##Если есть золото и предыдущее улучшение разблокировано: улучшение доступно для разблокировки
func ability_available_test():
	if not unlock_abilities.has("Abil_01") and gold >= 20:
		$AbilitiesScrollContainer/VBoxContainer/Abil_01/UpgradeButton01.disabled = false
	if not unlock_abilities.has("Abil_02") and unlock_abilities.has("Abil_01") and gold >= 40:
		$AbilitiesScrollContainer/VBoxContainer/Abil_02/UpgradeButton02.disabled = false
	if not unlock_abilities.has("Abil_03") and unlock_abilities.has("Abil_02") and gold >= 60:
		$AbilitiesScrollContainer/VBoxContainer/Abil_03/UpgradeButton03.disabled = false
	if not unlock_abilities.has("Abil_04") and unlock_abilities.has("Abil_03") and gold >= 80:
		$AbilitiesScrollContainer/VBoxContainer/Abil_04/UpgradeButton04.disabled = false
	if not unlock_abilities.has("Abil_05") and unlock_abilities.has("Abil_04") and gold >= 100:
		$AbilitiesScrollContainer/VBoxContainer/Abil_05/UpgradeButton05.disabled = false	


##Обработка нажатий на кнопки
func _on_upgrade_button_01_pressed():
	emit_signal("ability_01_unlock")
	unlock_abilities.append("Abil_01")
	gold -= 20
	#Блокируем кнопку после нажатия:
	$AbilitiesScrollContainer/VBoxContainer/Abil_01/UpgradeButton01.disabled = true
	$AbilitiesScrollContainer/VBoxContainer/Abil_01/UpgradeButton01.texture_disabled = \
	$AbilitiesScrollContainer/VBoxContainer/Abil_01/UpgradeButton01.texture_normal
	$AbilitiesScrollContainer/VBoxContainer/Abil_01/UnlockedCheckMark.visible = true
	print_debug("Abil01 in unlocked")
	ability_available_test() #следует вызывать по нажатию на кнопку вызова меню улучшений. пока находится здесь. 


func _on_upgrade_button_02_pressed():
	emit_signal("ability_02_unlock")
	unlock_abilities.append("Abil_02")
	gold -= 40
	$AbilitiesScrollContainer/VBoxContainer/Abil_02/UpgradeButton02.disabled = true
	$AbilitiesScrollContainer/VBoxContainer/Abil_02/UpgradeButton02.texture_disabled = \
	$AbilitiesScrollContainer/VBoxContainer/Abil_02/UpgradeButton02.texture_normal
	$AbilitiesScrollContainer/VBoxContainer/Abil_02/UnlockedCheckMark.visible = true
	print_debug("Abil02 in unlocked")
	ability_available_test()



func _on_upgrade_button_03_pressed():
	emit_signal("ability_03_unlock")
	unlock_abilities.append("Abil_03")
	gold -= 60
	$AbilitiesScrollContainer/VBoxContainer/Abil_03/UpgradeButton03.disabled = true
	$AbilitiesScrollContainer/VBoxContainer/Abil_03/UpgradeButton03.texture_disabled = \
	$AbilitiesScrollContainer/VBoxContainer/Abil_03/UpgradeButton03.texture_normal
	$AbilitiesScrollContainer/VBoxContainer/Abil_03/UnlockedCheckMark.visible = true
	print_debug("Abil03 in unlocked")
	ability_available_test()


func _on_upgrade_button_04_pressed():
	emit_signal("ability_04_unlock")
	unlock_abilities.append("Abil_04")
	gold -= 80
	$AbilitiesScrollContainer/VBoxContainer/Abil_04/UpgradeButton04.disabled = true
	$AbilitiesScrollContainer/VBoxContainer/Abil_04/UpgradeButton04.texture_disabled = \
	$AbilitiesScrollContainer/VBoxContainer/Abil_04/UpgradeButton04.texture_normal
	$AbilitiesScrollContainer/VBoxContainer/Abil_04/UnlockedCheckMark.visible = true
	print_debug("Abil04 in unlocked")
	ability_available_test()


func _on_upgrade_button_05_pressed():
	emit_signal("ability_01_unlock")
	unlock_abilities.append("Abil_05")
	gold -= 100
	$AbilitiesScrollContainer/VBoxContainer/Abil_05/UpgradeButton05.disabled = true
	$AbilitiesScrollContainer/VBoxContainer/Abil_05/UpgradeButton05.texture_disabled = \
	$AbilitiesScrollContainer/VBoxContainer/Abil_05/UpgradeButton05.texture_normal
	$AbilitiesScrollContainer/VBoxContainer/Abil_05/UnlockedCheckMark.visible = true
	print_debug("Abil05 in unlocked")
	ability_available_test()
