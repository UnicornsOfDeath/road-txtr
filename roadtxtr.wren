// title:   road txtr
// author:  unicorns of death
// desc:    tbd
// site:    tbd
// license: MIT License (change this to your license of choice)
// version: 0.1
// script:  wren

import "random" for Random

var WIDTH=240
var HEIGHT=136
var MAP_W=30
var MAP_H=17
var COLOR_BG=0
var MUSSPLASH=0
var MUSGAME=1
var MUSTITLE=2
var MUSDEATH=3
var MUSTEMPO=100
var MUSSPD=3
var FPS=60
var MUSBEATTICKS=FPS*60/MUSTEMPO*MUSSPD/6
var PALETTE_MAP=0x3FF0
var SFXNEXT=1
var SFXHIT=3
var SFXSCREAM=4
var SFXGRASS=5
var TXT_X=120
var TXT_Y=10
var TXT_W=WIDTH-TXT_X-10
var TXT_H=HEIGHT-TXT_Y-10
var EVENT_TICK=200
var WIN_X=2000
var STRESS_TICK=100
var RANDOM=Random.new()

// BUTTONS

var BTN_UP=0
var BTN_DOWN=1
var BTN_LEFT=2
var BTN_RIGHT=3
var BTN_A=4
var BTN_B=5
var BTN_X=6
var BTN_Y=7

// TILE IDs
var TILE_SIZE=8
var TILE_SIZE_2=16

var ROAD_TILES=[0,1,2,3,32,33]
var GRASS_TILES=[64,65,80,81]

class ChunkyFont {

    static init_() {
        __SYM_MAP={
            "}":0,
            "{":1,
            "^":2,
            "<":3,
            "=":4,
            ">":5,
            "]":6,
            "[":7,
            "r":16,
            "?":17,
            "|":18,
            "Y":19,
            "o":20,
            "T":21,
            "P":22,
            "7":23,
            "6":32,
            "j":33,
            "v":34,
            "m":35,
            "_":37,
            "L":38,
            "J":39,
        }

        __WIDTH=8
        __HEIGHT=8

        __COLOR1=10
        __COLOR2=9

        __LETTERS={
            "a":[
                "",
                "r?",
                "6v"
            ],
            "b":[
                "^",
                "]?",
                "Lj"
            ],
            "c":[
                "",
                "r>",
                "6>"
            ],
            "d":[
                " ^",
                "r[",
                "6J"
            ],
            "e":[
                "",
                "r?",
                "6>"
            ],
            "f":[
                "r>",
                "]>",
                "v"
            ],
            "g":[
                "",
                "r7",
                "6[",
                "<j"
            ],
            "h":[
                "^",
                "]?",
                "vv"
            ],
            "i":[
                "o",
                "^",
                "v"
            ],
            "j":[
                " o",
                " ^",
                " |",
                "<j"
            ],
            "k":[
                "^",
                "]>",
                "vo"
            ],
            "l":[
                "^",
                "|",
                "v"
            ],
            "m":[
                "",
                "PT?",
                "vvv"
            ],
            "n":[
                "",
                "P?",
                "vv"
            ],
            "o":[
                "",
                "r?",
                "6j"
            ],
            "p":[
                "",
                "P?",
                "]j",
                "v"
            ],
            "q":[
                "",
                "r7",
                "6[",
                " v"
            ],
            "r":[
                "",
                "P>",
                "v"
            ],
            "s":[
                "",
                "r>",
                "<j"
            ],
            "t":[
                "^",
                "]>",
                "6>"
            ],
            "u":[
                "",
                "^^",
                "6J"
            ],
            "v":[
                "",
                "^^",
                "Lj"
            ],
            "w":[
                "",
                "^^^",
                "6mj"
            ],
            "x":[
                "",
                "oo",
                "oo"
            ],
            "y":[
                "",
                "^^",
                "6[",
                "<j"
            ],
            "z":[
                "",
                "<?",
                "6>"
            ],
            "A":[
                "r=?",
                "]=[",
                "v v"
            ],
            "B":[
                "P=?",
                "]={",
                "L=j"
            ],
            "C":[
                "r=>",
                "|",
                "6=>"
            ],
            "D":[
                "P=?",
                "| |",
                "L=j"
            ],
            "E":[
                "P=>",
                "]=>",
                "L=>"
            ],
            "F":[
                "P=>",
                "]>",
                "v"
            ],
            "G":[
                "r=>",
                "|<7",
                "6=J"
            ],
            "H":[
                "^ ^",
                "]=[",
                "v v"
            ],
            "I":[
                "T",
                "|",
                "_"
            ],
            "J":[
                "  ^",
                "^ |",
                "6=j"
            ],
            "K":[
                "^ ^",
                "]={",
                "v v"
            ],
            "L":[
                "^",
                "|",
                "L=>"
            ],
            "M":[
                "PY7",
                "|v|",
                "v v"
            ],
            "N":[
                "P?^",
                "|||",
                "v6J"
            ],
            "O":[
                "r=?",
                "| |",
                "6=j"
            ],
            "P":[
                "P=?",
                "]=j",
                "v"
            ],
            "Q":[
                "r=?",
                "| |",
                "6=o"
            ],
            "R":[
                "P=?",
                "]={",
                "v v"
            ],
            "S":[
                "r=>",
                "6=?",
                "<=j"
            ],
            "T":[
                "<T>",
                " |",
                " v"
            ],
            "U":[
                "^ ^",
                "| |",
                "6=j"
            ],
            "V":[
                "^ ^",
                "|rj",
                "Lj"
            ],
            "W":[
                "^ ^",
                "|^|",
                "6mj"
            ],
            "X":[
                "o o",
                " o",
                "o o"
            ],
            "Y":[
                "^ ^",
                "6Yj",
                " v"
            ],
            "Z":[
                "<=7",
                "r=j",
                "L=>"
            ]
        }
        __WIDTHADJ={
            "j":-1
        }
    }

	construct new(x,y) {
		_x=x
		_y=y
    }

	ch(c) {
		var xadj=__WIDTHADJ[c]
		if (xadj==null) {
			xadj=0
        }
		var width=0
		var y=_y
		for (row in __LETTERS[c]) {
			var x=_x+xadj*__WIDTH
			var rowwidth=0
			var hasletter=false
			for (i in 0...row.count) {
				var letter=row[i]
				if (letter!=" ") {
					hasletter=true
					TIC.spr(__SYM_MAP[letter]+128,x,y)
                }
				if (hasletter) {
					rowwidth=rowwidth+1
                }
				x=x+__WIDTH
            }
			y=y+__HEIGHT
			width=width.max(rowwidth)
        }
		_x=_x+(width+xadj)*__WIDTH
    }

	s(s) {
		var x=_x
		var readcolor=0
		for (i in 0...s.count) {
			var c=s[i]
			if (c=="\n") {
				_x=x
				_y=_y+__HEIGHT*4
            } else if (c=="^") {
				readcolor=1
				resetpalette()
            } else if (readcolor==1) {
				var color=tonumberfromhex(c)
				TIC.poke4(PALETTE_MAP * 2 + __COLOR1, color)
				readcolor=2
            } else if (readcolor==2) {
				var color=tonumberfromhex(c)
				TIC.poke4(PALETTE_MAP * 2 + __COLOR2, color)
				readcolor=0
            } else {
				ch(c)
            }
        }
		resetpalette()
    }

    tonumberfromhex(c) {
        if (c=="a") { 
            return 0xa 
        } else if (c=="b") {
            return 0xb 
        } else if (c=="c") { 
            return 0xc 
        } else if (c=="d") {
            return 0xd 
        } else if (c=="e") { 
            return 0xe 
        } else if (c=="f") {
            return 0xf 
        } else { 
            return Num.fromString(c)
        }
    }

	resetpalette() {
		TIC.poke4(PALETTE_MAP * 2 + __COLOR1, __COLOR1)
		TIC.poke4(PALETTE_MAP * 2 + __COLOR2, __COLOR2)
    }
}

ChunkyFont.init_()

class State {
	construct new() {
		_tt=0
		_nextstate=this
    }
    nextstate { _nextstate }
    nextstate=(value) {
        _nextstate=value
    }
    tt { _tt }
    tt=(value) {
        _tt=value
    }
	reset() {
		_tt=0
    }
	update() {
		_tt=_tt+1
    }

	finish() {
        return
    }

	next() {
        return this
    }

	draw() {
        return
    }
}

class SkipState is State {
	construct new(grace) {
		super()
		_grace=grace
    }

	finish() {
        TIC.sfx(-1)
		TIC.sfx(SFXNEXT)
    }

    canSkip {tt>_grace}

	next() {
		if (canSkip && (TIC.btnp(0) || TIC.btnp(1) || TIC.btnp(2) || TIC.btnp(3) || TIC.btnp(4) || TIC.btnp(5))) {
			finish()
			nextstate.reset()
			return nextstate
        }
		return this
    }
}

class SplashStateText {
    t { _t }
    tx { _tx }
    construct new(t, tx) {
        _t=t
        _tx=tx
    }                                                              
}

class SplashState is SkipState {

	construct new() {
		super(10)
		_len=250
		_texts=[
			SplashStateText.new(0,"^56u^deni"),
			SplashStateText.new(1,"^56u^deni^56c^deorns"),
			SplashStateText.new(2,"^56u^deni^56c^deorns\n^56o^def"),
			SplashStateText.new(3,"^56u^deni^56c^deorns\n^56o^def^56d^deeath"),
			SplashStateText.new(4,"^56u^deni^56c^deorns\n^56o^def^56d^deeath\n^56g^deames"),
        ]
    }

	reset() {
		super.reset()
		TIC.music(MUSSPLASH,-1,-1,false)
    }

	draw() {
		super.draw()
		TIC.cls(COLOR_BG)
		var tx=null
		for (text in _texts) {
			if (tt<text.t*MUSBEATTICKS) {
				break
            }
			tx=text.tx
        }
		if (tx!=null) {
			var cf=ChunkyFont.new(50,20)
			cf.s(tx)
        }
		if (tt>5.8*MUSBEATTICKS) {
			//drawface(160,70)
        }
    }

	drawface(x,y) {
		//  head
		TIC.elli(x,y,35,30,4)
		TIC.ellib(x,y,35,30,3)
		// eyes
		var edx=12
		TIC.circ(x-edx,y-5,9,12)
		TIC.circ(x+edx,y-5,9,12)
		TIC.circ(x-edx,y-5,7,0)
		TIC.circ(x+edx,y-5,7,0)
		// mouth
		var my=y+10
		var mdx=25
		var mdy=15
		var its=16
		var d=Num.pi/its
		for (i in 0..its-1) {
			// draw fan of tris in semi-circle
			TIC.tri(x,my,x+d*i.cos*mdx,my+(d*i).sin*mdy,x+(d*(i+1)).cos*mdx,my+(d*(i+1)).sin*mdy,2)
        }
    }

	next() {
		if (tt>=_len) {
			finish()
			nextstate.reset()
			return nextstate
        }
		return super()
    }
}

class TitleState is State {
	construct new() {
        _player=Player.new(10,40,0)
        _nextStateCounter=0
    }

    isSwitchingToNextState{_nextStateCounter>0}

	reset() {
		super.reset()
		TIC.music(MUSTITLE,-1,-1,false)
        _player=Player.new(10,40,0)
        _nextStateCounter=0
    }

	finish() {
		TIC.sfx(SFXNEXT)
        _nextStateCounter=40
        TIC.music() // stop
    }

    next() {
        if(_nextStateCounter==1){
			nextstate.reset()
			return nextstate
        }
		return super()
    }

    update(){
        super.update()
        if(!isSwitchingToNextState){
            _player.update()
            if(_player.y>95){
                finish()
            }
        }
        if(isSwitchingToNextState){
            _nextStateCounter=_nextStateCounter-1
        }
    }

    draw() {
        super.draw()
        TIC.cls(COLOR_BG)
        TIC.print(">>> START GAME",30,100,12+(tt/20)%2)
        _player.draw(0,0)
        var cf=ChunkyFont.new(50,20)
        cf.s("^43ROAD\n^56TEXTER")
    }
}

class MainState is State {
    construct new() {
        _x=0
        _y=0
        _speed=2
        _player=Player.new(10,60,_speed)
        _obstacles=[]
        _map=GameMap.new()
        _currentTime=0
        _correctOnZ=true
        _correctChoice=false
        _choiceMade=false
        var message1 = Message.new("Martinez", "Hello! Is your\nrefrigerator\nrunning?","Yes","Too poor to own a fridge")
        var message2 = Message.new("Ezekial", "Hey!\nWhats your name?","Tony","Fuck you Tony")
        _messages = [message1, message2]
        _progressbar = ProgressBar.new()
		_winstate=this
    }
    winstate { _winstate }
    winstate=(value) {
        _winstate=value
    }

    reset() {
        super.reset()
        _x=0
        _player=Player.new(10,60,_speed)
        _obstacles=[]
        _showText=false
        _currentTime=0
        _choiceMade=false
		TIC.music(MUSGAME,-1,-1,true)
    }

    update() {
        super.update()

        _x=_x+_speed
        _player.update()
        _player.isOnGrass =_map.tileAtPixelIs(_player.x+24,_player.y+8,GRASS_TILES)

        if(tt%60==0) {
            var coords=_map.findYforRandomTileWithIdsAtX(_x+WIDTH,ROAD_TILES)
            _obstacles.add(Oldie.new(coords[0],coords[1]))
            TIC.trace(coords[0])
        }

        if(tt%10==0) {
            var coords=_map.findYforRandomTileWithIdsAtX(_x+WIDTH,GRASS_TILES)
            if(RANDOM.int(0,2)==0) {
                _obstacles.add(PalmTree.new(coords[0],coords[1]-TILE_SIZE_2))
            } else {
                _obstacles.add(PineTree.new(coords[0],coords[1]-TILE_SIZE_2))
            }
        }

        _obstacles=_obstacles.where {|obstacle| obstacle.x>_x-100}.toList

        _obstacles.each {|obstacle|
            obstacle.update()
            if(obstacle.isAlive&&obstacle.intersects(_player)) {
                _player.onHit(obstacle.damage)
                obstacle.onHit()
            }
        }
        // Remove obstacles off camera
        _obstacles.each {|obstacle|
            if(obstacle.x<_x){
                _obstacles.remove(obstacle)
            }
        }

        if (_showText == true) {
            if(TIC.btnp(BTN_A)){
                if (_correctOnZ == true ){
                    _correctChoice=true
                } else {
                    _correctChoice=false
                }
                _choiceMade=true
                _showText=!_showText
                TIC.sfx(SFXNEXT)
            }
            if(TIC.btnp(BTN_B)){
                if (_correctOnZ == false ){
                    _correctChoice=true
                } else {
                    _correctChoice=false
                }
                _choiceMade=true
                _showText=!_showText
                TIC.sfx(SFXNEXT)
            }
            if (_choiceMade == true && _correctChoice == false) {
                wrongAnswer()
            }
        }

        _currentTime = _currentTime + 1
        if(_currentTime == EVENT_TICK) {
           _rand = RANDOM.int(_messages.count)
           _randOrder = RANDOM.int(2)
           if (_randOrder == 0 ) {
            _correctOnZ = true
           } else {
            _correctOnZ = false
           }
           // If message is already shown, stress
           if (_showText == true) {
            wrongAnswer()
           }
           _showText=true
           _choiceMade=false
           _currentTime = 0
        }

        // Skip to death screen with B button
        if(TIC.btnp(BTN_X)){
            _player.onHit(9999)
        }

        _progressbar.update()
    }

    next() {
        _map.update(_x)
        if (_x>=WIN_X) {
            finish()
            winstate.reset()
            return winstate
        }
        // TODO: stay on this state a bit and show the car exploding etc
		if (_player.health==0) {
			finish()
			nextstate.reset()
			return nextstate
        }
		return super()
    }

    draw() {
        _map.draw()
        _obstacles.each {|obstacle| obstacle.draw(_x,_y) }
        _player.draw(_x,_y)
        _progressbar.draw(_x)

        if (_showText){
            var y=TXT_Y
            TIC.rect(TXT_X,y,TXT_W,TXT_H,12)
            TIC.rect(TXT_X,y,TXT_W,20,13)
            TIC.print(_messages[_rand].sender,TXT_X+4,y+4,0)
            y=y+20
            TIC.rect(TXT_X+3,y+2,TXT_W-35,25,13)
            TIC.print(_messages[_rand].message,TXT_X+5,y+4,0)


            y=y+40
            TIC.rectb(TXT_X+3,y+2,10,10,13)
            TIC.print("Z",TXT_X+5,y+4,5)
            if (_correctOnZ == true) {
                TIC.print(_messages[_rand].correct,TXT_X+15,y+4,0)
            } else {
                TIC.print(_messages[_rand].wrong,TXT_X+15,y+4,0)
            }
            y=y+15
            TIC.rectb(TXT_X+3,y+2,10,10,13)
            TIC.print("X",TXT_X+5,y+4,2)
            if (_correctOnZ == true) {
                TIC.print(_messages[_rand].wrong,TXT_X+15,y+4,0)
            } else {
                TIC.print(_messages[_rand].correct,TXT_X+15,y+4,0)
            }
        }

        TIC.print("A to suicide",140,HEIGHT-8,0)
        TIC.print("_x: %(_x)", 2, HEIGHT-16, 0)
        if (_choiceMade == true) {
            if (_correctChoice == true) {
                TIC.print("Correct Choice",2, HEIGHT-32, 0)
            } else {
                TIC.print("Wrong Choice",2, HEIGHT-32, 0)
            }
        }
    }

    wrongAnswer() {
        _player.makeStressed()
    }
}

class DeathState is SkipState {
	construct new() {
		super(10)
    }

    reset() {
        super.reset()
        TIC.music(MUSDEATH,-1,-1,false)
    }

	finish() {
        return
    }

	draw() {
		super.draw()
		TIC.cls(COLOR_BG)
		TIC.print("Totalled!", 40, 50)
		TIC.print("Press any key to restart", 10, 10)
    }
}

class WinState is SkipState {
	construct new() {
		super(300)
    }

	reset() {
		super.reset()
        // TODO: win music
		TIC.music(MUSTITLE,-1,-1,false)
    }

	finish() {
        return
    }

	draw() {
		super.draw()
		TIC.cls(COLOR_BG)
		TIC.print("You win!", 40, 30, 5)
		TIC.print("Time: ???", 30, 60, 12)
		TIC.print("Good texts: ???", 30, 70, 12)
		TIC.print("Bad texts: ???", 30, 80, 12)
		TIC.print("Pedestrians killed: ???", 30, 90, 12)
        if (canSkip){
            TIC.print("Press any key to reset", 10, HEIGHT-10, 12)
        }
    }
}

class Message {
    sender { _sender }
    message { _message }
    correct { _correct}
    wrong { _wrong }

    construct new (sender, message, correct, wrong) {
        _sender = sender
        _message = message
        _correct = correct
        _wrong = wrong
    }
}

class Rect {
    x { _x }
    y { _y }
    width { _width }
    height { _height }
    left { _x }
    right { _x + width }
    top { _y }
    bottom { _y + height }

    construct new(x,y,width,height) {
        _x=x
        _y=y
        _width=width
        _height=height
    }

    intersects(other) {
        return !(right < other.left || left > other.right || top > other.bottom || bottom < other.top)
    }

    translate(x,y) {
        return Rect.new(_x+x,_y+y,_width,_height)
    }
}

class GameObject {
    x { _x }
    y { _y }
    hitbox { _hitbox }
    x=(value){ _x=value }
    y=(value){ _y=value }

    construct new(x,y) {
        _x=x
        _y=y
    }

    construct new(x,y,hitbox) {
        _x=x
        _y=y
        _hitbox=hitbox
    }

    update(){}

    draw() {}

    intersects(other) {
        return _hitbox.translate(x,y).intersects(other.hitbox.translate(other.x,other.y))
    }
}

class Player is GameObject {
    health { _health }
    stressed { _stressed }

    makeStressed(){ 
        _stressed=true
    }

    construct new(x,y,speed) {
        super(x,y,Rect.new(0,5,32,11))
        _speed=speed
        _ticks=0
        _frame=0
        _steeringSpeed=1
        _stressTick=0
        _health=10
        _stressed=false
        _isOnGrass=false
    }
    isOnGrass=(value){
        if(value&&!_isOnGrass){
            TIC.sfx(SFXGRASS)
        }else if(!value&&_isOnGrass){
            TIC.sfx(-1)
        }
        _isOnGrass=value
    }

    onHit(dmg){
        TIC.sfx(SFXHIT)
        _health=_health-dmg
        if(_health<0){
            _health=0
        }
    }

    update() {
        super()
        x=x+_speed
        if(_stressed == true) {
            _stressTick=_stressTick + 1
        } else {
            if(TIC.btn(BTN_UP)) {
                y=y-_steeringSpeed
            }
            if(TIC.btn(BTN_DOWN)) {
                y=y+_steeringSpeed
            }
        }
        if(_stressTick >= STRESS_TICK) {
           _stressTick = 0
           _stressed = false 
        }
        _ticks=_ticks+1
        if(_ticks==15){
            _ticks=0
            _frame=1-_frame
        }
    }

    draw(camX,camY) {
        TIC.spr(352+_frame*4,x-camX,y-camY-8,0,1,0,0,4,3)
    }
}

class Obstacle is GameObject {
    damage { _damage }

    construct new(x,y,damage,hitbox) {
        super(x,y,hitbox)
        _damage=damage
        _isAlive=true
    }

    isAlive{_isAlive}
    onHit(){
        _isAlive=false
    }

    draw() {
        TIC.spr(256,x,y,0,1,0,0,4,2)
    }
}

class Oldie is Obstacle {
    construct new(x,y) {
        super(x,y,1,Rect.new(4,3,7,10))
        _ticks=0
        _dy=0
        _dx=0
    }

    update(){
        super()
        _ticks=_ticks+1
        if(!isAlive){
            _dy=_dy+0.15
            if(_ticks==10){
                TIC.sfx(SFXSCREAM)
            }
        }
        y=y+_dy
        x=x+_dx
    }

    onHit(){
        super()
        _dy=-3
        _dx=1
        _ticks=0
    }

    draw(camX,camY) {
        if(isAlive){
            var frame=(_ticks/30).floor%2
            TIC.spr(260+frame,x-camX,y-camY,0,1,0,0,1,2)
        }else{
            var frame=(_ticks/5).floor%2
            var r=((_ticks/10).floor%4)*90
            TIC.spr(260+frame,x-camX,y-camY,0,1,0,r,1,2)
        }
    }
}

class PalmTree is Obstacle {
    construct new(x,y) {
        super(x,y,1,Rect.new(5,20,3,9))
    }

    draw(camX,camY) {
        TIC.spr(288,x-camX,y-camY,0,1,0,0,2,4)
    }
}

class PineTree is Obstacle {
    construct new(x,y) {
        super(x,y,1,Rect.new(7,23,3,7))
    }

    draw(camX,camY) {
        TIC.spr(290,x-camX,y-camY,0,1,0,0,2,4)
    }
}

class GameMap {
    construct new() {
        _x=0
        _difficulty=0
        replace(1)
    }

    mapIdxToCoords(idx){
        return [(idx%8)*MAP_W,(idx/8).floor*MAP_H]
    }

    replace(idx){
        var idxCoords=mapIdxToCoords(idx)
        // Replace map at idx with tiles from a random template
        var template=0
        if (_difficulty==0){
            template=RANDOM.int(8,24)
        } else if (_difficulty==1) {
            template=RANDOM.int(24,40)
        } else {
            template=RANDOM.int(40,56)
        }
        var templateCoords=mapIdxToCoords(template)
        for(y in 0...MAP_H){
            for(x in 0...MAP_W){
                TIC.mset(idxCoords[0]+x,idxCoords[1]+y,TIC.mget(templateCoords[0]+x,templateCoords[1]+y))
            }
        }
    }

    update(x) {
        var oldX=_x
        _x = x%(WIDTH*2)
        // Switch map by template if we've crossed a boundary
        if(_x<oldX){
            // 1->0
            replace(1)
        }else if(_x>=WIDTH&&oldX<WIDTH){
            // 0->1
            replace(0)
        }
        // Ramp up difficulty as we get closer to the end
        if (x>WIN_X/3){
            _difficulty=1
        }
        if(x>WIN_X*2/3){
            _difficulty=2
        }
    }

    draw() {
        TIC.map(0, 0, MAP_W*2, MAP_H, -_x, 0)
        if(_x>=WIDTH){
            TIC.map(0, 0, MAP_W, MAP_H, -_x+WIDTH*2, 0)
        }
    }

    tile2At(x,y) {
        return TIC.mget((x*2)%(MAP_W*2),y*2+1)
    }

    tileAtPixelIs(x,y,options) {
        var tileX=(x/TILE_SIZE).floor
        var tileY=(y/TILE_SIZE).floor
        return options.contains(TIC.mget(tileX%(MAP_W*2),tileY))
    }

    findYforRandomTileWithIdsAtX(x,tileIDs) {
        var tileX=(x/TILE_SIZE_2).floor+1
        var tileOptions = (0...(HEIGHT/TILE_SIZE_2).floor).where {|i| tileIDs.contains(tile2At(tileX,i))}.toList
        var randomTileY = tileOptions[RANDOM.int(0,tileOptions.count)]
        return [tileX*TILE_SIZE_2,randomTileY*TILE_SIZE_2+TILE_SIZE]
    }
}

class ProgressBar {
	construct new() {
    }
    update() {
    }

    draw(x) {
        var progress=x*WIDTH/WIN_X
        TIC.rect(0,0,progress,7,11)
        TIC.rect(progress,0,WIDTH-progress,7,14)
        TIC.spr(511,progress-4,(x/30).floor%2-1,0)
        TIC.print("%((progress*100/WIDTH).floor)\%",progress-16,1,0,true,1,true)
    }
}

class Game is TIC{

	construct new(){
        var splashState = SplashState.new()
        var titleState = TitleState.new()
        var mainState = MainState.new()
        var deathState = DeathState.new()
        var winState = WinState.new()
        splashState.nextstate = titleState
        titleState.nextstate = mainState
        mainState.nextstate = deathState
        mainState.winstate = winState
        deathState.nextstate = titleState
        winState.nextstate = splashState
        _state=splashState
        _state.reset()
	}
	
	TIC(){
        TIC.cls(1)

        _state.update()
        _state.draw()
        _state=_state.next()
	}
}

// <TILES>
// 000:eeeeeeeeeeeeeeeeffffffffffffffffffffffffffffffffffffffffffffffff
// 001:eeeeeeeeeeeeeeeeffffffffffffffffffffffffffffffffffffffffffffffff
// 002:fffffcccffffffffffffffffffffffffffffffffffffffffffffffffffffffff
// 003:cccfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
// 016:fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffccc
// 017:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffcccfffff
// 018:fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffccc
// 019:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffcccfffff
// 032:fffffcccffffffffffffffffffffffffffffffffffffffffffffffffffffffff
// 033:cccfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
// 048:ffffffffffffffffffffffffffffffffffffffffffffffffeeeeeeeedddddddd
// 049:ffffffffffffffffffffffffffffffffffffffffffffffffeeeeeeeedddddddd
// 064:7777775775777767767776677767776777777777777577757676777677777777
// 065:7777577777776667677777776777777675775776767767777777777775777777
// 066:eeeeeeeedddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 067:eeeeeeeeedddddddedddddddedddddddedddddddedddddddedddddddeddddddd
// 068:ddeeffffeeddeeffddeeddeeddddeeddddddddeedddddddddddddddddddddddd
// 069:ffffffffffffffffffffffffeeffffffddeeffffeeddeeffedeeddeeedddeedd
// 080:7777577777766776777777767777777775777577767676777667767777777777
// 081:7677577777776767767776776777777777757777776677777776777677777767
// 082:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 083:edddddddedddddddedddddddedddddddedddddddedddddddedddddddeddddddd
// 084:ffffffffffffffffffffffffffffffeefffeeeddffeeddeeeeddeeddddeedddd
// 085:ffffeeddffeeddeeeeddeeddddeeddddeeddddddedddddddedddddddeddddddd
// 098:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 099:edddddddedddddddedddddddedddddddedddddddedddddddedddddddeddddddd
// 100:ddeeddddeeddeeddffeeddeeffffeeddffffffeeffffffffffffffffffffffff
// 101:edddddddedddddddedddddddeeddddddddeeddddeeddeeddffeeddeeffffeedd
// 114:ddddddddddddddddddddddddddddddddddddddddddddddddeeeeeeeedddddddd
// 115:edddddddedddddddedddddddedddddddedddddddedddddddeeeeeeeedddddddd
// 116:ddddddddddddddddddddddddddddddeedddeeeddddeeddeeeeddeeffddeeffff
// 117:edddeeddedeeddeeeeddeeffddeeffffeeffffffffffffffffffffffffffffff
// 128:9acaaaa99aaaaaaa09aaaaac009aaaaa009aaaaa09aaaaaa9accaaaa9acaaaa9
// 129:9acaaaa9aaaaaaa9caaaaa90aaaaa900aaaaa900aaaaaa90aaaaaca99aaaaaa9
// 130:0099990009aaaa909accaaa99acaaaa99aaaaaa99aaaaaa99aaaaaa99acaaaa9
// 131:0099999909aaaaaa9accaaac9acaaaaa9aaaaaaa9aaaaaaa09aaaaaa00999999
// 132:99999999aaaaaaaaccccccccaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa99999999
// 133:99999900aaaaaa90caaaaaa9aaaaaaa9aaaaaaa9aaaaaaa9aaaaaa9099999900
// 134:9acaaaa99acaaaaa9acaaaac9acaaaaa9acaaaaa9acaaaaa9acaaaaa9acaaaa9
// 135:9acaaaa9aacaaaa9ccaaaaa9aaaaaaa9aaaaaaa9aaaaaaa9aaaaaaa99acaaaa9
// 144:0000099900099aaa009aaaac09accaaa09acaaaa9aaaaaaa9aaaaaaa9acaaaa9
// 145:99900000aaa99000caaaa900aaaaaa90aaaaaa90aaaaaaa9aaaaaaa99aaaaaa9
// 146:9acaaaa99acaaaa99acaaaa99acaaaa99acaaaa99acaaaa99acaaaa99acaaaa9
// 147:99000099aa9009aacaa99accaaaaaacaaaaaaaaaaaaaaaaaaaaaaaaa9acaaaa9
// 148:0099990009aaaa909accaaa99acaaaa99aaaaaa99aaaaaa909aaaa9000999900
// 149:99999999aaaaaaaaccccccccaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa9acaaaa9
// 150:999999999aaaaaaa9accaaac9acaaaaa9aaaaaaa9aaaaaaa9aaaaaaa9acaaaa9
// 151:99999999aaaaaaa9ccccaaa9aaaaaaa9aaaaaaa9aaaaaaa9aaaaaaa99acaaaa9
// 160:9acaaaa99aaaaaaa9aaaaaac09aaaaaa09aaaaaa009aaaaa00099aaa00000999
// 161:9acaaaa9aaaaaaa9caaaaaa9aaaaaa90aaaaaa90aaaaa900aaa9900099900000
// 162:9acaaaa99aaaaaa99aaaaaa99aaaaaa99aaaaaa99aaaaaa909aaaa9000999900
// 163:9acaaaa9aacaaaaaccaaaaacaaaaaaaaaaaaaaaaaaa99aaaaa9009aa99000099
// 165:9acaaaa9aacaaaaaccaaaaacaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa99999999
// 166:9acaaaa99acaaaaa9acaaaac9acaaaaa9aaaaaaa9aaaaaaa9aaaaaaa99999999
// 167:9acaaaa9aaaaaaa9cacaaaa9aaaaaaa9aaaaaaa9aaaaaaa9aaaaaaa999999999
// </TILES>

// <SPRITES>
// 000:00000000000000000000000000000999000029990000999f0000cccf0000cccf
// 001:0000000000000000000000009999999999999999ff999999ffccccccffcccccc
// 002:00000000000000009000000099999999999999999ff99999cfffcccccffffccc
// 003:000000000000000000000000999000009994000099944000ccccc000ccccc000
// 004:0fddddf0fddeeedffde3333dde3cf3cfde3cf3cfde333333de33ff31fe233310
// 005:000000000fddddf0fddeeedffde3333dde3cf3cfde3cf3cfde333333de33ff31
// 006:0000000000000000000000000000000000000000020202c20cc22c2202cccccc
// 007:000000000000000000000000000000000000000022000000c200000020000000
// 016:0000999f0000cccf0000cccf0000999f00002999000009990000000000000000
// 017:ff999999ffccccccffccccccff99999999999999999999990000000000000000
// 018:9ffff999cffffccccfffcccc9ff9999999999999999999999000000000000000
// 019:99999000ccccc000ccccc0009994400099940000999000000000000000000000
// 020:012223321222244412222114122212241221222411f12224feeffeee0fef0fef
// 021:ee2333101222233212222444122211141221222411f1222400fef22400feeff0
// 022:02cccccc0c22c2220002c2000000000000000000000000000000000000000000
// 023:22000000c20000002c00000000c0000000000000000000000000000000000000
// 032:0000000000000000000000000000000000000005000000560000000600000006
// 033:0000000000000000000000000000000050000000670000006700000067000560
// 035:0000000000000000000000000000000000000000000000000700000077000000
// 048:5555600666666667077666660007777700000666000056660056666605666667
// 049:6770566667756670777667007757700075666000676666007176670011066770
// 050:0000000700000076000000660000006600007766000067660000f66700000607
// 051:660000006770000077770000607f0000777700007677f0006667f00066677000
// 064:5666677266677032677000320700003300000322000003210000032100000321
// 065:2107677011007770110077002000070010000000100000001000000010000000
// 066:0000777600077677000766770007666707676666077667770fff66ffff066606
// 067:6677f7001667777066677f70667ffff0666ff0f0777f77f067777f7f677777ff
// 080:0000033200003221000032110000321100003211000001110000000000000000
// 081:1000000010000000100000001000000010000000000000000000000000000000
// 082:0ff7767700ff77770000ffff0000000100000001000000110000000100000000
// 083:7ff7fff0777ffff0fffff0001100000011000000111000001100000000000000
// 096:000fffff00f1222200f121110f9122220f912222f9912222f9a12222f9a12222
// 097:ffffffff22222222111111112222222222222222222222222222222222222222
// 098:fffff00022222f0011122f0022222ff022222f9f22222f9f22222f9a22222faa
// 099:000000000000000000000000000000000000000000000000f00000001ffff000
// 100:00000000000fffff00f1222200f121110f9122220f912222f9912222f9a12222
// 101:00000000ffffffff222222221111111122222222222222222222222222222222
// 102:00000000fffff00022222f0011122f0022222ff022222f9f22222f9f22222f9a
// 103:00000000000000000000000000000000000000000000000000000000f0000000
// 112:faa12111faa12222fba11111fb911222fa912ffff912f999f912f9aaf12f9ba9
// 113:11111111222222221111111122221222ff212fff9f212f99f212f99af212f9ba
// 114:11122fab22222fabffffffab2222219affff221a9999f221aa99f121a99f1221
// 115:12222ff01222211f122222141222221c1222221c1222221c1222221f1222221f
// 116:f9a12222faa12111faa12222fba11111fb911222fa912ffff912f999f912f9aa
// 117:2222222211111111222222221111111122221222ff212fff9f212f99f212f99a
// 118:22222faa11122fab22222fabffffffab2222219affff221a9999f221aa99f121
// 119:1ffff00012222ff01222211f122222141222221c1222221c1222221c1222221f
// 128:f12cccccf2222222f2fff222f1111ffff122ffddf111fdcf0fffffed000000ff
// 129:c212cccc221222222212fff2fff11111ddff2222fedf1111ddffffffff000000
// 130:cccc1212222211222222222211111fff2222ffdd1111fdcfffffffed000000ff
// 131:2111111f2222221f2222221cfff1111cddff2214fedf1114ddfffff0ff000000
// 132:f12f9ba9f12cccccf2222222f2fff222f111fffff122fdcff111ffed0fffffff
// 133:f212f9bac212cccc221222222212fff2ffff1111fedf2222ddff1111ffffffff
// 134:a99f1221cccc121222221122222212221111ffff2222fdcf1111ffedffffffff
// 135:1222221f2111111f2222221f2222221cffff111cfedf2214ddff1114fffffff0
// 255:0000000000000000122221002aa2aa00222222241cd22cd10de11de000000000
// </SPRITES>

// <MAP>
// 000:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404041404140414040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 001:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404041404140414041404051505150515040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 002:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404051505150515051505150504140414040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 003:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040010001000100010001000101404140405150414040404040404040404040404040404040404040404040404040404040404040404040404040400100010001000100010001000100404040404040404
// 004:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040111011101110111011101111505150515050515040404040404040404040404040404040404040404040404040404040404040404040404040401110111011101110111011101110404040404040404
// 005:263626362636263626362636263626362636263626362636263626362636040404040404040404040404040404040404040404040404040404040404263626362636263626362636263626362636263626362636263626362636040404040404040404040404040404040404040404040404040404040404001000100010001000100010001000100010001000100010001000100010040404040010001000102030203002120212203020300010001014041404140404040404040404040404040404040404040404040404040404040404001000100010001020302030203020302030203020300010001000100010
// 006:273727372737273727372737273727372737273727372737273727372737040404040404040404040404040404040404040404040404040404040404273727372737273727372737273727372737273727372737273727372737040404040404040404040404040404040404040404040404040404040404011101110111011101110111011101110111011101110111011101110111040404040111011101112131213103130313213121310111011115051505150404040404040404040404040404040404040404040404040404040404011101110111011121312131213103132131213121310111011101110111
// 007:001000100010001000100010001000100010001000100010001000100010040404040404040404040404040404040404040404040404040404001000001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010203020302030203020302030203020302030203020302030203020302030001000102030203002120212021204140414021202122030203000100010001000100010001004040404040404040404040404040010001000100010203020302030203020302030455524344454203020302030203020302030
// 008:011101110111011101110111011101110111011101110111011101110111040404040404040404040404040404040404040404040404040404011101011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111213121312131213121312131213121312131213121312131213121312131011101112131213103130313031305150515031303132131213101110111011101110111011104040404040404040404040404040111011101110111213121312131213121314555140414041404445421312131213121312131
// 009:021202120212021202120212021202120212021202120212021202120212040404040404040404040404040404040404040404040404040404021202021202120212021202120212021202120212021202120212021202120212203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030021202120212021214041404140404140414041404140212021202120212021202122030203000100010040404040404001000102030203002120212203020302030203020304656150515051505475720302030203020302030
// 010:031303130313031303130313031303130313031303130313031303130313040404040404040404040404040404040404040404040404040404031303031303130313031303130313031303130313031303130313031303130313213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131031303130313031315051505150505150504141505150313031303130313031303132131213101110111040404040404011101112131213103130313213121312131213121312131465627374757213121312131213121312131
// 011:243424342434243424342434243424342434243424342434243424342434040404040404040404040404040404040404040404040404040404040404243424342434243424342434243424342434243424342434243424342434021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212040404040404040404040404040414041405151414041404140414041404140404040212021220302030001000100010203020300212021204040404021202120212021220302030203000102030203020300212021202120212
// 012:253525352535253525352535253525352535253525352535253525352535040404040404040404040404040404040004040404040404040404040404253525352535253525352535253525352535253525352535253525352535031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313040404040404040404040404040515051504141515051505150515051505150404040313031321312131011101110111213121310313031304040404031303130313213121312131213121312131213121312131031303130313
// 013:041404140414041404140414041404140414041404140414041404140414040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040405150404040404040404040404040404040404040402120212021202120212021202120404040404040404040404040404445402120212021202120212021202124555040404040404
// 014:051505150515051505150515051505150515051505150515051505150515040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040403130313031303130313031303130404040404040404040404040404253544540313031303130313031345550404040404040404
// 015:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040425352434243424342434243404040404040404040404
// 016:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 017:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 018:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 019:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 020:040404040404040404040404040404040404040404040404040404040404263626362636263626360404040404040404040426362636263626362636263626362636040404040404040404040404040404040404263626362636040404040404040404040404040404040404040404040404040404040404263626362636263626360404040404040404040426362636263626362636040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404263626362636040404040404040426362636263626362636263626362636
// 021:040404040404040404040404040404040404040404040404040404040404273727372737273727370404040404040404040427372737273727372737273727372737040404040404040404040404040404040404273727372737040404040404040404040404040404040404040404040404040404040404273727372737273727370404040404040404040427372737273727372737040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404273727372737040404040404040427372737273727372737273727372737
// 022:001000100010001000100010001000100010001000100010001000100010001000100010001000102636263626362636263600100010001000100010001000100010263626362636041404140414263626362636001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000102636263626362636263600100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010263626362636263600100010001000100010001000100010
// 023:011101110111011101110111011101110111011101110111011101110111011101110111011101112737273727372737273701110111011101110111011101110111273727372737051505150515273727372737011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101112737273727372737273701110111011101110111011101110111011101110313031303130313031301110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111273727372737273701110111011101110111011101110111
// 024:203020302030203020302030203020302030203020302030203020302030203020302030203020300010001000100010001020302030203020302030203020302030001000100010263626362636001000100010203020302030203020302030203020302030021202120212203020302030203020302030203020302030203020300010001000100010001020302030203020302030203020302030203020302434243424342434243420302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030001000100010001020302030203020302030203020302030
// 025:213121312131213121312131213121312131213121312131213121312131213121312131213121310111011101110111011121312131213121312131213121312131011101110111273727372737011101110111213121312131213121312131213121312131031303130313213121312131213121312131213121312131213121310111011101110111011121312131213121312131213121312131213121312737273727372737273721312131213121312131213121312131213121310313031303130313031321312131213121312131213121312131011101110111011121312131213121312131213121312131
// 026:203020302030203020300212021202120212021220302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030001000100010203020302030203020302030203020302030021202120212243424342434021202120212203020302030203020302030203020300212021202120212021220302030203020302030203020302030203020300010001000100010001020302030203020302030203020302030203020302434243424342434243420302030203020302030203020302030203020302030203020302030021202120212021220302030
// 027:213121312131213121310313031303130313031321312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131011101110111213121312131213121312131213121312131031303130313253525352535031303130313213121312131213121312131213121310313031303130313031321312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312737273727372737273721312131213121312131213121312131213121312131213121312131031303130313031321312131
// 028:021202120212021202122434243424342434243402120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212243424342434041404140414243424342434021202120212021202120212021202122434243424342434243402120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120010001000100010001002120212021202120212021202120212021202120212021202120212243424342434243402120212
// 029:031303130313031303132535253525352535253503130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313253525352535051505150515253525352535031303130313031303130313031303132535253525352535253503130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313253525352535253503130313
// 030:243424342434243424340404040404040404040424342434243424342434040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404243424342434040404040404040404040404040404040404243424342434243424342434243424340404040404040404040424342434243424342434040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404243424342434243424342434243424342434040404040404040424342434
// 031:253525352535253525350404040404040404040425352535253525352535040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404253525352535040404040404040404040404040404040404253525352535253525352535253525350404040404040404040425352535253525352535040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404253525352535253525352535253525352535040404040404040425352535
// 032:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 033:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 034:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 035:040404040404040404040404040404040404040404040404040404040404040404040404040426362636263626362636263626360404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040426362636263626362636263626360404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 036:040404040404040404040404040404040404040404040404040404040404040404040404040427372737273727372737273727370404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040427372737273727372737273727370404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 037:263626362636263626362636263626362636040404040404040426362636263626362636263600100010001000100010001000102636263626362636040404040404040404040404040404040404040404040404040404040404263626362636263600100010001000100010001000102636263626362636263626360404040404040404040404040404040404040404040426362636040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 038:273727372737273727372737273727372737040404040404040427372737273727372737273701110111011101110111011101112737273727372737040404040404040404040404040404040404040404040404040404040404273727372737273701110111011101110111011101112737273727372737273727370404040404040404040404040404040404040404040427372737040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 039:001000100010001000100010001000100010263626362636263600100010001000100010001020302030203020302030203020300010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001002120212021202120212021202120010001000100010001000102636263626362636041404140414263626362636263600100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010
// 040:011101110111011101110111011101110111273727372737273701110111011101110111011121312131213121312131213121310111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101112737273727372737051505150515273727372737273701110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111
// 041:203020302030203020302030203020302030001000100010001020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030021202120212203020302030203020302030203020300010001000100010263626362636001000100010001020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030
// 042:213121312131213121312131213121312131011101110111011121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131031303130313213121312131213121312131213121310111011101110111273727372737011101110111011121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131
// 043:203020302030021202120212021220302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020300212021202120212243424342434021202120212203020302030203020302030203020302030001000100010203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030
// 044:213121312131031303130313031321312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121310313031303130313253525352535031303130313213121312131213121312131213121312131011101110111213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131
// 045:021202120212243424342434243402120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202122434243424342434041404140414243424342434021202120212021202120212021220302030203020302030203020300212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212
// 046:031303130313253525352535253503130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313011101110111011101110111011101110313031303130313031303132535253525352535051505150515253525352535031303130313031303130313031321312131213121312131213121310313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313
// 047:243424342434040404040404040424342434243424342434243424342434040404040404040404040404040404040404040404040404040404042434243424342434021202120212021202120212021202122434243424340404243424340404040404040404040404040404040404040404243424342434243424342434243402120212021202120212021202122434243424342434040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 048:253525352535040404040404040425352535253525352535253525352535040404040404040404040404040404040404040404040404040404042535253525352535031303130313031303130313031303132535253525350404253525350404040404040404040404040404040404040404253525352535253525352535253503130313031303130313031303132535253525352535040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 049:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404243424342434243424342434243424340404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040424342434243424342434243424340404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 050:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404253525352535253525352535253525350404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040425352535253525352535253525350404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 051:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 052:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 053:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 054:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040426362636263626362636263626360404040404040404
// 055:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040427372737273727372737273727370404040404040404
// 056:040404040404040404040404040404040404040404040404040404040404263626362636263626360404040404040404040426362636263626362636263626362636263626360414041404140414041426362636263626362636263626362636040404040404040404040404040404040404263626362636040404040404040404040404040404040404040404040404040404040404263626362636040404040404263626362636263626362636263626362636263626362636263626362636263626362636040404040404263626362636263626362636263600100010001000100010001000102636263626362636
// 057:040404040404040404040404040404040404040404040404040404040404273727372737273727370404040404040404040427372737273727372737273727372737273727370515051505150515051527372737273727372737273727372737040404040404040404040404040404040404273727372737040404040404040404040404040404040404040404040404040404040404273727372737040404040404273727372737273727372737273727372737273727372737273727372737273727372737040404040404273727372737273727372737273701110111011101110111011101112737273727372737
// 058:001000100010001000100010001000100010001000100010001000100010001000100010001000102636263626362636263600100010001000100010001000100010001000102636263626362636263600100010001000100010001000100010263626362636041404140414263626362636001000100010001000100010001000100010001000100010001000100010001000100010001000100010263626362636001000100010001000100010001000100010001000100010001000100010001000100010263626362636001000100010001000100010001002120212021202120212021202120010001000100010
// 059:011101110111011101110111011101110111011101110111011101110111011101110111011101112737273727372737273701110111011101110111011101110111011101112737273727372737273701110111011101110111011101110111273727372737051505150515273727372737011101110111011101110111011101110111031303130313011101110111011101110111011101110111273727372737011101110111011101110111011101110111011101110111011101110111011101110111273727372737011101110111011101110111011101110111011101110111011101110111011101110111
// 060:203020302030203020300212021202120212021220302030203020302030203020302030203020300010001000100010001020302030203020302030203020302030203020300010001000100010001020302030203020302030203020302030001000100010263626362636001000100010203020302030203020302030021202120212243424342434021202120212203020302030203020302030001000100010203020302030021202120212203020302030203020302030021202120212203020302030001000100010203020302030203020302030203020302030203020302030203020302030203020302030
// 061:213121312131213121310313031303130313031321312131213121312131213121312131213121310111011101110111011121312131213121312131213121312131213121310313031303130313031321312131213121312131213121312131011101110111273727372737011101110111213121312131213121312131031303130313253525352535031303130313213121312131213121312131011101110111213121312131031303130313213121312131213121312131031303130313213121312131011101110111213121312131213121312131213121312131213121312131213121312131213121312131
// 062:021202120212021202122434243424342434243402120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202122434243424342434243402120212021202120212021202120212021202120212001000100010021202120212021202120212021202120212243424342434041404140414243424342434021202120212021202120212021202120212021202120212243424342434021202120212021202120212243424342434021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212
// 063:031303130313031303132535253525352535253503130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303132535253525352535253503130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313253525352535051505150515253525352535031303130313031303130313031303130313031303130313253525352535031303130313031303130313253525352535031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313
// 064:243424342434243424340404040404040404040424342434243424342434040404040404040404040404040404040404040404040404040404040404243424342434243424340404040404040404040424342434243424342434040404040404040404040404040404040404040404040404040404040404243424342434040404040404040404040404040404040404243424342434243424342434243424342434243424342434040404040404243424342434243424342434040404040404243424342434243424342434243424342434040404040404040404040404040404040404040404040404040404040404
// 065:253525352535253525350404040404040404040425352535253525352535040404040404040404040404040404040404040404040404040404040404253525352535253525350404040404040404040425352535253525352535040404040404040404040404040404040404040404040404040404040404253525352535040404040404040404040404040404040404253525352535253525352535253525352535253525352535040404040404253525352535253525352535040404040404253525352535253525352535253525352535040404040404040404040404040404040404040404040404040404040404
// 066:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 067:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 068:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 069:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 070:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 071:040404040404040404040404040404040404040404040404040404040404040404040404040426362636263626362636263626360404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 072:040404040404040404040404040404040404040404040404040404040404040404040404040427372737273727372737273727370404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 073:040404040404040404040404040404040404040404040404040404040404263626362636263600100010001000100010001000102636263626362636263626360404040404040404040404040404040404040404040426362636040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 074:040404040404040404040404040404040404040404040404040404040404273727372737273701110111011101110111011101112737273727372737273727370404040404040404040404040404040404040404040427372737040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 075:001000100010001000100010001000100010001000100010001000100010001000100010001002120212021202120212021202120010001000100010001000102636263626362636041404140414263626362636263600100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010
// 076:011101110111011101110111011101110111011101110111011101110111011101110111011101110111031303130313011101110111011101110111011101112737273727372737051505150515273727372737273701110111011101110111011101110313031303130313031301110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111
// 077:203020302030203020302030203020302030203020302030203020302030203020300212021202120212243424342434021202120212021220302030203020300010001000100010263626362636001000100010001020302030203020302030203020302434243424342434243420302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030
// 078:213121312131213121312131213121312131213121312131213121312131213121310313031303130313253525352535031303130313031321312131213121310111011101110111273727372737011101110111011121312131213121312131213121312737273727372737273721312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131
// 079:021202120212021202120212021202120212021202120212021202120212021202122434243424342434041404140414243424342434243402120212021202120212021202120212001000100010021202120212021202120212021202120212021202120010001000100010001002120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212
// 080:031303130313031301110111011101110111011101110313031303130313031303132535253525352535051505150515253525352535253503130313031303130313031301110111011101110111011101110313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313
// 081:243424342434243402120212021202120212021202122434243424342434243424340404040404040404040404040404040404040404040424342434243424342434243402120212021202120212021202122434243424342434040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 082:253525352535253503130313031303130313031303132535253525352535253525350404040404040404040404040404040404040404040425352535253525352535253503130313031303130313031303132535253525352535040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 083:040404040404040424342434243424342434243424340404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040424342434243424342434243424340404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 084:040404040404040425352535253525352535253525350404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040425352535253525352535253525350404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 085:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 086:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404042636263626362636263604040404040404040404040404040404040404040404040404040404040404040404040404040404
// 087:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404042737273727372737273704040404040404040404040404040404040404040404040404040404040404040404040404040404
// 088:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404042636263626362636263604040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404263626360010001000100010001026362636040404040404040404040404040404040404040404040404040404040404040404040404
// 089:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404042737273727372737273704040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404273727370111011101110111011127372737040404040404040404040404040404040404040404040404040404040404040404040404
// 090:263626362636263626362636263626362636263626362636263626362636263626362636263604040404040404040404040404042636263626362636263626362636040404040404263626362636263626362636263626362636263626362636040404040404263626362636263626362636263626362636263626362636263626360010001000100010001026362636263626362636263626362636263626362636263626362636263626362636263626362636263626362636001000100212021202120212021200100010263626362636263626362636263626362636263626362636263626362636263626362636
// 091:273727372737273727372737273727372737273727372737273727372737273727372737273704040404040404040404040404042737273727372737273727372737040404040404273727372737273727372737273727372737273727372737040404040404273727372737273727372737273727372737273727372737273727370111011101110111011127372737273727372737273727372737273727372737273727372737273727372737273727372737273727372737011101110111011101110111011101110111273727372737273727372737273727372737273727372737273727372737273727372737
// 092:001000100010001010100010001000100010001000100010001000100010001000100010001026362636263626362636263626360010001000100010001000100010263626362636001000100010001000100010001000100010001000100010263626362636001000100010001000100010001000100010001000100010001000100212021202120212021200100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010021202120212021202120212021202120212001000100010001000100010001000100010001000100010001000100010001000100010
// 093:011101110111011113130313031303130313031303130111011101110111011101110111011127372737273727372737273727370111011101110111011101110111273727372737011101110111031303130313011101110111011101110111273727372737011101110111031303130313011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111
// 094:021202120212021224342434243424342434243424340212021202120212021202120212021200100010001000100010001000100212021202120212021202120212001000100010021202120212243424342434021202120212021202120212001000100010021202120212243424342434021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212
// 095:031303130313031325352535253525352535253525350313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313253525352535031303130313031303130313031303130313031303130313253525352535031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130111011101110111011103130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313011101110111011101110111011101110111031303130313
// 096:243424342434243404040404040404040404040404042434243424342434243424342434243424342434243424342434243424342434243424342434243424342434243424342434243424342434040404040404243424342434243424342434243424342434243424342434040404040404243424342434243424342434243424342434243424342434243424342434243424342434243424342434243424340212021202120212021224342434243424342434243424342434243424342434243424342434243424342434243424342434243424342434021202120212021202120212021202120212243424342434
// 097:253525352535253504040404040404040404040404042535253525352535253525352535253525352535253525352535253525352535253525352535253525352535253525352535253525352535040404040404253525352535253525352535253525352535253525352535040404040404253525352535253525352535253525352535253525352535253525352535253525352535253525352535253525350313031303130313031325352535253525352535253525352535253525352535253525352535253525352535253525352535253525352535031303130111011101110111011103130313253525352535
// 098:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404042434243424342434243404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404243424340212021202120212021224342434040404040404
// 099:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404042535253525352535253504040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404253525350313031303130313031325352535040404040404
// 100:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404042434243424342434243404040404040404040404
// 101:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404042535253525352535253504040404040404040404
// 102:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 103:040404040404040404042636263626362636263604040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404042636263626362636263604040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 104:040404040404040404042737273727372737273704040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404042737273727372737273704040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 105:040404040404263626360010001000100010001026362636040404040404040404040404040404040404040404040404040404040404040404040404040404042636263626360010001000100010001026362636263604040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 106:040404040404273727370111011101110111011127372737040404040404040404040404040404040404040404040404040404040404040404040404040404042737273727370111011101110111011127372737273704040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 107:263626362636001000100212021202120212021200100010263626362636263626362636263626360404040404040404040426362636263626362636263626360010001000100212021202120212021200100010001026362636263626362636263604040404040404040404040404042636263626362636263626362636263626362636263626362636263626362636263626362636263626362636263626362636263626362636263626362636263626362636263626362636263626362636263626362636263626362636263626362636263626362636263626362636263626362636263626362636263626362636
// 108:273727372737011101110111011101110111011101110111273727372737273727372737273727370404040404040404040427372737273727372737273727370111011101110111011101110111011101110111011127372737273727372737273704040404040404040404040404042737273727372737273727372737273727372737273727372737273727372737273727372737273727372737273727372737273727372737273727372737273727372737273727372737273727372737273727372737273727372737273727372737273727372737273727372737273727372737273727372737273727372737
// 109:001000100010021202120212021202120212021202120212001000100010001000100010001000102636263626362636263600100010001000100010001000100212021202122434243424342434243402120212021200100010001000100010001026362636040404040404263626360010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010
// 110:011101110111011101110313031303130313031301110111011101110111011101110111011101112737273727372737273701110111011101110111011101110111031303132535253525352535253503130313011101110111011101110111011127372737040404040404273727370111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111
// 111:021202120212021202122434243424342434243402120212021202120212021202120212021202120010001000100010001002120212021202120212021202120212243424340404040404040404040424342434021202120212021202120212021200100010263626362636001000100212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212
// 112:031303130313031303132535253525352535253503130313031303130313031303130313011101110111011101110111011101110111031303130313031303130313253525350404040404040404040425352535031303130313031303130111011101110111273727372737011101110111011103130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313
// 113:243424342434243424340404040404040404040424342434243424342434243424342434021202120212021202120212021202120212243424342434243424342434040404040404040404040404040404040404243424342434243424340212021202120212001000100010021202120212021224342434243424342434243424342434243424342434243424342434243424342434243424342434243424342434243424342434243424342434243424342434243424342434243424342434243424342434243424342434243424342434243424342434243424342434243424342434243424342434243424342434
// 114:253525352535253525350404040404040404040425352535253525352535253525352535031303130111011101110111011103130313253525352535253525352535040404040404040404040404040404040404253525352535253525350313031303130111011101110111011103130313031325352535253525352535253525352535253525352535253525352535253525352535253525352535253525352535253525352535253525352535253525352535253525352535253525352535253525352535253525352535253525352535253525352535253525352535253525352535253525352535253525352535
// 115:040404040404040404040404040404040404040404040404040404040404040404040404243424340212021202120212021224342434040404040404040404040404040404040404040404040404040404040404040404040404040404042434243424340212021202120212021224342434243404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 116:040404040404040404040404040404040404040404040404040404040404040404040404253525350313031303130313031325352535040404040404040404040404040404040404040404040404040404040404040404040404040404042535253525350313031303130313031325352535253504040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 117:040404040404040404040404040404040404040404040404040404040404040404040404040404042434243424342434243404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404042434243424342434243404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 118:040404040404040404040404040404040404040404040404040404040404040404040404040404042535253525352535253504040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404042535253525352535253504040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 119:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 120:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 121:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 122:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 123:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 124:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 125:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 126:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 127:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 128:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 129:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 130:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 131:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 132:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 133:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 134:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 135:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// </MAP>

// <WAVES>
// 000:01358acefeca853101368acefeca8531
// 001:0123456789abcdeffedcba9876543210
// 002:0123456789abcdef0123456789abcdef
// 003:0123456789abcdef0123456789abcdef
// 005:0123456789abcdedecae9c7654421100
// 006:9744439acccefff4976ba91c55876614
// 007:0000000000000689abcfffffffffffff
// </WAVES>

// <SFX>
// 000:02000200020002001200320042004200520052007200720092009200a200a200c200d200e200e200f200e200e200e200e200e200e200e200e200e200470000000000
// 001:030033708300c300d300e300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300255000000200
// 002:06000600060006000600160026002600360046006600760086009600a600d600f600f600f600f600f600f600f600f600f600f600f600f600f600f600105000000000
// 003:04073402640f840ea40dd40ce40cf40bf408f408f408f408f408f408f408f408f408f408f408f408f408f408f40af409f40af409f40af400f400f400a00000000000
// 004:8367335703451355136333514301530f630e730d830c930b930aa30aa30ab309c308c308d308d308d308e308e308e308f308f308f308f308f308f308400000000600
// 005:d400d400d400c400c400d400d400d400e400e400d400d400c400c400d400c400d400f400f400f400e400b400a400a400a400a400b400c400d400e4004000000f0000
// 048:04002100410f610f910ee10ef10df10df10df10df10df10df10df10df10df10df10df10df10df10df10df10df10df10df10df10df10df10df10df10dc0b000000000
// 049:64008400b400e400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400300000000000
// 050:1400640fa40ef40df40cf40bf409f408f408f408f409f409f408f408f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400b00000000000
// 051:0400440074009400a400b400d400e400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400300000000000
// 052:040046006600760fa60fc60ee60ee60ee60df60df60cf60cf60cf60bf60bf60bf60df60df60df60df60df60cf60cf60cf60cf60cf60cf60cf60cf60c300000000000
// 053:040045008500a50fe50ff50ef50ef50ef50df50df50cf50cf50cf50bf50bf50bf50df50df50df50df50df50cf50cf50cf50cf50cf50cf50cf50cf50c105000000000
// 056:06000100010001000100110011001100110021002100310051006100610071007100810081009100a100a100b100c100c100d100e100f100f100f100300000000000
// 057:27005700670077008700870087009700a700a700b700b700b700b700b700c700d700d700e700f700f700f700f700f700f700f700f700f700f700f70040a000000000
// 058:0580257005502500250025004500650075008500850095009500950095009500950095009500a500950095009500a500a500b500c500c500d500e500605000000300
// </SFX>

// <PATTERNS>
// 000:900024100000000000000000400024100000000000000000800024100000000000000000400024100000000000000000900024100000000000000000000000900022000000000000022600000000000000000000000000000000000000000000100000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
// 001:400807000000e0082900000040081f400807000000b0083900000000000040081fb0084300000040081f60084300000040081f400807e0082900000040081f400807000000b0083900000000000040081fe0082900000040081fe00829000000400807000000e0082900000040081f400807000000e00829000000000000000000e00829000000000000000000000000000000000000e00829000000000000000000000000000000000000000000000000000000000000000000000000000000
// 002:400887100881400887100881800887000000000000b00887100881b00887100881b00887d00887000000b00887000000b00885100881b00885100881f00885000000000881600887100881600887100881600887800887000000600887000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
// 003:400887100881400887100881800887000000000000b00887100881b00887100881b00887d00887000000b00887000000400887000000000000000000000000000000000000000000000000400887b00885000000d00885000000f00885000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
// 004:000000000000800899100891400899000000000000b00899100891b00899100891b00899800899000000400899000000600899000000000000900899000891000000100891000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
// 005:b00885100881b00885100881f00885000000000881600887100881600887100881600887800887000000600887000000400887100881400887100881800887000000000000b00887100881b00887100881b00887d00887000000b00887000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
// 006:000000000000600899100891f00897000000000000900899100891900899100891900899600899000000f00897000000400899000000000000800899000891000000100891000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
// 007:900887100881900887100881d00887000000000881400889100881400889100881400889600889000000400889000000400887100881400887100881800887000000000000b00887100881b00887100881b00887d00887000000b00887000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
// 008:b00885100881b00885100881f00885000000000000600887100881600887100881600887800887000000600887000000400887000000000000000000000000000000000000000000000000400887b00885000000d00885000000f00885000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
// 009:000000000000d0089910089190089900000000000040089b10089140089b10089140089bf00899000000d00899000000b00899000000000000800899000891000000100891000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
// 010:000000000000600899100891f00897000000000000900899100891900899100891900899600899000000f00897000000400899000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
// 011:000000000000b0089910089180089900000000000040089b10089140089b10089140089bb00899000000800899000000900899000000000000d00899000891000000100891000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
// 012:000000000000900899100891600899000000000000f00899100891f00899100891f00899d00899000000b00899000000800899000000000000b00899000891000000100891000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
// 013:00000000000040089b100891d0089900000000000000000000000000000000000000000000000000000040089b000000f00899000000000000b00899000891000000100891000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
// 014:000000000000900899100891600899000000000000d00899100891b00899100891900899800899000000600899000000400899000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
// 015:0008a10000009008ad0000001008a10000000000000000000000000000001008a19008ad0000000000001008a10000008008991008a1800899100891600899700899100891800899000891000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
// 016:40080700000040081f00000040081f000000400807b0085940081f40081fb0084300000040081fb00843400807000000b00843400807b0084300000040081f00000040081fb00843000000000000000000000000000000000000000000000000400807000000e0082900000040081f400807000000e00829000000000000000000e00829000000000000000000000000000000000000e00829000000000000000000000000000000000000000000000000000000000000000000000000000000
// 017:400887000881100881000000b00885000000100881e00885100881e00885b00885000000e00885000000f00885000000b00899400887b00899400887900899a00899400887b00899000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
// 018:00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000040089b10089140089b100891e00899f0089910089140089b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
// 019:b00885000000100881000000b00885100881b00885100881e00885100881e00885000000100881000000f00885000000400887000000100881000000400885000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
// 020:000891000000b00895000000f00895100891600897100891900897000000800897100891600897000000700897000000800897000000100891000000400897000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
// </PATTERNS>

// <TRACKS>
// 000:100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ec02df
// 001:2c00002010002c00002010002c0500281700202a00242b002c0503281743202a83242bc30000000000000000000000009f0200
// 002:1142d4000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000de0200
// 003:115510000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ae0200
// </TRACKS>

// <PALETTE>
// 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
// </PALETTE>

