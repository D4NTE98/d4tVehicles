DB = {}

function DB.Query(query, params)
    return exports.d4tConnection:Query(query, params or {})
end

function DB.Single(query, params)
    return exports.d4tConnection:Single(query, params or {})
end

function DB.Execute(query, params)
    return exports.d4tConnection:Execute(query, params or {})
end

function DB.Insert(query, params)
    return exports.d4tConnection:Insert(query, params or {})
end
