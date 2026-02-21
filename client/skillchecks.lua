Skillcheck = {}


function Skillcheck.StartFirst()
    return exports.ox_lib:skillCheck(Config.skillcheck.first_task.difficulty, Config.skillcheck.first_task.keys)
end

function Skillcheck.StartSecond()
    return exports.ox_lib:skillCheck(Config.skillcheck.second_task.difficulty, Config.skillcheck.second_task.keys)
end

function Skillcheck.StartThird()
    return exports.ox_lib:skillCheck(Config.skillcheck.third_task.difficulty, Config.skillcheck.third_task.keys)
end