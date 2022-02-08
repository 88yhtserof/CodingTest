/*
 https://www.acmicpc.net/problem/1780
 종이의 개수
 N×N크기의 행렬로 표현되는 종이가 있다. 종이의 각 칸에는 -1, 0, 1 중 하나가 저장되어 있다. 우리는 이 행렬을 다음과 같은 규칙에 따라 적절한 크기로 자르려고 한다.

 만약 종이가 모두 같은 수로 되어 있다면 이 종이를 그대로 사용한다.
 (1)이 아닌 경우에는 종이를 같은 크기의 종이 9개로 자르고, 각각의 잘린 종이에 대해서 (1)의 과정을 반복한다.
 이와 같이 종이를 잘랐을 때, -1로만 채워진 종이의 개수, 0으로만 채워진 종이의 개수, 1로만 채워진 종이의 개수를 구해내는 프로그램을 작성하시오.
 */
import Foundation

func splitePaper(_ paper: [[String]], row: Int, column: Int, size: Int) {
    
    //종이가 모두 같은 수인가
    if checkPaper(paper, row: row, column: column, size: size) {//모두 같으면 true
        return
    }
    
    //종이가 모두 같은 수가 아닌 경우
    for i in 0..<3 { //3번 분할. 즉, 3개의 종이 확인
        for j in 0..<3 {
            splitePaper(paper, row: row + (size/3)*i, column: column + (size/3)*j, size: size/3) //재귀 호출
        }
    }
    
}

func checkPaper(_ paper: [[String]], row: Int, column: Int, size: Int) -> Bool {
    //종이가 모두 같은 수인가
    let compareNumber = paper[row][column]
    for i in row ..< row + size {
        for j in column ..< column + size {
            if compareNumber != paper[i][j] {
                return false //하나라도 다른 수가 있으면 false 반환
            }
        }
    }
    
    //모두 같은 수라면 해당하는 숫자의 종이 개수 증가
    switch compareNumber {
    case "-1":
        result[0] += 1
    case "0":
        result[1] += 1
    default: //1
        result[2] += 1
    }
    return true
}


var result: [Int] = [0, 0, 0] //숫자 별 종이 개수
var n: Int = 0
var paper: [[String]] = []

n =  Int(readLine()!)!

for _ in 1...9 {
    paper.append(readLine()!.components(separatedBy: " "))
}

splitePaper(paper, row: 0, column: 0, size: n)

print("\(result[0])\n\(result[1])\n\(result[2])")
