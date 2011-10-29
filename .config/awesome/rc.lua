-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
-- Widget library (git clone)
require("vicious")
-- dropdown regular apps, like tilda. 
-- ("togglefloat a client" finns redan)
-- keybinds?
--require("scratch")
-- Dynamic tags when needed
--require("eminent")
require("revelation")  -- mac exposé

-- applications menu
  require('freedesktop.utils')
--  freedesktop.utils.terminal = terminal  -- default: "xterm"
  freedesktop.utils.icon_theme = 'Tango'   -- look inside /usr/share/icons/, default: nil (don't use icon theme)
  require('freedesktop.menu')
--  require("debian.menu")                 -- vi kör inte debian

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
-- beautiful.init("/usr/share/awesome/themes/default/theme.lua")
beautiful.init("/home/occam/.config/awesome/themes/zenburn/theme.lua")

--just set this once, from the cli instead:
--os.execute("awsetbg -u feh -f /home/occam/pics/wallpapers/arch_headphones2.png")

-- This is used later as the default terminal and editor to run.
--terminal = "terminal"
terminal = "urxvt -pe tabbed" --modkey+ret awful.util.spawn_with_shell line ~258
-- commented out ctrl ret in .xbindkeysrc
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Usually, Mod4 is the key with a logo between Control and Alt.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
-- fair needed by "revelation.lua"?
layouts =
{
	-- behöver inte byta ordning
    awful.layout.suit.tile,			-- 1
    awful.layout.suit.tile.left,	-- 2
    awful.layout.suit.tile.bottom,	-- 3 setting to default
    awful.layout.suit.tile.top,		-- 4
--    awful.layout.suit.fair, 
--    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.floating
}

-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }, s, awful.layout.suit.tile.bottom)
end
-- }}}

-- {{{ Vanilla Menu (empty)
-- Create a laucher widget and a main menu
-- hittar inte pryttlar från freedesktop när försöker kommentera ut originalet
--myawesomemenu = {
   --{ "manual", terminal .. " -e man awesome" },
   --{ "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   --{ "restart", awesome.restart },
   --{ "quit", awesome.quit }
--}

--mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    --{ "open terminal", terminal }
                                  --}
                        --})

--mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     --menu = mymainmenu })
-- }}}

-- {{{ Freedesktop menu
-- Create a laucher widget and a main menu
-- hittar inte pryttlar från freedesktop när försöker kommentera ut originalet
menu_items = freedesktop.menu.new()
myawesomemenu = {
   { "manual", terminal .. " -e man awesome", freedesktop.utils.lookup_icon({ icon = 'help' }) },
   { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua", freedesktop.utils.lookup_icon({ icon = 'package_settings' }) },
   { "restart", awesome.restart, freedesktop.utils.lookup_icon({ icon = 'gtk-refresh' }) },
   { "quit", awesome.quit, freedesktop.utils.lookup_icon({ icon = 'gtk-quit' }) }
  }
table.insert(menu_items, { "awesome", myawesomemenu, beautiful.awesome_icon })
table.insert(menu_items, { "open terminal", terminal, freedesktop.utils.lookup_icon({icon = 'terminal'}) })
-- vi kör inte debian:
-- table.insert(menu_items, { "Debian", debian.menu.Debian_menu.Debian, freedesktop.utils.lookup_icon({ icon = 'debian-logo' }) })

mymainmenu = awful.menu.new({ items = menu_items, width = 220 })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

--[[  -- desktop icons
  require('freedesktop.desktop')  -- "./freedesktop/desktop.lua:8: module 'awful' not found"
  for s = 1, screen.count() do
        freedesktop.desktop.add_applications_icon({screen = s, showlabels = true})
        freedesktop.desktop.add_dirs_and_files_icon({screen = s, showlabels = true})
  end
--]]

-- }}}

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock({ align = "right" })

-- Create a systray
mysystray = widget({ type = "systray" })

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 5, awful.tag.viewnext),
                    awful.button({ }, 4, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)
					  
	-- Initialize widget
	-- Register widget

    -- Create the wibox
	mywibox[s] = awful.wibox({ position = "bottom", screen = s })
    --mywibox[s] = awful.wibox({ position = "left", screen = s })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            mylauncher,
            mytaglist[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        mylayoutbox[s],
        mytextclock,
        s == 1 and mysystray or nil,
        mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
    }
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 5, awful.tag.viewnext),
    awful.button({ }, 4, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),
    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:toggle({ keygrabber = true})        end),

    -- Layout manipulation
    awful.key({ modkey            }, "e",  revelation.revelation), -- mac exposé
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then 
		-- använder kbd. här vill vi ha raise, även om floating.
                client.focus:raise() 
            end
        end),

        -- alt-tab. use other keys instead
    awful.key({ "Mod1" }, "Tab", function ()
         -- If you want to always position the menu on the same place set coordinates
        awful.menu.menu_keys.down = { "Down", "Tab" }   -- alternative
        awful.menu.menu_keys.up = { "Up", "Alt_L" }
        local cmenu = awful.menu.clients({width=250}, { keygrabber=true, coords={x=0, y=0} })
    end),

    -- Standard program
    --awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey,           }, "Return", function () awful.util.spawn_with_shell(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),
	-- FIXME dollar Dollar $ wontwork, xbindkeys also fails
    --awful.key({ modkey,           }, "Dollar", awful.util.spawn("/usr/bin/site_perl/dmenuclip")),
    awful.key({         "Control" }, "Escape", awful.util.spawn("/usr/bin/site_perl/dmenuclip")),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),
	awful.key({ modkey, "Control" }, "n", awful.client.restore),

    --toggle statusbar
    awful.key({ modkey }, "b", function ()
    	mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible
    end),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey, "Control" }, "Next",  function () awful.client.moveresize( 40,  40, -80, -80) end),
    awful.key({ modkey, "Control" }, "Prior", function () awful.client.moveresize(-40, -40,  80,  80) end),
    awful.key({ modkey, "Control" }, "Down",  function () awful.client.moveresize(  0,  40,   0,   0) end),
    awful.key({ modkey, "Control" }, "Up",    function () awful.client.moveresize(  0, -40,   0,   0) end),
    awful.key({ modkey, "Control" }, "Left",  function () awful.client.moveresize(-40,   0,   0,   0) end),
    awful.key({ modkey, "Control" }, "Right", function () awful.client.moveresize( 40,   0,   0,   0) end),
    
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digits we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize),
    --alt like other window managers and resize with scrollwheel
    awful.button({ "Mod1" }, 1, awful.mouse.client.move),
    awful.button({ "Mod1" }, 3, awful.mouse.client.resize),
    awful.button({ modkey }, 5, function () awful.tag.incmwfact( 0.04)   end),
    awful.button({ modkey }, 4, function () awful.tag.incmwfact(-0.04)   end),
    awful.button({ "Mod1" }, 5, function () awful.tag.incmwfact( 0.04)   end),
    awful.button({ "Mod1" }, 4, function () awful.tag.incmwfact(-0.04)   end))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
--              xprop output:
--  WM_CLASS(STRING) = "smplayer", "Smplayer"
--                       |           |--- class
--                       |--- instance
--                       
--   WM_NAME(STRING) = "SMPlayer"
--                      |--- name
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
		     size_hints_honor = false, --fixar terms
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "Galculator" },
      properties = { floating = true } },
    { rule = { class = "Xsensors" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "Gimp" },
      properties = { floating = true } },
    { rule = { class = "Vlc" },
      properties = { floating = true } },
    { rule = { class = "Qjackctl" },
      properties = { floating = true } },
	  --string.match (string, pattern)
    --{ rule = { string.match( class, "REBOL" ) },
      --properties = { floating = true } },

    --{ rule = { class = "Opera" },
      --properties = { floating = false } },
    --{ rule = { instance = "addbookmarkdialog" },
      --properties = { floating = true } },
    --{ rule = { instance = "findtextdialog" },
      --properties = { floating = true } },
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[1][2] } },
}

-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
	-- vill vi ha raise-on-focus i floating layout? små fönster försvinner direkt bakom större
        --    c:raise()  	
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        awful.client.setslave(c)
        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

--funkar ju inte så jävla bra. $USERNAME (isf user)
--To execute an application only once, e.g. for restarting awesome, 
--use this function (from the awesome wiki):
--använder visst inte awful.util.spawn, skulle va bättre?
function run_once(prg)
	if not prg then
		do return nil end
	end
	--             x=$prg; pgrep -u $USER -x $prg || ($prg &)
	os.execute("x=" .. prg .. "; pgrep -u $USER -x " .. prg .. " || (" .. prg .. " &)")
end

-- AUTORUN APPS!
run_once("parcellite")
--run_once("xmodmap ~/.Xmodmap") -- script  i bin från .xinitrc ist
run_once("wicd-client")
run_once("terminal")
--run_once("urxvt -pe tabbed")
--run_once("gvim /home/occam/doku/laplacelog")
run_once("gvim -S ~/doku/vimse")
---- lägg på andra tags
--run_once("chromium-browser")
--run_once("")

