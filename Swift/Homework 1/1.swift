func hasExtention(path: String) -> Bool {
    let arr = Array(path)
    var i = arr.count - 1
    if arr[i] == "/" {
        return false
        //i -= 1
    }
    if arr[i] == "." {
        return false
    }
    while i >= 0 {
        if arr[i] == "." {
            return true
        }
        if arr[i] == "/" {
            return false
        }
        i -= 1
    }
    return false
}

func pathsWithExtention(paths: [String]) -> [String] {
    var result = [String]()
    for path in paths {
        if(hasExtention(path: path)) {
            result.append(path)
        }
    }
    return result
}


func pathsWithoutExtention(paths: [String]) -> Int {
    var count = 0
    for path in paths {
        if(!hasExtention(path: path)) {
            count += 1
        }
    }
    return count
}

func isPrefix(prefix: String, path: String) -> Bool {
    let arr = Array(path)
    let arr2 = Array(prefix)
    if arr.count <= arr2.count {
        return false
    }
    for i in 0..<arr2.count {
        if arr[i] != arr2[i] {
            return false
        }
    }
    return true
}

func prefixPath(paths: [String], pathsWitExtention : [String])  -> Int {
    var count = 0
    var dirs = [String]()
    for path in paths {
        for pathWitExtention in pathsWitExtention {
            if isPrefix(prefix: pathWitExtention, path: path) && !dirs.contains(pathWitExtention) {
                dirs.append(pathWitExtention)
                count += 1
            }
        }
    }
    return count
}

func countFolders(paths: [String]) -> Int {
    let setOfPaths = Set(paths)
    var unique = [String] ()
    for path in paths {
        if path.count > 1 && path.last == "/"  && !setOfPaths.contains(String(path.dropLast())) {
            unique.append(String(path.dropLast()))
        } else if path.last != "/" || path.count == 1 {
            unique.append(path)
        }  
        }
	var sorted_paths = unique
    sorted_paths.sort {
        $0.count < $1.count
    }
    let pathsWithoutExtentionCount = pathsWithoutExtention(paths: sorted_paths)
    let pathsWithExtentionArr = pathsWithExtention(paths: sorted_paths)
    let prefixPathCount = prefixPath(paths: sorted_paths, pathsWitExtention: pathsWithExtentionArr)
    return pathsWithoutExtentionCount + prefixPathCount
}

let paths = ["/ ", "/games/socoban/socoban.app", "/games/socoban", "/games"]
let paths2 = ["/","/g.a.m.e.s/socoban.folder","/g.a.m.e.s/"]
let paths3 = ["/","/g.a.m.e.s/socoban.folder","/g.a.m.e.s/", "/games/socoban.app", "/games"]
let paths4 = ["/","/a.a/","/b.b", "/a.a/b.b", "/c/"]
let paths5 = ["/","/a.a/","/b.b", "/a.a/b", "/c/", "/a.a/c.c", "/a.a/d.d", "/a.a/c.c/e.e", "/a.a/petko.com/ivan.com", "/a.a/petko.com"]
let path6 = ["/", "/....", "/..../", "/..../.a", "/..../.a/dsf"]
let path7 = ["/", "/a.", "/a./a.a", "/a/","/././", "/.","/a./b.b"]
let path8 = ["/","/a/","/a","/a/a.a","/a/a.a/","/a/a.a/b"]
// print(countFolders(paths: paths))
// print(countFolders(paths: paths2))
// print(countFolders(paths: paths3))
// print(countFolders(paths: paths4))
// print(countFolders(paths: paths5))
// print(countFolders(paths: path6))
// print(countFolders(paths: path7))
print(countFolders(paths: path8))
assert(hasExtention(path: "hello.swift"))
assert(!hasExtention(path: "hello"))
assert(hasExtention(path: "/abc/hello.a"))