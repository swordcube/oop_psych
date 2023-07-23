# Object Oriented Programming in Psych Lua

## ⚠️ WARNING: This is currently untested on Psych versions below 0.7!!

This repo is designed to allow for more OOP like programming in Psych Engine lua.
There is also some utilities for math, strings, and tables in here.

## How to install:
Git clone the repo or download the zip for it, then
extract the folder in said zip or put the folder from the clone into a
folder where your PsychEngine.exe file is located called "libs".

## Example usage:
- Sprites with tweening
```lua
local Game = require("libs/oop_psych/Game")
local Sprite = require("libs/oop_psych/Sprite")
local Tween = require("libs/oop_psych/tweens/Tween")
local Ease = require("libs/oop_psych/tweens/Ease")

local tween = nil
local scrotus = nil

Game.connect("onCreate", function()
    scrotus = Sprite.create("scrotus", 500, 300).loadGraphic("sick")
    scrotus.x = 50
    scrotus.y = 30.56
    scrotus.alpha = 0.45
    scrotus.add()

    tween = Tween.run(scrotus, {["scale.x"] = 5}, 2, Ease.cubeIn, 0)
end)
```