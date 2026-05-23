function PlayerIdentifier(source)
    local core = exports.d4tCore:AccessCore()

    if core and core.Player and core.Player.Identifier then
        return core.Player.Identifier(source)
    end

    for _, identifier in ipairs(GetPlayerIdentifiers(source)) do
        if identifier:find('license:') then
            return identifier
        end
    end

    return tostring(source)
end
