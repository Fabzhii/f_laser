# f_laser
A weapon laser system with nvg functions.
Statebags are used to to sync coords and colors between the players.

## Exports

| Exports         | Description                         | Parameter(s)    |
|-----------------|-------------------------------------|-----------------|
| toggleLaser     |  Toggle the laser                   | bool / nil      |
| toggleInfrared  |  Toggle laser to infrared/normal    | bool / nil      |
| toggleVisor     |  Toggle NVGs to see infrared laser  | bool / nil      |

If you leave the parameter empty it gets toggled, otherwise it is set to the bool
