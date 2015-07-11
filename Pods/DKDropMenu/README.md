# DKDropMenu
DKDropMenu is a simple iOS drop down list written in Swift. It expands and collapses. It allows the user to select only one item at a time. Items are just Strings. A delegate is notified when selection occurs. DKDropMenu is IBDesignable and IBInspectable with customizable colors, font, and row heights.

![DKDropMenu1](https://raw.githubusercontent.com/davecom/DKDropMenu/master/DKDropMenu.png)
![DKDropMenu2](https://raw.githubusercontent.com/davecom/DKDropMenu/master/DKDropMenu.gif)

## Installation
Use the cocoapod `DKDropMenu` or simply include `DKDropMenu.swift` in your project.

## Usage
Create a DKDropMenu in IB or in code (using UIView's init methods). Then add items and set a delegate:
```
dropMenu.addItems(["hello", "goodbye", "why?"])
dropMenu.delegate = self
```
Make sure to implement the single method the delegate (DKDropMenuDelegate) must implement:
```
func itemSelectedWithIndex(index: Int, name: String) {
    println("\(name) selected");
}
```
Items can be added or removed 
```
func addItems(names: [String])
func addItem(name: String)
func removeItemAtIndex(index: Int)
func removeItem(name: String)
```
The properties `collapsed` (Bool) and `selectedItem` (String) can be manually modified.

## License and Authorship
Released under the MIT License.  Copyright 2015 David Kopec. Please open issues on GitHub.
