# d4tVehicles

d4tVehicles is a vehicle ownership, garage, key, fuel and vehicle-state system for d4tCore.

## Features

- Owned vehicles
- Garage UI
- Impound support
- Vehicle keys
- Key sharing
- Lock and unlock command
- Fuel usage
- Mileage tracking
- Engine and body health saving
- Vehicle state saving
- MySQL persistence
- Preview UI
- d4tInventory trunk and glovebox ready
- d4tData ready

## Installation

1. Import:

```text
sql/d4t_vehicles.sql
```

2. Start resources:

```cfg
ensure d4tConnection
ensure d4tData
ensure d4tInventory
ensure d4tCore
ensure d4tVehicles
```

3. Optional admin permission:

```cfg
add_ace group.admin d4tVehicles.admin allow
```

## UI Preview

Open:

```text
web/preview.html
```

## Commands

```text
/garage
/vlock
```

Default garage key:

```text
F6
```

Default lock key:

```text
L
```

## Database Tables

- `d4t_vehicles`
- `d4t_vehicle_keys`
- `d4t_vehicle_history`

## Garages

Garages are configured in:

```text
shared/garages.lua
```

## Configuration

Main configuration:

```text
shared/config.lua
```

## Server Exports

### GetPlayerVehicles

```lua
local vehicles = exports.d4tVehicles:GetPlayerVehicles(source)
```

### GetVehicleByPlate

```lua
local vehicle = exports.d4tVehicles:GetVehicleByPlate(plate)
```

### CreateOwnedVehicle

```lua
local id, plate = exports.d4tVehicles:CreateOwnedVehicle(source, 'sultan', 'legion')
```

### HasVehicleKey

```lua
local hasKey = exports.d4tVehicles:HasVehicleKey(source, plate)
```

### GiveVehicleKey

```lua
exports.d4tVehicles:GiveVehicleKey(source, plate, 'shared')
```

### SaveVehicleData

```lua
exports.d4tVehicles:SaveVehicleData(plate, data)
```

## Test Vehicle

Admins can create a test vehicle using:

```lua
TriggerServerEvent('d4tVehicles:server:createTestVehicle', 'sultan')
```

## Notes

d4tVehicles is designed to be expanded with dealerships, tuning, insurance and police impound systems.
