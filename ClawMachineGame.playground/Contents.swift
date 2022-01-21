//
//  ClawMachineGame.swift
//  StudyCodingTest
//
//  Created by limyunhwi on 2022/01/14.
//
/*
 https://programmers.co.kr/learn/courses/30/lessons/64061?language=swift
 2019카카오개발자겨울인턴쉽
 크레인 인형 뽑기
 스택
 */
import Foundation

func solution(_ board:[[Int]], _ moves:[Int]) -> Int {
    var board = board //인형(숫자)이 배치되어 있는 보드
    var toy = 0 //잡은 인형(숫자)
    var toys: [Int] = [] //잡은 인형을 담은 바구니. 스택역할
    var popToys = 0 //터진 인형의 개수(주의: 두 개가 모일 시 pop된다.)
    
    moves.forEach{
        move in
        for row in 0..<board.count {
            //주의: 주어진 인형(숫자)배열은 각 원소 당 열로 배열이 묶여있지만, 기계의 인형 스택들은 행으로 묶여있다.
            if board[row][move-1] > 0{ //해당 행에 인형(숫자)이 있는지, 없으면 0 이하
                toy = board[row][move-1] //인형이 있으므로 잡기
                board[row][move-1] = 0 //인형을 잡았으면 해당 자리 0으로 초기화
                
                if toy == toys.last {//같은 인형(숫자)가 2개 모일 시 pop
                    toys.removeLast()
                    popToys += 2
                }else{
                    toys.append(toy)
                }
                break //인형을 잡고 작업을 끝냈다면 다음 move로 이동
            }
        }
    }
    
    return popToys
}

print(solution([[0,0,0,0,0],[0,0,1,0,3],[0,2,5,0,1],[4,2,4,4,2],[3,5,1,3,1]], [1,5,3,5,1,2,1,4]))
