using Godot;
using Godot.Collections;
using System;
using System.Diagnostics;

public partial class Player : Node2D
{
	[Export] public TileMap[] indicators;
	public bool first = true;
	public int first_move = 2;
	public int second_move = 1;
	public override void _Ready()
	{
		indicators[0].Visible = true;
		Position = new Vector2(9,9);
	}

	public override void _Process(double delta)
	{
		Move();
	}

	public void Move()
	{
		Vector2 pos = Position;
		int multiplier = first ? first_move : second_move;
		
		if (Input.IsActionJustPressed("Move Right"))
    	{
        	pos.X += 18 * multiplier;
			SwitchIndicators(true);
    	}

		if (Input.IsActionJustPressed("Move Left"))
		{
			pos.X -= 18 * multiplier;
			SwitchIndicators(true);
		}

		if (Input.IsActionJustPressed("Move Down"))
		{
			pos.Y += 18 * multiplier;
			SwitchIndicators(false);
		}

		if (Input.IsActionJustPressed("Move Up"))
		{
			pos.Y -= 18  * multiplier;
			SwitchIndicators(false);
		}

		Position = pos;
	}

	public void SwitchIndicators(bool horizontal){
		if (first){
			indicators[0].Visible = false;
			indicators[1].Visible = !horizontal;
			indicators[2].Visible = horizontal;
		}
		else
		{
			indicators[1].Visible = false;
			indicators[2].Visible = false;
			indicators[0].Visible = true;
		}
		first = !first;
	}
}
