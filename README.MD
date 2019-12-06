
Tektronix DPO4000
========================================

Interfaced via TCP socket.
Note: setting IP address will fail with "Invalid device IP address" unless a network cable is connected!
"Socket Server" should be enabled, using port 4000.
Device should now respond to 'ping', show web page on http:// port 80, and be accessible via 'telnet' on port 4000.

Implemented via simple 'stream' device protocol,
some subroutine records to scale waveforms.

Example commands to type:
 *IDN?

Select ASCII:
DATa:ENCd ASCIi;

Select signed binary, MSB first:
DATa:ENCd RIBinary;


:HEAD OFF;:VERB ON;:DAT:STAR 1;:DAT:STOP 10000;:DAT:WID 1;:DAT:ENC ASCII;
:DAT:SOU CH1;:CURV?

DATa:ENCd RIBinary;:DAT:SOU CH1;:CURV?


Must not query channel that's disabled.
Select and enable channel:
:SEL:CH4 1;

Check if channel is enabled:
:SEL:CH4?

In case of 'error', how to recover? Scope just stops responding for a long time...
*ESR?
*CLS;

