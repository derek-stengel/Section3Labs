/*:
## Exercise - Extensions
 
 Define an extension to `Character` that includes a function `isVowel()`. The function returns `true` if the character is a vowel (a,e,i,o,u), and `false` otherwise. Be sure to properly handle uppercase and lowercase characters.
 */
extension Character {
    func isVowel() -> Bool {
        let lowercaseSelf = String(self).lowercased()
        return "aeiou".contains(lowercaseSelf)
    }
}
//:  Create two `Character` constants, `myVowel` and `myConsonant`, and set them to a vowel and a consonant, respectively. Use the `isVowel()` methods on each constant to determine whether or not it's a vowel.
let myVowel: Character = "a"
let myConsonant: Character = "b"

myVowel.isVowel()
myConsonant.isVowel()

//:  Create a `Rectangle` struct with two variable properties, `length` and `width`, both of type `Double`. Below the definition, write an extension to `Rectangle` that includes a function, `halved()`. This function returns a new `Rectangle` instance with half the length and half the width of the original rectangle.
struct Rectangle {
    var length: Double
    var width: Double
}

extension Rectangle {
    func halved() -> Rectangle {
        Rectangle(length: self.length / 2, width: self.width / 2) // returns half values for H & W
    }
    
    mutating func half() {
        let halfRetangle = self.halved()
        self.length = halfRetangle.length
        self.width = halfRetangle.width
    }
}

/*:
 Within the existing `Rectangle` extension, add a new mutating function, `half()`, which updates the original rectangle to have half the length and half the width. Use the `halved()` function as part of the implementation for `half()`.
 
 Below, create a variable `Rectangle` called `myRectangle`, and set its length to 10 and its width to 5. Create a second instance, `mySmallerRectangle`, that's the result of calling `halved()` on `myRectangle`. Then update the values of `myRectangle` by calling `half()` on itself. Print each of the instances.
 */
var myRetangle = Rectangle(length: 10, width: 5)
var mySmallerRetangle = myRetangle.halved()
myRetangle.half()

print(mySmallerRetangle)

/*:
page 1 of 2  |  [Next: App Exercise - Workout Extensions](@next)
 */
