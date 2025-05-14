// Starta servern
s.boot; // en rad kod körs med <Shift> och <Enter>
// Stop server
s.quit;
// Start oscilloscope
s.scope;

// När servern är igång skickar man över en eller flera synth definitioner till serven.
// Kod inom parenteser körs med <cmd> och <Enter> på Mac eller <ctrl> och <Enter> i Windows

// Bass drum

~lvl1 = Buffer.read(s, "projekt\sounds\lvl1.wav");

(
SynthDef(\lvl1, { arg t_trig = 1;
	var output, sound;


	Out.ar(0, {output}!2);

}).play;

)