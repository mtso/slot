/**
 * slot-cli is a command line game written in Swift by Matthew Tso
 */

import Darwin

var balance = 100
var day = 0
var highest = 100

print("Welcome to Slots")

print("How many coins would you like to bet?\n         ", terminator: "")

var shouldContinue = true

func spin(with bet: Int) -> Int {
	let wheel1 = arc4random_uniform(3) + 1
	let wheel2 = arc4random_uniform(3) + 1
	let wheel3 = arc4random_uniform(3) + 1

	print(wheel1, wheel2, wheel3, terminator: " ")

	if wheel1 == wheel2 && wheel2 == wheel3 {
		let modifier = arc4random_uniform(3) + 4 // 4 or 5 or 6
		let winnings = bet * Int(wheel1) * Int(modifier)

		print("+\(winnings) ", terminator: "")
		return winnings
	} else {
		print("+0 ", terminator: "")
		return 0
	}
}

// for i in 0...1000000 {
// print("")
while (shouldContinue) {

	print("Day\(day) \(balance)c: ", terminator: "")

	// var input: String?; input = "1" // String( ((arc4random_uniform(UInt32(balance) - 1) + 1) / 2) + 1 )
	let input = readLine(strippingNewline: true)

	if let bet = Int(input!) {

		if bet > balance { print("You cannot bet more coins than you have."); continue }

		balance -= bet
		balance += spin(with: bet)
		if balance > highest { highest = balance }

		if balance == 0 {
			print("Day\(day) \(balance)c: ")
			print("You went bankrupt on day \(day). At your richest, you had \(highest) coins.")
			print("Your final score is \( highest - day > 0 ? highest - day : 0 ).")
			break
		}
	}

	day += 1
}
