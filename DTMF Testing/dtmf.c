  // 24bit DDS algorithm for dual simultaneous sinewaves on one PWM module
  // this is an example for DTMF generation
  // 8 MHz xtal (8 MIPS on PIC 18F PLL)
  #define Frow0 46775   // 697 Hz  DTMF rows
  #define Frow1 51674   // 770 Hz
  #define Frow2 57177   // 852 Hz
  #define Frow3 63149   // 941 Hz
  #define Fcol0 81135   // 1209 Hz  DTMF columns
  #define Fcol1 89657   // 1336 Hz
  #define Fcol2 99120   // 1477 Hz
  #define Fcol3 109589  // 1633 Hz
  unsigned long waveA   absolute 0x15;   // 32bit accumulator for the sinewaves
  unsigned char waveA_2 absolute 0x17;   // overload for fast access to byte 2
  unsigned long waveB   absolute 0x19;
  unsigned char waveB_2 absolute 0x1B;
  unsigned char pwm;

  // This uses dual sinewaves of 28% different amplitudes, to match the spec for "twist" in
  // telephone DTMF to ensure the higher freq has a higher amplitude, to cope with line losses.
  const unsigned char sine64low[64] = {
  39,42,46,50,53,57,60,63,66,68,71,72,74,75,76,77,77,77,76,75,74,72,71,68,66,63,60,57,53,50,46,42
  39,35,31,27,24,20,17,14,11,9,6,5,3,2,1,0,0,0,1,2,3,5,6,9,11,14,17,20,24,27,31,35};
  const unsigned char sine64high[64] = {
  50,54,59,64,68,73,77,81,85,88,91,93,95,97,98,99,99,99,98,97,95,93,91,88,85,81,77,73,68,64,59,54,
  50,45,40,35,31,26,22,18,14,11,8,6,4,2,1,0,0,0,1,2,4,6,8,11,14,18,22,26,31,35,40,45};

  // loop and generate dual sinewave DTMF tone
  PR2 = (128-1);            // PWM at period = 128
  while(1)
  {
    while(!PIR1.TMR2IF);  // sync to start of PWM cycle
    PIR1.TMR2IF = 0;

    // calc the A sinewave, 
    waveA += Frow0;               // zero error Accumulation 
    pwm = sine64low[waveA_2 & 0x3F]; // Binary Divide output (/65536) and keep 6 bits
    // calc the B sinewave, and ADD the 2 waves together
    waveB += Fcol0;
    pwm += sine64high[waveB_2 & 0x3F];
    pwm = (pwm >> 1);   // scale 0-200 back to 0-100 for PWM
    CCPR2L = pwm;       // load added sinewaves into PWM module
  }

