class_name Ballistics extends RefCounted

## Начало траектории
var source: Vector2

## Цель
var target: Vector2

## Наивысшая точка траектории
var center: Vector2

## Скорость снаряда
var move_speed: float

## Длина проекции траектории на землю
var distance: float

## Угол выстрела относительно земли
var angle: float

## Время до цели
var time: float

## Высота в максимальной точке траектории
var elevation: float

## Расположение высшей точки траектории
## Меняется от 0 до 1. 
## Равно 0.5 если смотрим на траекторию сбоку.
var progress_center: float

# Ускорение свободного падения
const gravity = 9.81


func _init(from: Vector2, to: Vector2, speed: float):
	source = from
	target = to
	move_speed = speed
	distance = source.distance_to(target)
	angle = atan((move_speed * move_speed) / (distance * gravity))
	var angle_sin = sin(angle)
	time = (2.0 * move_speed * angle_sin) / (gravity * 25.0)
	elevation = (move_speed * move_speed) * (angle_sin * angle_sin) / gravity
	center = source.lerp(target, 0.5)
	center.y -= elevation * 0.1
	var sy = absf(center.y - source.y)
	var ey = absf(center.y - target.y)
	progress_center = sy / (sy + ey)


## Создание траектории движения снаряда
func create_trajectory() -> Curve2D:
	var dir = source.direction_to(target)
	var curve = Curve2D.new()
	curve.add_point(source)
	curve.add_point(center, 
		-dir * distance * 0.25, 
		dir * distance * 0.25
	)
	curve.add_point(target)
	return curve
