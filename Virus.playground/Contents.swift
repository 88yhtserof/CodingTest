/*
 https://www.acmicpc.net/problem/2606
 바이러스
 신종 바이러스인 웜 바이러스는 네트워크를 통해 전파된다. 한 컴퓨터가 웜 바이러스에 걸리면 그 컴퓨터와 네트워크 상에서 연결되어 있는 모든 컴퓨터는 웜 바이러스에 걸리게 된다.
 
 예를 들어 7대의 컴퓨터가 <그림 1>과 같이 네트워크 상에서 연결되어 있다고 하자. 1번 컴퓨터가 웜 바이러스에 걸리면 웜 바이러스는 2번과 5번 컴퓨터를 거쳐 3번과 6번 컴퓨터까지 전파되어 2, 3, 5, 6 네 대의 컴퓨터는 웜 바이러스에 걸리게 된다. 하지만 4번과 7번 컴퓨터는 1번 컴퓨터와 네트워크상에서 연결되어 있지 않기 때문에 영향을 받지 않는다.

 어느 날 1번 컴퓨터가 웜 바이러스에 걸렸다. 컴퓨터의 수와 네트워크 상에서 서로 연결되어 있는 정보가 주어질 때, 1번 컴퓨터를 통해 웜 바이러스에 걸리게 되는 컴퓨터의 수를 출력하는 프로그램을 작성하시오.
 
 무향 그래프, 깊이우선탐색 DFS
 */
import Foundation

//파라미터 vertex를 정점으로 하여 그래프 깊이우선탐색
func DFS(_ vertex: Int, _ adjacents: [Int]){
    visited[vertex] = true //해당 정점 방문 여부 표시
    numberOfConnected += 1
    
    //끝에 도달하면 방문 안 한 정점을 찾아 되돌아오기
    if adjacents.isEmpty {return}
    
    for column in 0..<adjacents.count{
        let adjacent = adjacents[column]
        
        if !visited[adjacent]{//방문한 적이 없다면 방문하기
            DFS(adjacent, graph[adjacent])
        }
    }
}

var numberOfComputers = 0
var numberOfPairs = 0

numberOfComputers = Int(readLine()!)!
numberOfPairs = Int(readLine()!)!

var graph: [[Int]] = Array(repeating: [], count: numberOfComputers+1) //인접배열. 무향 그래프. 컴퓨터의 개수만 확인하면 되므로 각 정점별 오름차순 정리는 하지 않는다.
var numberOfConnected: Int = 0 //1번 컴퓨터와 연결된 컴퓨터의 개수
var visited: [Bool] = Array(repeating: false, count: numberOfComputers+1)

//인접배열 만들기
for _ in 1...numberOfPairs {
    let pair: [Int] = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
    graph[pair[0]].append(pair[1]) //행: 정점, 열: 인접한 정점
    graph[pair[1]].append(pair[0]) //무향 그래프
}

//깊이우선탐색
//깊이 우선 탐색은 모든 정점을 한 번씩 방문한다.
//1번 컴퓨터와 연결된 컴퓨터만 바이러스로 고장나기 때문에 1번 정점만 탐색하면 된다.
DFS(1, graph[1])

print(numberOfConnected-1)//1번 컴퓨터는 제외한다.
