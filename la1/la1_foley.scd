// Starta servern
s.boot; // en rad kod körs med <Shift> och <Enter>
// Stop server
s.quit;


// När servern är igång skickar man över en eller flera synth definitioner till serven.
(
// Kod inom parenteser körs med <cmd> och <Enter> på Mac eller <ctrl> och <Enter> i Windows

SynthDef(\samplePlayer, { arg bufnum = 0;
    var sound = PlayBuf.ar(
		numChannels: 2,
		bufnum: bufnum,
		rate:  1.0 * BufRateScale.kr(bufnum),
		trigger: 1,
		startPos: 0,
		loop: 0,
		doneAction: 0,
	);
	var mysin=SinOsc.kr(freq:2).range(-0.7,0.7);

	//var output = sound;
	var output = RHPF.ar(in: sound, freq: 880, rq: 0.2, mul: 1.0, add: 0.0);
	//var output = BPF.ar(in: sound, freq: 880.0, rq: 0.1, mul: 1.0, add: 0.0);
	//var output = HPF.ar(in: sound, freq: 880.0, mul: 1.0, add: 0.0);
	var envelope = EnvGen.kr(Env.perc(attackTime: 0.05, releaseTime: 5.0, level: 1.0, curve: -4.0));
	output = output * envelope * mysin * 7.0;

	Out.ar(0, output);
}).add;

SynthDef(\samplePlayer2, { arg bufnum = 0, rateMod = 1.0;
    var sound = PlayBuf.ar(
		numChannels: 2,
		bufnum: bufnum,
		rate: rateMod * BufRateScale.kr(bufnum),
		trigger: 1,
		startPos: 0,
		loop: 0,
		doneAction: 0,
	);

	//var output = sound;
	//var output = RHPF.ar(in: sound, freq: 440.0, rq: 0.9, mul: 1.0, add: 0.0);
	//var output = BPF.ar(in: sound, freq: 880.0, rq: 0.1, mul: 1.0, add: 0.0);
	var output = HPF.ar(in: sound, freq: 880.0, mul: 1.0, add: 0.0);
	var envelope = EnvGen.kr(Env.perc(attackTime: 0.01, releaseTime: 3.0, level: 1.0, curve: -4.0));
	output = output * 4.0;

	Out.ar(0, output);
}).add;

)

// Klientside skript
(
// Kod inom parenteser körs med <cmd> och <Enter> på Mac eller <ctrl> och <Enter> i Windows

var trä = Buffer.read(s, thisProcess.nowExecutingPath.dirname++"/ring.wav");
var papper = Buffer.read(s, thisProcess.nowExecutingPath.dirname++"/papper.wav");
var hallare = Buffer.read(s, thisProcess.nowExecutingPath.dirname++"/nagel_pappersh.wav");
var metall = Buffer.read(s, thisProcess.nowExecutingPath.dirname++"/nagel_metall.wav");
s.scope;

fork({
s.record;
Synth.new(\samplePlayer2, [\bufnum, metall, \rateMod, 2.0]);
2.2.wait;
Synth.new(\samplePlayer2, [\bufnum, metall, \rateMod, 3.0]);
1.9.wait;
Synth.new(\samplePlayer2, [\bufnum, metall, \rateMod, 4.0]);
2.0.wait;
Synth.new(\samplePlayer, [\bufnum, papper]);
	5.0.wait;
	s.stopRecording;

})



)