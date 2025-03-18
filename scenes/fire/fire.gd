extends Node2D

##################################################
const FIRE_TEXTURE: Texture = preload("res://scenes/fire/explosion00.png")
# 불꽃 텍스처를 상수로 미리 정의

var particle_node: GPUParticles2D
# 파티클 노드를 저장할 변수

##################################################
func _ready() -> void:
	particle_node = $GPUParticles2D
	# GPUParticles2D 노드를 가져와 particle_node에 할당
	particle_node.texture = FIRE_TEXTURE
	# 텍스처를 FIRE_TEXTURE로 설정
	particle_node.draw_order = GPUParticles2D.DRAW_ORDER_REVERSE_LIFETIME
	# 입자의 그리기 순서를 수명과 반대로 설정(수명이 다할수록 앞에 그려짐)
	particle_node.amount = 10
	# 입자 개수 설정
	particle_node.lifetime = 0.75
	# 입자의 수명을 0.75초로 설정
	
	particle_node.process_material = ParticleProcessMaterial.new()
	var particle_process_material: ParticleProcessMaterial = \
		particle_node.process_material
	# 입자의 물리적 동작을 설정할 ParticleProcessMaterial을 생성
	
	particle_process_material.gravity = Vector3(0, -100.0, 0)
	# 중력 벡터를 설정(입자가 위로 올라가는 효과를 위해 음의 Y 방향으로 설정)
	particle_process_material.initial_velocity_min = 100.0
	particle_process_material.initial_velocity_max = 200.0
	# 입자의 초기 속도 최소값 및 최대값 설정
	particle_process_material.angular_velocity_min = 10.0
	particle_process_material.angular_velocity_max = 20.0
	# 입자의 초기 각속도(회전 속도) 최소값 및 최대값 설정
	particle_process_material.direction = Vector3(0, -1, 0)
	# 입자의 초기 방출 방향을 Y축의 음수 방향으로 설정(위쪽으로)
	particle_process_material.spread = 5.0
	# 입자의 퍼짐 각도 설정(값이 클수록 더 넓게 퍼짐)
	particle_process_material.scale_min = 0.05
	particle_process_material.scale_max = 0.2
	# 입자의 최소 및 최대 크기 설정
	particle_process_material.emission_shape = \
		ParticleProcessMaterial.EMISSION_SHAPE_BOX
	# 입자 방출 형태를 박스 모양으로 설정
	particle_process_material.emission_box_extents = Vector3(10, 25, 0)
	# 박스 방출 형태의 크기 설정
	
	var gradient_texture: GradientTexture1D = GradientTexture1D.new()
	# 색상 변화에 사용할 그라디언트 텍스처 생성
	gradient_texture.gradient = Gradient.new()
	# 새 그라디언트 객체 생성 및 설정
	gradient_texture.gradient.add_point(0.0, Color(1.0, 0.5, 0.0, 1.0))
	gradient_texture.gradient.add_point(0.5, Color(1.0, 0.25, 0.0, 0.7))
	gradient_texture.gradient.add_point(1.0, Color(1.0, 0.0, 0.0, 0.0))
	# 그라디언트의 색상 점 추가 (시간에 따른 색상 변화 지정)
	particle_process_material.color_ramp = gradient_texture
	# 그라디언트를 입자의 색상 변화 램프로 설정
