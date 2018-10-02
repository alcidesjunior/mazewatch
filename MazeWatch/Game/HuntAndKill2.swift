//
//  HuntAndKill2.swift
//  MazeWatch
//
//  Created by Ada 2018 on 02/10/2018.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import Foundation

class Vector2{
	var x: Float
	var y: Float
	init(x: Float, y: Float) {
		self.x = x
		self.y = y
	}
}
	

class HuntAndKill2{

	
	var sizeX, sizeY : Int?
	var value, visitados, total : Int?
	var lineEmptyCheck : [Int]?
	var currentPosition : Vector2?
	var grid: [[Int]];
	//List<Vector2> DeadCells = new List<Vector2>();
	
	
	init(sizeX: Int,sizeY: Int = 0)
	{
		self.sizeX = sizeX;
		self.sizeY = sizeY == 0 ? sizeX : sizeY;
		self.total = Int(sizeX * self.sizeY!);
		self.grid = [[Int]](repeating: [Int](repeating: 0, count: self.sizeX!), count:self.sizeY!);
	}
	
	func GridMazeGenerator()->[[Int]]
	{
		
		Initialization();
		
		while (visitados!<total!)
		{
			self.Walk(&grid, &currentPosition!);
			currentPosition = Hunt(&grid);
			if ((currentPosition?.x)! < Float(0))
			{
				break;
			}
		}
		
		return grid;
	}
	
	func Initialization()
	{


		lineEmptyCheck = [Int](repeating: 0, count: sizeY!);
		currentPosition = Vector2(x: 0, y: 0)
		lineEmptyCheck![0] += 1;
		grid[0][0] = 1;
		value = 1;
		visitados = 1;
	
	}
	
	func Hunt(_ grid: inout [[Int]]) -> Vector2
	{
		var j = 0
		var i = 0
		for j in 0..<sizeY!
		{
			if (lineEmptyCheck![j] < sizeX!)
			{
				for i in 0..<sizeX!
				{
					if (grid[i][j] == 0)
					{
						var pos = Vector2(x: Float(i), y: Float(j));
						var neighbor = ChooseNextPosition(grid: &grid, position: &pos, op: "f");//checar se há vizinho preenchido;
						if (neighbor.x < 0){
							continue;
						}
						lineEmptyCheck![j] += 1;
						visitados! += 1;
						if (grid[Int(neighbor.x)][Int(neighbor.y)] < 0){
							grid[Int(neighbor.x)][Int(neighbor.y)] *= -1;
						}
						
						value = grid[Int(neighbor.x)][Int(neighbor.y)] + 1
						grid[Int(pos.x)][Int(pos.y)] = value!;
						//Debug.Log(value);
						return pos;
					}
				}
			}
		}
		return Vector2(x: -1, y: 0);
	}
	
	func Walk(_ grid: inout [[Int]], _ position: inout Vector2)
	{
		value = grid[Int(position.x)][Int(position.y)];
		//Debug.Log(value);
		var newPosition = ChooseNextPosition(grid: &grid, position: &position, op: "e");
		if (newPosition.x < 0)
		{
			grid[Int(position.x)][Int(position.y)] *= -1;
			return;
		}
		value! += 1;
		position = newPosition;
		visitados! += 1;
		grid[Int(position.x)][Int(position.y)] = value!;
		lineEmptyCheck![Int(position.y)] += 1;
		Walk( &grid, &position);
		
		
	}
	
	func ChooseNextPosition(grid: inout [[Int]] , position: inout Vector2, op : Character = "f") -> Vector2
	{
		var neighBools = op == "f" ? self.NeighborhoodCheck(grid, position, sizeX!, sizeY!, "f") : self.NeighborhoodCheck(grid, position, sizeX!, sizeY!, "e");
		var choice = false;
		var indexes = [0, 1, 2, 3];
		Reshuffle(texts: &indexes, size: 4);
		for j in 0..<4
		{
			choice = neighBools[indexes[j]];
			if (choice)
			{
				position = Vector2(x: Directions(index: indexes[j]).x + position.x, y:Directions(index: indexes[j]).y + position.y);
				return position;
			}
			
		}
		return Vector2(x: -1, y: 0);
		
	}
	func Directions(index: Int)->Vector2
	{
		var directions = [Vector2(x: 1, y: 0),Vector2(x: 0, y: 1),Vector2(x: -1, y: 0),Vector2(x: 0, y: -1)]
		return directions[index];
	}

	
	func NeighborhoodCheck(_ matrix: [[Int]], _ position: Vector2, _ sizeX: Int, _  sizeY: Int, _ op: Character)->[Bool]{
		var neigBools = [false, false, false, false]
		var x = 0
		var op2 = 0
		switch (op)
		{
		case "f":
			op2 = 1
		default:
			op2 = 0
			
		x = Int(position.x + 1);//direita
		if (InRange(x, sizeX))
		{
			
			if (matrix[x][Int(position.y)] == op2)
			{
				neigBools[0] = true;
			}
		}
		x = Int(position.y + 1);//cima
		if (InRange(x, sizeY))
		{
			if (matrix[Int(position.x)][ Int(x)] == op2)
			{
				neigBools[1] = true;
			}
		}
		x = Int(position.x - 1);//esquerda
		if (InRange(x, sizeX))
		{
			if (matrix[x][Int(position.y)] == op2)
			{
				neigBools[2] = true;
			}
		}
		x = Int(position.y - 1);//baixo
		if (InRange(x, sizeY))
		{
			if (matrix[Int(position.x)][ Int(x)] == op2)
			{
				neigBools[3] = true;
			}
		}

		

			
		}

		
		return neigBools
	}
	func Reshuffle(texts: inout [Int], size: Int)
	{
		// Knuth shuffle algorithm :: courtesy of Wikipedia :)
		for t in 0..<size
		{
			var tmp = texts[t];
			var r = Int(arc4random()) % size;
			texts[t] = texts[r];
			texts[r] = tmp;
		}
	}
	
	func InRange(_ index: Int, _ range: Int)-> Bool
	{
		if (index < 0){
			return false;
		}
		if (index >= range) {
			return false;
		}
		return true;
	}

	
}
