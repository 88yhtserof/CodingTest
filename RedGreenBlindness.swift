//
//  RedGreenBlindness.swift
//  CodingTest
//
//  Created by limyunhwi on 2022/02/24.
//
/*
 https://www.acmicpc.net/problem/10026
 적록색약
 적록색약은 빨간색과 초록색의 차이를 거의 느끼지 못한다. 따라서, 적록색약인 사람이 보는 그림은 아닌 사람이 보는 그림과는 좀 다를 수 있다.

 크기가 N×N인 그리드의 각 칸에 R(빨강), G(초록), B(파랑) 중 하나를 색칠한 그림이 있다. 그림은 몇 개의 구역으로 나뉘어져 있는데, 구역은 같은 색으로 이루어져 있다. 또, 같은 색상이 상하좌우로 인접해 있는 경우에 두 글자는 같은 구역에 속한다. (색상의 차이를 거의 느끼지 못하는 경우도 같은 색상이라 한다)

 예를 들어, 그림이 아래와 같은 경우에

 RRRBB
 GGBBB
 BBBRR
 BBRRR
 RRRRR
 적록색약이 아닌 사람이 봤을 때 구역의 수는 총 4개이다. (빨강 2, 파랑 1, 초록 1) 하지만, 적록색약인 사람은 구역을 3개 볼 수 있다. (빨강-초록 2, 파랑 1)

 그림이 입력으로 주어졌을 때, 적록색약인 사람이 봤을 때와 아닌 사람이 봤을 때 구역의 수를 구하는 프로그램을 작성하시오.

 입력
 첫째 줄에 N이 주어진다. (1 ≤ N ≤ 100)

 둘째 줄부터 N개 줄에는 그림이 주어진다.

 출력
 적록색약이 아닌 사람이 봤을 때의 구역의 개수와 적록색약인 사람이 봤을 때의 구역의 수를 공백으로 구분해 출력한다.
 
 DFS 깊이 우선 탐색 
 */
import Foundation

func DFS(_ row: Int, _ column: Int, color: Character, isRedGreenBlindness option: Bool) -> Bool{
    if row < 0 || row >= n || column < 0 || column >= n {return false} //범위를 벗어나면 탐색 중단
    
    if !option {//적록색맹이 아니면
        if color != poster[row][column] || visited[row][column].optionFalse {return false} //색이 같지 않으면 탐색 중단, 방문한 적이 있다면
    } else {//적록색맹이면
        if visited[row][column].optionTrue {return false} //방문한 적이 있다면
        
        if color == "R" || color == "G" {//색이 빨강 또는 초록일 때
            if poster[row][column] == "B" {return false} //색이 파랑이면 탐색 중단
        }else {//파랑일 때
            if poster[row][column] == "R" || poster[row][column] == "G" {return false} //색이 빨강 또는 초록이면 탐색 중단
        }
    }
    
    //적록색약 구분해 방문 여부 표시
    if !option {
        visited[row][column].optionFalse = true
    }else {
        visited[row][column].optionTrue = true
    }
    
    let directions:[[Int]] = [[-1, 0], [1, 0], [0, -1], [0, 1]] // 상, 하, 좌, 우
    var result = false
    
    for direction in directions {
        result = DFS(row+direction[0], column+direction[1], color: color, isRedGreenBlindness: option)
    }
    result = true //상하좌우 탐색을 모두 마쳤다면 true
    
     return result
}

let n = Int(readLine()!)!
var poster: [[Character]] = [] //그림
var visited: [[(optionTrue: Bool, optionFalse: Bool)]] = Array(repeating: Array(repeating: (false,false), count: n), count: n) //각 정점 방문 여부 표시
var numberOfArea = 0 //적록색약을 가지지 않은 사람들이 보는 구역 개수
var numberOfAreaRedGreen = 0 //적록색양을 가진 사람들이 보는 구역 개수

//그림 생성
for _ in 0..<n {
    poster.append(Array(readLine()!))
}

for row in 0..<n {
    for column in 0..<n {
        let color = poster[row][column]
        
        //적록색맹을 가지지 않은 사람들이 보는 구역 개수 탐색
        if DFS(row, column, color: color, isRedGreenBlindness: false) { //구역을 찾았다면
            numberOfArea += 1
        }
        //적록색맹을 가진 사람들이 보는 구역 개수 탐색
        if DFS(row, column, color: color, isRedGreenBlindness: true){//구역을 찾았다면
            numberOfAreaRedGreen += 1
        }
    }
}

print("\(numberOfArea) \(numberOfAreaRedGreen)")
