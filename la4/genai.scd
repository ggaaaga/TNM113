// Starta servern
s.boot; // en rad kod körs med <Shift> och <Enter>
// Stop server
s.quit;
// Start oscilloscope
s.scope;

// När servern är igång skickar man över en eller flera synth definitioner till serven.

// Audio files

(

SynthDef(\temperatureSynth, { arg frequency = 220, level = 0;
	var output = SinOsc.ar(freq: frequency, mul: 0.3) * level.lag(0.5);

	Out.ar(0, {output}!2);
}).add;

)

(

SynthDef(\sunSynth, { arg bufnum = 0, on = 0;
		var output = PlayBuf.ar(
		numChannels: 2,
		bufnum: bufnum,
		rate: 1.0,
		trigger: 1,
		startPos: 0,
		loop: 1,
		doneAction: 0

	);

	output = output * on;

	Out.ar(0, {output}!2);
}).add;

)


(

SynthDef(\rainSynth, {arg bufnum = 0, on = 0;
		var output = PlayBuf.ar(
		numChannels: 2,
		bufnum: bufnum,
		rate: 1.0,
		trigger: 1,
		startPos: 0,
		loop: 1,
		doneAction: 0

	);

	output = output * on;

	Out.ar(0, {output}!2);
}).add;

)

(
SynthDef(\snowSynth, {arg bufnum = 0, on = 0;
	var output = PlayBuf.ar(
		numChannels: 2,
		bufnum: bufnum,
		rate: 1.0,
		trigger: 1,
		startPos: 0,
		loop: 1,
		doneAction: 0

	);

	output = output * on;

	Out.ar(0, {output}!2);
}).add;
)



(

// Sounds
var glockenspiel = Buffer.read(s, "C:/Users/gayat/TNM113/la4/softsnowycoldandcalmglockenspieltones.wav");

var cicadas = Buffer.read(s, "C:/Users/gayat/TNM113/la4/queitandcalmcicadasandgrasshopperswithsunbeaming.wav");

var rainy = Buffer.read(s, "C:/Users/gayat/TNM113/la4/rainybrownnoisehittingthegroundsoftly.wav");

// Flaggor som håller koll på vädret
~sunFlag = false;
~rainFlag = false;
~snowFlag = false;

// Synthinstansen för temperaturen
~temperatureSynth = Synth.new(\temperatureSynth);

// Weather sounds
~cicadas = Synth.new(\cicadas,[\bufnum, cicadas]);
~sunSynth = Synth.new(\sunSynth, [\bufnum, cicadas]);

~rainy = Synth.new(\rainy,[\bufnum, rainy]);
~rainSynth = Synth.new(\rainSynth, [\bufnum, rainy]);

~glockenspiel = Synth.new(\glockenspiel,[\bufnum, glockenspiel]);
~snowSynth = Synth.new(\snowSynth,[\bufnum, glockenspiel]);

// En del GUI-grejer
w = Window.new("Thermometer",
	Rect.new(
		20,
		200,
		1024,
		500))
.front;
u = UserView(w, Rect(0, 0, 1024, 500))
.background = Color.hsv(0.31, 0.2, 1, 0.5);
~text = StaticText(u, Rect(874, 20, 160, 60))
.string_(" 10.0 degrees")
.font_(Font("Monaco", 16));
~sunImage = Image.open(thisProcess.nowExecutingPath.dirname +/+ "sun.png").scalesWhenResized_(true).setSize(300, 300);
~sunshine = UserView(u, Rect(700, 120, 300, 300))
.background_(Color.new255(0,0,0,0))
.setBackgroundImage(~sunImage, alpha: 0.5);
~sunButton = Button.new(w,Rect(700,120,300,300))
.states_([
	["", Color.black, Color.gray(0,0)]
])
.action_({
	if (~sunFlag) {
		~sunFlag = false;
		~sunshine.background_(Color.new255(0,0,0,0))
		.setBackgroundImage(~sunImage, alpha: 0.5);
	} {
		~sunFlag = true;
		~sunshine.background_(Color.new255(0,0,0,25))
		.setBackgroundImage(~sunImage, alpha: 1);
		~rainFlag = false;
		~rain.background_(Color.new255(0,0,0,0))
		.setBackgroundImage(~rainImage, alpha: 0.5);
		~snowFlag = false;
		~snow.background_(Color.new255(0,0,0,0))
		.setBackgroundImage(~snowImage, alpha: 0.5);
	};
	~sunAction.value;
	~rainAction.value;
	~snowAction.value;
});
~rainImage = Image.open(thisProcess.nowExecutingPath.dirname +/+ "rain.png").scalesWhenResized_(true).setSize(300, 300);
~rain = UserView(u, Rect(360, 120, 300, 300))
.setBackgroundImage(~rainImage, alpha: 0.5);
~rainButton = Button.new(w,Rect(360,120,300,300))
.states_([
	["", Color.black, Color.gray(0,0)]
])
.action_({
	if (~rainFlag) {
		~rainFlag = false;
		~rain.background_(Color.new255(0,0,0,0))
		.setBackgroundImage(~rainImage, alpha: 0.5);
	} {
		~rainFlag = true;
		~rain.background_(Color.new255(0,0,0,25))
		.setBackgroundImage(~rainImage, alpha: 1);
		~sunFlag = false;
		~sunshine.background_(Color.new255(0,0,0,0))
		.setBackgroundImage(~sunImage, alpha: 0.5);
		~snowFlag = false;
		~snow.background_(Color.new255(0,0,0,0))
		.setBackgroundImage(~snowImage, alpha: 0.5);
	};
	~sunAction.value;
	~rainAction.value;
	~snowAction.value;
});
~snowImage =  Image.open(thisProcess.nowExecutingPath.dirname +/+ "snow.png").scalesWhenResized_(true).setSize(300, 300);
~snow = UserView(u, Rect(20, 120, 300, 300))
.setBackgroundImage(~snowImage, alpha:0.5);
~snowButton = Button.new(w,Rect(20,120,300,300))
.states_([
	["", Color.black, Color.gray(0,0)]
])
.action_({
	if (~snowFlag) {
		~snowFlag = false;
		~snow.background_(Color.new255(0,0,0,0))
		.setBackgroundImage(~snowImage, alpha: 0.5);
	} {
		~snowFlag = true;
		~snow.background_(Color.new255(0,0,0,25))
		.setBackgroundImage(~snowImage, alpha: 1);
		~sunFlag = false;
		~sunshine.background_(Color.new255(0,0,0,0))
		.setBackgroundImage(~sunImage, alpha: 0.5);
		~rainFlag = false;
		~rain.background_(Color.new255(0,0,0,0))
		.setBackgroundImage(~rainImage, alpha: 0.5);
	};
	~sunAction.value;
	~rainAction.value;
	~snowAction.value;
});
~slider = Slider(u, Rect(20, 20, 840, 60))
.value_(0.5);




// -------------------------|||||-------------------------
// --------------- Här nedan börjar det roliga -----------
// -------------------------|||||-------------------------




// När slidern klickas spelas ljudet från temperatursynthen upp
~slider.mouseDownAction = {
	~temperatureSynth.set(\level, 1);
};
~slider.mouseUpAction = {
	~temperatureSynth.set(\level, 0);
};

// Följande funktioner ropas på när de olika väderförhållandena väljs
~sunAction = {
	if (~sunFlag) {
		("Sun").postln;
		~sunSynth.set(\on, 1);
	} {
		("No sun").postln;
		~sunSynth.set(\on, 0);
	};
};
~rainAction = {
	if (~rainFlag) {
		("Rain").postln;
		~rainSynth.set(\on, 1);
	} {
		("No rain").postln;
		~rainSynth.set(\on, 0);
	};
};
~snowAction = {
	if (~snowFlag) {
		("Snow").postln;
		~snowSynth.set(\on, 1);
	} {
		("No snow").postln;
		~snowSynth.set(\on, 0);
	};
};

// Följande funktion körs när slidern flyttas på
~slider.action_({ arg obj;
	var hue, string; // två variabler för GUIt
	// Följande skalar om sliderns värde till en float mellan -20 och 40
	var temperature = (linlin(obj.value, 0, 1, -20, 40)*10).round/10;

	// När temperaturen ändras gör saker med ljudet här
	~temperatureSynth.set(\frequency, linexp(temperature, -20, 40, 110, 880));














	// Följande justerar bakgrundsfärgen i GUIt
	hue = linlin(temperature, -20, 40, 0.6, 0.1);
	if (temperature >= 0) {
		string = "" + temperature + "degrees";
	} {
		string = temperature + "degrees";
	};
	~text.string_(string);
	u.background_(Color.hsv(hue, 0.2, 1, 0.5));

});




// Följande stänger fönstret när processen stängs
CmdPeriod.doOnce({
	w.free;
	w.close;
});

)