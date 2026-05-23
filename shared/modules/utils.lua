D4TVehicles = D4TVehicles or {}

function D4TVehicles.Json(value)
    return json.encode(value or {})
end

function D4TVehicles.Decode(value)
    if not value or value == '' then
        return {}
    end

    local ok, result = pcall(json.decode, value)

    if ok and type(result) == 'table' then
        return result
    end

    return {}
end

function D4TVehicles.Plate()
    return Config.Vehicle.platePrefix .. tostring(math.random(10000, 99999))
end

function D4TVehicles.Round(value, places)
    local mult = 10 ^ (places or 2)
    return math.floor(value * mult + 0.5) / mult
end
