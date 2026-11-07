--- @sync entry

return {
    setup = function(state)
        state.history = {}
        state.position = {}

        ps.sub("cd", function(body)
            if not body or not body.tab then
                return
            end

            local tab = body.tab
            if not tab then
                return
            end
            
            local cwd = Url(cx.active.current.cwd)

            local history = state.history[tab] or {}
            local position = state.position[tab] or 0

            -- Ignore duplicate directories.
            if history[position]
                and tostring(history[position]) == tostring(cwd) then
                return
            end

            -- Discard forward history.
            for i = #history, position + 1, -1 do
                history[i] = nil
            end

            table.insert(history, cwd)

            state.history[tab] = history
            state.position[tab] = #history
        end)
    end,

    entry = function(state, job)
        local tab = cx.tabs.idx
        local history = state.history[tab]
        local position = state.position[tab]

        if not history or not position then
            return
        end

        local direction = job.args[1]

        if direction == "back" then
            position = position - 1
        elseif direction == "forward" then
            position = position + 1
        else
            return
        end

        if position < 1 or position > #history then
            return
        end

        state.position[tab] = position

        -- Clone the URL because ya.emit transfers ownership.
        ya.emit("cd", { Url(history[position]) })
    end,
}