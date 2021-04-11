# Godot Transitions

A Godot addon for fancy scene transition effects

### **WIP** - This addon is currently under active developement. 

Feel free to create issues if you find any bugs or have any transition ideas that should be added to this addon

## Getting Started

Download the zip or clone the repo and import the project to Godot using `project.json` in `godot` folder.

### Adding the Plugin to your Project

- Download the zip or clone the repository.
- Copy the `addons` folder to the root of your project
- Now, in the Godot Editor, open `Project Settings` and open the `Plugins` tab
- Enable the `Godot Transitions` plugin

And you're ready to go! You can now use `Transitions` singleton to transition between scenes.

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

### Shrink(from: scene, to: String, duration: float)
**from** -> The scene from which the function is being called, usually `self`
**to** -> The path to the target scene, eg. `res://demo/Demo1.tscn`
**duration** -> Duration for the transition to last (in seconds), eg. `1.5`

![Shrink with Fade](/src/ShrinkWithFade.gif)

### Slide Rect(from: scene, to: String, duration: float, color: Color, direction: Vector2)
**from** -> The scene from which the function is being called, usually `self`
**to** -> The path to the target scene, eg. `res://demo/Demo1.tscn`
**duration** -> Duration for the transition to last (in seconds), eg. `1.5`
**color** -> The color of the overlay. eg. `Color.black`
**direction** -> The direction in which the zigzag overlay will move. It needs to be either RIGHT or LEFT eg. `Vector2.RIGHT`

![Slide Black Rect](/src/SlideZag.gif)

### Horizontal Stripes(from: scene, to: String, duration: float, color: Color)
**from** -> The scene from which the function is being called, usually `self`
**to** -> The path to the target scene, eg. `res://demo/Demo1.tscn`
**duration** -> Duration for the transition to last (in seconds), eg. `1.5`
**color** -> The color of the overlay. eg. `Color.black`

![Horizontal Stripes](/src/HorizontalStripes.gif)

### Dual Circles(from: scene, to: String, duration: float, color: Color)
**from** -> The scene from which the function is being called, usually `self`
**to** -> The path to the target scene, eg. `res://demo/Demo1.tscn`
**duration** -> Duration for the transition to last (in seconds), eg. `1.5`
**color** -> The color of the overlay. eg. `Color.black`

![Dual Circles](/src/DualCircles.gif)

### Donut Eye(from: scene, to: String, duration: float, color: Color)
**from** -> The scene from which the function is being called, usually `self`
**to** -> The path to the target scene, eg. `res://demo/Demo1.tscn`
**duration** -> Duration for the transition to last (in seconds), eg. `1.5`
**color** -> The color of the overlay. eg. `Color.black`

![Donut Eye](/src/DonutEye.gif)