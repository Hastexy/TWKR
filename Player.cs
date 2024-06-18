using Godot;
using System;
using System.Diagnostics;

public partial class Player : Node2D
{
	public override void _Ready()
	{
		Position = new Vector2(9,9);
	}

	public override void _Process(double delta)
	{
		Vector2 pos = Position;
		
		if (Input.IsActionJustPressed("Move Right"))
    	{
        	pos.X += 18;
    	}

		if (Input.IsActionJustPressed("Move Left"))
		{
			pos.X -= 18;
		}

		if (Input.IsActionJustPressed("Move Down"))
		{
			pos.Y += 18;
		}

		if (Input.IsActionJustPressed("Move Up"))
		{
			pos.Y -= 18; 
		}

		Position = pos;

	}
}
