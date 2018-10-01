//
//  HuntAndKill.swift
//  MazeWatch
//
//  Created by Ada 2018 on 01/10/2018.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import Foundation
import UIKit

class HuntNKill{
	var size: Int = 0
	var grid = [[Double]]()
	
//	func Hunt(size: Int, grid: [[Double]]){
//		self.size = size;
//		self.grid = [];
//		for x in 0...self.size{
//			self.grid[x] = []
//			for y in 0...self.size{
//				//self.grid[x][y] = HKNode(x,y)
//			}
//		}
//	}
//
//	func getMaze(){
//		var start = self.grid[floor(arc4random(self.size) * self.size)][floor(random() * self.size)];
//		start.visited = true;
//		var current = start;
//		while (true) {
//			var neighbors = current.getNeighbors(self.grid, self.size);
//			if (neighbors.length == 0) {
//				// Hunt
//				var found = false;
//
//				hunt:
//					for (var y = 0; y < this.size; y++) {
//						for (var x = 0; x < this.size; x++) {
//							var node = this.grid[x][y];
//							if (!node.visited) {
//								var neighbors = node.getVisitedNeighbors(this.grid, this.size);
//								if (neighbors.length != 0) {
//									found = true;
//									var neighbor = neighbors[Math.floor(Math.random() * neighbors.length)];
//									current = node;
//									this.grid[current.x][current.y].visited = true;
//									this.grid[neighbor.x][neighbor.y].addChildren(current);
//									break hunt;
//								}
//							}
//						}
//				}
//				if (!found){
//					return self.buildMaze();
//				}
//
//			} else {
//				// Kill
//				var next = neighbors[Math.floor(Math.random() * neighbors.length)];
//				current.addChildren(next);
//				current = next;
//				self.grid[current.x][current.y].visited = true;
//				current.visited = true;
//			}
//		}
//	}
//
	
}

