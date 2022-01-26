/*
 https://www.acmicpc.net/problem/3190
 뱀
 'Dummy' 라는 도스게임이 있다. 이 게임에는 뱀이 나와서 기어다니는데, 사과를 먹으면 뱀 길이가 늘어난다. 뱀이 이리저리 기어다니다가 벽 또는 자기자신의 몸과 부딪히면 게임이 끝난다.

 게임은 NxN 정사각 보드위에서 진행되고, 몇몇 칸에는 사과가 놓여져 있다. 보드의 상하좌우 끝에 벽이 있다. 게임이 시작할때 뱀은 맨위 맨좌측에 위치하고 뱀의 길이는 1 이다. 뱀은 처음에 오른쪽을 향한다.

 뱀은 매 초마다 이동을 하는데 다음과 같은 규칙을 따른다.

 먼저 뱀은 몸길이를 늘려 머리를 다음칸에 위치시킨다.
 만약 이동한 칸에 사과가 있다면, 그 칸에 있던 사과가 없어지고 꼬리는 움직이지 않는다.
 만약 이동한 칸에 사과가 없다면, 몸길이를 줄여서 꼬리가 위치한 칸을 비워준다. 즉, 몸길이는 변하지 않는다.
 사과의 위치와 뱀의 이동경로가 주어질 때 이 게임이 몇 초에 끝나는지 계산하라.
 */
import Foundation

var n: Int //보드의 크기
var k: Int //사과의 개수
var time: Int = 0
var board: [[Int]]
var snake: [(row: Int, column: Int)] = [(0, 0)]//뱀의 몸통 값을 저장할 큐 선입선출
var row = 0
var column = 0
var direction: (direction: String, row: Int, column: Int) = ("east", 0, 1)
var moves: [(second: Int, direction: String)] = []
var directionChange: Int
var isGameOver = false


n = Int(readLine()!)! //보드 크기 입력
board = Array(repeating: Array(repeating: 0, count: n), count: n) //보드 생성. 0: 빈 칸, 1: 사과, -1: 뱀 몸통

//사과 배치
k = Int(readLine()!)! //사과의 개수 입력
for _ in 0..<k {
    let apple = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
    board[apple[0]-1][apple[1]-1] = 1 //해당 위치에 사과 배치
}

directionChange = Int(readLine()!)!
for _ in 0..<directionChange {
    let move = readLine()!.components(separatedBy: " ") //[0]: 초, [1]: 방향
    moves.append((Int(move[0])!, move[1]))
}
moves.append((n + moves.last!.second,"none")) //더 이상 변환할 방향이 없으므로 뱀은 최대 n+마지막 시간 까지만 이동할 수 있다.

for i in 0..<moves.count {
    while time < moves[i].second {//이동, time은 0부터 시작
        time += 1 //매 초 이동하므로 이동 시 1초 증가
        row += direction.row
        column += direction.column
        if row >= n || row < 0
            || column >= n || column < 0
            || board[row][column] == -1 {//벽을 만났거나 자기자신(-1)과 부딪혔을 경우
            isGameOver = true
            break
        }
        
        snake.append((row, column))
        if board[row][column] != 1 {//사과를 먹지 않는다면
            board[snake[0].row][snake[0].column] = 0 //꼬리 당기기
            snake.removeFirst()
        }
        board[row][column] = -1 //뱀의 몸통 표시
    }
    if isGameOver {break} //게임 종료
    
    //방향 전환
    switch direction.direction {
    case "east": //동
        if moves[i].direction == "L" {//왼쪽이면
            direction = ("north", -1, 0)
        }else {//오른쪽이면
            direction = ("south", 1,0)
        }
    case "west": //서
        if moves[i].direction == "L" {//왼쪽이면
            direction = ("south", 1,0)
        }else {//오른쪽이면
            direction = ("north", -1, 0)
        }
    case "north": //북
        if moves[i].direction == "L" {//왼쪽이면
            direction = ("west", 0, -1)
        }else {//오른쪽이면
            direction = ("east", 0, 1)
        }
    case "south": //남
        if moves[i].direction == "L" {//왼쪽이면
            direction = ("east", 0, 1)
        }else {//오른쪽이면
            direction = ("west", 0, -1)
        }
    default:
        print("switch")
    }
}

print(time)


