// Start and Stop Server
s.boot;
s.scope;


(
var path = thisProcess.nowExecutingPath.dirname ++ "/loop/";
~lvl1Buf = Buffer.read(s, path ++ "try2.wav");
~lvl2Buf = Buffer.read(s, path ++ "lazysunday.wav");
~crowdBuf = Buffer.read(s, path ++ "supermarket.wav");
~fluteBuf = Buffer.read(s, path ++"magic-flute.wav");
~stringsBuf = Buffer.read(s, path ++"strings-loop.wav");

~bpm = 90;
~clock = TempoClock(~bpm / 60);


// SynthDefs

SynthDef(\lvl1, { arg bufnum, level=0.1, rate=1.0;
	var sound = PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum)*rate, loop: 1);
	var pitchShifted = PitchShift.ar(sound, 0.1, 2 ** (3 / 12));
	var output = LPF.ar(pitchShifted, 500) * level;
	Out.ar(0, output);
}).add;

SynthDef(\lvl2, { arg bufnum, level=0.1, rate=1.0;
	var sound = PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum)*rate, loop: 1);
	Out.ar(0, sound * level);
}).add;

SynthDef(\crowd, { arg bufnum, level=0.1;
	var sound = PlayBuf.ar(2, bufnum, loop: 1);
	Out.ar(0, sound * level);
}).add;

SynthDef(\strings, { arg bufnum = 0, level = 0, rate = 1.0;
      var sound;

      sound = PlayBuf.ar(2, bufnum,BufRateScale.kr(bufnum) * rate, loop: 1);



      Out.ar(0, sound*level);
}).add;

SynthDef(\flute, { arg bufnum = 0, level = 0, rate = 1.0;
      var sound;

      sound = PlayBuf.ar(2, bufnum,BufRateScale.kr(bufnum) * rate, loop: 1) * level;

      Out.ar(0, sound*level);
}).add;

SynthDef(\bassDrum, { arg t_trig = 1;
	var body, hmit, output, klick;

	body = SinOsc.ar(80);
	body = body * EnvGen.ar(Env.perc(0.001, 1.5, 1, -4), t_trig);

	//Klick

	klick = LFTri.ar(220);
	klick = klick * EnvGen.ar(Env.perc(0,0.01,1,-4), t_trig);

	output = (body + klick*0.63);
	Out.ar(0, {output}!2);

}).add;

SynthDef(\snareDrum, { arg t_trig = 1;
	var body, hit, output, noise;

	body = SinOsc.ar(150);
	body = body + SinOsc.ar(150*1.5) * 0.1;
	body = body * EnvGen.ar(Env.perc(0, 0.5, 1, -4), t_trig);

	noise = HPF.ar(WhiteNoise.ar(0.05), 220);
	noise = noise * EnvGen.ar(Env.perc(0, 0.4, 1, -4), t_trig);

	output = body + (noise * 0.54);

	Out.ar(0, {output}!2);

}).play;

SynthDef(\HiHat, { arg t_trig;
	var noise, hit, output;

	noise = HPF.ar(WhiteNoise.ar(0.2), 1500);
	noise = noise * EnvGen.ar(Env.perc(0, 0.12, 1, -1));

	output = noise * 0.8;

	Out.ar(0, {output}!2);

}).add;

~drumLoop = Routine({
	loop {
		// Beat 1
		Synth(\bassDrum, [\t_trig, 1]);
		//Synth(\HiHat, [\t_trig, 1]);

		1.wait;

		// Beat 2
		Synth(\HiHat, [\t_trig, 1]);

		1.wait;

		// Beat 3
		Synth(\snareDrum, [\t_trig, 1]);
		Synth(\HiHat, [\t_trig, 1]);

		1.wait;

		// Beat 4
		Synth(\HiHat, [\t_trig, 1]);

		1.wait;
	}
});
)

// Start Synths
(
//~crowdSynth = Synth(\crowd, [\level, 0.3, \bufnum, ~crowdBuf]);
//~bgSynth = Synth(\lvl1, [\level, 0.1, \bufnum, ~lvl1Buf, \rate, (~bpm/174)]);
~pianoSynth = Synth(\lvl2, [\level, 1, \bufnum, ~lvl2Buf, \rate, 1.0]);
//~fluteSynth = Synth(\flute, [\bufnum, ~fluteBuf, \level, 1, \rate , 0.8, \rate, (~bpm/100)]);
~bgSynth = Synth(\strings, [\bufnum, ~stringsBuf,\level, 0.5, \rate , 0.8, \rate, (~bpm/135)]);
~clock.sched(0, { ~drumLoop.play(~clock); nil });
)

// Simulate Data Function
(
~simulateQueue = {
	var data = List.new;
	var current = 3; // runs over 1 minute and smoothyl goes between 1-5 vals
	60.do({ |i|
		var delta = [-1, 0, 1].choose;
		current = (current + delta).clip(1, 5);
		data.add(current);
	});
	data;
};
~queueData = ~simulateQueue.value;
)

(
~updateMusic = { |numPeople|
	switch (numPeople,
		1, {
			~bgSynth.set(\level, 0.2);
			~pianoSynth.set(\level, 0.8);
		},
		2, {
			~crowdSynth.set(\level, 0.1);
			~bgSynth.set(\level, 0.4);
			~pianoSynth.set(\level, 0.6);
		},
		3, {
			~crowdSynth.set(\level, 0.3);
			~bgSynth.set(\level, 0.6);
			~pianoSynth.set(\level, 0.4);
		},
		4, {
			~crowdSynth.set(\level, 0.4);
			~bgSynth.set(\level, 0.8);
			~pianoSynth.set(\level, 0.2);
		},
		5, {
			~crowdSynth.set(\level, 0.6);
			~bgSynth.set(\level, 1.0);
			~pianoSynth.set(\level, 0.1);
		}
	);
};
)

// run simulated queue changes over 1 minute
(
Routine({
	~queueData.do { |persons|
		persons.postln;
		~updateMusic.(persons);
		1.wait; // waits 1 second between updates
	};
}).play;
)
