/*
 https://www.acmicpc.net/problem/1406
 에디터
 한 줄로 된 간단한 에디터를 구현하려고 한다. 이 편집기는 영어 소문자만을 기록할 수 있는 편집기로, 최대 600,000글자까지 입력할 수 있다.

 이 편집기에는 '커서'라는 것이 있는데, 커서는 문장의 맨 앞(첫 번째 문자의 왼쪽), 문장의 맨 뒤(마지막 문자의 오른쪽), 또는 문장 중간 임의의 곳(모든 연속된 두 문자 사이)에 위치할 수 있다. 즉 길이가 L인 문자열이 현재 편집기에 입력되어 있으면, 커서가 위치할 수 있는 곳은 L+1가지 경우가 있다.

 이 편집기가 지원하는 명령어는 다음과 같다.

 L    커서를 왼쪽으로 한 칸 옮김 (커서가 문장의 맨 앞이면 무시됨)
 D    커서를 오른쪽으로 한 칸 옮김 (커서가 문장의 맨 뒤이면 무시됨)
 B    커서 왼쪽에 있는 문자를 삭제함 (커서가 문장의 맨 앞이면 무시됨)
 삭제로 인해 커서는 한 칸 왼쪽으로 이동한 것처럼 나타나지만, 실제로 커서의 오른쪽에 있던 문자는 그대로임
 P $    $라는 문자를 커서 왼쪽에 추가함
 초기에 편집기에 입력되어 있는 문자열이 주어지고, 그 이후 입력한 명령어가 차례로 주어졌을 때, 모든 명령어를 수행하고 난 후 편집기에 입력되어 있는 문자열을 구하는 프로그램을 작성하시오. 단, 명령어가 수행되기 전에 커서는 문장의 맨 뒤에 위치하고 있다고 한다.
 */
import Foundation

class Node {
    var data: String?
    var leftLink: Node?
    var rightLink: Node?
    
    init(data: String) {
        self.data = data
    }
}

class Editor {
    var head: Node?
    var tail: Node?
    var cursorLeft: Node? //현재 노드는 커서의 왼쪽 노드를 의미한다.
    
    func append(data: String) {
        let newNode = Node(data: data)
        
        //빈 리스트
        if head == nil {
            let emptyNode = Node(data: "") //빈 노드를 생성해 커서가 맨 앞에 위치한 경우로 사용한다.
            head = emptyNode
            head?.rightLink = newNode
            newNode.leftLink = head
            tail = newNode
            cursorLeft = tail //명령어가 수행되기 전에 커서는 문장의 맨 뒤에 위치하고 있다.
            
            return
        }
        
        //글자가 한 개 이상(노드가 두 개 이상)
        tail?.rightLink = newNode
        newNode.leftLink = tail
        tail = newNode
        cursorLeft = tail
    }
    
    //L: 커서를 왼쪽으로 한 칸 옮김 (커서가 문장의 맨 앞이면 무시됨)
    func moveLeft() {
        //빈 리스트인 경우
        if head == nil {return}
        
        //커서가 문장의 맨 앞이면 무시된다.
        if cursorLeft?.leftLink == nil { return }
        
        //이외
        cursorLeft = cursorLeft?.leftLink
    }
    
    //D: 커서를 오른쪽으로 한 칸 옮김 (커서가 문장의 맨 뒤이면 무시됨)
    func moveRight() {
        //빈 리스트인 경우
        if head == nil {return}
        
        //커서가 문장의 맨 뒤이면 무시된다.
        if cursorLeft?.rightLink == nil {return}
        
        //이외
        cursorLeft = cursorLeft?.rightLink
    }
    
    //B: 커서 왼쪽에 있는 문자를 삭제함 (커서가 문장의 맨 앞이면 무시됨)
    //삭제로 인해 커서는 한 칸 왼쪽으로 이동한 것처럼 나타나지만, 실제로 커서의 오른쪽에 있던 문자는 그대로임
    func removeLeft() {
        //빈 리스트인 경우
        if head == nil {return}
        
        //커서가 문장의 맨 앞이면 무시된다
        if cursorLeft?.leftLink == nil { return }
        
        //커서가 문장의 맨 끝에 있는 경우
        if cursorLeft?.rightLink == nil {
            tail = tail?.leftLink
            cursorLeft?.leftLink?.rightLink = nil
            cursorLeft = cursorLeft?.leftLink //참조가 끊어지면 ARC에 의해 메모리 해제된다.
            
            return
        }
        
        //이외
        cursorLeft?.leftLink?.rightLink = cursorLeft?.rightLink
        cursorLeft?.rightLink?.leftLink = cursorLeft?.leftLink
        cursorLeft = cursorLeft?.leftLink //참조가 끊어지면 ARC에 의해 메모리 해제된다.
    }
    
    //P $ : $라는 문자를 커서 왼쪽에 추가함
    func insertLeft(data: String) {
        //문장 마지막에 커서가 위치할 때
        if cursorLeft?.rightLink == nil {
            append(data: data)
            return
        }
        
        let newNode = Node(data: data)
        //이외
        cursorLeft?.rightLink?.leftLink = newNode
        newNode.rightLink = cursorLeft?.rightLink
        cursorLeft?.rightLink = newNode
        newNode.leftLink = cursorLeft
        cursorLeft = newNode
        
    }
    
    func toString() -> String {
        var temp = head
        var result: String = ""
        
        //빈 리스트인 경우
        if head == nil {return ""}
        
        while temp != nil {
            result.append(temp!.data!)
            temp = temp?.rightLink //마지막 노드인 경우 nil을 할당한다
        }
        return result
    }
}

//문제 시작
var editor = Editor()
let numberOfInstruction: Int

var inputs = Array(readLine()!)
numberOfInstruction = Int(readLine()!)!

for input in inputs {
    editor.append(data: String(input))
}

for _ in 1...numberOfInstruction {
    let command = readLine()!.components(separatedBy: " ")
    
    switch command[0] {
    case "L":
        editor.moveLeft()
    case "D":
        editor.moveRight()
    case "B":
        editor.removeLeft()
    default: //"P"
        editor.insertLeft(data: command[1])
    }
}

print(editor.toString())

