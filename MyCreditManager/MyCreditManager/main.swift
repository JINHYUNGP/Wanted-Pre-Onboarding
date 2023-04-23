//
//  main.swift
//  MyCreditManager
//
//  Created by 박진형 on 2023/04/23.
//

import Foundation

class Student{
    var name: String = ""
    var subjectsAndGrade: [String: String] = [:]
    init(name: String) {
        self.name = name
    }
    func printAndCalcGrade(){
        var GradesSum:Float = 0.0
        for subjectAndGrade in self.subjectsAndGrade{
            print(subjectAndGrade.key + " " + subjectAndGrade.value)
            switch subjectAndGrade.value{
            case "A+" :
                GradesSum += 4.5
            case "A" :
                GradesSum += 4.0
            case "B+" :
                GradesSum += 3.5
            case "B" :
                GradesSum += 3.0
            case "C+" :
                GradesSum += 2.5
            case "C" :
                GradesSum += 2.0
            case "D+" :
                GradesSum += 1.5
            case "D" :
                GradesSum += 1.0
            case "F" :
                GradesSum += 0
            default: break
                
            }
        }
        let GPA: Float = GradesSum / Float(subjectsAndGrade.count)
        var GPAString = String(format: "%.2f", GPA)
        if GPAString.hasSuffix(".00") { // 맨 뒤에 .00이 있다면
            GPAString = String(GPAString.dropLast(3)) // 맨 뒤의 .00을 제외한 문자열 출력
        } else if GPAString.hasSuffix("0") { // 맨 뒤에 0이 있다면
            GPAString = String(GPAString.dropLast()) // 맨 뒤의 0을 제외한 문자열 출력
        }
        print("평점 : \(GPAString)")
    }
}

let menuText: String = "원하는 기능을 입력해주세요 \n1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료"

let errorMessage: String = "뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요."

let endMessage: String = "프로그램을 종료합니다..."

let grades = ["A+", "A", "A-", "B+", "B", "B-", "C+", "C", "C-", "D+", "D", "D-", "F"]

var students: [Student] = []
while true{
    print(menuText)
    if let input = readLine(), input != "X" {
        switch Int(input) {
        case 1:
            addStudent()
        case 2:
            deleteStudent()
        case 3:
            addGrade()
        case 4:
            deleteGrade()
        case 5:
            checkGPA()
        default:
            print(errorMessage)
            
        }
    } else{
        print(endMessage)
        break
    }
}

// MARK: menu 에서 1을 선택했을 때 호출되는 함수
func addStudent(){
    let addStudentComment: String = "추가할 학생의 이름을 입력해주세요"
    let addStudentErrorMessage: String = "입력이 잘못되었습니다. 다시확인해주세요"
    print(addStudentComment)
    if let input = readLine(){
        let trimmedName = input.filter{ !$0.isWhitespace }
        if trimmedName.count == 0 {
            
            print(addStudentErrorMessage)
            
        }else {
            var isStudentExist: Bool = false
            for student in students {
                if student.name ==  input{
                    isStudentExist = true
                }
            }
            if isStudentExist {
                print("\(input)은 이미 존재하는 학생입니다. 추가하지 않습니다.")
            }else {
                let student:Student = Student(name: input)
                students.append(student)
                print("\(input) 학생을 추가했습니다.")
            }
            
        }
    }
}

// MARK: menu 에서 2를 선택했을 때 호출되는 함수
func deleteStudent(){
    let deleteStudentComment: String = "삭제할 학생의 이름을 입력해주세요"
    let deleteStudentErrorMessage: String = "학생을 찾지 못했습니다."
    print(deleteStudentComment)
    var isStudentExist: Bool = false
    
    if let input = readLine(){
        
        for student in students {
            if input == student.name{
                isStudentExist = true
                students.removeAll(where: { $0.name == input })
                print("\(input) 학생을 삭제하였습니다.")
            }
            if !isStudentExist{
                print("\(input) " + deleteStudentErrorMessage )
            }
        }
        
    }
}

// MARK: menu 에서 3을 선택했을 때 호출되는 함수
func addGrade(){
    let addGradeComment: String = "성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요. \n입력예) Mickey Swift A+\n만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다."
    let errorMessage: String = "학생을 찾지 못했습니다."
    print(addGradeComment)
    if let input = readLine(){
        let trimmedName = input.filter{ !$0.isWhitespace }
        if trimmedName.count == 0 || trimmedName.count + 2  != input.count {
            
            print(errorMessage)
            
        }else {
            // 입력이 빈칸이 아니라면
            // student 배열을 돌아서
            
            let words = input.split(separator: " ")
            
            let (name, subject, grade) = (String(words[0]), String(words[1]), String(words[2]))
            
            for student in students {
                
                if student.name == name{
                    
                    
                    student.subjectsAndGrade[subject] = grade
                    print("\(student.name) 학생의 \(subject) 과목이 \(grade)로 추가(변경)되었습니다.")
                    
                    
                    
                }
            }
        }
    }
}

// MARK: menu 에서 2를 선택했을 때 호출되는 함수
func deleteGrade(){
    let deleteGradeComment: String = "성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요. \n입력예) Mickey Swift"
    let deleteGradeErrorMessage: String = "입력이 잘못되었습니다. 다시 확인해주세요."
    print(deleteGradeComment)
    if let input = readLine(){
        let trimmedName = input.filter{ !$0.isWhitespace }
        if trimmedName.count == 0 || trimmedName.count + 1  != input.count {
            
            print(deleteGradeErrorMessage)
            
        }else {
            // 입력이 빈칸이 아니라면
            // student 배열을 돌아서
            
            let words = input.split(separator: " ")
            
            let (name, subject) = (String(words[0]), String(words[1]))
            
            for student in students {
                if student.name == name{
                    for subjectAndGrade in student.subjectsAndGrade {
                        if subjectAndGrade.key == subject {
                            student.subjectsAndGrade.removeValue(forKey: subject)
                            print("\(name) 학생의 \(subject) 과목의 성적이 삭제되었습니다.")
                        }
                    }
                    
                }
            }
        }
    }
}

// MARK: menu 에서 2를 선택했을 때 호출되는 함수
func checkGPA(){
    let checkGPAComment: String = "평점을 알고싶은 학생의 이름을 입력해주세요"
    let checkGPAErrorMessage: String = "입력이 잘못되었습니다. 다시확인해주세요."
    print(checkGPAComment)
    if let input = readLine(){
        let trimmedName = input.filter{ !$0.isWhitespace }
        if trimmedName.count == 0 {
            
            print(checkGPAErrorMessage)
            
        }else {
            // 학생이 존재하는지 확인
            var isStudentExist: Bool = false
            for student in students{
                if student.name ==  input{
                    isStudentExist = true
                    student.printAndCalcGrade()
                }
            }
            if !isStudentExist {
                print("\(input) 학생을 찾지 못했습니다.")
            }
        }
    }
}
