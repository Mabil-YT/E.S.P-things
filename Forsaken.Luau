local library = loadstring(game:HttpGet("https://github.com/GoHamza/AppleLibrary/blob/main/main.lua?raw=true"))()

local WindowOpenKey = Instance.new("StringValue")
WindowOpenKey.Value = "Enum.KeyCode.RightShift"

local MainWindow = library:init("E.S.P For Forsaken", true, WindowOpenKey, true)
MainWindow:Divider("There would be some Malicious things there, they will be highlighted in red, be careful!")

local Settings = MainWindow:Section("E.S.P Settings")

-------------------------------------------------------------------
--       ↓↓          Settings Section Code          ↓↓           --
-------------------------------------------------------------------

local UserInputService = game:GetService("UserInputService")

local Settings = MainWindow:Section("E.S.P Settings")

-- Label showing the current key
local KeyLabel = Settings:Label("Current Menu Key: " .. WindowOpenKey.Value:gsub("Enum.KeyCode.", ""))

-- Listening state
local listening = false

-- Nicer popup indicator
local ListeningPopup = nil

local function ShowListeningPopup()
    ListeningPopup = MainWindow:Notify(
        "Listening...",
        "Press any key to set a new menu key.",
        "Info",
        "rbxassetid://12608259004"
    )
end

local function CloseListeningPopup()
    if ListeningPopup and ListeningPopup.Close then
        ListeningPopup:Close()
    end
end

-------------------------------------------------------------------
--                     Change Menu Key Button                    --
-------------------------------------------------------------------

Settings:Button("Change Menu Key", function()
    if listening then return end
    listening = true

    ShowListeningPopup()

    local connection
    connection = UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.KeyCode == Enum.KeyCode.Unknown then return end

        -- Update key
        WindowOpenKey.Value = tostring(input.KeyCode)

        -- Update label
        KeyLabel:Set("Current Menu Key: " .. tostring(input.KeyCode):gsub("Enum.KeyCode.", ""))

        CloseListeningPopup()

        MainWindow:Notify(
            "Success!",
            "Menu key set to " .. tostring(input.KeyCode):gsub("Enum.KeyCode.", ""),
            "Success",
            "rbxassetid://12608259004"
        )

        listening = false
        connection:Disconnect()
    end)
end)

-------------------------------------------------------------------
--                     Reset to Default Button                   --
-------------------------------------------------------------------

Settings:Button("Reset Menu Key to Default", function()
    WindowOpenKey.Value = "Enum.KeyCode.RightShift"
    KeyLabel:Set("Current Menu Key: RightShift")

    MainWindow:Notify(
        "Reset!",
        "Menu key reset to RightShift.",
        "Info",
        "rbxassetid://12608259004"
    )
end)

-------------------------------------------------------------------
--                     UI Theme Settings                         --
-------------------------------------------------------------------

Settings:Divider("UI Theme Settings")

Settings:Dropdown("Theme", {"Dark", "Light", "Aqua", "Midnight", "Cherry"}, "Dark", function(theme)
    library:ChangeTheme(theme)

    MainWindow:Notify(
        "Theme Updated",
        "UI theme changed to " .. theme,
        "Success",
        "rbxassetid://12608259004"
    )
end)

Settings:Slider("UI Transparency", 0, 0.5, 1, function(value)
    library:SetTransparency(value)
end)

Settings:Slider("UI Blur", 0, 5, 20, function(value)
    library:SetBlur(value)
end)
