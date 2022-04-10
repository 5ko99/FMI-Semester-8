struct Maze {
    var width: Int = 0
    var height: Int = 0
    var start = (0, 0)
    var end = (0, 0)
    var walls: [[Int]] = []

    // 0 -> can go
    // 1 -> can't go
    // 2 -> start
    // 3 -> end
    init(maze: [[String]]) {
        self.width = maze[0].count
        self.height = maze.count
        for i in 0..<self.height {
            var row: [Int] = []
            for j in 0..<self.width {
                if maze[i][j] == "0"  {
                    row.append(0)
                } else if maze[i][j] == "1" || maze[i][j] == "#" {
                    row.append(1)
                } else if maze[i][j] == "^" {
                    row.append(2)
                    start = (i, j)
                } else if maze[i][j] == "*" {
                    row.append(3)
                    end = (i, j)
                }
            }
            self.walls.append(row)
        }
    }

    func isValid(x: Int, y: Int) -> Bool {
        return x >= 0 && x < self.width && y >= 0 && y < self.height
    }

    func isWall(x: Int, y: Int) -> Bool {
        return self.walls[x][y] == 1
    }

    func isStart(x: Int, y: Int) -> Bool {
        return self.walls[x][y] == 2
    }

    func isEnd(x: Int, y: Int) -> Bool {
        return self.walls[x][y] == 3
    }

    func print_maze() {
        for i in 0..<self.height {
            for j in 0..<self.width {
                if self.walls[i][j] == 0 {
                    print("0", terminator: "")
                } else if self.walls[i][j] == 1 {
                    print("1", terminator: "")
                } else if self.walls[i][j] == 2 {
                    print("^", terminator: "")
                } else if self.walls[i][j] == 3 {
                    print("*", terminator: "")
                }
            }
            print("")
        }
    }
}



//function that find the different paths in a maze
func findPaths(maze: [[String]]) -> Int {


    //create a maze object
    let mazeObj = Maze(maze: maze)

    //create a visited array
    var visited: [[Bool]] = []

    for _ in 0..<mazeObj.height {
        var row: [Bool] = []
        for _ in 0..<mazeObj.width {
            row.append(false)
        }
        visited.append(row)
    }

    return findPathHelper(maze: mazeObj, x: mazeObj.start.0, y: mazeObj.start.1, visited: &visited)

}

func findPathHelper(maze: Maze, x: Int, y: Int, visited: inout [[Bool]]) -> Int {
    if x < 0 || x >= maze.height || y < 0 || y >= maze.width || visited[x][y] || maze.isWall(x: x, y: y) {
        return 0
    }

    if x == maze.end.0 && y == maze.end.1 {
        return 1
    }

    visited[x][y] = true


    var count = 0
    count += findPathHelper(maze: maze, x: x + 1, y: y, visited: &visited)
    count += findPathHelper(maze: maze, x: x - 1, y: y, visited: &visited)
    count += findPathHelper(maze: maze, x: x, y: y + 1, visited: &visited)
    count += findPathHelper(maze: maze, x: x, y: y - 1, visited: &visited)
    // count += findPathHelper(maze: maze, x: x + 1, y: y + 1, visited: &visited)
    // count += findPathHelper(maze: maze, x: x - 1, y: y - 1, visited: &visited)
    // count += findPathHelper(maze: maze, x: x - 1, y: y + 1, visited: &visited)
    // count += findPathHelper(maze: maze, x: x + 1, y: y - 1, visited: &visited)

    visited[x][y] = false

    return count

}



let testMaze = [
        ["^", "0", "0", "0", "0", "0", "0", "1"],
		["0", "1", "1", "1", "1", "1", "0", "0"],
		["0", "0", "0", "0", "0", "1", "#", "1"],
		["0", "1", "1", "1", "0", "1", "0", "0"],
		["0", "1", "0", "1", "0", "0", "0", "1"],
		["0", "0", "0", "1", "0", "1", "0", "*"]]

let testMaze2 = [
    ["^", "0", "0", "0"],
    ["0", "1", "1", "0"],
    ["0", "0", "1", "0"],
    ["0", "1", "1", "*"]]

let testMaze3 = [
    ["^", "0", "0", "0"],
    ["0", "1", "1", "0"],
    ["0", "0", "0", "0"],
    ["0", "1", "1", "*"]]

let maze = Maze(maze: testMaze)

print(findPaths(maze: testMaze))

print(findPaths(maze: testMaze2))

print(findPaths(maze: testMaze3))