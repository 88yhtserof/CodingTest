//
//  FindTheArea.swift
//  CodingTest
//
//  Created by limyunhwi on 2022/02/25.
//
/*
 https://www.acmicpc.net/problem/2583
 영역 구하기
 문제
 눈금의 간격이 1인 M×N(M,N≤100)크기의 모눈종이가 있다. 이 모눈종이 위에 눈금에 맞추어 K개의 직사각형을 그릴 때, 이들 K개의 직사각형의 내부를 제외한 나머지 부분이 몇 개의 분리된 영역으로 나누어진다.

 예를 들어 M=5, N=7 인 모눈종이 위에 <그림 1>과 같이 직사각형 3개를 그렸다면, 그 나머지 영역은 <그림 2>와 같이 3개의 분리된 영역으로 나누어지게 된다.

 <그림 2>와 같이 분리된 세 영역의 넓이는 각각 1, 7, 13이 된다.

 M, N과 K 그리고 K개의 직사각형의 좌표가 주어질 때, K개의 직사각형 내부를 제외한 나머지 부분이 몇 개의 분리된 영역으로 나누어지는지, 그리고 분리된 각 영역의 넓이가 얼마인지를 구하여 이를 출력하는 프로그램을 작성하시오.
 
 깊이우선탐색 DFS / x, y와 행과 열 구분 하기
 */
import Foundation

func DFS(_ x: Int, _ y: Int) -> Int {
    if x < 0 || x >= input[1] || y < 0 || y >= input[0] {return 0} //범위를 벗어나면 탐색 중단
    
    if graphPaper[y][x] == 0 //1이 아니면, 즉 직사각형이 있는 부분이거나
        || visited[y][x] {return 0} //방문한 적이 있다면 탐색 중단
    
    visited[y][x] = true
    let directions: [[Int]] = [[-1, 0], [1, 0], [0, -1], [0, 1]] //상하좌우
    var area = 0 //정점의 개수를 기록 - 한 칸의 넓이는 1
    
    //해당 정점의 상하좌우 탐색
    for direction in directions {
        area += DFS(x+direction[1], y+direction[0])
    }
    return area + 1
}

var input = Array(readLine()!.components(separatedBy: " ").map{Int(String($0))!})
var rectangles: [[Int]] = [] //직사각형의 좌표를 받을 배열
var graphPaper: [[Int]] = Array(repeating: Array(repeating: 1, count: input[1]), count: input[0]) //0: 직사각형 1: 빈 공간
var graphs: [Int] = [] //결과인 각 그래프의 넓이를 저장할 배열
var visited: [[Bool]] = Array(repeating: Array(repeating: false, count: input[1]), count: input[0])
typealias Coordinate = (x: Int, y: Int)

//직사각형 좌표 받기 [왼쪽 아래 x y,  오른쪽 위 x y]
for _ in 0..<input[2] {
    rectangles.append(Array(readLine()!.components(separatedBy: " ").map{Int(String($0))!}))
}

//모눈종이에 직사각형 그리기 - 구현 시에는 문제 설명과 다르게 0,0이 왼쪽상단에 위치한다.
for rectangle in rectangles {
    let bottomLeft: Coordinate = (rectangle[0], rectangle[1])
    let topRight: Coordinate = (rectangle[2]-1, rectangle[3]-1)//2차 배열의 인덱스에 맞추기 위해 -1 해준다.
    
    for x in bottomLeft.x...topRight.x {
        for y in bottomLeft.y...topRight.y {
            graphPaper[y][x] = 0 //직사각형은 0으로 채운다.
        }
    }
}

//빈공간의 개수와 넓이 구하기-그래프의 개수와 크기 구하기
for y in 0..<input[0] {
    for x in 0..<input[1] {
        let result = DFS(x, y)
        if result > 0 {
            graphs.append(result)
        }
    }
}

print("\(graphs.count)")
print(graphs.sorted().map{String($0)}.joined(separator: " "))
