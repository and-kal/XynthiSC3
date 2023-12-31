//third party FFT UGens

//sick lincoln remembers complex analysis courses
PV_ConformalMap : UGen 
{

	*new { arg buffer, areal = 0.0, aimag = 0.0;
		^this.multiNew('control', buffer, areal, aimag)
	}
}

//in and kernel are both audio rate changing signals
Convolution : UGen
{
	*ar { arg in, kernel, framesize=512,mul = 1.0, add = 0.0;
		^this.multiNew('audio', in, kernel, framesize).madd(mul, add);
	}
}

//fixed kernel convolver with fix by nescivi to update the kernel on receipt of a trigger message 
Convolution2 : UGen
{
 *ar { arg in, bufnum, trigger, framesize=0,mul = 1.0, add = 0.0;
  ^this.multiNew('audio', in, bufnum, trigger, framesize).madd(mul, add);
 }
}

//fixed kernel convolver with linear crossfade
Convolution2L : UGen
{
 *ar { arg in, bufnum, trigger, framesize=0, crossfade=1, mul = 1.0, add = 0.0;
  ^this.multiNew('audio', in, bufnum, trigger, framesize, crossfade).madd(mul, add);
 }
}

//time based convolution by nescivi
Convolution3 : UGen
{
 *ar { arg in, kernel, trigger=0, framesize=0, mul = 1.0, add = 0.0;
  ^this.multiNew('audio', in, kernel, trigger, framesize).madd(mul, add);
 }
 *kr { arg in, kernel, trigger=0, framesize=0, mul = 1.0, add = 0.0;
  ^this.multiNew('control', in, kernel, trigger, framesize).madd(mul, add);
 }
}


//jensen andersen inspired FFT feature detector
PV_JensenAndersen : UGen
{
	*ar { arg buffer, propsc=0.25, prophfe=0.25, prophfc=0.25, propsf=0.25, threshold=1.0, waittime=0.04;
		^this.multiNew('audio', buffer, propsc, prophfe, prophfc, propsf,  threshold, waittime);
	}
}


PV_HainsworthFoote : UGen
{
	*ar { arg buffer, proph=0.0, propf=0.0, threshold=1.0, waittime=0.04;
		^this.multiNew('audio', buffer, proph, propf, threshold, waittime);
	}
}

//not FFT but useful for time domain onset detection
RunningSum : UGen
{
	*ar { arg in, numsamp=40;
		^this.multiNew('audio', in, numsamp);
	}
	
	*kr { arg in, numsamp=40;
		^this.multiNew('control', in, numsamp);
	}
	
	*rms { arg in, numsamp=40;
		^(RunningSum.ar(in.squared,numsamp)*(numsamp.reciprocal)).sqrt;
	}
}


