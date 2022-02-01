/*
 https://www.acmicpc.net/problem/1158
 요세푸스 문제
 요세푸스 문제는 다음과 같다.

 1번부터 N번까지 N명의 사람이 원을 이루면서 앉아있고, 양의 정수 K(≤ N)가 주어진다. 이제 순서대로 K번째 사람을 제거한다. 한 사람이 제거되면 남은 사람들로 이루어진 원을 따라 이 과정을 계속해 나간다. 이 과정은 N명의 사람이 모두 제거될 때까지 계속된다. 원에서 사람들이 제거되는 순서를 (N, K)-요세푸스 순열이라고 한다. 예를 들어 (7, 3)-요세푸스 순열은 <3, 6, 2, 7, 5, 1, 4>이다.

 N과 K가 주어지면 (N, K)-요세푸스 순열을 구하는 프로그램을 작성하시오.
 */
import Foundation

class Node {
    var data: Int
    var rightLink: Node?
    var leftLink: Node?
    
    init(data: Int) {
        self.data = data
    }
}

class CircularLinkedList {
    private var front: Node?
    private var rear: Node?
    private var finder: Node?
    
    func append(data: Int)  {
        let newNode = Node(data: data)
        
        //빈 리스트인 경우
        if front == nil {
            front = newNode
            rear = newNode
            finder = front
            
            front?.leftLink = rear //원형 큐
            rear?.rightLink = front
        }
        
        //한 개 이상
        rear?.rightLink = newNode
        newNode.leftLink = rear
        rear = newNode
        rear?.rightLink = front //원형 큐
    }
    
    func remove(at: Int) -> Int? {
        var removedData: Int
        
        //빈 리스트일 경우
        if front == nil {return nil}
        
        //첫 번째 원소일 경우
        if at == 1 {
            if front?.data == rear?.data {//노드가 하나일 경우
                removedData = front!.data
                finder = nil
                front = nil
                rear = nil
                 
                return removedData
            }
            //노드가 여러 개일 경우
            removedData = front!.data
            finder = front?.rightLink
            front = front?.rightLink
            
            front?.leftLink = rear //원형 큐
            rear?.rightLink = front
            
            return removedData
        }
        
        //찾고자 하는 순서의 노드로 finder를 이동
        for _ in 1..<at {
            finder = finder?.rightLink
        }
        
        //찾는 노드에 도착
        if finder?.rightLink?.data == front?.data {//찾는 노드가 마지막일 경우
            removedData = finder!.data
            rear = finder?.leftLink
            rear?.rightLink = front //참조만 끊어주면 ARC에 의해 메모리 할당 해제
        }else{
            removedData = finder!.data
            finder?.leftLink?.rightLink = finder?.rightLink
            finder?.rightLink?.leftLink = finder?.leftLink
            //참조만 끊어주면 ARC에 의해 메모리 할당 해제
        }
        finder = finder?.rightLink
        
        return removedData
    }
}

var input: [String] = [] //총 사람의 수, 삭제할 순번
var people = CircularLinkedList()
var results: [String] = []


input = readLine()!.components(separatedBy: " ")

for i in 1...Int(input[0])! {
    people.append(data: i)
}

for _ in 1...Int(input[0])! {
    results.append(String(people.remove(at: Int(input[1])!)!))
}

print("<\(results.joined(separator: ", "))>")


