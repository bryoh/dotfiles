#!/usr/bin/env python3
#
# Copyright (C) 2016 James Murphy
# Licensed under the GPL version 2 only
#
# A battery indicator blocklet script for i3blocks

from subprocess import check_output

status = check_output(['acpi'], universal_newlines=True)

if not status:
    # stands for no battery found
    fulltext = "<span color='red'><span font='FontAwesome'>\uf00d \uf240</span></span>"
    percentleft = 100
else:

    percentleft = 0    
    state = status.split("\n")
    del state[-1]
    timeleft = ""

    for i,line in enumerate(state):
        percentleft += int(float(line.split(", ")[1].rstrip("%")) / (len(state)*100) * 100)
        state[i] = line.split(": ")[1].split(",")[0]
        if len(line.split(", ")) > 2:
            timeleft = line.split(", ")[2].split()[0]
 
    FA_LIGHTNING = "<span color='yellow'><span font='FontAwesome'>\uf0e7</span></span>"     # Charging icon (lightning bolt)
    FA_PLUG = "<span font='FontAwesome'>\uf1e6</span>"          # Plugged in icon (plug)
    FA_QUESTION = "<span font='FontAwesome'>\uf128</span>"      # Unknown state (question mark)

    fulltext = ""
    timeleft_symbol = "-"
    
    # At least one battery is full
    if all(s == "Full" for s in state):
            fulltext = FA_PLUG
    
    elif "Charging" in state or "Discharging" in state:
        if "charging" in timeleft:  # catch when no time return is given
            timeleft = ""
        else:
            time = ":".join(timeleft.split(":")[0:2])
            timeleft = "{}".format(time)

        if "Charging" in state:
            fulltext = FA_PLUG + FA_LIGHTNING
            timeleft_symbol = "+"


    elif all(s=="Unknown" for s in state):
        fulltext = FA_PLUG + FA_QUESTION
    else:
        fulltext = FA_QUESTION 

    if "Discharging" not in state:
        fulltext += " "

    if percentleft >= 100:
        timeleft = " (FULL)"
    elif ":" in timeleft:
        timeleft = " ({}{})".format(timeleft_symbol, timeleft)
    
    def color(percent):
        if percent < 10:
            # exit code 33 will turn background red
            return "#FFFFFF"
        if percent < 20:
            return "#FF0000"
        if percent < 30:
            return "#FF3300"
        if percent < 40:
            return "#FF6600"
        if percent < 50:
            return "#FF9900"
        if percent < 60:
            return "#FFCC00"
        if percent < 70:
            return "#FFFF00"
        return "#CCFF00" if percent < 80 else "#00FF00"

    form =  '<span color="{}">{}%</span>'
    fulltext += form.format(color(percentleft), percentleft)
    fulltext += timeleft

print(fulltext)
print(fulltext)
if percentleft < 10:
    exit(33)
