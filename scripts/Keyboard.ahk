#SingleInstance, force
#NoEnv
SetBatchLines -1

Aqua=0xFFFF00
Black=0x000000
Blue=0xF0B000
Blue_2=0xFF0000
Blue_Dark=0x8B0000
Brown=0x2A2AA5
Crimson=0x3C14DC
Fuchsia=0xFF00FF
Gold=0x00D7FF
Green=0x008000
Green_Dark=0x006400
Grey=0x808080
Indigo=0x82004B
Magenta=0xFF00FF
Maroon=0x000080
Navy=0x800000
Orange=0x00A5FF
OrangeRed=0x0045FF
Pink=0xCBC0FF
Pink_Deep=0x9314FF
Purple=0x800080
Red=0x0000FF
RoyalBlue=0xE16941
Sienna=0x2D52A0
Tan=0x8CB4D2
Teal=0x808000
Turquoise=0xD0E040
White=0xFFFFFF
insert=alt+5
Yellow=0x00FFFF
 

#IfWinActive ahk_class screenClass ahk_exe POWERPNT.EXE






a::PenColor(Aqua)
b::PenColor(Black)
c::PenColor(Crimson)
d::PenColor(Pink_Deep)  
f::PenColor(Fuchsia) 
g::PenColor(Green_dark) 
h::PenColor(Magenta) 
i::PenColor(gold) 
j::PenColor(green) 
k::PenColor(grey) 
l::PenColor(Red) 
m::PenColor(maroon) 
n::PenColor(navy) 
o::PenColor(orange) 
p::PenColor(purple) 
q::PenColor(orange red) 
r::PenColor(Red) 
s::PenColor(Sienna) 
t::PenColor(tan)
u::PenColor(teal)
v::PenColor(turquoise)
w::PenColor(white)
x::PenColor(royal blue)
y::PenColor(yellow)
z::(insert)
,::PenColor(Blue)
.::PenColor(Blue_2)
/::PenColor(Blue_Dark)

#IfWinActive

PenColor(Color){
; Activate the slideshow
WinActivate, ahk_class screenClass ahk_exe POWERPNT.EXE
		
Try
	{
    ppt := ComObjActive("PowerPoint.Application")
    MyView := ppt.ActivePresentation.SlideShowWindow.View
    
    MyView.PointerType := 1
    ; Get color code and transform it from string to numerical value
    Color_Num := Color , Color_Num += 0
    	
    ; Set pen color		
    MyView.PointerColor.RGB := Color_Num
    				
    ; Set pointer as pen
    MyView.PointerType := 2
    
    ppt:=""
	}
}