import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    /// Method to print coverage info
    func showCoverageInfo() {
        print("")
    }

    func greet(person: String) -> String {
        let greeting = "Hello " + person
        return greeting
    }

    func getHelloWorld() -> String {
        return "Hello World"
    }

    func stringToInt(string: String) -> Int {
        return Int(string) ?? 0
    }
}
