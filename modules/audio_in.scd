(
// build synthDef, synthObj, gui, midiCtrls

// synthDef //

SynthDef(\audio_in, {|out=0, in=1, gate=0.001, amp=1|
	var input, amplitude;
  input=SoundIn.ar(in);
	amplitude=Amplitude.kr(input);
	amp=amp * Lag.kr(amplitude > gate, 0.02);
	Out.ar(out, input * amp)
}).send(s);

// synthObj //
~audioIn=~busControlledSynth.reproduce;
~audioIn.synthDefName=\audio_in;
~audioIn.fastPlay=false;
~audioIn.defaultSettings=[0.001, 1];
~audioIn.makeBusDictionary={|self|
	var bus;
	bus=Bus.control(s, 2);
	self.busDictionary=Dictionary[
		\gate -> bus.index,
		\amp -> (bus.index + 1)
	];
	bus.setn(self.defaultSettings);
	self.busarr=bus;
};
// gui //
~audioInGui=~buildGui.reproduce;
~audioInGui.synthObj=~audioIn;
~audioInGui.makeGui={|self, w|
	self.elementDictionary=Dictionary[
		\in ->
		NumberBox(w, self.elementStyle.smallBoxSize)
			.action_({|v| self.synthObj.setArgs(\in, v.value) })
	];
	(self.showIO).if({
		self.elementDictionary.put(
			\out,
			NumberBox(w, self.elementStyle.smallBoxSize)
				.action_({|v| self.synthObj.setArgs(\out, v.value) })
		);
	});
	w.startRow;
	self.elementDictionary.putAll(Dictionary[
		\gate ->
		EZKnob.new(w, self.elementStyle.knobSize, 'gate', \amp,
			{|v|
				self.synthObj.setArgs(\gate, v.value);
				self.updateMIDI(\gate, v.value);
			},
			nil,
			false,
			self.elementStyle.knobLabel,
			self.elementStyle.knobNumber
		),
		\amp ->
		EZKnob.new(w, self.elementStyle.knobSize, 'amp', \amp,
			{|v|
				self.synthObj.setArgs(\amp, v.value);
				self.updateMIDI(\amp, v.value);
			},
			nil,
			false,
			self.elementStyle.knobLabel,
			self.elementStyle.knobNumber
		)
	]);
	w.vert({|v|
		self.elementDictionary.putAll(Dictionary[
			\play ->
			ToggleButton(v, " P ", {
				self.synthObj.playSynth;
			}, {
				self.synthObj.stopSynth;
			}).view,
			\mute ->
			ToggleButton(v, " M ", {
				self.synthObj.runSynth(false);
			}, {
				self.synthObj.runSynth(true);
			}).view
		]);
		ActionButton(v, " S ", {
			Dialog.savePanel({|path|
				var dict;
				dict=self.getValues;
				dict.writeTextArchive(path);
			})
		});
		ActionButton(v, " L ", {
			Dialog.getPaths({|path|
				self.valueDictionary=Object.readTextArchive(path[0]);
				self.setValues;
			})
		});
	}, 20@100);
};
~audioInGui.valueDictionary=Dictionary[
	\in-> 1,
	\out -> 0,
	\gate -> 0.001,
	\amp -> 1,
	\mute -> 1,
	\play -> 1
];

// MIDI
~audioInMidi = ~incDecMidi.reproduce;
~audioInMidi.synthObj=~audioInSynth;
~audioInMidi.guiObj=~audioInGui;
~audioInMidi.valueDictionary=~audioInGui.valueDictionary.copy;
~audioInMidi.makeResponder={|self|
	self.responderObj=IncDecResponderBank(
		self.src,
		self.chan,
		self.ccDictionary.at(\gate), 0.0078, \amp,
			{|s, c, n, v|
				self.synthObj.setArgs(\gate, v);
				self.updateGui(\gate, v, \valueNoAction_);
			},
			self.valueDictionary.at(\gate),
		self.ccDictionary.at(\amp), 0.0078, \amp,
			{|s, c, n, v|
				self.synthObj.setArgs(\amp, v);
				self.updateGui(\amp, v, \valueNoAction_);
			},
			self.valueDictionary.at(\amp)
	);
	self.responderObj;
};

~audioInInstr=(
	reproduce: {|self|
		var newSelf;
		newSelf=self.copy;
		newSelf.theSynth=self.theSynth.reproduce(true);
		newSelf.theGui=self.theGui.reproduce;
		newSelf.theGui.synthObj=newSelf.theSynth;
		newSelf.theMidi=self.theMidi.reproduce;
		newSelf.theMidi.synthObj=newSelf.theSynth;
		newSelf.theMidi.guiObj=newSelf.theGui;
		newSelf;
	},
	theSynth: ~audioIn,
	theGui: ~audioInGui,
	theMidi: ~audioInMidi,
	midiOn: {|self|
		self.theGui.midiObj=self.theMidi;
	}
)
)