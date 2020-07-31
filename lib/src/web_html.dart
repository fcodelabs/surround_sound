String html(String background) {
  return '''
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Audio API</title>
</head>
<body style="background-color:$background;">
<script>
    console.clear();
    let audioCtx;
    let panner;
    let listener;
    let oscillator;
    let volumeController;

    let started = false;
    let xPos = 30;
    let yPos = 30;
    let zPos = 300;
    let freq = 512;
    let vol = 0.5;

    function _setPanner() {
        if (panner.positionX) {
            panner.positionX.value = xPos;
            panner.positionY.value = yPos;
            panner.positionZ.value = zPos;
        } else {
            panner.setPosition(xPos, yPos, zPos);
        }
    }

    async function _things() {
        let AudioContext = window.AudioContext || window.webkitAudioContext;
        audioCtx = new AudioContext();

        panner = audioCtx.createPanner();
        panner.panningModel = 'HRTF';
        panner.distanceModel = 'inverse';
        panner.refDistance = 1;
        panner.maxDistance = 10000;
        panner.rolloffFactor = 1;
        panner.coneInnerAngle = 360;
        panner.coneOuterAngle = 0;
        panner.coneOuterGain = 0;

        if (panner.orientationX) {
            panner.orientationX.value = 0;
            panner.orientationY.value = 0;
            panner.orientationZ.value = -1;
        } else {
            panner.setOrientation(0, 0, -1);
        }

        listener = audioCtx.listener;

        if (listener.forwardX) {
            listener.forwardX.value = 0;
            listener.forwardY.value = 0;
            listener.forwardZ.value = 1;
            listener.upX.value = 0;
            listener.upY.value = 1;
            listener.upZ.value = 0;
        } else {
            listener.setOrientation(0, 0, 1, 0, 1, 0);
        }

        if (listener.positionX) {
            listener.positionX.value = xPos;
            listener.positionY.value = yPos;
            listener.positionZ.value = zPos;
        } else {
            listener.setPosition(xPos, yPos, zPos);
        }

        _setPanner();

        oscillator = audioCtx.createOscillator();
        oscillator.type = 'square';
        oscillator.frequency.value = freq;
        oscillator.start();

        volumeController = audioCtx.createGain();
        volumeController.gain.value = vol;

        // Connecting
        oscillator.connect(panner);
        panner.connect(volumeController)
    }

    async function init_sound() {
        if (!audioCtx) {
            await _things();
        }

        // check if context is in suspended state (autoplay policy)
        if (audioCtx.state === 'suspended') {
            audioCtx.resume();
        }
    }

    function play() {
        if (!started) {
            volumeController.connect(audioCtx.destination);
            started = true;
        }
    }

    function stop() {
        if (started) {
            volumeController.disconnect(audioCtx.destination);
            started = false;
        }
    }

    function set_panner(x, y, z) {
        xPos = x;
        yPos = y;
        zPos = z;
        _setPanner();
    }

    function set_freq(f) {
        freq = f;
        oscillator.frequency.value = freq;
    }

    function set_volume(v) {
        vol = v;
        volumeController.gain.value = vol;
    }

</script>
</body>
</html>
''';
}
