This FiveM script allows players to attach and detach vehicles to and from other vehicles using simple chat commands and is standalone, no dependencies, which means you can use it with any framework in any server.

Commands:
/attach [model] - Attaches your vehicle (or a nearby vehicle) to the closest vehicle of the specified model within range. Specify [model] if you want to attach a vehicle to another vehicle. Example: /attach il76 (attaches the vehicle you are in or standing nearby of to the vehicle you want to).
/detach - Detaches your current or nearby attached vehicle and places you in the driver seat if nearby, if detaching from inside the vehicle, the vehicle will just be detached, nothing else.

Features:
- Supports multiple vehicle-to-vehicle attachments at once, no limitations.
- Fully synced with other players — everyone sees attached vehicles correctly.
- Attaching works inside or outside of vehicles.
- Supports cargo planes, ships, trailers, or any vehicle type.

By default:
- Attach radius from inside a vehicle: 30 units.
- Attach radius from outside a vehicle: 5 units.
- Detach radius from outside a vehicle: 5 units.
- Detach radius from inside a vehicle: (not required).

Usage:
- Attaching: /attach [model] , [model] of the vehicle you want to attach to. (Example: /attach il76).
- Detaching: /detach

Lightweight, no server-side component required. All operations are client-side and synced across players.
