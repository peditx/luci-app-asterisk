module("luci.controller.asterisk.sip_manager", package.seeall)

function index()
    entry({"admin", "asterisk", "sip_manager"}, call("action_sip_manager"), _("SIP Server Manager"), 60)
end

function action_sip_manager()
    local http = require("luci.http")
    local form = http.formvalue("option")

    if form == "1" then

        os.execute("bash /etc/asterisk/create_sip_user.sh")
        http.redirect("/admin/asterisk/sip_manager")
    elseif form == "2" then

        os.execute("bash /etc/asterisk/delete_sip_user.sh")
        http.redirect("/admin/asterisk/sip_manager")
    elseif form == "3" then

        os.execute("asterisk -rx 'pjsip list endpoints'")
        http.redirect("/admin/asterisk/sip_manager")
    elseif form == "4" then

        http.redirect("/admin/asterisk")
    else
        http.redirect("/admin/asterisk/sip_manager")
    end
end
