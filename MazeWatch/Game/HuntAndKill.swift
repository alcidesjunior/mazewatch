//
//  main.swift
//  huntnkill
//
//  Created by Ada 2018 on 02/10/2018.
//  Copyright © 2018 Academy. All rights reserved.
//

import Foundation

class HuntNKill{
	var size: Int = 0
	var grid = [[HKNode]]()
	
	init(size: Int){
		self.size = size
		self.grid = []
		
		for x in 0...self.size{
			self.grid[x] = []
			for y in 0...self.size{
				self.grid[x][y] = HKNode.init(x: x, y: y)
			}
		}
		
	}
	
	
	func getMaze() -> [[Int]] {
		let random:Int = Int(floor(drand48() * Double(self.size)))
		
		let start = self.grid[random][random]
		start.visited = true
		var current = start
		while (true) {
			var neighbors = current.getNeighbors(grid: self.grid, size: self.size)
			if (neighbors.count == 0) {
				// Hunt
				var found = false
				
				hunt:
					for y in 0...self.size {
						for x in 0...self.size {
							let node = self.grid[x][y]
							if (!node.visited) {
								var neighbors = node.getVisitedNeighbors(grid: self.grid, size: self.size)
								if (neighbors.count != 0) {
									found = true
									let randomNeighbor:Int = Int(floor(drand48() * Double(neighbors.count)))
									let neighbor = neighbors[randomNeighbor]
									current = node
									self.grid[current.x][current.y].visited = true
									self.grid[neighbor.x][neighbor.y].addChildren(node: current)
									break hunt
								}
							}
						}
				}
				if (!found){
					return self.buildMaze()
				}
				
			} else {
				// Kill
				let randomNext:Int = Int(floor(drand48() * Double(neighbors.count)))
				let next = neighbors[randomNext]
				current.addChildren(node: next)
				current = next
				self.grid[current.x][current.y].visited = true
				current.visited = true
			}
		}
	}
	
	func buildMaze() -> [[Int]] {
		var maze = [[Int]]()
		for x in 0...(self.size * 2 + 1) {
			maze[x] = []
			
			for y in 0...(self.size * 2 + 1) {
				maze[x][y] = 1
			}
		}
		
		for x in 0...self.size {
			for y in 0...self.size {
				if self.grid[x][y].visited {
					maze[x * 2 + 1][y * 2 + 1] = 0;
					let children = self.grid[x][y].children
					
					for child in children {
						if (child.x < x) {
							maze[x * 2][y * 2 + 1] = 0
						}
						if (child.x > x) {
							maze[x * 2 + 2][y * 2 + 1] = 0
						}
						if (child.y < y) {
							maze[x * 2 + 1][y * 2] = 0
						}
						if (child.y > y) {
							maze[x * 2 + 1][y * 2 + 2] = 0
						}
					}
				}
			}
		}
		
		return maze
	}
	
}

class HKNode {
	var x: Int
	var y: Int
	var visited = false;
	var children = Array<HKNode>();
	
	init(x: Int, y: Int) {
		self.x = x
		self.y = y
	}
	
	func addChildren(node: HKNode){
		self.children.append(node)
	}
	
	func getNeighbors(grid:[[HKNode]], size: Int) -> [HKNode]{
		var neighbors = Array<HKNode>()
		if (self.x > 0 && !grid[self.x - 1][self.y].visited) {
			neighbors.append(grid[self.x - 1][self.y])
		}
		if (self.x < size - 1 && !grid[self.x + 1][self.y].visited) {
			neighbors.append(grid[self.x + 1][self.y])
		}
		if (self.y > 0 && !grid[self.x][self.y - 1].visited) {
			neighbors.append(grid[self.x][self.y - 1])
		}
		if (self.y < size - 1 && !grid[self.x][self.y + 1].visited) {
			neighbors.append(grid[self.x][self.y + 1])
		}
		return neighbors
	}
	
	func getVisitedNeighbors(grid:[[HKNode]], size: Int) -> [HKNode]{
		var neighbors = Array<HKNode>()
		if (self.x > 0 && grid[self.x - 1][self.y].visited) {
			neighbors.append(grid[self.x - 1][self.y])
		}
		if (self.x < size - 1 && grid[self.x + 1][self.y].visited) {
			neighbors.append(grid[self.x + 1][self.y])
		}
		if (self.y > 0 && grid[self.x][self.y - 1].visited) {
			neighbors.append(grid[self.x][self.y - 1])
		}
		if (self.y < size - 1 && grid[self.x][self.y + 1].visited) {
			neighbors.append(grid[self.x][self.y + 1])
		}
		return neighbors
	}
	
	
}

//var huntnKill = HuntNKill(size: 50)
//var maze = huntnKill.getMaze()
//
//for x in 0...maze.count {
//	for y in 0...maze.count {
//		print(maze[x][y])
//	}
//}


