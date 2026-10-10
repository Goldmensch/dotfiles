{
    services.mosquitto = {
        enable = true;
        listeners = [
            {
                address = "localhost";
                port = 1883;

                users.hass = {
                    acl = [ "readwrite #" ];
                    hashedPassword = "$7$101$bpHNTzTKudqToBkt$hN2PfR2rNueP2gnhlPeyInjt8sJiWaWtE83Q9PmI/I7XI6n3SqOnAkmJm1eaSB8scwsa5Gk6SIV2X+kbDtqk6A==";
                };
            }
        ];
    };
}
