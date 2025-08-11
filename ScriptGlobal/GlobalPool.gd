extends Node

var userPrefab: PackedScene = null
var userPoolSize: int = 4
var pawnPrefab: PackedScene = null
var pawnPoolSize: int = 10
var areaPrefab: PackedScene = null
var areaPoolSize: int = 4
var tilePrefab: PackedScene = null
var tilePoolSize: int = 400

var field: Node
var world: Node
var userPool: Array = []
var pawnPool: Array = []
var areaPool: Array = []
var tilePool: Array = []

var uids: Array[int] = [0, 0, 0, 0]

func makeUID(idx: int) -> int:
	var nextuid = uids[idx] + 1
	uids[idx] = nextuid
	return int(pow(10, idx)) + nextuid

func _ready():
	GlobalSignals.game_state_entered.connect(_on_game_state_entered)

func _on_game_state_entered(nextstate: int):
	if nextstate == 1: # 1 for world init
		assert(field != null)
		for i in userPoolSize:
			makePooledUser(field)
		userPool.reverse()

		assert(field != null)
		for i in pawnPoolSize:
			makePooledPawn(field)
		pawnPool.reverse()

		assert(world != null)
		for i in areaPoolSize:
			makePooledArea(world)
		areaPool.reverse()

		assert(world != null)
		for i in tilePoolSize:
			makePooledTile(world)
		tilePool.reverse()

func makePooledUser(nextParent: Node):
	var nextName = "User" + str(makeUID(0))
	makeEntity(userPrefab, nextParent, nextName, userPool)
	return
func genUser(pos: Vector3) -> Node:
	var entity: Node = genEntity(userPool)
	entity.set_position(pos)
	return entity
func freeUser(instance: Node) -> Node:
	return freeEntity(instance, userPool)

func makePooledPawn(nextParent: Node):
	var nextName = "Pawn" + str(makeUID(1))
	makeEntity(pawnPrefab, nextParent, nextName, pawnPool)
	return
func genPawn(pos: Vector3) -> Node:
	var entity: Node = genEntity(pawnPool)
	entity.set_position(pos)
	return entity
func freePawn(instance: Node) -> Node:
	return freeEntity(instance, pawnPool)

func makePooledArea(nextParent: Node):
	var nextName = "Area" + str(makeUID(2))
	makeEntity(areaPrefab, nextParent, nextName, areaPool)
	return
func genArea(pos: Vector3) -> Node:
	var entity: Node = genEntity(areaPool)
	entity.set_position(pos)
	return entity
func freeArea(instance: Node) -> Node:
	return freeEntity(instance, areaPool)

func makePooledTile(nextParent: Node):
	var nextName = "Tile" + str(makeUID(3))
	makeEntity(tilePrefab, nextParent, nextName, tilePool)
	return
func genTile(pos: Vector3) -> Node:
	var entity: Node = genEntity(tilePool)
	entity.set_position(pos)
	return entity
func freeTile(instance: Node) -> Node:
	return freeEntity(instance, tilePool)

func makeEntity(prefab: PackedScene, nextParent: Node, nextName: String, pool: Array):
	assert(prefab != null)
	var instance: Node = prefab.instantiate()
	instance.name = nextName
	instance.visible = false
	nextParent.add_child(instance)
	pool.push_back(instance)
	return instance

func genEntity(pool: Array):
	if pool.is_empty():
		print("pool exhausted")
		return null # Pool exhausted
	var instance: Node = pool.pop_back()
	instance.visible = true
	return instance

func freeEntity(instance: Node, pool: Array):
	instance.visible = false
	instance.set_process(false)
	pool.push_back(instance)
	return
