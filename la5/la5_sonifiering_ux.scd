Parametrisk sonifiering harmoni, skapa mer falska toner ju högre data

// Starta servern
s.boot; // en rad kod körs med <Shift> och <Enter>
// Stop server
s.quit;
// Start oscilloscope
s.scope;

// När servern är igång skickar man över en eller flera synth definitioner till serven.
(
// Kod inom parenteser körs med <cmd> och <Enter> på Mac eller <ctrl> och <Enter> i Windows

SynthDef(\dataSonification, { arg freq,  detune = 0, level = 0.6, waveMix = 0;
	var sinus, sawtooth, mixed, output;

	sinus = SinOsc.ar(freq + detune) + SinOsc.ar(freq - detune);
	sawtooth = Saw.ar(freq + detune) + Saw.ar(freq - detune);

	mixed = ((1 - waveMix) * sinus) + (waveMix * sawtooth);

	output = LPF.ar(mixed, freq * 1.5) * level.lag(0.2) * 0.7;
	Out.ar(0, {output}!2);

}).add;

SynthDef(\levelBackground, { arg freq = 220;
	var output = SinOsc.ar(freq) * 0.3;
    output = LPF.ar(output, freq * 3);
	Out.ar(0, {output}!2);
}).add;

SynthDef(\ding, { arg freq = 550, dur = 0.4;
    var env = EnvGen.kr(Env.perc(0.01, dur), doneAction: 2);
	var output = RLPF.ar(LFTri.ar(freq) * env, 2000);
	Out.ar(0, {output} ! 2);
}).add;

SynthDef(\sharpDing, { arg freq = 550, dur = 0.4;
    var env = EnvGen.kr(Env.perc(0.01, dur), doneAction: 2);
	var output = LPF.ar(LFSaw.ar(freq) * env, 2000);
	Out.ar(0, {output} ! 2);
}).add;

)

(
// Följande registrerar dataSonification synthdefinitionen på servern
~dataSynth = Synth.new(\dataSonification).register;

// Följande är en OSC-lyssnare för level-meddelanden
OSCdef(\levelListener, { arg inputmsg;
	if (inputmsg.size > 1) {
		// Ta hand om meddelandet om det inte är samma som förra
		if (inputmsg[1].asInteger != ~statusLevel) {
			var freq = 220;
			// Detta plockar ut level ur meddelandet som ett heltal
			// och sparar i environment-variabeln
			~statusLevel = inputmsg[1].asInteger;

			if (~levelBG.notNil) {
				~levelBG.free;
			};

			switch(~statusLevel,
				0, { freq = 220;},
				1, { freq = 300;},
				2, { freq = 400;},
				3, { freq = 550; },
				{ freq = 220; }
			);

			~statusLevel.postln;

			~levelBG = Synth(\levelBackground, [\freq, freq]);
			//Synth(\levelBackground, [\freq, freq]);
			//Synth(\levelPling, [\freq, freq]); // gör ny synth varje gg
		};
	};
}, 'level');

// Följande är en OSC-lyssnare för data-meddelanden
OSCdef(\dataListener, { arg inputmsg;
	if (inputmsg.size > 1) {
		// Ta hand om meddelandet om det inte är samma som förra
		if (inputmsg[1].asInteger != ~currentData) {
			var frequency, detune, level, waveMix;
			// Detta plockar ut datavärdet ur meddelandet som ett heltal
			// och sparar i environment-variabeln
			~currentData = inputmsg[1].asInteger;
			// Följande skickar data-nivån (som en int) till en mapp-funktion
			// som returnerar värdet och sparar det i frequency-variabeln
			frequency = ~mapPitch.value(~currentData);
			detune = ~currentData.linlin(0, 300, 0, 30);
			level = ~currentData.linexp(0 , 300, 0.2, 1);
			waveMix = ~currentData.linlin(0, 300, 0, 1);
			// Följande skickar värdet, frekvensen, till synthdefinitionen
			~dataSynth.set(\freq, frequency, \detune, detune, \level, level, \waveMix, waveMix);
		};
	};
}, 'data');

// Följande är en OSC-lyssnare för fel-meddelanden
OSCdef(\errorListener, { arg inputmsg;
	if (inputmsg.size > 1) {
		// Detta plockar ut felmeddelandet ur meddelandet
		// och sparar i environment-variabeln
		~errorMessage = inputmsg[1];

			switch(~errorMessage,
			'Bipolar capacity low', {

				fork({
					Synth(\ding, [\freq, 440]);
					0.2.wait;
					Synth(\ding, [\freq, 330]);
					0.2.wait;
					Synth(\ding, [\freq, 220]);
					0.2.wait;
					Synth(\ding, [\freq, 110]);
					0.2.wait;
				})

			},
			'Zero target null', {
				fork({
					Synth(\sharpDing, [\freq, 220, \dur, 1.3]);
					0.2.wait;
				})

			},
			'Risk for overheating', {
				fork({
					Synth(\sharpDing, [\freq, 550]);
					0.2.wait;
					Synth(\sharpDing, [\freq, 550]);
					0.2.wait;
					Synth(\sharpDing, [\freq, 550]);
					0.2.wait;
				})
			},
			'Unstable output', {
				fork({
					Synth(\ding, [\freq, 330, \dur, 0.8]);
					0.2.wait;
					Synth(\ding, [\freq, 220, \dur, 0.8]);
				})
			}
			);

		~errorMessage.postln;
	};
}, 'error');


~mapPitch = { arg freq;
	// Först görs en linjär till linjär mappning av värdet till frekvens (i Hz)
	var frequency = linlin(freq, 0, 300, 220, 880) ;
	// returnerar värdet
	frequency.value;
};

)

// Följande rad kollar vilken lokal address som OSC-lyssnaren använder. Denna måste
// vara samma i båda programmen, så att "monitorGUIt" skickar på rätt address.

NetAddr.localAddr;