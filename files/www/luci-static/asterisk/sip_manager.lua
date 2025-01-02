module("luci.controller.asterisk.sip_manager", package.seeall)

function read_sip_users()
    local users = {}
    local file = io.open("/etc/asterisk/pjsip.conf", "r")
    if file then
        for line in file:lines() do

            if line:match("^%[(%d+)%]") then
                table.insert(users, line:match("^%[(%d+)%]"))
            end
        end
        file:close()
    end
    return users
end

function index()
    entry({"admin", "services", "asterisk", "sip_manager"}, call("action_sip_manager"), _("SIP Server Manager"), 60)
end

function action_sip_manager()
    local http = require("luci.http")
    local form = http.formvalue("option")
    local users = read_sip_users()


    http.prepare_content("text/html")
    http.write([[
        <html>
        <head>
            <title>SIP Server Manager</title>
        </head>
        <body>
            <img src="/path/to/banner.jpg" alt="SIP Banner" />
            <h1>SIP Users</h1>
            <ul>
    ]])


    for _, user in ipairs(users) do
        http.write("<li>" .. user .. "</li>")
    end

    http.write([[
            </ul>
            <form method="post">
                <input type="submit" name="option" value="1" /> New SIP User
                <input type="submit" name="option" value="2" /> Delete SIP User
                <input type="submit" name="option" value="3" /> Show Users
                <input type="submit" name="option" value="4" /> Back to Asterisk
            </form>
        </body>
        </html>
    ]])

    if form == "1" then
        os.execute("bash /etc/asterisk/create_sip_user.sh")
        http.redirect("/admin/services/asterisk/sip_manager")
    elseif form == "2" then
        os.execute("bash /etc/asterisk/delete_sip_user.sh")
        http.redirect("/admin/services/asterisk/sip_manager")
    elseif form == "3" then
        os.execute("asterisk -rx 'pjsip list endpoints'")
        http.redirect("/admin/services/asterisk/sip_manager")
    elseif form == "4" then
        http.redirect("/admin/services/asterisk")
    else
        http.redirect("/admin/services/asterisk/sip_manager")
    end
end
