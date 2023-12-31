

+ SynthDef {

	asSynthDef { ^this }
	asDefName {	^name	}

}

+ Object {

	asSynthDef {
		error("Cannot convert this object to a SynthDef:" + this);
		this.dump;
		^nil
	}
	asDefName { 
		^this.asSynthDef.name
	}

}

	
+ String {
	asDefName { ^this }
}

+ Symbol {
	asDefName { ^this.asString }
}

+ Function {	
	/*
		this is mainly for  {}.play and Synth({ })
		
		Synth({
			SinOsc.ar
		})
		or:
		Synth({
			Out.ar(0,SinOsc.ar)
		})

		it inserts an Out only if it needs it		
	*/
	
	asDefName { // won't work immediately for Synth.new
		var def;
		def = this.asSynthDef;
		def.send(Server.default);
		^def.name
	}
	
	asSynthDef { arg rates, prependArgs, outClass=\Out, fadeTime, name;
		^GraphBuilder.wrapOut(name ?? { this.identityHash.abs.asString },
			this, rates, prependArgs, outClass, fadeTime
		);	
	}
	
	play { arg target, outbus = 0, fadeTime=0.02, addAction=\addToHead;
		var def, synth, server, bytes, synthMsg;
		target = target.asTarget;
		server = target.server;
		if(server.serverRunning.not) { 
			("server '" ++ server.name ++ "' not running.").warn; ^nil
		};
		def = this.asSynthDef(
			fadeTime:fadeTime, 
			name: SystemSynthDefs.tempNamePrefix ++ this.identityHash.abs.asString
		);
		synth = Synth.basicNew(def.name, server);
		bytes = def.asBytes;
		synthMsg = synth.newMsg(target, [\i_out, outbus, \out, outbus], addAction);
		if(bytes.size > 65535) {
			if(server.isLocal) {
				def.load(server, synthMsg)
			}{
				"synthdef too large to send to remote server".warn 
			}
		} {
			server.sendMsg("/d_recv", bytes, synthMsg)
		};
		^synth
	}
	
}

