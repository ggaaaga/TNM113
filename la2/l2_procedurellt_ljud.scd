// Starta servern
s.boot; // en rad kod körs med <Shift> och <Enter>
// Stop server
s.quit;
// Start oscilloscope
s.scope;

// När servern är igång skickar man över en eller flera synth definitioner till serven.
// Kod inom parenteser körs med <cmd> och <Enter> på Mac eller <ctrl> och <Enter> i Windows

// Bass drum
(
SynthDef(\bassDrum, { arg t_trig = 1;
	var body, hmit, output, klick;

	body = SinOsc.ar(80);
	body = body * EnvGen.ar(Env.perc(0.001, 0.25, 1, -4), t_trig);

	//Klick

	klick = LFTri.ar(220);
	klick = klick * EnvGen.ar(Env.perc(0,0.01,1,-4), t_trig);

	output = (body + klick*0.33) * 0.8;
	Out.ar(0, {output}!2);

}).add;

)


// Snare drum
(
SynthDef(\snareDrum, { arg t_trig = 1;
	var body, hit, output, noise;

	body = SinOsc.ar(150);
	body = body + SinOsc.ar(150*1.5) * 0.1;
	body = body * EnvGen.ar(Env.perc(0, 0.2, 1, -4), t_trig);

	noise = HPF.ar(WhiteNoise.ar(0.05), 220);
	noise = noise * EnvGen.ar(Env.perc(0, 0.2, 1, -4), t_trig);

	output = body + noise * 0.54;

	Out.ar(0, {output}!2);

}).add;
)

// ClHiHat
(
SynthDef(\clHiHat, { arg t_trig;
	var noise, output;

	noise = HPF.ar(WhiteNoise.ar(0.25), 1500);
	noise = noise * EnvGen.ar(Env.perc(0.005, 0.1, 1, -1));

	output = noise ;

	Out.ar(0, {output}!2);


}).add;
)

// OpHiHat
(
SynthDef(\opHiHat, { arg t_trig;
	var noise, hit, output;

	noise = HPF.ar(WhiteNoise.ar(0.2), 1500);
	noise = noise * EnvGen.ar(Env.perc(0, 0.2, 1, -1));

	output = noise ;

	Out.ar(0, {output}!2);

}).add;
)


// High tom
(
SynthDef(\highTom, { arg t_trig;

	var body, pitchEnvelope, output;

	pitchEnvelope = EnvGen.ar(Env.perc(0, 0.1, 1, -4), t_trig).range(1, 3);
	body = SinOsc.ar(75 * pitchEnvelope);
	body = body * EnvGen.ar(Env.perc(0.005, 0.3, 1, -4));

	output = body *0.7;

	Out.ar(0, {output}!2);

}).add;
)


// Low tom
(
SynthDef(\lowTom, { arg t_trig;

	var body, hit, pitchEnvelope, output;

	pitchEnvelope = EnvGen.ar(Env.perc(0, 0.1, 1, -4), t_trig).range(1, 3);
	body = SinOsc.ar(50 * pitchEnvelope);
	body = body * EnvGen.ar(Env.perc(0.005, 0.3, 1, -4));

	output = body * 0.7;

	Out.ar(0, {output}!2);

}).add;
)

// Woodblock
(
SynthDef(\woodBlock, { arg t_trig;
	var klick, output;

	klick = SinOsc.ar(530);
	klick = klick * EnvGen.ar(Env.perc(0, 0.15, 1, -8));

	output = klick;

	Out.ar(0,{output}!2);

}).add;
)

// Cowbell
(
SynthDef(\cowBell, { arg t_trig;
	var osc1, osc2, body, output;

	osc1 = LFPulse.ar(540, 0, 0.3);
	osc2 = LFPulse.ar(800, 0, 0.5);
	body = (osc1 + osc2) *  EnvGen.ar(Env.perc(0, 0.5, 1, -4));

	output = body * 0.04;

	Out.ar(0,{output}!2);

}).add;
)

// Crash
(
SynthDef(\crash, { arg t_trig;

	var noise, hit, output;

	noise = HPF.ar(WhiteNoise.ar(0.2), 1500);
	noise = noise * EnvGen.ar(Env.perc(0.01, 3, 1, -8));

	output = RHPF.ar(in: noise, freq: 5000, rq: 0.3,§ mul: 1.0, add: 0.0);

	Out.ar(0, {output}!2);

}).add;
)

Server.default.record

Server.default.stopRecording