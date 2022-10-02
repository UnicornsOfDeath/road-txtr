// title:   road txtr
// author:  unicorns of death
// desc:    tbd
// site:    tbd
// license: MIT License (change this to your license of choice)
// version: 0.1
// script:  wren

var WIDTH=240
var HEIGHT=136
var COLOR_BG=0
var MUSSPLASH=0
var MUSGAME=1
var MUSTITLE=2
var MUSTEMPO=100
var MUSSPD=3
var FPS=60
var MUSBEATTICKS=FPS*60/MUSTEMPO*MUSSPD/6
var PALETTE_MAP=0x3FF0
var SFXNEXT=1
var TXT_X=120
var TXT_Y=10
var TXT_W=WIDTH-TXT_X-10
var TXT_H=HEIGHT-TXT_Y-10
var EVENT_TICK=200

// BUTTONS

var BTN_UP=0
var BTN_DOWN=1
var BTN_LEFT=2
var BTN_RIGHT=3
var BTN_A=4
var BTN_B=5
var BTN_X=6
var BTN_Y=7

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
		TIC.sfx(SFXNEXT)
    }

	next() {
		if (tt>_grace && (TIC.btnp(0) || TIC.btnp(1) || TIC.btnp(2) || TIC.btnp(3) || TIC.btnp(4) || TIC.btnp(5))) {
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

class TitleState is SkipState {
	construct new() {
		super(10)
    }

	reset() {
		super.reset()
		TIC.music(MUSTITLE,-1,-1,false)
    }

	finish() {
        return
    }

	draw() {
		super.draw()
		TIC.cls(COLOR_BG)
		TIC.print("This is the title screen!\nPress any key to go back to the\nsplash screen", 10, 10)
    }
}

class MainState is State {
    construct new() {
        _x=0
        _speed=1.5
        _player=Player.new(10,60)
        _currentTime=0
    }

    reset() {
        super.reset()
        _x=0
        _player=Player.new(10,60)
        _showText=false
		TIC.music(MUSGAME,-1,-1,true)
    }

    update() {
        _x=_x-_speed
        _player.update()

        // Show/hide text with A button
        if(TIC.btnp(BTN_A)){
            _showText=!_showText
            TIC.sfx(SFXNEXT)
        }


        _currentTime = _currentTime + 1
        if(_currentTime == EVENT_TICK) {
           _showText=!_showText
           _currentTime = 0
        }

        // Skip to death screen with B button
        if(TIC.btnp(BTN_B)){
            _player.onHit(9999)
        }
    }

    next() {
        // TODO: stay on this state a bit and show the car exploding etc
		if (_player.health==0) {
			finish()
			nextstate.reset()
			return nextstate
        }
		return super()
    }

    draw() {
        TIC.map(0, 0, WIDTH, HEIGHT, _x, 0)
        _player.draw()

        if (_showText){
            var y=TXT_Y
            TIC.rect(TXT_X,y,TXT_W,TXT_H,12)
            TIC.rect(TXT_X,y,TXT_W,20,13)
            TIC.print("Unknown",TXT_X+4,y+4,0)
            y=y+20
            TIC.rect(TXT_X+3,y+2,TXT_W-35,25,13)
            TIC.print("Hello! Is your\nrefrigerator\nrunning?",TXT_X+5,y+4,0)
        }

        TIC.print("Z to show/hide txt",2,HEIGHT-8,0)
        TIC.print("X to suicide",140,HEIGHT-8,0)
    }
}

class DeathState is SkipState {
	construct new() {
		super(10)
    }

	reset() {
		super.reset()
        // TODO: death music
		TIC.music(MUSTITLE,-1,-1,false)
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

class Message {

}

class GameObject {
    x { _x }
    y { _y }
    x=(value){ _x=value }
    y=(value){ _y=value }

    construct new(x,y) {
        _x=x
        _y=y
    }

    draw() {}
}

class Player is GameObject {
    health { _health }

    construct new(x,y) {
        super(x,y)
        _steeringSpeed=1
        _health=10
    }

    onHit(dmg){
        // TODO: hit effects
		TIC.sfx(SFXNEXT)
        _health=_health-dmg
        if(_health<0){
            _health=0
        }
    }

    update() {
        if(TIC.btn(BTN_UP)) {
            y=y-_steeringSpeed
        }
        if(TIC.btn(BTN_DOWN)) {
            y=y+_steeringSpeed
        }
    }

    draw() {
        TIC.spr(256,x,y,0,1,0,0,4,2)
    }
}

class Game is TIC{

	construct new(){
        var splashState = SplashState.new()
        var titleState = TitleState.new()
        var mainState = MainState.new()
        var deathState = DeathState.new()
        splashState.nextstate = titleState
        titleState.nextstate = mainState
        mainState.nextstate = deathState
        deathState.nextstate = titleState
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
// 000:eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
// 001:eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
// 016:eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
// 017:eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
// 032:eeeecccceeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
// 033:ccceeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
// 048:eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
// 049:eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
// 064:6666666666666656656666766666666666766666666666666665666566666666
// 065:6666666666665666667666666666676666666666656656666666666666666766
// 080:6666666667665666666666766666666666666666656665666666666666666666
// 081:6566666666665666666667666676666666666666766566766666666666666666
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
// 004:00000000000000000000000000000000000000000000c00000000ccc00000ccc
// 005:0000000000000000000000000000000000000000c00000000000000000000000
// 006:0000000000000000000000000000000000000000020202c20cc22c2202cccccc
// 007:000000000000000000000000000000000000000022000000c200000020000000
// 016:0000999f0000cccf0000cccf0000999f00002999000009990000000000000000
// 017:ff999999ffccccccffccccccff99999999999999999999990000000000000000
// 018:9ffff999cffffccccfffcccc9ff9999999999999999999999000000000000000
// 019:99999000ccccc000ccccc0009994400099940000999000000000000000000000
// 020:000000cc00000ccc00000ccc00000ccc000000cc000000000000000000000000
// 021:c0000000cc000000cc000000cc00c000c0ccc000000000000000000000000000
// 022:02cccccc0c22c2220002c2000000000000000000000000000000000000000000
// 023:22000000c20000002c00000000c0000000000000000000000000000000000000
// 032:0000000000000000000000000000000500000055000000550000005570000005
// 033:0000000000000000000000000000000050000000550000505500055055000550
// 035:0000000000000000000000000000000000000000000000000700000077000000
// 048:7777700577777775077777750007777700007777000057770055557705555555
// 049:5550555055555550555555007755500077557000777777007177777011077770
// 050:0000000700000077000000770000007700007777000077770000fff700000007
// 051:7700000077700000777700007077000077770000777770007777700077777000
// 064:5555555155555011500000110000001100000111000001110000011100000111
// 065:1107777011007770110000701000000010000000100000001000000000000000
// 066:0000777700077777000777770007777707777777077777770fffffff00000001
// 067:777777001777777017777770777ffff077700000777777707777777777777777
// 080:0000011100000111000001110000011100000111000000000000000000000000
// 082:7777777777777777ffffffff0000000100000001000000010000000000000000
// 083:7777777777777777ffffffff1100000011000000110000000000000000000000
// </SPRITES>

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
// </PATTERNS>

// <TRACKS>
// 000:100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ec02df
// 001:2c00002010002c00002010002c0500281700202a00242b002c0503281743202a83242bc30000000000000000000000009f0200
// 002:1142d4000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000de0200
// </TRACKS>

// <PALETTE>
// 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
// </PALETTE>

