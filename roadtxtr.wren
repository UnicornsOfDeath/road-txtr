// title:   ROAD TXTR
// author:  unicorns of DEATH
// desc:    avoid pedestrians and respond to texts
// site:    tbd
// license: MIT License
// version: 0.1
// script:  wren

import "random" for Random

var WIDTH=240
var HEIGHT=136
var MAP_W=30
var MAP_H=17
var COLOR_BG=8
var MUSSPLASH=0
var MUSGAME=1
var MUSTITLE=2
var MUSDEATH=3
var MUSWIN=4
var MUSTEMPO=100
var MUSSPD=3
var FPS=60
var MUSBEATTICKS=FPS*60/MUSTEMPO*MUSSPD/6
var SFXNEXT=1
var SFXHIT=3
var SFXSCREAM=4
var SFXGRASS=5
var SFXRIGHT=6
var SFXWRONG=7
var SFXTXT=8
var SFXEXPLODE=9
var SFXBORK=10
var PLAYER_DX=10
var TXT_X=120
var TXT_Y=10
var TXT_W=WIDTH-TXT_X-10
var TXT_H=HEIGHT-TXT_Y
var EVENT_TICK=600
var WIN_X=12900
var CROSSING_GAP=200
var STRESS_TICK=120
var SHAKING_TICK=30
var RANDOM=Random.new()
var DEBUG_HITBOX=false
var ENABLE_PHONE=true
var ENABLE_COLLISIONS=true
var AUTO_DRIVE=false
var SHOW_DOG=false
var XING_X=7980
var XING_TICKS=720
var DUCK_SPRITE=268
var DUCKLING_SPRITE=302
var XING_LINGS=12
var XING_BORK_TICKS=[4455,4500,4555,4600]

// VRAM ADDRESSES
var MOUSE_CURSOR=0x3FFB
var PALETTE_MAP=0x3FF0

// BUTTONS

var BTN_UP=0
var BTN_DOWN=1
var BTN_LEFT=2
var BTN_RIGHT=3
var BTN_A=4
var BTN_B=5
var BTN_X=6
var BTN_Y=7

var CHEAT_CODE=[BTN_UP,BTN_UP,BTN_DOWN,BTN_DOWN,BTN_LEFT,BTN_RIGHT,BTN_LEFT,BTN_RIGHT,BTN_B,BTN_A]

// SPRITES

var PEDESTRIAN_SPRITES=[256,258,260,262,264,266,268,270]
var PEDESTRIAN_SPEEDS={
    256:0.25,
    258:0.2,
    260:0.15,
    262:0.3,
    264:0.4,
    266:0.5,
    268:0.2,
    270:0.3,
    302:0.2
}

// TILE IDs
var TILE_SIZE=8
var TILE_SIZE_2=16

var ROAD_TILES=[0,1,2,3,16,17,18,19,32,33,48,49]
var GRASS_TILES=[64,65,80,81]
var FOOTPATH_TILES=[66,67,82,83,98,99,114,115]
var FOOTPATH_DOWN=[68,69,84,85]
var FOOTPATH_UP=[100,101,116,117]
var CROSSING_TILES=[34,35,50,51]

var GOOD_TEXT=0
var BAD_TEXT=0
var PEDESTRIANS_KILLED=[]

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
					TIC.spr(__SYM_MAP[letter]+128,x,y,0)
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
        if (canSkip && (TIC.btnp(0) || TIC.btnp(1) || TIC.btnp(2) || TIC.btnp(3) || TIC.btnp(4) || TIC.btnp(5) || TIC.btnp(6) || TIC.btnp(7))) {
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
			SplashStateText.new(0,"^56u"),
			SplashStateText.new(1,"^56u^deni"),
			SplashStateText.new(2,"^56u^deni^56c^deorns"),
			SplashStateText.new(3,"^56u^deni^56c^deorns\n^56o^def"),
			SplashStateText.new(4,"^56u^deni^56c^deorns\n^56o^def^21DEATH"),
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
			var cf=ChunkyFont.new(50,40)
			cf.s(tx)
        }
		if (tt>5.8*MUSBEATTICKS) {
			drawface(170,36)
        }
    }

	drawface(x,y) {
        TIC.spr(204,x,y,0,1,0,0,4,4)
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
        _player=Player.new(PLAYER_DX,40,0,null)
        _nextStateCounter=0
        _phone=Phone.new()
        _keys=[]
    }

    isSwitchingToNextState{_nextStateCounter>0}

	reset() {
		super.reset()
		TIC.music(MUSTITLE,-1,-1,false)
        _player=Player.new(PLAYER_DX,40,0,null)
        _nextStateCounter=0
        _keys=[]
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
            _player.update(0,0)
            if(_player.y>95){
                finish()
            }
        }
        if(isSwitchingToNextState){
            _nextStateCounter=_nextStateCounter-1
        }

        // Check cheat code
        for(k in BTN_UP..BTN_B) {
            if(TIC.btnp(k)) {
                _keys.add(k)
                if (_keys.count==CHEAT_CODE.count) {
                    var same=true
                    for (i in 0..._keys.count) {
                        if (_keys[i] != CHEAT_CODE[i]) {
                            same=false
                            break
                        }
                    }
                    if (same) {
                        TIC.sfx(SFXRIGHT)
                        AUTO_DRIVE=true
                        SHOW_DOG=true
                        ENABLE_PHONE=false
                    }
                    _keys.removeAt(0)
                }
                break
            }
        }

        _phone.update()
        if (!_phone.isShowing()){
            _phone.showPhone([
                Message.new("Game hint", "Drive the car\nup/down.\nIsn't this\ngame great?","Yes!","No..."),
                Message.new("Game hint", "Hitting trees\nand pedestrians\ndamages the car!","Got it","Who cares"),
                Message.new("Game hint", "Answer texts\nto hide the phone","Like this","Go away"),
                Message.new("Game hint", "Wrong replies\nwill freeze\nthe car","Sure","Liar"),
                Message.new("Game hint", "What is 1+1?","2","I refuse")
            ])
        }
    }

    draw() {
        super.draw()
        TIC.cls(COLOR_BG)
        TIC.print(((tt/40).floor%2)==0?">>> START GAME":">>> DRIVE HERE",30,100,12+(tt/20)%2)
        TIC.spr(510,20,64+((tt/20).floor%4)*10,0)
        _player.draw(0,0)
        _phone.draw()
        var cf=ChunkyFont.new(30,20)
        cf.s("^43ROAD\n^56TXTR")
    }
}

class MainState is State {
    construct new() {
        _x=0
        _y=0
        _speed=2
        _phone=Phone.new()
        _obstacles=[]
        _map=GameMap.new()
        _player=Player.new(PLAYER_DX,60,_speed,_map)
        _currentTime=0
        _progressbar = ProgressBar.new()
		_winstate=this
        _deathticks=0
        _lastCrossingX=0
        _xinged=false
    }
    winstate { _winstate }
    winstate=(value) {
        _winstate=value
    }

    reset() {
        super.reset()
        _x=0
        _player=Player.new(PLAYER_DX,60,_speed,_map)
        _phone=Phone.new()
        _obstacles=[]
        _showText=false
        _currentTime=0
        _choiceMade=false
        _deathticks=0
        _lastCrossingX=0
		TIC.music(MUSGAME,-1,-1,true)
        GOOD_TEXT=0
        BAD_TEXT=0
        PEDESTRIANS_KILLED=[]
        _xinged=false
    }

    setCrossing(coordX) {
        // Change road tiles to crossing tiles
        _lastCrossingX = _x
        var tileX = (coordX/TILE_SIZE).floor
        var x = tileX%(MAP_W*3)
        for(y in 0...MAP_H){
            if (_map.tileAtIs(x,y,ROAD_TILES)) {
                TIC.mset(x,y,CROSSING_TILES[0])
                TIC.mset(x+1,y,CROSSING_TILES[1])
            }
            y = y + 1
            if (_map.tileAtIs(x,y,ROAD_TILES)) {
                TIC.mset(x,y,CROSSING_TILES[2])
                TIC.mset(x+1,y,CROSSING_TILES[3])
            }
        }
    }

    update() {
        super.update()

        if (_deathticks>0) {
            _deathticks=_deathticks-1
            return
        } else if (_player.health<=0){
            TIC.music()
            _deathticks=60
        }

        _player.update(_x,_y)
        _x=_player.x-PLAYER_DX
        _phone.update()
        _player.isOnGrass =_map.tileAtPixelIs(_player.x+24,_player.y+8,GRASS_TILES)

        var coords=_map.findYforRandomTileWithIdsAtX(_x+WIDTH+RANDOM.int(0,60),ROAD_TILES+FOOTPATH_TILES)
        if (coords!=null) {
            // Xing ducks
            if (AUTO_DRIVE && _x>=XING_X && !_xinged) {
                _xinged=true
                setCrossing(coords[0])
                var duck=Oldie.new(coords[0]+4,coords[1],0,1,DUCK_SPRITE,_map,_player)
                duck.xing()
                _obstacles.add(duck)
                for(i in 1..XING_LINGS){
                    var d = Oldie.new(coords[0]+4,coords[1]-i*12,0,1,DUCKLING_SPRITE,_map,_player)
                    d.xing()
                    _obstacles.add(d)
                }
            } else if(tt%(60-(50*_x/WIN_X).floor).floor==0) {
                var dir=RANDOM.int(0,2)*2-1
                var sprite=RANDOM.sample(PEDESTRIAN_SPRITES)

                if(_map.tileAtPixelIs(coords[0],coords[1],ROAD_TILES)) {
                    // Crossing road
                    _obstacles.add(Oldie.new(coords[0]+RANDOM.int(0,8),coords[1],0,dir,sprite,_map,_player))

                    // Change road tiles to crossing tiles
                    if (_x > _lastCrossingX + CROSSING_GAP && RANDOM.int(0,2)==0) {
                        setCrossing(coords[0])
                    }
                } else {
                    // Walking along sidewalk
                    _obstacles.add(Oldie.new(coords[0],coords[1],dir,0,sprite,_map,_player))
                }
            }
        }

        if((tt+15)%50==0) {
            var coords=_map.findYforRandomTileWithIdsAtX(_x+WIDTH,FOOTPATH_TILES)

            if(coords!=null) {
                _obstacles.add(Post.new(coords[0],coords[1]))
            }
        }

        if(tt%10==0) {
            var coords=_map.findYforRandomTileWithIdsAtX(_x+WIDTH,GRASS_TILES)

            if(coords!=null) {
                if(RANDOM.int(0,2)==0) {
                    _obstacles.add(PalmTree.new(coords[0],coords[1]-TILE_SIZE_2))
                } else {
                    _obstacles.add(PineTree.new(coords[0],coords[1]-TILE_SIZE_2))
                }
            }
        }

        _obstacles=_obstacles.where {|obstacle| obstacle.x>_x-100}.toList

        _obstacles.each {|obstacle|
            obstacle.update()
            if(obstacle.isAlive&&obstacle.intersects(_player) && ENABLE_COLLISIONS && !AUTO_DRIVE) {
                _player.onHit(obstacle.damage)
                obstacle.onHit()
            }
        }
        // Remove obstacles off camera
        _obstacles.each {|obstacle|
            if(obstacle.x<_x-50){
                _obstacles.remove(obstacle)
            }
        }

        _currentTime = _currentTime + 1
        if(_currentTime == EVENT_TICK) {
            if(_phone.isShowing()) {
                wrongAnswer()
            }
            _phone.showPhone()
            _currentTime = 0
        }

        _progressbar.update()
        if (_phone.isWrong() == true) {
            wrongAnswer()
        }
    }

    next() {
        _map.update(_x)
        if (_x>=WIN_X) {
            finish()
            winstate.reset()
            return winstate
        }
		if (_deathticks==1) {
			finish()
			nextstate.reset()
			return nextstate
        }
		return super()
    }

    draw() {
        _map.draw()

        _obstacles.each {|obstacle|
            if(DEBUG_HITBOX){
                TIC.rectb(obstacle.x-_x+obstacle.hitbox.x,obstacle.y+obstacle.hitbox.y,obstacle.hitbox.width,obstacle.hitbox.height,5)
            }
        }
        if(DEBUG_HITBOX){
            TIC.rectb(_player.x-_x+_player.hitbox.x,_player.y+_player.hitbox.y,_player.hitbox.width,_player.hitbox.height,5)
        }

        var drawables=_obstacles+[_player]
        drawables.sort {|a,b| a.y+a.hitbox.top < b.y+b.hitbox.top}
        drawables.each {|drawable| drawable.draw(_x,_y)}

        if (!AUTO_DRIVE) {
            _progressbar.draw(_x)
        }
        _phone.draw()
    }

    wrongAnswer() {
        _player.makeStressed()
        _map.shakeItOff()
    }
}

class DeathState is SkipState {
	construct new() {
		super(60)
        _player=Player.new(WIDTH/2,HEIGHT/2,0,null)
        _player.health=1
    }

    reset() {
        super.reset()
        TIC.music(MUSDEATH,-1,-1,false)
    }

	finish() {
        return
    }

    update() {
        super.update()
        _player.update(0,0)
    }

	draw() {
		super.draw()
		TIC.cls(COLOR_BG)
        _player.draw(0,0)
		TIC.print("Totalled!", 50, 50, 3)
		TIC.print("Press any key to restart", 40, 100, 12)
    }
}

class WinState is SkipState {
	construct new() {
		super(300)
        _corpses=[]
    }

	reset() {
		super.reset()
		TIC.music(MUSWIN,-1,-1,false)
        var x=30
        _corpses=PEDESTRIANS_KILLED.map{|sprite|
            x=x+12
            return Corpse.new(x,87+RANDOM.int(10),sprite)
        }.toList
    }

	finish() {
        SHOW_DOG=true
        if (BAD_TEXT==0 && PEDESTRIANS_KILLED.count==0) {
            AUTO_DRIVE=true
        }
    }

	draw() {
		super.draw()
		TIC.cls(COLOR_BG)
		TIC.print("You win!", 40, 30, 5)
		TIC.print("Good texts: %(GOOD_TEXT)", 30, 60, 12)
		TIC.print("Bad texts: %(BAD_TEXT)", 30, 70, 12)
		TIC.print("Pedestrians killed: %(PEDESTRIANS_KILLED.count)", 30, 80, 12)
        _corpses.each{|corpse| corpse.draw()}
        if (!SHOW_DOG) {
            TIC.print("Dog unlocked! (X to bork)", 30, 110, 5+((tt/10).floor%2))
        }
        if (BAD_TEXT==0 && PEDESTRIANS_KILLED.count==0 && !AUTO_DRIVE) {
            TIC.print("PERFECT! (auto-play unlocked)", 30, 120, 5+((tt/2).floor%2))
        }
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

class Smoke is GameObject {
    construct new(x,y) {
        super(x+RANDOM.int(20),y+RANDOM.int(10)-5,Rect.new(0,0,0,0))
        _ticks=0
    }

    frame{(_ticks/4).floor}

    update() {
        super.update()
        y=y-1
        x=x-0.2*_ticks
        _ticks=_ticks+1
    }

    draw() {
        TIC.spr(496+frame,x,y,0,1)
    }
}

class Player is GameObject {
    health { _health }
    health=(value){_health=value}
    stressed { _stressed }
    borking { _borkTick>0 }

    makeStressed(){ 
        _stressed=true
    }

    construct new(x,y,speed,map) {
        super(x,y,Rect.new(0,5,32,11))
        _speed=speed
        _map=map
        _ticks=0
        _frame=0
        _steeringSpeed=1.5
        _stressTick=0
        _dy=0
        _maxHealth=10
        _health=_maxHealth
        _damageshaketick=0
        _stressed=false
        _isOnGrass=false
        _smoke=[]
        _borkTick=0
        _xingStopTicks=0
        _xingAccelTicks=0
        _xingState="normal"
        _totalTicks=0
    }
    isOnGrass=(value){
        if(value&&!_isOnGrass){
            TIC.sfx(SFXGRASS)
        }else if(!value&&_isOnGrass){
            TIC.sfx(-1)
        }
        _isOnGrass=value
    }

    bork() {
        if (_borkTick>0) {
            return
        }
        if(!AUTO_DRIVE) {
            TIC.sfx(SFXBORK)
        }
        _borkTick=20
    }

    onHit(dmg){
        _health=(_health-dmg).max(0)
        TIC.sfx(_health>0?SFXHIT:SFXEXPLODE)
        _damageshaketick=10
    }

    update(camX,camY) {
        super.update()
        var dx=1
        if (AUTO_DRIVE && x>=XING_X) {
            if (_xingState=="normal") {
                _xingState="stopping"
                _xingAccelTicks=200
            } else if (_xingState=="stopping") {
                _xingAccelTicks=_xingAccelTicks-1
                dx=_xingAccelTicks/200
                if (_xingAccelTicks==0) {
                    _xingState="stop"
                }
            } else if (_xingState=="stop") {
                dx=0
                _xingStopTicks=_xingStopTicks+1
                XING_BORK_TICKS.each {|tick|
                    if (tick==_totalTicks) {
                        bork()
                    }
                }
                if (_xingStopTicks==XING_TICKS) {
                    _xingState="starting"
                }
            } else if (_xingState=="starting") {
                dx=_xingAccelTicks/200
                _xingAccelTicks=_xingAccelTicks+1
                if (_xingAccelTicks==200) {
                    _xingState="continue"
                }
            }
        }
        _totalTicks=_totalTicks+1
        x=x+_speed*dx
        if(_stressed == true) {
            _stressTick=_stressTick + 1
        } else {
            var ddy=0
            if(TIC.btn(BTN_UP)) {
                ddy=-1
            }else if(TIC.btn(BTN_DOWN)) {
                ddy=1
            }
            _dy=(_dy+ddy*0.5).clamp(-1,1)

            if (SHOW_DOG && TIC.btnp(BTN_B)) {
                bork()
            }
        }

        if (AUTO_DRIVE && _map) {
            var driveY=0
            if (_map.tileAtPixelIs(x+32,y+16,FOOTPATH_DOWN)){
                driveY=-1
            }
            if (_map.tileAtPixelIs(x+32,y+2,FOOTPATH_UP)){
                driveY=1
            }
            if (!_map.tileAtPixelIs(x+32,y+16,ROAD_TILES+CROSSING_TILES) && _map.tileAtPixelIs(x+32,y+4,ROAD_TILES+CROSSING_TILES)) {
                driveY=-1
            }
            if (!_map.tileAtPixelIs(x+32,y+2,ROAD_TILES+CROSSING_TILES) && _map.tileAtPixelIs(x+32,y+14,ROAD_TILES+CROSSING_TILES)) {
                driveY=1
            }
            if ((!_map.tileAtPixelIs(x+32,y+2,ROAD_TILES+CROSSING_TILES) || !_map.tileAtPixelIs(x+32,y+16,ROAD_TILES+CROSSING_TILES)) && driveY==0) {
                driveY=y>HEIGHT/2?-1:1
            }
            
            if (driveY!=0) {
                y=y+_speed.abs*0.5*driveY
                _dy=-_dy*RANDOM.float(0.5,1.5)
            } else if (dx==1) {
                // Random auto drive up/down
                if (_dy.abs<0.01 || _dy.abs>0.5){
                    _dy=0.25
                }
                y=y+_dy*_steeringSpeed
            }
        } else {
            _dy=(_dy-_dy.sign*0.15).clamp(-1,1)
            if(_dy.abs<0.1){
                _dy=0
            }
            y=(y+_dy*_steeringSpeed).clamp(8,HEIGHT-16)
        }

        if(_stressTick >= STRESS_TICK) {
           _stressTick = 0
           _stressed = false 
        }
        _ticks=_ticks+1
        if(_ticks>=15-damageLevel*4){
            _ticks=0
            _frame=1-_frame
        }
        _borkTick=(_borkTick-1).max(0)
        if(damageLevel>0){
            if(RANDOM.int(5)==0){
                _smoke.add(Smoke.new(x-camX,y-camY))
            }
            if(damageLevel>1){
                if(RANDOM.int(5)==0){
                    _smoke.add(Smoke.new(x-camX,y-camY))
                }
            }
        }
        _smoke.each {|smoke|
            smoke.update()
            if(smoke.frame>4){
                _smoke.remove(smoke)
            }
        }
        _damageshaketick=(_damageshaketick-1).max(0)
    }

    damageLevel{
        return ((_maxHealth-health)*3/_maxHealth).floor.min(2)
    }

    draw(camX,camY) {
        var dx=_damageshaketick>0?(RANDOM.int(2)-1)*_damageshaketick/5:0
        var dy=_damageshaketick>0?(RANDOM.int(2)-1)*_damageshaketick/5:0
        var drawX=x-camX+dx
        var drawY=y-camY-8+dy
        TIC.spr(352+damageLevel*48+_frame*4,drawX,drawY,0,1,0,0,4,3)
        if (SHOW_DOG) {
            var frame=1-_frame
            if (_borkTick>0) {
                frame=2+((_borkTick/5).floor%3).max(1)-1
            }
            TIC.spr(360+frame*2,drawX,drawY+8,0,1,0,0,2,2)
        }
        _smoke.each {|smoke|
            smoke.draw()
        }
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

class FlyingObstacle is Obstacle {
    // Obstacle that flies away when hit
    construct new(x,y,sprite,animFrames,tileHeight,flip) {
        super(x,y,1,Rect.new(4,3,7,7))
        _ticks=0
        _dy=0
        _dx=0
        _sprite=sprite
        _animFrames=animFrames
        _tileHeight=tileHeight
        _flip=flip
    }
    sprite{_sprite}
    ticks{_ticks}
    flip=(value){_flip=value}

    update(){
        super()
        _ticks=_ticks+1
        if(!isAlive){
            _dy=_dy+0.07
        }
        y=y+_dy
        x=x+_dx
    }

    onHit(){
        super()
        _dy=-2
        _dx=1
        _ticks=0
    }

    draw(camX,camY) {
        var drawX=x-camX+4
        var drawY=y-camY-_tileHeight*8+8
        if(isAlive){
            var frame=_animFrames>0 ? (_ticks/_animFrames).floor%2 : 0
            TIC.spr(_sprite+frame,drawX,drawY,0,1,_flip?1:0,0,1,_tileHeight)
        }else{
            var frame=_animFrames>0 ? (_ticks/5).floor%2 : 0
            var r=_animFrames>0 ? ((_ticks/10).floor%4) : 0
            TIC.spr(_sprite+frame,drawX,drawY,0,1,0,r,1,_tileHeight)
        }
    }
}

class Oldie is FlyingObstacle {
    construct new(x,y,walkDirX,walkDirY,sprite,map,player) {
        var animFrames=(6/PEDESTRIAN_SPEEDS[sprite]).floor
        if (sprite==DUCKLING_SPRITE) {
            animFrames=(animFrames/2).floor
        }
        super(x,y,sprite,animFrames,2,(walkDirX==-1||RANDOM.int(0,2)==0)&&walkDirX!=1)

        _walkingSpeedX=walkDirX*PEDESTRIAN_SPEEDS[sprite]
        _walkingSpeedY=walkDirY*PEDESTRIAN_SPEEDS[sprite]
        _map=map
        _player=player
        _onRoad=false
        _ignorePlayer=false
    }

    xing() {
        _ignorePlayer=true
    }

    onHit(){
        super()
        PEDESTRIANS_KILLED.add(sprite)
    }

    update(){
        super()
        if(!isAlive){
            if(ticks==10){
                TIC.sfx(SFXSCREAM)
            }
        } else {
            x=x+_walkingSpeedX
            y=y+_walkingSpeedY
            if (_walkingSpeedX!=0) {
                // Follow footpath if walking along the side
                if (_map.tileAtPixelIs(x,y+8,FOOTPATH_DOWN)){
                    y=y+_walkingSpeedX.abs
                }
                if (_map.tileAtPixelIs(x,y+8,FOOTPATH_UP)){
                    y=y-_walkingSpeedX.abs
                }
            } else {
                // Run away from player
                if ((AUTO_DRIVE || _player.borking) && !_ignorePlayer) {
                    if (hitbox.translate(x-48,y-8).intersects(_player.hitbox.translate(_player.x,_player.y))) {
                        y=y+0.5
                        _walkingSpeedY=_walkingSpeedY.abs
                    }
                    if (hitbox.translate(x-48,y+8).intersects(_player.hitbox.translate(_player.x,_player.y))) {
                        y=y-0.5
                        _walkingSpeedY=-_walkingSpeedY.abs
                    }
                }
                // Stop crossing road if reached other side
                if (y>0 && (_map.tileAtPixelIs(x,y,ROAD_TILES) || _map.tileAtPixelIs(x,y,CROSSING_TILES))) {
                    _onRoad=true
                }
                if (_onRoad &&
                    ((_walkingSpeedY>0 && (_map.tileAtPixelIs(x,y,GRASS_TILES) || _map.tileAtPixelIs(x,y,FOOTPATH_TILES))) ||
                    (_walkingSpeedY<0 && (_map.tileAtPixelIs(x,y+8,GRASS_TILES) || _map.tileAtPixelIs(x,y+8,FOOTPATH_TILES))))) {
                    _walkingSpeedX=_walkingSpeedY*(RANDOM.int(0,1)-0.5)*1.2
                    flip=_walkingSpeedX<0
                    _walkingSpeedY=0
                }
            }
        }
    }
}

class Corpse is GameObject {
    construct new(x,y,sprite){
        super(x,y)
        _sprite=sprite
        _tileHeight=2
        _flip=RANDOM.int(2)*2
    }

    draw(){
        TIC.spr(_sprite,x,y,0,1,_flip,1,1,_tileHeight)
    }
}

class Post is FlyingObstacle {
    construct new(x,y) {
        super(x,y,292+RANDOM.int(2),0,4,false)
    }
}

class PalmTree is Obstacle {
    construct new(x,y) {
        super(x,y,1,Rect.new(5,20,3,9))
    }

    draw(camX,camY) {
        TIC.spr(isAlive?288:295,x-camX,y-camY,0,1,0,0,2,4)
    }
}

class PineTree is Obstacle {
    construct new(x,y) {
        super(x,y,1,Rect.new(7,23,3,7))
    }

    draw(camX,camY) {
        TIC.spr(isAlive?290:295,x-camX,y-camY,0,1,0,0,2,4)
    }
}

class Phone {
    construct new() {
        _showPhone = false
        _randOrder=0
        _messageIndex=0
        _correctOnZ=true
        _correctChoice=false
        _choiceMade=false
        _profilePic=PEDESTRIAN_SPRITES[0]
        var profiles=List.new().addAll(PEDESTRIAN_SPRITES)
        RANDOM.shuffle(profiles)
        _profilePicMap={
            "Roomie":profiles[0],
            "Babe":profiles[1],
            "Boss":profiles[2],
            "Mum":profiles[3],
            "Bestie":profiles[4]
        }
        _y=HEIGHT
        var message1 = Message.new("Roomie", "Did you eat the\ncake I left in the\nfridge?","No way","Yes way")
        var message2 = Message.new("Babe", "Are you ready to\nmeet my family\ntonight?","Of course","Of course not")
        var message3 = Message.new("Boss", "Can you please\nlisten to your\nradio at a\nreasonable volume\nfrom 9 till 11","acceptable","unacceptable")
        var message4 = Message.new("Mum", "Hi, Mum here\nHave you forgotten\nyour grandma's\nbirthday?","No","Yes")
        var message5 = Message.new("Bestie", "We hitting the town\nthis weekend?\nIt has been a while.","Hell yes","Hell no")
        var message6 = Message.new("Bestie", "Did my girlfriend\nsend nudes to you?","Hell no","Hell yes")
        var message7 = Message.new("Roomie", "Can you please\nstop using my\ntowel after you\nhave a shower?","Yes way","No way")
        var message8 = Message.new("Babe", "Do you think I\nlook I look\nfat in my new\ndress?","Of course not","Of course")
        var message9 = Message.new("Bestie", "Impression yoda my\nlike you do?","Hell yes","Hell no")
        var message10 = Message.new("Boss", "Hawaiian shirt day\nwill be on every\nfriday from now\non ","unacceptable","acceptable")
        var message11 = Message.new("Mum", "Hi, Mum here\nWill you be joining\nus for Christmas\nlunch?","Yes","No")
        var message12 = Message.new("Mum", "Hi, Mum here\nI think I put a\nvirus on my\ncomputer. Can you\nfix it now?","Yes","No")
        var message13 = Message.new("Bestie", "When I move\noverseas are you\ngoing to forget me?","Hell no","Hell yes")
        var message14 = Message.new("Boss", "I'm going to\nneed those TPS\nreports ASAP ","acceptable","unacceptable")
        var message15 = Message.new("Babe", "Just watching\nfarmer wants a wife\nand do you think\nJamie is hotter\nthan me?","Of course not","Of course")
        var message16 = Message.new("Babe", "Was thinking of\nyou today. Did you\nthink of me?","Of course","Of course not")
        var message17 = Message.new("Mum", "Hi, Mum here\nDo you think it\nwould be too much\n effort call me\nsometime?","No","Yes")
        var message18 = Message.new("Roomie", "Can you please\nlearn to flush\nthe toilet. Sick\nof surprises","Yes way","No way")
        var message19 = Message.new("Roomie", "Did you set up\na camera in my\nbedroom to spy\non me?","No way","Yes way")
        var message20 = Message.new("Bestie", "Hey, Birthday this\nweekend. You coming\nyeah?","Hell yes","Hell no")


        _messages = [message1,message2,message3,message4,message5,message6,message7,message8,message9,
        message10,message11,message12,message13,message14,message15,message16,message17,message18,message19,
        message20]
        RANDOM.shuffle(_messages)
    }
    update() {
        if (_showPhone && ENABLE_PHONE) {
            if (_y > TXT_Y) {
                _y= _y - 10
            }
            if (_y < TXT_Y) {
                _y = TXT_Y
            }
            if(TIC.btnp(BTN_X)){
                _correctChoice = _correctOnZ == true
                _choiceMade=true
                _showPhone=false

                if(_correctChoice) {
                    GOOD_TEXT = GOOD_TEXT +1
                } else {
                    BAD_TEXT = BAD_TEXT + 1
                }
                
                TIC.sfx(_correctChoice?SFXRIGHT:SFXWRONG)
            }
            if(TIC.btnp(BTN_A)){
                _correctChoice = _correctOnZ == false
                _choiceMade=true
                _showPhone=false

                if(_correctChoice) {
                    GOOD_TEXT = GOOD_TEXT +1
                } else {
                    BAD_TEXT = BAD_TEXT + 1
                }

                TIC.sfx(_correctChoice?SFXRIGHT:SFXWRONG)
            }
        } else {
            if (_y < HEIGHT) {
                _y= _y + 10
            }
            if (_y > HEIGHT) {
                _y = HEIGHT
            }
        }
    }

    showPhone(messages) {
         _choiceMade = false
         _showPhone = true
         _messages = messages
         _randOrder = RANDOM.int(2)
         _correctOnZ = _randOrder == 0
         _profilePic = RANDOM.sample(PEDESTRIAN_SPRITES)
         _messageIndex = _messageIndex + 1
        if (_messageIndex >= _messages.count) {
            _messageIndex = 0
        }
    }

    showPhone() {
        if (!ENABLE_PHONE) {
            return
        }
        TIC.sfx(SFXTXT)
         _choiceMade = false
         _showPhone = true
         _randOrder = RANDOM.int(2)
         _correctOnZ = _randOrder == 0
         _messageIndex = _messageIndex + 1
        if (_messageIndex >= _messages.count) {
            _messageIndex = 0
        }
         _profilePic = _profilePicMap[_messages[_messageIndex].sender]
         if(_profilePic==null) {
            _profilePic = RANDOM.sample(PEDESTRIAN_SPRITES)
         }
    }

    isShowing() {
        return _showPhone && ENABLE_PHONE
    }

    hidePhone() {
        _showPhone = false
    }

    isWrong() {
        if (_choiceMade == true) {
            // to stop it from being double checked
            _choiceMade = false 
            return _correctChoice == false
        } 
        return false
        
    }

    roundedRect(x,y,w,h,r,c){
        TIC.circ(x,y,r,c)
        TIC.circ(x+w,y,r,c)
        TIC.circ(x,y+h,r,c)
        TIC.circ(x+w,y+h,r,c)
        TIC.rect(x,y-r,w,h+r*2+1,c)
        TIC.rect(x-r,y,w+r*2+1,h,c)
    }

    draw() {
        if (!ENABLE_PHONE) {
            return
        }
        var R=8
        var PHONE_C=0
        roundedRect(TXT_X,_y,TXT_W,TXT_H,R,PHONE_C)
        var y=_y
        TIC.rect(TXT_X,y,TXT_W,TXT_H,12)
        TIC.rect(TXT_X,y,TXT_W,20,13)
        TIC.rect(TXT_X+4,y+2,18,16,11)
        TIC.rectb(TXT_X+3,y+1,20,18,12)
        TIC.spr(_profilePic,TXT_X+5,y+2,0,2)
        TIC.print(_messages[_messageIndex].sender,TXT_X+26,y+4,0)
        y=y+20
        roundedRect(TXT_X+6,y+5,TXT_W-15,30,3,13)
        TIC.print(_messages[_messageIndex].message,TXT_X+5,y+4,0)


        y=y+40
        roundedRect(TXT_X+5,y+2,TXT_W-20,8,2,6)
        TIC.rectb(TXT_X+4,y+2,10,10,13)
        TIC.print("A",TXT_X+6,y+4,0)
        if (_correctOnZ == true) {
            TIC.print(_messages[_messageIndex].correct,TXT_X+15,y+4,0)
        } else {
            TIC.print(_messages[_messageIndex].wrong,TXT_X+15,y+4,0)
        }
        y=y+15
        roundedRect(TXT_X+5,y+2,TXT_W-20,8,2,6)
        TIC.rectb(TXT_X+4,y+2,10,10,13)
        TIC.print("Z",TXT_X+6,y+4,0)
        if (_correctOnZ == true) {
            TIC.print(_messages[_messageIndex].wrong,TXT_X+15,y+4,0)
        } else {
            TIC.print(_messages[_messageIndex].correct,TXT_X+15,y+4,0)
        }
    }
}

class GameMap {
    construct new() {
        _x=0
        _y=0
        _shakeCount=0
        _shaking=false
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
        _x = x%(WIDTH*3)
        // Switch map by template if we've crossed a boundary
        if(_x<oldX){
            // 2->0
            replace(2)
        }else if(_x>=WIDTH&&oldX<WIDTH){
            // 0->1
            replace(0)
        }else if(_x>=WIDTH*2&&oldX<WIDTH*2){
            // 1->2
            replace(1)
        }
        // Ramp up difficulty as we get closer to the end
        if (x>WIN_X/3){
            _difficulty=1
        }
        if(x>WIN_X*2/3){
            _difficulty=2
        }
        if (_shaking) {
            _shakeCount = _shakeCount + 1
            if (_shakeCount % 2 == 0) {
                _y  = _y + 2
            } else {
                _y  = _y - 2
            }
        }
        if (_shakeCount >= SHAKING_TICK) {
            _y = 0
            _shakeCount = 0
            _shaking = false
        }
    }

    shakeItOff() {
       _shaking = true
    }

    draw() {
        TIC.map(0, 0, MAP_W*3, MAP_H, -_x, _y)
        if(_x>=WIDTH*2){
            TIC.map(0, 0, MAP_W, MAP_H, -_x+WIDTH*3, 0)
        }
    }

    tile2At(x,y) {
        return TIC.mget((x*2)%(MAP_W*3),y*2+1)
    }

    tileAtPixelIs(x,y,options) {
        var tileX=(x/TILE_SIZE).floor
        var tileY=(y/TILE_SIZE).floor
        return tileAtIs(tileX,tileY,options)
    }

    tileAtIs(tileX,tileY,options) {
        return options.contains(TIC.mget(tileX%(MAP_W*3),tileY))
    }

    findYforRandomTileWithIdsAtX(x,tileIDs) {
        var tileX=(x/TILE_SIZE_2).floor+1
        var tileOptions = (0...(HEIGHT/TILE_SIZE_2).floor).where {|i| tileIDs.contains(tile2At(tileX,i))}.toList
        if(tileOptions.count==0) return null
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
        TIC.poke(MOUSE_CURSOR,74)

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
// 034:ffccccccffffffffffffffffffccccccffccccccffffffffffffffffffcccccc
// 035:ccccccffffffffffffffffffccccccffccccccffffffffffffffffffccccccff
// 048:ffffffffffffffffffffffffffffffffffffffffffffffffeeeeeeeedddddddd
// 049:ffffffffffffffffffffffffffffffffffffffffffffffffeeeeeeeedddddddd
// 050:ffccccccffffffffffffffffffccccccffccccccffffffffffffffffffcccccc
// 051:ccccccffffffffffffffffffccccccffccccccffffffffffffffffffccccccff
// 064:7777775775777767767776677767776777777777777577757676777677777777
// 065:7777577777776667677777776777777675775776767767777777777775777777
// 066:eeeeeeeedddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 067:eeeeeeeeedddddddedddddddedddddddedddddddedddddddedddddddeddddddd
// 068:ddeeffffeeddeeffddeeddeeddddeeddddddddeedddddddddddddddddddddddd
// 069:ffffffffffffffffffffffffeeffffffddeeffffeeddeeffedeeddeeedddeedd
// 070:ddee7757eeddee67ddeeddeeddddeeddddddddeedddddddddddddddddddddddd
// 071:757777777677675777677767ee777767ddee7777eeddee76edeeddeeedddeedd
// 080:7777577777766776777777767777777775777577767676777667767777777777
// 081:7677577777776767767776776777777777757777776677777776777677777767
// 082:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 083:edddddddedddddddedddddddedddddddedddddddedddddddedddddddeddddddd
// 084:ffffffffffffffffffffffffffffffeefffeeeddffeeddeeeeddeeddddeedddd
// 085:ffffeeddffeeddeeeeddeeddddeeddddeeddddddedddddddedddddddeddddddd
// 086:777775777775767775776777767777ee767eeedd77eeddeeeeddeeddddeedddd
// 087:6777eedd77eeddeeeeddeeddddeeddddeeddddddedddddddedddddddeddddddd
// 098:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 099:edddddddedddddddedddddddedddddddedddddddedddddddedddddddeddddddd
// 100:ddeeddddeeddeeddffeeddeeffffeeddffffffeeffffffffffffffffffffffff
// 101:edddddddedddddddedddddddeeddddddddeeddddeeddeeddffeeddeeffffeedd
// 102:ddeedddde5ddeedd76eeddee6777eedd775775ee676776777677767577777776
// 103:edddddddedddddddedddddddeeddddddd5eedddde6d5eedd776eddee7767eedd
// 114:ddddddddddddddddddddddddddddddddddddddddddddddddeeeeeeeedddddddd
// 115:edddddddedddddddedddddddedddddddedddddddedddddddeeeeeeeedddddddd
// 116:ddddddddddddddddddddddddddddddeedddeeeddddeeddeeeeddeeffddeeffff
// 117:edddeeddedeeddeeeeddeeffddeeffffeeffffffffffffffffffffffffffffff
// 118:ddddddddddddddddddddddddddddddeedddeeeddddeedde5eeddee76ddee7777
// 119:edddeeddedeeddeeee5d5e77dde66777ee776777777777577757766777677677
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
// 204:0000000000000000000000000000f000000f4f00000f444f0000f34400000f34
// 205:000000000000000000000000000000000000000000000000f00000004f0fffff
// 206:0000000c00ff0fcf00f3fcef000fcdcf00fcdef000cdcef0fcddef00cfcfef00
// 207:f000000000000000000000000000000000000000000000000000000000000000
// 220:000000f3fff0000f222ff0f412211f44211ff44421f444441f444444f4444444
// 221:4ff44444f444444444444fff4444fccc444fcccc44fcffcc44fcffcc44fdcccc
// 222:fddef0004feef000f44ffff0ffffcccfcffccccccdfcccffcdfcccffdffdcccc
// 223:00000000000000000000000000000000f0000000cf000000cf000000df000000
// 236:f444444444444444444444444444444f444444f4444444f4444444f4444444f4
// 237:44ffdccd444fffff444444444444444444444444444444444444444444444444
// 238:f44fdccd4444ffff444444444444444444444444444444444444444444f44444
// 239:f4f0000044f00000444f00004444f00044444f00444ffff04ff4444f334444ff
// 252:444444f4444444f34444444f4444444444444444444444444444444344444333
// 253:44444434444443443333f344fffff334443f0ff3433f000f33f000003f000000
// 254:444f4444444fff44444fccf4444fcccf4444ffff33444443ff33444400ffffff
// 255:34ff44ff44ff444f4444433ffffffff0cccfccf0fff3ff0044433f00fffff000
// </TILES>

// <SPRITES>
// 000:0ffffff0ffffffffffffffffff3dd3ddff4cf4cfff444444ff44ff43fe342f30
// 001:000000000ffffff0ffffffffffffffffff3dd3ddff4cf4cfff444444ff44ff43
// 002:0f2222f0f333333f23322222232bf3bf234fc4fc23444444ff442f4300344430
// 003:000000000f2222f0f333333f23322222232bf3bf234fc4fc23444444ff442f43
// 004:0fddddf0fddeeedffde3333dde3cf3cfde3cf3cfde333333de33ff31fe233310
// 005:000000000fddddf0fddeeedffde3333dde3cf3cfde3cf3cfde333333de33ff31
// 006:00ffff000f2222f0f233333ff3feffefff3ff3fff23333300232cc3000233320
// 007:0000000000ffff000f2222f0f233333ff3feffefff3ff3fff23333300232cc30
// 008:75ffff5755755775f7555557f757c3d7f77cf4cff74444440f442f4300342430
// 009:0000000075ffff5755755775f7555557f757c3d7f77cf4cff74444440f442f43
// 010:ef0000f0eefffffff2feeeef0fe34e340ee4fe4f0fe34e340eeeeeee00feeeef
// 011:ef0000f0eefffffff2feeeef0fe34e340ee4fe4f0fe34e340eeeeeee00feeeef
// 012:00dddd000dccccd0dccccccddcfcccfddcfcccfcdc444444dcc3333d0dccccd0
// 013:0000000000dddd000dccccd0dccccccddcfcccfddcfcccfcdc444444dcc3333d
// 014:88888888899999998993333389311311894cf4cf894444448f422c4300344430
// 015:0000000088888888899999998993333389311311894cf4cf894444448f422c43
// 016:0f7777f0f766676f766666334466673344799980fe998998fef80fee0f0000ff
// 017:fe342f300f7777f00f6666f00f744700007448000f9999800ff99f0000feeef0
// 018:0f9999f0f9aab9af9aaaba3344aab93344922210dc221221dcd10dcc0d0000dd
// 019:003444300f9999f00faabaf00f944900009441000f2222100ff22f0000feeef0
// 020:012223321222244412222114122212241221222411f12224feeffeee0fef0fef
// 021:ee2333101222233212222444122211141221222411f1222400fef22400feeff0
// 022:0f1111f0f111411f1111412233114f2233feeef0dceefeefdcdf0dcc0d0000dd
// 023:002333200f1111f00f1114f00f13340000133f000d2222f00fd22d0000dcccd0
// 024:0faaaaf0fabbbaafabbbbb3344aaaa3344abbba0f2aaaa2ff2f00f220f0000ff
// 025:003424300faaaaf00fbbbbf00fa44af0faa44baf0faaaaf00ff22f0000f222f0
// 026:0feefffffeffeeffffeeffeeefeeffee00ffeef0ffeefeeffeff0fee0f0000ff
// 027:0fefffff0ffeefee0ffeefeeefeffeff0eeeeef00feeeef00ffeeff000feeef0
// 028:00dccd0000dccd00ddccccd0dccccccddccdcccd3ddcccd333dddd3303000033
// 029:0dccccd0ddccccd0dccccccddccdcccd0ddcccd000dddd000003030000333330
// 030:0fefcff0feefcfefeeeefe3344feff3344ff4ff0feeefeeffeff0fee0f0000ff
// 031:003444300ffefcf00feefcf00fe44e0000e44f000feffef00ffeef0000feeef0
// 032:0000000000000000000000000000000000000005000000560000000600000006
// 033:0000000000000000000000000000000050000000670000006700000067000560
// 035:0000000000000000000000000000000000000000000000000700000077000000
// 036:000ff00000fa9f0000fa9f0000ffff000faaa9f00faaa9f00faaa9f00faaa9f0
// 046:00000000000000000000000000000000000000000000000000dddd000dccccd0
// 047:000000000000000000000000000000000000000000dddd000dccccd00dcfcfd0
// 048:5555600666666667077666660007777700000666000056660056666605666667
// 049:6770566667756670777667007757700075666000676666007176670011066770
// 050:0000000700000076000000660000006600007766000067660000f66700000607
// 051:660000006770000077770000607f0000777700007677f0006667f00066677000
// 052:0fa999f00ffffff00fccccf000ffff0000fa9f0000fa9f0000fa9f0000fa9f00
// 053:0000000000dddd000d2222d0d22cc22dd2cccc2dd2cccc2dd22cc22d0d2222d0
// 054:000ff00000f44f0000f44f000f4ff4f0ff4ff4fff444444ff44ff44ff444444f
// 062:0dcfcfd00dcfcfd00dcc444000dd33000dccccd0ddccdcd03cddcc3303dddd30
// 063:0dcfcfd00dcc444000dd33000dccccd0ddccdcd0dcddccd00dddddd000332300
// 064:5666677266677032677000320700003300000322000003210000032100000321
// 065:2107677011007770110077002000070010000000100000001000000010000000
// 066:0000777600077677000766770007666707676666077667770fff66ffff066606
// 067:6677f7001667777066677f70667ffff0666ff0f0777f77f067777f7f677777ff
// 068:00fa9f0000fa9f0000fa9f0000fa9f0000fa9f0000fa9f0000fa9f0000fa9f00
// 069:00dddd0000feef0000fdef0000fdef0000fdef0000fdef0000fdef0000fdef00
// 070:0ffffff000feef0000fdef0000fdef0000fdef0000fdef0000fdef0000fdef00
// 080:0000033200003221000032110000321100003211000001110000000000000000
// 081:1000000010000000100000001000000010000000000000000000000000000000
// 082:0ff7767700ff77770000ffff0000000100000001000000110000000100000000
// 083:7ff7fff0777ffff0fffff0001100000011000000111000001100000000000000
// 084:00fa9f0000fa9f000fa999f00faffff00faa99f00faaa9f00faa99f000ffff00
// 085:00fdef0000fdef0000fdef0000fdef0000fdef000fdddef00fddeef000ffff00
// 086:00fdef0000fdef0000fdef0000fdef0000fdef000fdddef00fddeef000ffff00
// 087:0000003300000322000003330000032100000321000000110000000000000000
// 088:2000000022000000210000001100000011000000100000000000000000000000
// 096:000fffff00f1222200f121110f9122220f912222f9912222f9a12222f9a12222
// 097:ffffffff22222222111111112222222222222222222222222222222222222222
// 098:fffff00022222f0011122f0022222ff022222f9f22222f9f22222f9a22222faa
// 099:000000000000000000000000000000000000000000000000f00000001ffff000
// 100:00000000000fffff00f1222200f121110f9122220f912222f9912222f9a12222
// 101:00000000ffffffff222222221111111122222222222222222222222222222222
// 102:00000000fffff00022222f0011122f0022222ff022222f9f22222f9f22222f9a
// 103:00000000000000000000000000000000000000000000000000000000f0000000
// 104:000000000000000f00ee00ee0eeefeeeeeddeece0dddecfe0000ecfe0000eccc
// 105:00000000f0000000ef000000ee000000ece00000cfe00000cf000000cc330000
// 106:0000000f00ee00ee0eeefeeeeeddeece0dddecfe0000ecfe0000eccc0000eccc
// 107:f0000000ef000000ee000000ece00000cfe00000cf000000cc330000cc300000
// 108:0ee00fffeeee00ee0ddefeee00ddeece000decfe0000ecfc0000ecc10000ec11
// 109:f0000000ef000000ce330000fc300000fcc00000c11000c01110c00c11100c0c
// 110:0ee00fffeeee00ee0ddefeee00ddeece000decfe0000ecfe0000eccc0000eccc
// 111:f0000000ef000000ee000000ece00000cfe00000cf000000cc330c00cc30c0c0
// 112:faa12111faa12222fba11111fb911222fa912ffff912f999f912f9aaf12f9ba9
// 113:11111111222222221111111122221222ff212fff9f212f99f212f99af212f9ba
// 114:11122fab22222fabffffffab2222219affff221a9999f221aa99f121a99f1221
// 115:12222ff01222211f122222141222221c1222221c1222221c1222221f1222221f
// 116:f9a12222faa12111faa12222fba11111fb911222fa912ffff912f999f912f9aa
// 117:2222222211111111222222221111111122221222ff212fff9f212f99f212f99a
// 118:22222faa11122fab22222fabffffffab2222219affff221a9999f221aa99f121
// 119:1ffff00012222ff01222211f122222141222221c1222221c1222221c1222221f
// 120:0000eccc0000ec2200000e22000000f30000000f000000000000000000000000
// 121:cc3000002f00000012f000002120000032f00000ff0000000000000000000000
// 122:0000ec2200000e2200000f22000000f3000000f30000000f0000000000000000
// 123:2f00000012f0000012f0000012f000002f000000f00000000000000000000000
// 124:0000ec2100000e2200000fee000000fe0000000f000000000000000000000000
// 125:21000c0c12f0c00c31f000c0ddf00000ff000000000000000000000000000000
// 126:0000ec1100000eee00000fee000000ff00000000000000000000000000000000
// 127:dd00c0c0eef00c00ff000000f000000000000000000000000000000000000000
// 128:f12cccccf2222222f2fff222f1111ffff122ffddf111fdcf0fffffed000000ff
// 129:c212cccc221222222212fff2fff11111ddff2222fedf1111ddffffffff000000
// 130:cccc1212222211222222222211111fff2222ffdd1111fdcfffffffed000000ff
// 131:2111111f2222221f2222221cfff1111cddff2214fedf1114ddfffff0ff000000
// 132:f12f9ba9f12cccccf2222222f2fff222f111fffff122fdcff111ffed0fffffff
// 133:f212f9bac212cccc221222222212fff2ffff1111fedf2222ddff1111ffffffff
// 134:a99f1221cccc121222221122222212221111ffff2222fdcf1111ffedffffffff
// 135:1222221f2111111f2222221f2222221cffff111cfedf2214ddff1114fffffff0
// 144:000fffff00f1222200f121110f9122220f912222f9912222f9a12222f9f12222
// 145:ffffffff22222222111222212221111122222222211122222222221122111112
// 146:fff00000222ff0001112ff0022222ff022222f9f12222f9f11122fcc2222ffac
// 147:000000000000000000000000000000000000000000000000f0000000fffff000
// 148:00000000000fffff00f1222200f121110f9122220f912222f9912222f9a12222
// 149:00000000ffffffff222222221112222122211111222222222111222222222211
// 150:00000000fff00000222ff0001112ff0022222ff022222f9f12222f9f11122fcc
// 151:00000000000000000000000000000000000000000000000000000000f0000000
// 160:fff12111fff12222fbf11111fb911222fa912ffff912f999f912f9aaf12f9ba9
// 161:11122211222222221111111122221222ff212aff9f212ffff212aafff212aaaf
// 162:111fffab22ff11ccff1111ac2221119affaf221afffaa221fffff121ffcf1221
// 163:1222ff0012222f00122211f0121112f012222210122222101221111f1222211f
// 164:f9f12222fff12111fff12222fbf11111fb911222fa912ffff912f999f912f9aa
// 165:2211111211122211222222221111111122221222ff212aff9f212ffff212aaff
// 166:2222ffac111fffab22ff11ccff1111ac2221119affaf221afffaa221fffff121
// 167:fffff0001222ff0012222f00122211f0121112f012222210122222101221111f
// 176:f12cccccf2222222fffff2220f111fff00f2ffdd00fffdcf0000ffed000000ff
// 177:c212cccc221222222212fff2fff11111ddff2221fedf1111ddffffffff000000
// 178:cccc1212221111121112111222211fff1221ffdd1111fdcfffffffed000000ff
// 179:2111111f222222f0222222f0fff11ff0ddff2f00fedfff00ddffff00ff000000
// 180:f12f9ba9f12cccccf2222222fffff2220f111fff00f21dcf00ffffed000000ff
// 181:f212aaafc212cccc221222222212fff2fff11111fedf1111ddffffffff000000
// 182:ffcf1221cccc1212221111121112111222211fff1111fdcfffffffdd000000ff
// 183:1222211f2111111f222222f0222222f0fff11ff0fedf2f00ddffff00ff000000
// 192:000fffff00f1222200f121110f1122220ff12222f1f11222f1f11122f1fff112
// 193:ffff0000222ff0001112f0002221f000222221ff211111212221221122111111
// 194:00000000000000000000000000000000fffffffff1111f1ff1111f1cf111ff1c
// 195:000000000000000000000000000000000000000000000000f0000000fff00000
// 196:00000000000fffff00f1222200f121110f1122220ff12222f1f11222f1f11122
// 197:00000000ffff0000222ff0001112f0002221f000222221ff2111112122212211
// 198:0000000000000000000000000000000000000000fffffffff1111f1ff1111f1c
// 199:00000000000000000000000000000000000000000000000000000000f0000000
// 208:f1f1f111f9f1ff11f9f1ff11f9fff222f9112ffff912f9cff912f9cff12f9bcc
// 209:111211111122211f1111111f2222ff1fff21ff1fff21f11ff21ff11ff21ff11f
// 210:fffffffbf2ff111cff11111cff21111affff221afffff221fffff121ffff1221
// 211:122f000012222f00122111f01211ddf01211dd10121fdd1012ddd00012fff000
// 212:f1fff112f1f1f111f9f1ff11f9f1ff11f9fff222f9112ffff912f9cff912f9cf
// 213:22111111111211111122211f1111111f2222ff1fff21ff1fff21f11ff21ff11f
// 214:f111ff1cfffffffbf2ff111cff11111cff21111affff221afffff221fffff121
// 215:fff00000122f000012222f00122111f01211ddf01211dd10121fdd1012ddd000
// 224:f12cccccf2222222fffff2220f111ffe00f2ffdd00ffffcf0000fffd000000ff
// 225:c21ff1ff221f11ff221ff111dff1fffffdfffffffedf1111ddffffffff000000
// 226:ffff1212ffff1112111f1112fff11ffffff1ffdd1111fdcfffffffdd000000ff
// 227:21ddd100222222f0222222f0eef11ff0ddff2f00fedfff00ddffff00ff000000
// 228:f12f9bccf12cccccf2222222fffff2220f111fff00f2fdcf00fffeee000000ff
// 229:f21ff11fc21ff1ff221f11ff221ff111fff1fffffedfffffddff1111ffffffff
// 230:ffff1221ffff1212ffff1112111f1112fff11ffffff1fdcf1111ffedffffffee
// 231:12fff00021ddd100222222f0222222f0fff11ff0feff2f00dfffff00ffffff00
// 240:0000000000000000000000000000000000d000000000d0000000000000000000
// 241:00000000000000000000000000e000000ed0000000e0d00000000e0000000000
// 242:000000000000000000ee00000ee000000ed0e00000edde00000ede000000e000
// 243:0000000000fe00000feef000fee0dff0fedfefe00feddef00ffede00000fe000
// 254:00cdde0000ddee0000ddee00cdddeeddddddeeef0edddef000edef00000ef000
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
// 020:040404040404040404040404040404040404040404040404040404040404263626362636263626366474040404040404657526362636263626362636263626362636647404040404040404040404040404046575263626362636040404040404040404040404040404040404040404040404040404040404263626362636263626366474040404040404657526362636263626362636040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404263626362636647404040404657526362636263626362636263626362636
// 021:040404040404040404040404040404040404040404040404040404040404273727372737253525352535647404046575253525352535273727372737273725352535253564740404040404040404040465752535253525352737040404040404040404040404040404040404040404040404040404040404273727372737253525352535647404046575253525352535273727372737040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404273725352535253564746575253525352535273727372737273727372737
// 022:001000100010001000100010001000100010001000100010001000100010001000100010465625352636263626362636263625354757001000100010001046562535263626362636647404146575263626362636253547570010001000100010001000100010001000100010001000100010001000100010001000100010465625352636263626362636263625354757001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001046562535263626362636263625354757001000100010001000100010
// 023:011101110111011101110111011101110111011101110111011101110111011101110111011146562737273727372737273747570111011101110111011101114656273725352535253564752535253525352737475701110111011101110111011101110111011101110111011101110111011101110111011101110111011146562737273727372737273747570111011101110111011101110111011101110313031303130313031301110111011101110111011101110111011101110111011101110111011101110111011101110111011101114656273727372737273747570111011101110111011101110111
// 024:203020302030203020302030203020302030203020302030203020302030203020302030203020300010001000100010001020302030203020302030203020302030001046562535263626362636253547570010203020302030203020302030203020302030021202120212203020302030203020302030203020302030203020300010001000100010001020302030203020302030203020302030203045552434243424342434243444542030203020302030203020302030203020302030203020302030203020302030203020302030203020302030001000100010001020302030203020302030203020302030
// 025:213121312131213121312131213121312131213121312131213121312131213121312131213121310111011101110111011121312131213121312131213121312131011101114656273727372737475701110111213121312131213121312131213121312131031303130313213121312131213121312131213121312131213121310111011101110111011121312131213121312131213121312131213146562737273727372737273747572131213121312131213121312131213121310313031303130313031321312131213121312131213121312131011101110111011121312131213121312131213121312131
// 026:203020302030203020300212021202120212021220302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030001000100010203020302030203020302030203020302030021202124555243424342434445402120212203020302030203020302030203020300212021202120212021220302030203020302030203020302030203020300010001000100010001020302030203020302030203020302030203045552434243424342434243444542030203020302030203020302030203020302030203020302030021202120212021220302030
// 027:213121312131213121310313031303130313031321312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131011101110111213121312131213121312131213121312131031345552535253525352535253544540313213121312131213121312131213121310313031303130313031321312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213146562737273727372737273747572131213121312131213121312131213121312131213121312131031303130313031321312131
// 028:021202120212021245552434243424342434243444540212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202124555243425352535253567762535253525352434445402120212021202120212021245552434243424342434243444540212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120010001000100010001002120212021202120212021202120212021202120212021202124555243424342434243444540212
// 029:031303130313455525352535253525352535253525354454031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031345552535253525352535677705156676253525352535253544540313031303130313455525352535253525352535253525354454031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031345552535253525352535253525354454
// 030:243424342434253525352535677704046676253525352535243424342434253567770404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404243425352535253567770404040404040404040466762535253525352434243424342434253525352535677704046676253525352535243424342434040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404243424342434243424342434243425352535253567776676253525352535
// 031:253525352535253525356777040404040404667625352535253525352535677704040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404253525352535677704040404040404040404040404046676253525352535253525352535253525356777040404040404667625352535253525352535040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404253525352535253525352535253525352535677704040404667625352535
// 032:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 033:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 034:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 035:040404040404040404040404040404040404040404040404040404040404040404040404657526362636263626362636263626366474040404040404040404040404040404040404040404040404040404040404040404040404040404040404657526362636263626362636263626366474040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 036:040404040404040404040404040404040404040404040404040404040404040404046575253525352535273727372737253525352535647404040404040404040404040404040404040404040404040404040404040404040404040404046575253525352535273727372737253525352535647404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 037:263626362636263626362636263626362636647404040404657526362636263626362636263625354757001000100010465625352636263626362636040404040404040404040404040404040404040404040404040404040404263626362636263625354757001000100010465625352636263626362636263626366474040404040404040404040404040404040404657526362636040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 038:273727372737273727372737273725352535253564746575253525352535273727372737273747570111011101110111011146562737273727372737040404040404040404040404040404040404040404040404040404040404273727372737273747570111011101110111011146562737273727372737253525352535647404040404040404040404040404046575253525352737040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 039:001000100010001000100010001046562535263626362636263625354757001000100010001020302030203020302030203020300010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001002120212021202120212021202120010001000100010465625352636263626362636647404140404657526362636263625354757001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010
// 040:011101110111011101110111011101114656273727372737273747570111011101110111011121312131213121312131213121310111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011146562737273725352535253564746575253525352737273747570111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111
// 041:203020302030203020302030203020302030001000100010001020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030021202120212203020302030203020302030203020300010001046562535263626362636253547570010001020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030
// 042:213121312131213121312131213121312131011101110111011121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131031303130313213121312131213121312131213121310111011101114656273727372737475701110111011121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131
// 043:203020302030021202120212021220302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020300212021202124555243424342434445402120212203020302030203020302030203020302030001000100010203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030
// 044:213121312131031303130313031321312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121310313031345552535253525352535253544540313213121312131213121312131213121312131011101110111213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131
// 045:021202124555243424342434243444540212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021245552434243425352535253567762535253525352434445402120212021202120212021220302030203020302030203020300212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212
// 046:031345552535253525352535253525354454031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313011101110111011101110111011101110313031303130313455525352535253525352535677705156676253525352535253544540313031303130313031321312131213121312131213121310313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313
// 047:243425352535253567776676253525352535243424342434243424342434040404040404040404040404040404040404040404040404667626362434243424342434445402120212021202120212021245552434243424342434253525356777040404040404040404040404040466762535253525352434243424342434243444540212021202120212021245552434243424342434040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 048:253525352535677704040404667625352535253525352535253525352535040404040404040404040404040404040404040404040404040466762535253525352535253544540313031303130313455525352535253525352535253567770404040404040404040404040404040404046676253525352535253525352535253525354454031303130313455525352535253525352535040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 049:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040466762535253525352434243424342434253525352535677704040404040404040404040404040404040404040404040404040404040404040404040404046676253525352535243424342434253525352535677704040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 050:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404046676253525352535253525352535253525356777040404040404040404040404040404040404040404040404040404040404040404040404040404040404667625352535253525352535253525356777040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 051:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 052:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 053:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 054:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404657526362636263626362636263626366474040404040404
// 055:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404046575253525352535273727372737253525352535647404040404
// 056:040404040404040404040404040404040404040404040404040404040404263626362636263626366474040404040404657526362636263626362636263626362636263626366474041404140414657526362636263626362636263626362636647404040404040404040404040404046575263626362636040404040404040404040404040404040404040404040404040404040404263626362636647404046575263626362636263626362636263626362636263626362636263626362636263626362636647404046575263626362636263626362636263625354757001000100010465625352636263626362636
// 057:040404040404040404040404040404040404040404040404040404040404273727372737253525352535647404046575253525352535273727372737273727372737253525352535647405156575253525352535273727372737273725352535253564740404040404040404040465752535253525352737040404040404040404040404040404040404040404040404040404040404273725352535253564752535253525352737273727372737273727372737273727372737273727372737273725352535253564752535253525352737273727372737273747570111011101110111011146562737273727372737
// 058:001000100010001000100010001000100010001000100010001000100010001000100010465625352636263626362636263625354757001000100010001000100010465625352636263626362636263625354757001000100010001046562535263626362636647404146575263626362636253547570010001000100010001000100010001000100010001000100010001000100010001046562535263626362636253547570010001000100010001000100010001000100010001000100010001046562535263626362636253547570010001000100010001002120212021202120212021202120010001000100010
// 059:011101110111011101110111011101110111011101110111011101110111011101110111011146562737273727372737273747570111011101110111011101110111011146562737273727372737273747570111011101110111011101114656273725352535253564752535253525352737475701110111011101110111011101110111031303130313011101110111011101110111011101114656273727372737475701110111011101110111011101110111011101110111011101110111011101114656273727372737475701110111011101110111011101110111011101110111011101110111011101110111
// 060:203020302030203020300212021202120212021220302030203020302030203020302030203020300010001000100010001020302030203020302030203020302030203020300010001000100010001020302030203020302030203020302030001046562535263626362636253547570010203020302030203020302030021202124555243424342434445402120212203020302030203020302030001000100010203020302030021202120212203020302030203020302030021202120212203020302030001000100010203020302030203020302030203020302030203020302030203020302030203020302030
// 061:213121312131213121310313031303130313031321312131213121312131213121312131213121310111011101110111011121312131213121312131213121312131213121310313031303130313031321312131213121312131213121312131011101114656273727372737475701110111213121312131213121312131031345552535253525352535253544540313213121312131213121312131011101110111213121312131031303130313213121312131213121312131031303130313213121312131011101110111213121312131213121312131213121312131213121312131213121312131213121312131
// 062:021202120212021245552434243424342434243444540212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021245552434243424342434243444540212021202120212021202120212021202120212001000100010021202120212021202120212021202124555243425352535253567762535253525352434445402120212021202120212021202120212021202124555243424342434445402120212021202124555243424342434445402120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212
// 063:031303130313455525352535253525352535253525354454031303130313031303130313031303130313031303130313031303130313031303130313031303130313455525352535253525352535253525354454031303130313031303130313031303130313031303130313031303130313031303130313031345552535253525352535677705156676253525352535253544540313031303130313031303130313031345552535253525352535253544540313031345552535253525352535253544540313031303130313031303130313031303130313031303130313031303130313031303130313031303130313
// 064:243424342434253525352535677704046676253525352535243424342434040404040404040404040404040404040404040404040404040404040404243424342434253525352535677704046676253525352535243424342434040404040404040404040404040404040404040404040404040404040404243425352535253567770404040404040404040466762535253525352434243424342434243424342434243425352535253567762535253525352434243425352535253567762535253525352434243424342434243424342434040404040404040404040404040404040404040404040404040404040404
// 065:253525352535253525356777040404040404667625352535253525352535040404040404040404040404040404040404040404040404040404040404253525352535253525356777040404040404667625352535253525352535040404040404040404040404040404040404040404040404040404040404253525352535677704040404040404040404040404046676253525352535253525352535253525352535253525352535677704046676253525352535253525352535677704046676253525352535253525352535253525352535040404040404040404040404040404040404040404040404040404040404
// 066:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 067:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 068:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 069:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 070:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 071:040404040404040404040404040404040404040404040404040404040404040404040404657526362636263626362636263626366474040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 072:040404040404040404040404040404040404040404040404040404040404040404046575253525352535273727372737253525352535647404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 073:040404040404040404040404040404040404040404040404040404040404263626362636263625354757001000100010465625352636263626362636263626366474040404040404040404040404040404040404657526362636040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 074:040404040404040404040404040404040404040404040404040404040404273727372737273747570111011101110111011146562737273727372737253525352535647404040404040404040404040404046575253525352535040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 075:001000100010001000100010001000100010001000100010001000100010001000100010001002120212021202120212021202120010001000100010465625352636263626362636647404146575263626362636263625354757001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010
// 076:011101110111011101110111011101110111011101110111011101110111011101110111011101112131031303130313011101110111011101110111011146562737273725352535253564752535253525352737273747570111011101110111011101110313031303130313031301110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111
// 077:203020302030203020302030203020302030203020302030203020302030203020300212021202124555243424342434445402120212021220302030203020300010001046562535263626362636253547570010001020302030203020302030203045552434243424342434243444542030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030203020302030
// 078:213121312131213121312131213121312131213121312131213121312131213121310313031345552535253525352535253544540313031321312131213121310111011101114656273727372737475701110111011121312131213121312131213146562737273727372737273747572131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131213121312131
// 079:021202120212021202120212021202120212021202120212021202120212021245552434243425352535253567762535253525352434243444540212021202120212021202120212001000100010021202120212021202120212021202120212021202120010001000100010001002120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212
// 080:031303130313031301110111011101110111011101110313031303130313455525352535253525352535677705156676253525352535253525354454031303130313031301110111011101110111011101110313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313
// 081:243424342434243444540212021202120212021245552434243424342434253525352535677704040404040404040404040404046676253525352535243424342434243444540212021202120212021245552434243424342434040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 082:253525352535253525354454031303130313455525352535253525352535253525356777040404040404040404040404040404040404667625352535253525352535253525354454031303130313455525352535253525352535040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 083:040404046676253525352535243424342434253525352535677704040404040404040404040404040404040404040404040404040404040404040404040404046676253525352535243424342434253525352535677704040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 084:040404040404667625352535253525352535253525356777040404040404040404040404040404040404040404040404040404040404040404040404040404040404667625352535253525352535253525356777040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 085:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 086:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040465752636263626362636263664740404040404040404040404040404040404040404040404040404040404040404040404040404
// 087:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404657525352535253527372535253525356474040404040404040404040404040404040404040404040404040404040404040404040404
// 088:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040465752636263626362636263664740404040404040404040404040404040404040404040404040404040404040404040404040404040404046575263626362535475700104656253526362636647404040404040404040404040404040404040404040404040404040404040404040404
// 089:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404657525352535253527372535253525356474040404040404040404040404040404040404040404040404040404040404040404040404040465752535253525354757011101110111465625352535253564740404040404040404040404040404040404040404040404040404040404040404
// 090:263626362636263626362636263626362636263626362636263626362636263626362636263664740404040404040404040465752636263626362636263626362636647404046575263626362636263626362636263626362636263626362636647404046575263626362636263626362636263626362636263626362636263626362535475700104656253526362636263626362636263626362636263626362636263626362636263626362636263626362636263626362636253547570212021202120212021246562535263626362636263626362636263626362636263626362636263626362636263626362636
// 091:273727372737273727372737273727372737273727372737273727372737273727372535253525356474040404040404657525352535253527372737273725352535253564752535253525352737273727372737273727372737273725352535253564752535253525352737273727372737273727372737273727372737273727374757011101110111465627372737273727372737273727372737273727372737273727372737273727372737273727372737273727372737475701110111011101110111011101114656273727372737273727372737273727372737273727372737273727372737273727372737
// 092:001000100010001010100010001000100010001000100010001000100010001000104656253526362636263626362636263626362535475700100010001046562535263626362636253547570010001000100010001000100010001046562535263626362636253547570010001000100010001000100010001000100010001000100212021202120212021200100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010021202120212021202120212021202120212001000100010001000100010001000100010001000100010001000100010001000100010
// 093:011101110111011113130313031303130313031303130111011101110111011101110111465627372737273727372737273727374757011101110111011101114656273727372737475701110111031303130313011101110111011101114656273727372737475701110111031303130313011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111
// 094:021202120212455524342434243424342434243424344454021202120212021202120212021200100010001000100010001000100212021202120212021202120212001000100010021202124555243424342434445402120212021202120212001000100010021202124555243424342434445402120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212
// 095:031303134555253525352535253525352535253525352535445403130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031345552535253525352535253544540313031303130313031303130313031345552535253525352535253544540313031303130313031303130313031303130313031303130313031303130313031303130313031303130111011101110111011103130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313011101110111011101110111011101110111031303130313
// 096:243424342535253525356777040404040404667625352535253524342434243424342434243424342434243424342434243424342434243424342434243424342434243424342434243425352535253567762535253525352434243424342434243424342434243425352535253567762535253525352434243424342434243424342434243424342434243424342434243424342434243424342434243424344454021202120212455524342434243424342434243424342434243424342434243424342434243424342434243424342434243424342434445402120212021202120212021202124555243424342434
// 097:253525352535253567770404040404040404040466762535253525352535253525352535253525352535253525352535253525352535253525352535253525352535253525352535253525352535677704046676253525352535253525352535253525352535253525352535677704046676253525352535253525352535253525352535253525352535253525352535253525352535253525352535253525352535445403134555253525352535253525352535253525352535253525352535253525352535253525352535253525352535253525352535253544540111011101110111011145552535253525352535
// 098:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404667625352535253524342535253525356777040404040404040404040404040404040404040404040404040404040404040404040404040466762535253525354454021202120212455525352535253567770404
// 099:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040466762535253525352535253567770404040404040404040404040404040404040404040404040404040404040404040404040404040404046676253525352535445403134555253525352535677704040404
// 100:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404667625352535253524342535253525356777040404040404
// 101:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040466762535253525352535253567770404040404040404
// 102:040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 103:040404040404040465752636263626362636263664740404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040465752636263626362636263664740404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 104:040404040404657525352535253527372535253525356474040404040404040404040404040404040404040404040404040404040404040404040404040404040404657525352535253527372535253525356474040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 105:040404046575263626362535475700104656253526362636647404040404040404040404040404040404040404040404040404040404040404040404040465752636263626362535475700104656253526362636263664740404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 106:040465752535253525354757011101110111465625352535253564740404040404040404040404040404040404040404040404040404040404040404657525352535253527374757011101110111465627372535253525356474040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 107:263626362636253547570212021202120212021246562535263626362636263626362636263626366474040404040404657526362636263626362636263626362535475700100212021202120212021200104656253526362636263626362636263664740404040404040404040465752636263626362636263626362636263626362636263626362636263626362636263626362636263626362636263626362636263626362636263626362636263626362636263626362636263626362636263626362636263626362636263626362636263626362636263626362636263626362636263626362636263626362636
// 108:273727372737475701110111011101110111011101114656273727372737273727372737253525352535647404046575253525352535273727372737273727374757011101110111011101110111011101110111465627372737273727372535253525356474040404040404657525352535253527372737273727372737273727372737273727372737273727372737273727372737273727372737273727372737273727372737273727372737273727372737273727372737273727372737273727372737273727372737273727372737273727372737273727372737273727372737273727372737273727372737
// 109:001000100010021202120212021202120212021202120212001000100010001000100010465625352636263626362636263625354757001000100010001000100212021245552434243424342434243444540212021200100010001000104656253526362636647404046575263626362535475700100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010
// 110:011101110111011101110313031303130313031301110111011101110111011101110111011146562737273727372737273747570111011101110111011101110111455525352535253525352535253525354454011101110111011101110111465625352535253564752535253525354757011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111
// 111:021202120212021245552434243424342434243444540212021202120212021202120212021202120010001000100010001002120212021202120212021202124555253525352535677704046676253525352535445402120212021202120212021246562535263626362636253547570212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120212
// 112:031303130313455525352535253525352535253525354454031303130313031303130313011101110111011101110111011101110111031303130313031345552535253525356777040404040404667625352535253544540313031303130111011101114656273727372737475701110111011103130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313031303130313
// 113:243424342434253525352535677704046676253525352535243424342434243424342434445402120212021202120212021202124555243424342434243425352535253567770404040404040404040466762535253525352434243424344454021202120212001000100010021202120212455524342434243424342434243424342434243424342434243424342434243424342434243424342434243424342434243424342434243424342434243424342434243424342434243424342434243424342434243424342434243424342434243424342434243424342434243424342434243424342434243424342434
// 114:253525352535253525356777040404040404667625352535253525352535253525352535253544540111011101110111011145552535253525352535253525352535677704040404040404040404040404046676253525352535253525352535445403130111011101110111011103134555253525352535253525352535253525352535253525352535253525352535253525352535253525352535253525352535253525352535253525352535253525352535253525352535253525352535253525352535253525352535253525352535253525352535253525352535253525352535253525352535253525352535
// 115:040404040404040404040404040404040404040404040404040404040404040466762535253525354454021202120212455525352535253567770404040404040404040404040404040404040404040404040404040404040404667625352535253524344454021202120212455524342535253525356777040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 116:040404040404040404040404040404040404040404040404040404040404040404046676253525352535445403134555253525352535677704040404040404040404040404040404040404040404040404040404040404040404040466762535253525352535445403134555253525352535253567770404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 117:040404040404040404040404040404040404040404040404040404040404040404040404667625352535253524342535253525356777040404040404040404040404040404040404040404040404040404040404040404040404040404040404667625352535253524342535253525356777040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
// 118:040404040404040404040404040404040404040404040404040404040404040404040404040466762535253525352535253567770404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040466762535253525352535253567770404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
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
// 007:0000000000000789abffffffffffffff
// 008:0000000000000000ffffffffffffffff
// 009:0000000000000005bfffffffffffffff
// </WAVES>

// <SFX>
// 000:02000200020002001200320042004200520052007200720092009200a200a200c200d200e200e200f200e200e200e200e200e200e200e200e200e200470000000000
// 001:030033708300c300d300e300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300255000000200
// 002:06000600060006000600160026002600360046006600760086009600a600d600f600f600f600f600f600f600f600f600f600f600f600f600f600f600105000000000
// 003:04073402640f840ea40dd40ce40cf40bf408f408f408f408f408f408f408f408f408f408f408f408f408f408f40af409f40af409f40af400f400f400a00000000000
// 004:8367335703451355136333514301530f630e730d830c930b930aa30aa30ab309c308c308d308d308d308e308e308e308f308f308f308f308f308f308400000000600
// 005:d400d400d400c400c400d400d400d400e400e400d400d400c400c400d400c400d400f400f400f400e400b400a400a400a400a400b400c400d400e4004000000f0000
// 006:0800080018001800180038405840584058406800680068007800887088709870987098709870a870b870b870c870d870f870f870f870f870f870f870500000000000
// 007:060006000600f600f600f6000670067006700670067016701670167016701670167016702670267036703670367046705670f670f670f670f670f6702f5000000000
// 008:4800010001001100110021002100310041004100510051006100710081008100a100a100b100b100c100c100d100d100d100e100e100e100e100f100770000000000
// 009:0407340364018400a40ea40d5406540464028400940fa40eb40d94058404840394019400a40eb40d94039401a40fb40ec40dc40ed40fe40ee40ef40db60000000000
// 010:4800270308040806080708070807080708060806080508031802280038004800580f580e680d780c880ba80bb80ab80ac80ad809e809e808e808f808c12011000000
// 048:04002100410f610f910ee10ef10df10df10df10df10df10df10df10df10df10df10df10df10df10df10df10df10df10df10df10df10df10df10df10dc0b000000000
// 049:64008400b400e400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400604000000000
// 050:1400640fa40ef40df40cf40bf409f408f408f408f409f409f408f408f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400b00000000000
// 051:0400440074009400a400b400d400e400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400300000000000
// 052:040046006600760fa60fc60ee60ee60ee60df60df60cf60cf60cf60bf60bf60bf60df60df60df60df60df60cf60cf60cf60cf60cf60cf60cf60cf60c300000000000
// 053:040045008500a50fe50ff50ef50ef50ef50df50df50cf50cf50cf50bf50bf50bf50df50df50df50df50df50cf50cf50cf50cf50cf50cf50cf50cf50c105000000000
// 054:64008400b400e400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400604000030000
// 055:f400f400f400040f450f950ef50ef50ef50df50df50cf50cf50cf50bf50bf50bf50df50df50df50df50df50cf50cf50cf50cf50cf50cf50cf50cf50c402000000000
// 056:06000100010001000100110011001100110021002100310051006100610071007100810081009100a100a100b100c100c100d100e100f100f100f100300000000000
// 057:27005700670077008700870087009700a700a700b700b700b700b700b700c700d700d700e700f700f700f700f700f700f700f700f700f700f700f700400000000000
// 058:0580257005502500250025004500650075008500850095009500950095009500950095009500a500950095009500a500a500b500c500c500d500e500605000000300
// 059:47005700670077008700870087009700a700a700b700b700b700b700b700c700d700d700e700f700f700f700f700f700f700f700f700f700f700f70040a000030000
// 060:b90099008900790079006900690079007900890099019902a901a900b90fc90ef90ff900f900f900f900f900f900f900f900f900f900f900f900f900405000f10098
// </SFX>

// <PATTERNS>
// 000:900024100000000000000000400024100000000000000000800024100000000000000000400024100000000000000000900024100000000000000000000000900022000000000000022600000000000000000000000000000000000000000000100000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
// 001:400807000000e0082900000040081f400807000000b0083900000000000040081fb0084300000040081f60084300000040081f400807e0082900000040081f400807000000b0083900000000000040081fe0082900000040081fe00829000000400807000000e0082900000040081f400807000000b0083900000000000040081fb0084300000040081f60084300000040081f400807e0082900000040081f400807000000b0083900000000000040081fe0082900000040081fe00829e00829
// 002:400887100881400887100881800887000000000000b00887100881b00887100881b00887d00887000000b00887000000b00885100881b00885100881f00885000000000881600887100881600887100881600887800887000000600887000000400887100881400887100881800887000000000000b00887100881b00887100881b00887d00887000000b00887000000400887000000000000000000000000000000000000000000000000400887b00885000000d00885000000f00885000000
// 003:400887100881400887100881800887000000000000b00887100881b00887100881b00887d00887000000b00887000000b00885100881b00885100881f00885000000000881600887100881600887100881600887800887000000600887000000b00885100881b00885100881f00885000000000881600887100881600887100881600887800887000000600887000000400887100881400887100881800887000000000000b00887100881b00887100881b00887d00887000000b00887000000
// 004:000000000000800899100891400899000000000000b00899100891b00899100891b00899800899000000400899000000600899000000000000900899000891000000100891000000000000000000000000000000000000000000000000000000100891000000600899100891f00897000000000000900899100891900899100891900899600899000000f00897000000400899000000000000800899000891000000100891000000000000000000000000000000000000000000000000000000
// 005:900887100881900887100881d00887000000000881400889100881400889100881400889600889000000400889000000400887100881400887100881800887000000000000b00887100881b00887100881b00887d00887000000b00887000000b00885100881b00885100881f00885000000000000600887100881600887100881600887800887000000600887000000400887000000000000b00885000000000000400887000000100881400887b00885000000d00885000000f00885000000
// 006:000000000000d0089910089190089900000000000040089b10089140089b10089140089bf00899000000d00899000000b00899000000000000800899000891000000100891000000000000000000000000000000000000000000000000000000000000000000600899100891f00897000000000000900899100891900899100891900899600899000000f00897000000400899000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
// 007:069100000000b0089910089180089900000000000040089b10089140089b10089140089bb00899000000800899000000900899000000000000d00899000891000000100891000000000000000000000000000000000000000000000000000000069100000000900899100891600899000000000000f00899100891f00899100891f00899d00899000000b00899000000800899000000000000b00899000891000000100891000000000000000000000000000000000000000000000000000000
// 008:06910000000040089b100891d0089900000000000092499b10089190089b10089180089b60089b00000046999b000000f00899000000000000b00899000891000000100891000000000000000000000000000000000000000000000000000000069100000000900899100891600899000000000000d9a999100891b00899100891900899800899000000600899000000400899000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
// 009:900887100881900887100881400887000000000881900885100881400887900887000881100000000000b00887000891400887100881400887100881b00887000000000000400887100881b00887100881b00887d00887000000b00887000000b00885100881b00885100881600887000000000000b00887100881b00885b00887000881b00887000000b00885000000400887100891400887100881800887000000000000400887100881400885e00885000000d00885000000b00885000000
// 010:4fa9c90000000000000000009008c9000000000000d008c91008914ff99b10089140089bf00899000891d00899100891bfa9c90000000000000000004008cb0000000000008008c91008918ff99b40089bb0089940089bb00899800899100891ffa9c70000000000000000006008c90000000000009008c9100891dff999100891d00899b008990008919008991008918fa9c90000000000000000004008c9000891000000b008c91008918ff999b0089940089bb0089940089b80089b100891
// 011:1008c10000000000000000001008c10000000000001008c10008c1dff999100891d00899b008990008919008991008911008c10000000000000000001008c10000000000001008c10008c110089185a99b46999bb7899948799bb969998a59991008c10000000000000000001008c10000000000001008c10008c19ff9991008919008998008990008916008991008911008c10000000000000000001008c10000000000001008c10008c11008918a5999b9699948799bb7899946999b85a99b
// 012:900887100881900887100881400887000000000881900885100881400887900887000881100881000000b00887000891400887100881400887100881800887000000000000b00887100881b00887100881b00887d00887000000b00887000000b00887100881b00887100881600887000000000000b00885100881b00885b00887000881d00887000000b00887000000400887100881400887100881100881400887100881400887100881400887b00885000000d00885000000f00885000000
// 013:4fa9c90000000000000000009008c9000000000000d008c91008914ff99b10089140089bf00899000891d00899100891bfa9c90000000000000000004008cb0000000000008008c9100891bff999100891b00899900899000891800899100891bfa9c7000000000000000000f008c70000000000006008c91008919ff9991008919008998008990008916008991008914fa9c91008c14008c91008c11008c14008c91008c14008c9100891100891100891100891100891000891100891100891
// 014:1008c10000000000000000001008c10000000000001008c10008c1d00899100891d00899b008990008919008991008911008c10000000000000000001008c10000000000001008c10008c18008991008918008996008990008914008991008911008c10000000000000000001008c10000000000001008c10008c1600899100891600899400899000891f008971008918008971008918008971008911008c1800897100891800897100881100891100891100891100891000891100891100891
// 015:0008a10000009008ad0000001008a10000000000000000000000000000001008a19008ad0000000000001008a10000008008991008a1800899100891600899700899100891800899000891000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
// 016:40080700000040081f00000040081f000000400807b0085940081f40081fb0084300000040081fb00843400807000000b00843400807b0084300000040081f00000040081fb00843000000000000000000000000000000000000000000000000400807000000e0082900000040081f400807000000e00829000000000000000000e00829000000000000000000000000000000000000e00829000000000000000000000000000000000000000000000000000000000000000000000000000000
// 017:400887000881100881000000b00885000000100881e00885100881e00885b00885000000e00885000000f00885000000b00899400887b00899400887900899a00899400887b00899000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
// 018:00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000040089b10089140089b100891e00899f0089910089140089b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
// 019:b00885000000100881000000b00885100881b00885100881e00885100881e00885000000100881000000f00885000000400887000000100881000000400885000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
// 020:000891000000b00895000000f00895100891600897100891900897000000800897100891600897000000700897000000800897000000100891000000400897000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
// 021:40086f000861000861000861000811000811f0081f000861f0081f000861000000000000f0081f000000f0081f000000f0081f000000000000000000000000f0081ff0081f000000000000000000000000f0081ff0081f000000f0081f00000000000000000000000040086f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f0081f49998d87798db5598df4498d43398ff2298db1198d81198d41198d81198db1198d
// 022:c008b7000000000000000000100891000000000000000000c00897000891100891100891c00897100881c00897000000e00897000891000000100891000000000000c00897000891000000100891100891100891e008970000001008910000000000000000000000004008b9000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000400897000000000000000000000000000000000000000000000000000000000000000000
// 023:4008b90000000000000000001008910000000000000000004008990008911008911008914008991008814008990000006008990008910000001008910000000000004008990008910000001008911008911008916008990000001008910000000000000000000000008008b9000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b00897000000000000000000000000000000000000000000000000000000000000000000
// 024:7008b9000000000000000000100891000000000000000000700899000891100891100891700899100881700899000000900899000891000000100891000000000000700899000891000000100891100891100891900899000000100891000000000000000000000000b008b9000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000400899000000000000000000000000000000000000000000000000000000000000000000
// 025:900887100881900887100881d00887000000000881400889100881400889100881400889600889000000400889000000400887100881400887100881800887000000000000b00887100881b00887100881b00887d00887000000b00887000000b00885100881b00885100881f00885000000000000600887100881600887100881600887800887000000600887000000400887000000000000b00885000000000000400885100881000000400885e00885000000d00885000000b00885000000
// 026:000000000000800899100891400899000000000000b00899100891b00899100891b0089980089900000040089900000060089900000000000090089900089100000010089100000000000090089b60089bf0089960089bf00899b00899000000100891000000600899100891f00897000000000000900899100891900899100891900899600899000000f0089700000040089900000000000080089900089100000010089100000000000080089b40089bb0089940089bb00899800899000000
// 027:00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010089100000000000095a99b66999bf7899968799bf96999ba59990000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008910000001008910000000000008a599b49699bb8799947899bb6999985a999
// 028:000000000000d0089910089190089900000000000040089b10089140089b10089140089bf00899000000d00899000000b00899000000000000800899000891000000100891000000000000b0089b80089b40089b80089b40089bb00899000000000000000000600899100891f00897000000000000900899100891900899100891900899600899000000f00897000000400899400899400899100891000891400899400899400899100891000000000000000000000000000000000000000000
// 029:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100891000000000000b5a99b86999b47899b88799b49699bba5999000000000000000000000000000000000000000000d00899100891b00899100891900899800899000000600899000000400899000000000000800899000000000000400899000891000000000000000000000000000000000000000000000000
// 030:40080700000040081f00000040081f000000400807b0085940081f40081fb0084300000040081fb0084340080700000040080740081f40081f00000040081f00000040081fb0084300000040081fb0084300000040080700000040081f40081f40080700000040081f00000040081f000000400807b0085940081f40081fb0084300000040081fb00843400807000000b00843400807b0084300000040081f00000040081fb0084300000000000000000000000000000000000040081f40081f
// 031:400887000881100881000000b00885000000100881e00885100881e00885b00885000000e00885000000f00885000000400887100891400887100881b00885000000100881e00885100881e00885b00885000000a00885000000b00885000000400887000881100881000000b00885000000100881e00885100881e00885b00885000000e00885000000f00885000000400887100881400887100881e00885400887100881400887100881400887b00885000000e00885000000f00885000000
// 032:433997000881100881000000b00895000000100881e00895100881e00895b00895000000e00895000000f008950000004aa997100891400897000000b00895000000100881e00895100881e00895b00895000000e00895000000f008950000004ff997000881100881000000b00895000000100881e00895100881e00895b00895000000e00895000000f008950000008008991008a1800899100891600899700899100891800899000881000881000881000000000881000000000881000000
// 033:0000000000009008ad0000001008a10000000000000000000000000000000008a19008ad0008a11008a10000000008a10000000000009008ad0000001008a10000000000000000000000000000000000009008ad0008a11008a1000000000000899999000881100881000000e00897000000100881600899100881600899e0089700000060089900000070089900000040089b10089140089b100891e00899f0089910089140089b0000000000006008ad0000006008ad0000001008a1000000
// 034:400887000881100881000000b00885000000100881e00885100881e00885b00885000000e00885000000f00885000000400887100891400887000000b00885000000100881e00885100881e00885b00885000000a00885000000b00885000000400887000881100881000000b00885000000100881e00885100881e00885b00885000000e00885000000f00885000000b00899400887b00899400887900899a00899400887b00899000000000000000000000000e00885000000f00885000000
// 035:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000666979000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000600879000000000000000000000000000000600879000000000000600859600859000000600879000000000000
// 036:000000000000000000000000600859000000000000600859000000600859000000000000600859600859000000000000000000000000600859000000600859000851000000000000600859000000600859000000000000600859000000000000600859600859000000000000600859000000000000600859000000000000000000000000600859000000600859000000000000600859600859000851600859600859000000600859600859000851b66995000000e66995000000f66995000000
// 037:40080700000040081f00000040081f000000400807b0085940081f40081fb0084300000040081fb0084340080700000040080740081f40081f00000040081f00000040081fb0084300000040081fb0084300000040080700000040081f40081f40080700000040081f00000040081f000000400807b0085940081f40081fb0084300000040081fb00843400807000000b00843400807b0084300000040081f00000040081fb0084340081f40081fb0084300000040081fb0084340080740081f
// 038:000000000000800899100891400899000000000000b00899100891b00899100891b008998008990000004008990000006008990000000000009008990008910000001008910000000000009939991008919939999008990008911008910000001008910000006ff999100891f00897000000000000900899100891900899100891900899600899000000f00897000000400899000000000000800899000891000000100891000000000000839999100891800899800899000891400899000000
// 039:100891000000d0089910089190089900000000000040089b10089140089b10089140089bf00899000000d00899000000b008990000000000008008990008910000001008910000000000008939991008918008998008990008916008990000001008910000006ff999100891f00897000000000000900899100891900899100891900899600899000000f00897000000400899100891400899100891000891400899100891400899100891000000000000000000000000000000000000000000
// 040:069100000000b0089910089180089900000000000040089b10089140089b10089140089bb00899000000800899000000900899000000000000d00899000891000000100891000000000000b93999100891b00899b00899000000100891000000069100000000900899100891600899000000000000f00899100891f00899100891f00899d00899000000b00899000000800899000000000000b00899000891000000100891000000000000b39999100891b00899b00899000000100891000000
// 041:06910000000040089b100891d0089900000000000092499b10089190089b10089180089b60089b00000046999b000000f00899000000000000b00899000891000000100891000000000000b93999100891b00899b00899000000100891000000069100000000900899100891600899000000000000d9a999100891b00899100891900899800899000000600899000000400899000000b00897000891000000800897000891400897000000000000000000000000000000000000000000000000
// 042:400807000000e0082900000040081f400807000000b0083900000000000040081fb0084300000040081f60084300000040081f400807e0082900000040081f400807000000b0083900000000000040081fe0082900000040081fe00829000000400807000000e0082900000040081f400807000000b0083900000000000040081fb0084300000040081f60084300000040080700000000000040080700000040081fb0083900000000000000000000000000000000000040081fe00829e00829
// </PATTERNS>

// <TRACKS>
// 000:100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ec02df
// 001:2c00002c0000201500281700201502286742282b03243ec3201b17ba1d97628529fd81a820150028170020176a2818aa9f0000
// 002:1142d4000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000de0200
// 003:115510000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ae0200
// 004:6d5856000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f000ef
// </TRACKS>

// <PALETTE>
// 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
// </PALETTE>

