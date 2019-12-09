/** Sequence to process chains for proc1, 2, 3, 4
 *  in that order, waiting for each chain to complete,
 *  then reading them again after a short delay
 */
program Process("P=Test_LLRF:,R=DSO_Kly1")

short mode;
assign mode to "{P}{R}:mode";
monitor mode;

short proc[4];
assign proc to { "{P}{R}:proc1", "{P}{R}:proc2", "{P}{R}:proc3", "{P}{R}:proc4" };

int i;

ss process
{
  state local
  {
    when (mode > 0)
    {
      printf("Process: Remote\n");
    }
    state remote
  }

  state remote
  {
    when (mode < 1)
    {
      printf("Process: Local\n");
    }
    state local

    when (delay(0.5))
    {
    }
    state process
  }

  state process
  {
    when ()
    {
      for (i=0; i<4; ++i)
      {
        proc[i] = 1;
        pvPut(proc[i], SYNC);
      }
    }
    state remote
  }
}
