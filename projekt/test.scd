// Starta servern
s.boot; // en rad kod körs med <Shift> och <Enter>
// Stop server
s.quit;
// Start oscilloscope
s.scope;

/***** SynthDefs *****/

(
SynthDef(\lvl1, { arg bufnum = 0, level = 0;
	var output, sound;

	output = SinOsc.ar(440) * level;


	Out.ar(0, {output}!2);

}).add;

SynthDef(\lvl2, { arg bufnum = 0, level = 0, rate = 1.0;
	var output, sound;

	sound = PlayBuf.ar(
            numChannels: 2,
            bufnum: bufnum,
            rate: BufRateScale.kr(bufnum) * rate,
            trigger: 1,
            startPos: 0,
            loop: 1,
      );

	output = sound;

	Out.ar(0, {output}!2);

}).play;

)


/***** Buffers *****/
(
var lvl1Buf = Buffer.read(s, thisProcess.nowExecutingPath.dirname++"/nochildleftbehind.wav");
var lvl2Buf = Buffer.read(s, "loop\\lvl1.wav");
var lvl3Buf = Buffer.read(s, "loop\\lvl1.wav");
var lvl4Buf = Buffer.read(s, "loop\\lvl1.wav");
var lvl5Buf = Buffer.read(s, "loop\\lvl1.wav");
)

/***** Switchcase *****/
(
var out = {
	switch (

};



)

/***** PersonListener *****/
(



)





