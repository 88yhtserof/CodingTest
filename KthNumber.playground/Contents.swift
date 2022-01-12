import Foundation

func solution(_ array:[Int], _ commands:[[Int]]) -> [Int] {
    var results: Array<Int> = []
    
    for n in 0..<commands.count {
        let i = commands[n][0]
        let j = commands[n][1]
        let k = commands[n][2]
        
        var subrange = Array(array[(i-1)..<j]) //Array로 형변환
        subrange.sort() //오름차순 정렬
        results.append(subrange[k-1])
    }
    
    return results
}

solution([1, 5, 2, 6, 3, 7, 4], [[2, 5, 3], [4, 4, 1], [1, 7, 3]])
