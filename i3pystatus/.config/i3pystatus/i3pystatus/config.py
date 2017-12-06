# Configuration files for mongolia machine
# Rachel Shaw <rshaw@olivermattei.net>
from i3pystatus import Status
from i3pystatus.weather import weathercom

status = Status()

# Displays clock like this:
# Tue 30 Jul 2016 11:59:46 PM KW31
status.register("clock",
    format="%a %-d %b %Y %X KW%V",)

# Shows the average load of the last minute and the last 5 minutes
# (the default value for format is used)
status.register("load",
    # on left click, let us run a system monitor to see what's up
    on_leftclick="urxvt -name mongolia -e htop")

# Shows CPU usage
# status.register("cpu_usage_bar",)
status.register("cpu_usage_graph",)
status.register("cpu_usage",
    format="CPU: {usage}%",)

# NetSpeed module appears to not be functional atm
#status.register("net_speed")
status.register(
    'weather',
    format='Current Temp: {current_temp}{temp_unit}[ (Hi: {high_temp}[{temp_unit}]] Lo: {low_temp}{temp_unit} Hum: {humidity}%',
    colorize=True,
    backend=weathercom.Weathercom(
	location_code='22904:4:US',
        units='metric',
    ),
)

# Shows your CPU temperature, if you have a Intel CPU
status.register("temp",
    format="CPU: {temp:.0f}°C",)

# Show GPU temp --> missing files, does not work.
#status.register("gpu_temp")

# Displays whether a DHCP client is running
#status.register("runwatch",
#    name="DHCP",
#    path="/var/run/dhclient*.pid",)

# Shows the address and up/down state of eth0. If it is up the address is shown in
# green (the default value of color_up) and the CIDR-address is shown
# (i.e. 10.10.10.42/24).
# If it's down just the interface name (eth0) will be displayed in red
# (defaults of format_down and color_down)
#
# Note: the network module requires PyPI package netifaces
status.register("network",
    interface="eth0",
    format_up="{v4cidr}",)

#status.register("net_speed")
# Note: requires both netifaces and basiciw (for essid and quality)
#status.register("network",
#    interface="wlp2s0",
#    format_up="{essid}{quality:3.0f}%",)

# Shows disk usage of /
# Format:
# 42/128G [86G]
#status.register("disk",
#    path="/",
#    format="{used}/{total}G [{avail}G]",)

# Shows pulseaudio default sink volume
#
# Note: requires libpulseaudio from PyPI
status.register("pulseaudio",
    format="♪: {volume}",)

# Shows spotify status
status.register("spotify",
    format="{artist} —→ {title} ({length})",)

status.run()

