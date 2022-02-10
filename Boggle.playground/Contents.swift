/*
 https://algospot.com/judge/problem/read/BOGGLE
 보글 게임
 보글(Boggle) 게임은 그림 (a)와 같은 5x5 크기의 알파벳 격자인
 게임판의 한 글자에서 시작해서 펜을 움직이면서 만나는 글자를 그 순서대로 나열하여 만들어지는 영어 단어를 찾아내는 게임입니다. 펜은 상하좌우, 혹은 대각선으로 인접한 칸으로 이동할 수 있으며 글자를 건너뛸 수는 없습니다. 지나간 글자를 다시 지나가는 것은 가능하지만, 펜을 이동하지않고 같은 글자를 여러번 쓸 수는 없습니다.

 */
//미해결 - 단어의 첫 번째 글자를 예제와 같이 찾지 못함
import Foundation

func searchWord(_ word: String, index: Int, row: Int, column: Int) -> Bool {
    //글자 완성된 경우
    if word == searchedWord {
        return true
    }
    
    var row = row
    var column = column
    
    //처음인 경우 단어의 첫 번째 알파벳 위치 찾기
    if searchedWord.isEmpty {
        guard let firstAlphabet: direction = searchFirstAlphabet(word) else {return false}
        row = firstAlphabet.row
        column = firstAlphabet.column
        print("\(row), \(column)")
    }
    
    typealias direction = (row: Int, column: Int)
    let north: direction = (row - 1, column) //상
    let south: direction = (row+1, column) //하
    let west: direction = (row, column-1) //좌
    let east: direction = (row,column+1) //우
    let northeast: direction = (row-1, column+1) //대각선
    let northwest: direction = (row-1, column-1)
    let southeast: direction = (row+1, column+1)
    let southwest: direction = (row+1, column-1)
    
    let i = word.index(word.startIndex, offsetBy: index)
    let char = String(word[i]) //찾는 단어의 다음 글자
    var result = false
    print(char)
    
    if north.row > -1,
       char == board[north.row][north.column] {
        searchedWord.append(board[north.row][north.column])
        result = searchWord(word, index: index+1, row: north.row, column: north.column)
    }else if south.row < board.count,
             char == board[south.row][south.column] {
        searchedWord.append(board[south.row][south.column])
        result = searchWord(word, index: index+1, row: south.row, column: south.column)
    }else if east.column < board.count,
             char == board[east.row][east.column] {
        searchedWord.append(board[east.row][east.column])
        result = searchWord(word, index: index+1, row: east.row, column: east.column)
    }else if west.column > -1,
             char == board[west.row][west.column]{
        searchedWord.append(board[west.row][west.column])
        result = searchWord(word, index: index+1, row: west.row, column: west.column)
    }else if northeast.row > -1, northeast.column < board.count,
             char == board[northeast.row][northeast.column] {
        searchedWord.append(board[northeast.row][northeast.column])
        result = searchWord(word, index: index+1, row: northeast.row, column: northeast.column)
    }else if northwest.row > -1, northwest.column > -1,
             char == board[northwest.row][northwest.column] {
        searchedWord.append(board[northwest.row][northwest.column])
        result = searchWord(word, index: index+1, row: northwest.row, column: northwest.column)
    }else if southeast.row < board.count, southeast.column < board.count,
             char == board[southeast.row][southeast.column]{ //남동 - 우측하단
        searchedWord.append(board[southeast.row][southeast.column])
        result = searchWord(word, index: index+1, row: southeast.row, column: southeast.column)
    }else if southwest.row < board.count, southwest.column > -1,
             char == board[southwest.row][southwest.column] {
            searchedWord.append(board[southwest.row][southwest.column])
            result = searchWord(word, index: index+1, row: southwest.row, column: southwest.column)
        
    }else {
        result = false //주변에 다음 글자가 없을 경우
    }
             
    
//    switch char {
//    case board[north.row][north.column]:  //북 - 상
//        print(board[north.row][north.column])
//        searchedWord.append(board[north.row][north.column])
//        result = searchWord(word, index: index+1, row: north.row, column: north.column)
//    case board[south.row][south.column]: //남 - 하
//        searchedWord.append(board[south.row][south.column])
//        result = searchWord(word, index: index+1, row: south.row, column: south.column)
//    case board[east.row][east.column]: //동 - 우
//        searchedWord.append(board[east.row][east.column])
//        result = searchWord(word, index: index+1, row: east.row, column: east.column)
//    case board[west.row][west.column]: //서 - 좌
//        searchedWord.append(board[west.row][west.column])
//        result = searchWord(word, index: index+1, row: west.row, column: west.column)
//    case board[northeast.row][northeast.column]: //북동 - 우측상단
//        searchedWord.append(board[northeast.row][northeast.column])
//        result = searchWord(word, index: index+1, row: northeast.row, column: northeast.column)
//    case board[northwest.row][northwest.column]: //북서 - 좌측상단
//        searchedWord.append(board[northwest.row][northwest.column])
//        result = searchWord(word, index: index+1, row: northwest.row, column: northwest.column)
//    case board[southeast.row][southeast.column]: //남동 - 우측하단
//        searchedWord.append(board[southeast.row][southeast.column])
//        result = searchWord(word, index: index+1, row: southeast.row, column: southeast.column)
//    case board[southwest.row][southwest.column]: // 남서 - 좌측하단
//        searchedWord.append(board[southwest.row][southwest.column])
//        result = searchWord(word, index: index+1, row: southwest.row, column: southwest.column)
//    default:
//        result = false //주변에 다음 글자가 없을 경우
//    }
    
    return result
}

func searchFirstAlphabet(_ word: String) -> (Int, Int)? {
    for row in 0..<board.count {
        for column in 0..<board[row].count {
            if String(word[word.startIndex]) == board[row][column] {
                return (row, column)
            }
        }
    }
    return nil
}


var numberOfTestCases: Int
var board: [[String]] = []
var numberOfWords: Int
var searchedWord = ""


numberOfTestCases = Int(readLine()!)!
for _ in 1...numberOfTestCases {
    board.append(Array(readLine()!).map{String($0)})
}
print(board)

numberOfWords = Int(readLine()!)!
for _ in 1...numberOfWords {
    let word = readLine()!
    let result = searchWord(word, index: 0, row: 0, column: 0)
    
    print("\(word) \(result)")
}
