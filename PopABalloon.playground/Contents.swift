/*
 https://www.acmicpc.net/problem/2346
 풍선 터뜨리기
 1번부터 N번까지 N개의 풍선이 원형으로 놓여 있고. i번 풍선의 오른쪽에는 i+1번 풍선이 있고, 왼쪽에는 i-1번 풍선이 있다. 단, 1번 풍선의 왼쪽에 N번 풍선이 있고, N번 풍선의 오른쪽에 1번 풍선이 있다. 각 풍선 안에는 종이가 하나 들어있고, 종이에는 -N보다 크거나 같고, N보다 작거나 같은 정수가 하나 적혀있다. 이 풍선들을 다음과 같은 규칙으로 터뜨린다.

 우선, 제일 처음에는 1번 풍선을 터뜨린다. 다음에는 풍선 안에 있는 종이를 꺼내어 그 종이에 적혀있는 값만큼 이동하여 다음 풍선을 터뜨린다. 양수가 적혀 있을 경우에는 오른쪽으로, 음수가 적혀 있을 때는 왼쪽으로 이동한다. 이동할 때에는 이미 터진 풍선은 빼고 이동한다.

 예를 들어 다섯 개의 풍선 안에 차례로 3, 2, 1, -3, -1이 적혀 있었다고 하자. 이 경우 3이 적혀 있는 1번 풍선, -3이 적혀 있는 4번 풍선, -1이 적혀 있는 5번 풍선, 1이 적혀 있는 3번 풍선, 2가 적혀 있는 2번 풍선의 순서대로 터지게 된다.
 */
import Foundation

class Node {
    var data: (number: Int, paper: Int)
    var rightLink: Node?
    var leftLink: Node?
    
    init(data: (number: Int, paper: Int)) {
        self.data = data
    }
}

class CircularLinkedList {
    private var front: Node?
    private var rear: Node?
    private var finder: Node?
    
    func append(data: (number: Int, paper: Int))  {
        let newNode = Node(data: data)
        
        //빈 리스트인 경우
        if front == nil {
            front = newNode
            rear = newNode
            finder = front
            
            front?.leftLink = rear //원형 큐
            rear?.rightLink = front
            
            return
        }
        //한 개 이상
        rear?.rightLink = newNode
        newNode.leftLink = rear
        rear = newNode
        rear?.rightLink = front //원형 큐
        front?.leftLink = rear
    }
    
    func removeRight(at: Int) -> (number: Int, paper: Int)? {
        var removedData: (number: Int, paper: Int)
        
        //빈 리스트일 경우
        if front == nil {return nil}
        
        //찾고자 하는 순서의 노드로 finder를 이동
        if at != 1 {
            for _ in 1..<at {
                finder = finder?.rightLink
            }
        }
        
        //찾는 노드에 도착
        removedData = finder!.data
        
        if front?.data.number == rear?.data.number, //노드가 하나일 때
           front?.data.paper == rear?.data.paper {
            finder = nil
            front = nil
            rear = nil
            
            return removedData
        }
        
        if finder?.data.number == front?.data.number, //찾은 노드가 첫 번째 노드일 때
           finder?.data.paper == front?.data.paper {
            front = front?.rightLink
        }
        if finder?.data.number == rear?.data.number, //찾은 노드가 마지막 노드일 때
           finder?.data.paper == rear?.data.paper {
            rear = rear?.leftLink
        }
        
        finder?.leftLink?.rightLink = finder?.rightLink
        finder?.rightLink?.leftLink = finder?.leftLink
        //참조만 끊어주면 ARC에 의해 메모리 할당 해제
        
        if removedData.paper > 0 {
            finder = finder?.rightLink //방향 정하기
        }else{
            finder = finder?.leftLink //방향 정하기
        }
        
        return removedData
    }
    
    func removeLeft(at: Int) -> (number: Int, paper: Int)? {
        var removedData: (number: Int, paper: Int)
        let at = -at
        
        //빈 리스트일 경우
        if front == nil {return nil}
        
        //찾고자 하는 순서의 노드로 finder를 이동
        if at != 1 {
            for _ in 1..<at {
                finder = finder?.leftLink
            }
        }
        
        //찾는 노드에 도착
        removedData = finder!.data
        
        if front?.data.number == rear?.data.number, //노드가 하나일 때
           front?.data.paper == rear?.data.paper {
            finder = nil
            front = nil
            rear = nil
            
            return removedData
        }
        
        if finder?.data.number == front?.data.number, //찾은 노드가 첫 번째 노드일 때
           finder?.data.paper == front?.data.paper {
            front = front?.rightLink
        }
        if finder?.data.number == rear?.data.number, //찾은 노드가 마지막 노드일 때
           finder?.data.paper == rear?.data.paper {
            rear = rear?.leftLink
        }
        
        finder?.leftLink?.rightLink = finder?.rightLink
        finder?.rightLink?.leftLink = finder?.leftLink
        //참조만 끊어주면 ARC에 의해 메모리 할당 해제
        
        if removedData.paper > 0 {
            finder = finder?.rightLink //방향 정하기
        }else{
            finder = finder?.leftLink //방향 정하기
        }
        
        return removedData
    }
}

var n: Int
var numbers: [String] = []
var balloons = CircularLinkedList() //풍선들을 배치할 원형 큐
var ballon: (number: Int, paper: Int) = (1, 1) //풍선의 번호와 풍선 안 종이 숫자를 저장할 변수
var balloonNumbers: [String] = [] //터진 풍선 번호를 저장할 배열

n = Int(readLine()!)!
numbers = readLine()!.components(separatedBy: " ")

//원형 큐 생성
for i in 0..<n {
    balloons.append(data: (i+1, Int(numbers[i])!))
}

//풍선 제거
for _ in 1...n {
    if ballon.paper < 0 { //음수면 왼쪽으로 이동
        ballon = balloons.removeLeft(at: ballon.paper)!
    }else{//양수면 오른쪽으로 이동
        ballon = balloons.removeRight(at: ballon.paper)!
    }
    
    balloonNumbers.append(String(ballon.number))
}

print(balloonNumbers.joined(separator: " "))
