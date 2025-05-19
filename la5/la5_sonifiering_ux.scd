// Starta servern
s.boot; // en rad kod körs med <Shift> och <Enter>
// Stop server
s.quit;
// Start oscilloscope
s.scope;

// När servern är igång skickar man över en eller flera synth definitioner till serven.
(
// Kod inom parenteser körs med <cmd> och <Enter> på Mac eller <ctrl> och <Enter> i Windows

SynthDef(\dataSonification, { arg freq,  detune = 0, level = 0.6;
	var sig1 = SinOsc.ar(freq + detune);
    var sig2 = SinOsc.ar(freq - detune);
	var output = sig1+sig2;
	Out.ar(0, {output}!2);
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
			// Detta plockar ut level ur meddelandet som ett heltal
			// och sparar i environment-variabeln
			~statusLevel = inputmsg[1].asInteger;
		};
	};
}, 'level');

// Följande är en OSC-lyssnare för data-meddelanden
OSCdef(\dataListener, { arg inputmsg;
	if (inputmsg.size > 1) {
		// Ta hand om meddelandet om det inte är samma som förra
		if (inputmsg[1].asInteger != ~currentData) {
			var frequency, detune;
			// Detta plockar ut datavärdet ur meddelandet som ett heltal
			// och sparar i environment-variabeln
			~currentData = inputmsg[1].asInteger;
			// Följande skickar data-nivån (som en int) till en mapp-funktion
			// som returnerar värdet och sparar det i frequency-variabeln
			frequency = ~mapPitch.value(~currentData);
			detune = ~currentData.linlin(0, 300, 0, 15); // Justera 15
			// Följande skickar värdet, frekvensen, till synthdefinitionen
			~dataSynth.set(\freq, frequency, /*\detune, detune*/);
		};
	};
}, 'data');

// Följande är en OSC-lyssnare för fel-meddelanden
OSCdef(\errorListener, { arg inputmsg;
	if (inputmsg.size > 1) {
		// Detta plockar ut felmeddelandet ur meddelandet
		// och sparar i environment-variabeln
		~errorMessage = inputmsg[1];
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