
#include "mem_drtd.h"	// see data file for memory structure and register offsets

// globals follow
s_vars			vars;
char			vers[]		= {"1.00000"};
float			iir			= .707;
float			pid_err;
int16			padd;
char			rx_timer 	= 0;
char			rx_count 	= 0;
char			end_count	= RX_MAX;
int1			bLock;
int1			bUpdate;
int32			ticks		= 0;
char			rx_tx[RX_MAX];
