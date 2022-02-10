/*
 https://www.acmicpc.net/problem/2630
 색종이 만들기
 아래 <그림 1>과 같이 여러개의 정사각형칸들로 이루어진 정사각형 모양의 종이가 주어져 있고,각 정사각형들은 하얀색으로 칠해져 있거나 파란색으로 칠해져 있다.
 주어진 종이를 일정한 규칙에 따라 잘라서 다양한 크기를 가진 정사각형 모양의 하얀색 또는 파란색 색종이를 만들려고 한다.
 ...
 */
import Foundation

func splitePaper(_ paper: [[String]], row: Int, column: Int, size: Int) {
    
    //모두 같은 색인가
    if checkColor(paper, row: row, column: column, size: size) {//모두 같으면 true
        return
    }
    
    //종이가 모두 같은 색이 아닌 경우
    let temp = size/2
    for i in 0..<2 { //2번 분할. 즉, 2개의 종이 확인
        for j in 0..<2 {
            splitePaper(paper, row: row + temp*i, column: column + temp*j, size: temp) //재귀 호출
        }
    }
    
}

func checkColor(_ paper: [[String]], row: Int, column: Int, size: Int) -> Bool {
    //종이가 모두 같은 색인가
    let compareNumber = paper[row][column]
    for i in row ..< row + size {
        for j in column ..< column + size {
            if compareNumber != paper[i][j] {
                return false //하나라도 다른 색이 있으면 false 반환
            }
        }
    }
    
    
    //모두 같은 색이라면 해당하는 색의 종이 개수 증가
    switch compareNumber {
    case "0":
        result[0] += 1
    default:
        result[1] += 1
    }
    return true
}


var result: [Int] = [0, 0, 0] //색에 따른 종이 개수
var n: Int = 0
var paper: [[String]] = []

n =  Int(readLine()!)!

for _ in 1...n {
    paper.append(readLine()!.components(separatedBy: " "))
}

splitePaper(paper, row: 0, column: 0, size: n)

print("\(result[0])\n\(result[1])")
