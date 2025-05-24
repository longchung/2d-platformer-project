using Godot;
using System;
using System.Collections.Generic;
// this class act as the enemy spawner
// to use this enemy spawner, attach into the level an Node named enemy. In it,
// add a back_to_start Marker2D node and an enemy_spawner Node2D node.
// In the enemy_spawner node, attach Maker#  Marker2D node to it to designate
// where the enemy should spawn and attach this script to the enemy_spawner node
// I haven't used c# in Godot before so my understanding and cleanliness may not be the best
	public partial class enemy_spawner : Node2D{	
		//this is the prototype abstract class
		public abstract partial class Prototype: Node{
			public abstract Prototype Clone( Node location);
		}		
		// this is the implementation for spawning Koopa Troopa
		public partial class Koopa_trooper: Prototype{
			public Node node;
			public PackedScene scene;
			public Node at;
			public Koopa_trooper(PackedScene enemy, Node location){
				scene = enemy;
				node = enemy.Instantiate();
				at = location;
				at.AddChild(node);
			}
			public override Prototype Clone( Node location){
				return new Koopa_trooper(scene, location);
			}
		}
		// this is the implementation for spawning Goomba
		public partial class Goomba: Prototype{
			public Node node;
			public PackedScene scene;
			public Node at;
			public Goomba(PackedScene enemy, Node location){
				scene = enemy;
				node = enemy.Instantiate();
				at = location;
				at.AddChild(node);
			}
			public override Prototype Clone( Node location){
				return new Goomba(scene,location);
			}
		}
		// this is the implementation of how we spawn the enemy
		public override void _Ready(){
			var koopa_scene = GD.Load<PackedScene>("res://scenes/enemy/koopa_trooper.tscn");
			var goomba_scene = GD.Load<PackedScene>("res://scenes/enemy/goomba.tscn");
			var markers = new Godot.Collections.Dictionary();
			int i=0;
			//create a dictionary of the location of every spawn maker
			foreach (Node child in GetChildren()){
				markers[i] = child.GetPath();
				i+=1; 
			}
			//spawn 2 inital enemy to start
			var at = GetNode(markers[0].ToString());
			var enemy_goomba = new Goomba(goomba_scene,at); 
			at = GetNode(markers[1].ToString());
			var enemy_koopa = new Koopa_trooper(koopa_scene,at);
			// then for all remaining markers, if random number generator 
			// is even then spawn a goomba, else spawn a Koopa Troopa
			for (int j =2; j < markers.Count ; ++j){
				if (GD.Randi() % 2 ==0){
					enemy_goomba.Clone(GetNode(markers[j].ToString()));
				}
				else{
					enemy_koopa.Clone(GetNode(markers[j].ToString()));
				}
			}					
		}				
	}
	
