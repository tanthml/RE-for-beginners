include(`commons.m4')org 100h
mov al,13h
int 10h

; _EN(`set palette')_RU(`установить палитру')
mov dx, 3c8h
mov al, 0
out dx, al
mov cx, 100h
inc dx
l00:
mov al, cl
shl ax, 2
out dx, al ; _EN(`red')_RU(`красный')
out dx, al ; _EN(`green')_RU(`зеленый')
out dx, al ; _EN(`blue')_RU(`синий')
loop l00

push 0a000h
pop es

xor di, di

FillLoop:
cwd
mov ax,di
mov cx,320
div cx
sub ax,100
sub dx,160

xor bx,bx
xor si,si

MandelLoop:
mov bp,si
imul si,bx
add si,si
imul bx,bx
jo MandelBreak
imul bp,bp
jo MandelBreak
add bx,bp
jo MandelBreak
sub bx,bp
sub bx,bp

sar bx,6
add bx,dx
sar si,6
add si,ax

loop MandelLoop

MandelBreak:
xchg ax,cx
stosb
cmp di, 0FA00h
jb FillLoop

; _EN(`wait for keypress')_RU(`дождаться нажатия любой клавиши')
xor ax,ax
int 16h
; _EN(`set text video mode')_RU(`установить текстовый видеорежим')
mov ax, 3
int 10h
; _EN(`exit')_RU(`выход')
int 20h
