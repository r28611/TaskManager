import UIKit

struct Person: Codable {
    let name: String
    let age: Int
    let isDeveloper: Bool
    
    var description: String {
        return "name: \(self.name) age: \(self.age) isDeveloper: \(self.isDeveloper)"
    }
}

protocol ParserHandler {
    var next: ParserHandler? { get set }
    func parse(_ data: Data) -> [Person]
 }

class FirstParser: ParserHandler {

     var next: ParserHandler?

     private struct PersonsData: Codable {
         var data: [Person]
     }

     func parse(_ data: Data) -> [Person] {
         do {
             let personsData = try JSONDecoder().decode(PersonsData.self, from: data)
             return personsData.data
         } catch {
             return self.next?.parse(data) ?? []
         }
     }
 }

class SecondParser: ParserHandler {

     var next: ParserHandler?

     private struct PersonsData: Codable {
         var result: [Person]
     }

     func parse(_ data: Data) -> [Person] {
         do {
             let personsData = try JSONDecoder().decode(PersonsData.self, from: data)
             return personsData.result
         } catch {
             return self.next?.parse(data) ?? []
         }
     }
 }

 class ThirdParser: ParserHandler {

     var next: ParserHandler?

     func parse(_ data: Data) -> [Person] {
         do {
             let persons = try JSONDecoder().decode([Person].self, from: data)
             return persons
         } catch {
             return self.next?.parse(data) ?? []
         }
     }
 }

func data(from file: String) -> Data {
    let path1 = Bundle.main.path(forResource: file, ofType: "json")!
    let url = URL(fileURLWithPath: path1)
    let data = try! Data(contentsOf: url)
    return data
}


func parseFile(_ file: String) -> [Person] {
    let parser1 = FirstParser()
    let parser2 = SecondParser()
    let parser3 = ThirdParser()

    parser3.next = parser2
    parser2.next = parser1
    parser1.next = nil

    let data = data(from: file)

    return parser3.parse(data)
}

print(parseFile("1").description, parseFile("2"), parseFile("3"))
