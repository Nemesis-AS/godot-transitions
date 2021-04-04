# Godot Transitions

A Godot addon for fancy scene transition effects

### **WIP** - This addon is currently under active developement. 

Feel free to create issues if you find any bugs or have any transition ideas that should be added to this addon

## Getting Started

Download the zip or clone the repo and import the project to Godot using `project.json` in `godot` folder.

## Transitions

### Fade Out(from: scene, to: String, duration: float, color: Color)
**from** -> The scene from which the function is being called, usually `self`
**to** -> The path to the target scene, eg. `res://demo/Demo1.tscn`
**duration** -> Duration for the transition to last (in seconds), eg. `1.5`
**color** -> The color to which the screen will fade out to and the new scene will fade in. eg. `Color.black`

![Fade to Black](/src/FadeToBlack.gif)

### Move To(from: scene, to: String, duration: float, direction: Vector2)
**from** -> The scene from which the function is being called, usually `self`
**to** -> The path to the target scene, eg. `res://demo/Demo1.tscn`
**duration** -> Duration for the transition to last (in seconds), eg. `1.5`
**direction** -> The direction from which the new scene will enter the viewport. It needs to be either UP, DOWN, RIGHT or LEFT eg. `Vector2.RIGHT`

![Move from Right](/src/MoveFromRight.gif)