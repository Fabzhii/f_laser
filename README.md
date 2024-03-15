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

## Config 

| Settings        | Description                                 | Parameter(s)        |
|-----------------|---------------------------------------------|---------------------|
| RenderDistance  |  Distance in which the lasers get rendered  | int                 |
| Green           |  The Color of the Green laser               | vector4(r, g, b, a) |
| White           |  The Color of the infrared laser            | vector4(r, g, b, a) |
