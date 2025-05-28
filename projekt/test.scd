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
~dFullBuf = Buffer.read(s, path ++"drumsfull.wav");
~dTopBuf= Buffer.read(s, path ++"drumtops.wav");
~spiceBuf= Buffer.read(s, path ++"lilspice.wav");

~bpm = 90;
~clock = TempoClock(~bpm / 60);
~drumsOn = true;


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

SynthDef(\strings, { arg bufnum = 0, level = 0, rate = 1.0, bpf = 150, plus = 150;
      var sound;

     sound = PlayBuf.ar(2, bufnum,BufRateScale.kr(bufnum) * rate, loop: 1);
	sound = RHPF.ar(RLPF.ar(sound, bpf+plus), bpf-plus);

      Out.ar(0, sound*level);
}).add;

SynthDef(\drumsfull, { arg bufnum = 0, level = 0, rate = 1.0, cutoffFreq = 600;
      var sound;

      sound = PlayBuf.ar(2, bufnum,BufRateScale.kr(bufnum) * rate, loop: 1) * level;
	sound = RLPF.ar(sound, cutoffFreq, 0.5);

      Out.ar(0, sound*level);
}).add;

SynthDef(\drumstop, { arg bufnum = 0, level = 0, rate = 1.0, cutoffFreq = 1500;
      var sound;

      sound = PlayBuf.ar(2, bufnum,BufRateScale.kr(bufnum) * rate, loop: 1) * level;
	sound = RLPF.ar(sound, cutoffFreq, 0.5);

      Out.ar(0, sound*level);
}).add;

SynthDef(\lilspice, { arg bufnum, level=0, rate=1.0;
	var sound = PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum)*rate, loop: 1);
	Out.ar(0, sound * level);
}).add;

SynthDef(\flute, { arg bufnum, level=0, rate=1.0, cutoffFreq = 600;
	var sound, pitchShifted;
	sound = PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum)*rate, loop: 1);
	sound = LPF.ar(sound, cutoffFreq);
	pitchShifted = PitchShift.ar(sound, 0.1, 1.111);
	Out.ar(0, pitchShifted * level);
}).add;

// Procedurella
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

}).add;

SynthDef(\HiHat, { arg t_trig;
	var noise, hit, output;

	noise = HPF.ar(WhiteNoise.ar(0.2), 1500);
	noise = noise * EnvGen.ar(Env.perc(0, 0.12, 1, -1));

	output = noise * 0.8;

	Out.ar(0, {output}!2);

}).add;

/*~drumLoop = Routine({
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
});*/
)

// Start Synths
(
~crowdSynth = Synth(\crowd, [\level, 0, \bufnum, ~crowdBuf]);
//~bgSynth = Synth(\lvl1, [\level, 0, \bufnum, ~lvl1Buf, \rate, (~bpm/174)]);
~pianoSynth = Synth(\lvl2, [\level, 0, \bufnum, ~lvl2Buf, \rate, 1.0]);
~fluteSynth = Synth(\flute, [\bufnum, ~fluteBuf, \level, 0, \rate, (~bpm/100)]);
~bgSynth = Synth(\strings, [\bufnum, ~stringsBuf,\level, 0, \rate, (~bpm/135)]);
~dtSynth = Synth(\drumstop, [\bufnum, ~dTopBuf, \level, 0, \rate, (~bpm/100)]);
~dfSynth = Synth(\drumsfull, [\bufnum, ~dFullBuf, \level, 0, \rate, (~bpm/100)]);
~spiceSynth = Synth(\drumsfull, [\bufnum, ~spiceBuf, \level, 0]);


// Simulate Data Function

~queueData = [
    1, 2, 3, 4, 5
];

~updateMusic = { |numPeople|
	switch (numPeople,
		1, {
			~crowdSynth.set(\level,0.09);

			~bgSynth.set(\level, 0);
			~pianoSynth.set(\level, 1.0);
			~dtSynth.set(\level, 0.8, \cutoffFreq, 7000);
			~dfSynth.set(\level, 0.6, \cutoffFreq, 10000);
			//~spiceSynth.set(\level, 1.0);
			~fluteSynth.set(\level, 0.5);
		},
		2, {
			~crowdSynth.set(\level, 0.2);

			~bgSynth.set(\level, 0);
			~pianoSynth.set(\level, 0.8);

			~dtSynth.set(\level, 0.5, \cutoffFreq, 5000);
			~dfSynth.set(\level, 0.6, \cutoffFreq, 2500);
			~fluteSynth.set(\level, 0.0);
		},
		3, {
			~crowdSynth.set(\level, 0.3);

			~bgSynth.set(\level, 0.1);
			~pianoSynth.set(\level, 0.6);
			~dtSynth.set(\level, 0.5, \cutoffFreq, 600);
			~dfSynth.set(\level, 0.1, \cutoffFreq, 2500);

		},
		4, {
			~crowdSynth.set(\level, 0.35);

			~bgSynth.set(\level, 0.5);
			~pianoSynth.set(\level, 0.4);
			~dtSynth.set(\level, 0);
			~dfSynth.set(\level, 0);

		},
		5, {
			~crowdSynth.set(\level, 0.5);

			~bgSynth.set(\level, 1.0, \plus, 50);
			~pianoSynth.set(\level, 0.15);
			~dtSynth.set(\level, 0);
			~dfSynth.set(\level, 0);
		}
	);
};


// run simulated queue changes over 1 minute

Routine({
	~queueData.do { |persons|
		("Nr of people in queue:" + persons).postln;
		~updateMusic.(persons);
		10.wait; // Adjust timing here if needed
	};
}).play;
)
