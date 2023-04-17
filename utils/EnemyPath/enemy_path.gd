@tool class_name EnemyPath extends EnemyPathEditor

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


## Создаём объект следования по "рельсу"
func create_follower() -> EnemyPathFollower:
	return EnemyPathFollower.new(self)
