using Godot;
using Godot.Collections;
using System;
using System.Diagnostics;
using System.Linq;

public partial class Player : Node2D
{
	public int moves = 3;
	public int[] legalmoves;
	public override void _Ready()
	{
		legalmoves = [2, 2, 2, 2];
		Position = new Vector2(9,9);
	}

	public override void _Process(double delta)
	{
		Move();
	}

	public void printbug(){
		string text = "[";
		foreach(var item in legalmoves)
		{
			text += item;
		}
		Debug.Print(text+"] moves: "+moves);
	}

	public void Move()
	{
		Vector2 pos = Position;
		
		if (Input.IsActionJustPressed("Move Right") && legalmoves[0] > 0)
    	{
			moves--;
			legalmoves[0]--;
			legalmoves[1] = 0;
			if (legalmoves[2] == 1 || legalmoves[3] == 1){
				legalmoves[2] = 0;
				legalmoves[3] = 0;
			}
			printbug();
        	pos.X += 18;
    	}

		if (Input.IsActionJustPressed("Move Left") && legalmoves[1] > 0)
		{
			moves--;
			legalmoves[1]--;
			legalmoves[0] = 0;
			if (legalmoves[2] == 1 || legalmoves[3] == 1){
				legalmoves[2] = 0;
				legalmoves[3] = 0;
			}
			printbug();
			pos.X -= 18;
		}

		if (Input.IsActionJustPressed("Move Down") && legalmoves[2] > 0)
		{
			moves--;
			legalmoves[2]--;
			legalmoves[3] = 0;
			if (legalmoves[1] == 1 || legalmoves[0] == 1){
				legalmoves[1] = 0;
				legalmoves[0] = 0;
			}
			printbug();
			pos.Y += 18;
		}

		if (Input.IsActionJustPressed("Move Up") && legalmoves[3] > 0)
		{
			moves--;
			legalmoves[3]--;
			legalmoves[2] = 0;
			if (legalmoves[1] == 1 || legalmoves[0] == 1){
				legalmoves[1] = 0;
				legalmoves[0] = 0;
			}
			printbug();
			pos.Y -= 18;
		}

		Position = pos;
		if (moves <= 0){
			moves = 3;
			legalmoves = [2, 2, 2, 2];
		}
	}

}
