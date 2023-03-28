class_name EnemyPath extends Path2D

## Вражеские "рельсы"
##
## Путь по которому юниты двигаются к цели.
## Враги могут отходить от "рельса" в случаях когда в зоне их видимости
## оказывается более приоритетная цель.


## Получить стартовую позицию
func start_position() -> Vector2:
	return curve.get_baked_points()[0]


## Получить финишную позицию
func end_position() -> Vector2:
	return curve.get_baked_points()[-1]


## Метод для запуска нового врага по "рельсу".
func add_enemy(enemy: Node):
	enemy.set_path(self)
	add_child(enemy)
