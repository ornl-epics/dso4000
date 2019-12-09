/** Sequence to process chains for proc1, 2, 3, 4
 *  in that order, waiting for each chain to complete,
 *  then reading them again after a short delay
 */
program Process("P=Test_LLRF:,R=DSO_Kly1")

%% #include <epicsTime.h>

short mode;
assign mode to "{P}{R}:mode";
monitor mode;

short proc[4];
assign proc to { "{P}{R}:proc1", "{P}{R}:proc2", "{P}{R}:proc3", "{P}{R}:proc4" };


double scantime;
assign scantime to "{P}{R}:scantime";

double scandelay;
assign scandelay to "{P}{R}:scandelay";
monitor scandelay;


%% epicsTimeStamp start, end;
int i;

ss process
{
  state local
  {
    entry
    {
      printf("Process: Local\n");
      scantime = 0.0;
      pvPut(scantime);
    }

    when (mode > 0) {} state remote
  }

  state remote
  {
    entry
    {
      printf("Process: Remote\n");
    }

    when (mode < 1) {} state local

    when (delay(scandelay))
    {
%%    epicsTimeGetCurrent(&start);
      for (i=0; i<4; ++i)
      {
        proc[i] = 1;
        pvPut(proc[i], SYNC);
      }
%%    epicsTimeGetCurrent(&end);
%%    pVar->scantime = epicsTimeDiffInSeconds(&end, &start);
      pvPut(scantime);
    } state remote
  }
}
