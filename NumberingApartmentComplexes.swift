//
//  NumberingApartmentComplexes.swift
//  CodingTest
//
//  Created by limyunhwi on 2022/02/24.
//
/*
 https://www.acmicpc.net/problem/2667
 단지번호 붙이기
 <그림 1>과 같이 정사각형 모양의 지도가 있다. 1은 집이 있는 곳을, 0은 집이 없는 곳을 나타낸다. 철수는 이 지도를 가지고 연결된 집의 모임인 단지를 정의하고, 단지에 번호를 붙이려 한다. 여기서 연결되었다는 것은 어떤 집이 좌우, 혹은 아래위로 다른 집이 있는 경우를 말한다. 대각선상에 집이 있는 경우는 연결된 것이 아니다. <그림 2>는 <그림 1>을 단지별로 번호를 붙인 것이다. 지도를 입력하여 단지수를 출력하고, 각 단지에 속하는 집의 수를 오름차순으로 정렬하여 출력하는 프로그램을 작성하시오.
 입력
 첫 번째 줄에는 지도의 크기 N(정사각형이므로 가로와 세로의 크기는 같으며 5≤N≤25)이 입력되고, 그 다음 N줄에는 각각 N개의 자료(0혹은 1)가 입력된다.

 출력
 첫 번째 줄에는 총 단지수를 출력하시오. 그리고 각 단지내 집의 수를 오름차순으로 정렬하여 한 줄에 하나씩 출력하시오.
 
 깊이우선탐색 / 오름차순 출력 주의
 */

import Foundation


//깊이우선 탐색 - 모든 정점의 방문
func DFS(_ row: Int, _ column: Int) -> Int?{
    if row < 0 || row >= n || column < 0 || column >= n {return nil} //지도의 범위를 벗어나면 탐색 중지
    
    if map[row][column] != 1 //집이 없거나
        || visited[row][column] //방문 한 적이 있다면
    {return nil} //탐색 중지
    
    visited[row][column] = true
    let directions: [[Int]] = [[-1, 0], [1, 0], [0, -1], [0, 1]] //상, 하, 좌, 우
    var count = 0 //집, 즉 정점의 개수를 기록
    
    //해당 정점의 상하좌우 탐색
    for direction in directions {
        if let result = DFS(row+direction[0], column+direction[1]){
            count += result
        }
    }
    return count + 1
}

var n: Int = 0
var map: [[Int]] = [] //지도
var visited: [[Bool]] //방문 여부 표시 지도
var graphs:[Int] = [] //단지 수, 즉 그래프의 개수를 저장할 배열

n = Int(readLine()!)!
visited = Array(repeating: Array(repeating: false, count: n), count: n) //map과 동일한 크기의 방문 여부 표시 지도 생성

//지도 생성
for _ in 0..<n {
    let input = Array(readLine()!)
    map.append(input.map{Int(String($0))!})
}

//탐색-지도의 모든 집을 한 번씩 탐색한다.
for row in 0..<n {
    for column in 0..<n {
        if let numberOfVertex = DFS(row, column) {//단지가 있다면, 즉 정점의 개수가 nil이 아니라면
            graphs.append(numberOfVertex)
        }
    }
}

print(graphs.count)
graphs.sort() //오름차순 정렬
for numberOfVertex in graphs {
    print(numberOfVertex)
}
