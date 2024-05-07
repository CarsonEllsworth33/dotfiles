import sys
import subprocess
from enum import StrEnum


class BatteryIndicators(StrEnum):
    LOWBATTERY="🪫"
    HIGHBATTERY="🔋"
    CHARGING="🔌⚡"
    DISCHARGING="🔻"
    FULL="🔌✅"


def get_uptime() -> str:
    uptime:str=subprocess.Popen(("uptime"),stdout=subprocess.PIPE)
    cut1:str=subprocess.Popen(("cut", "-d", ",", "-f1"), stdin=uptime.stdout, stdout=subprocess.PIPE)
    result:str=subprocess.run(["cut", "-d", " ", "-f4,5"], stdin=cut1.stdout, capture_output=True)
    return result.stdout.decode()[1:-1]  # Cut off initial whitespace and ending newline character


def get_date() -> str:
    result:str=subprocess.run(["date", "+%a %F %H:%M"], capture_output=True).stdout.decode()
    print(result.split())
    split = result.split()
    result = "{} {}🗓️ {}".format(split[0],split[1],split[2])
    return result


def get_linux_version() -> str:
    uptime:str=subprocess.Popen(("uname","-r"),stdout=subprocess.PIPE)
    result:str=subprocess.run(["cut", "-d", "-", "-f1"], stdin=uptime.stdout, capture_output=True)
    return result.stdout.decode()[:-1]  # Cut off initial whitespace and ending newline character
    

def get_battery_percent(battery_id=0) -> int:
    """gets the battery percent of the system"""
    result:str=subprocess.run(["cat", "/sys/class/power_supply/BAT{}/capacity".format(battery_id)], capture_output=True).stdout.decode()
    return int(result)


def get_battery_status(battery_id=0) -> str:
    """Gets the current status of the battery. Charging | Discharging | Full"""
    result:str=subprocess.run(["cat", "/sys/class/power_supply/BAT{}/status".format(battery_id)], capture_output=True).stdout.decode()
    return result[:-1] # Cut off the newline character
    

def main(argv=None, argc=None)->None:
    battery_percentage:int = get_battery_percent()
    battery_status:str = get_battery_status()
    battery_indicator: BatteryIndicators
    battery_status_indicator: BatteryIndicators
    if battery_percentage > 25:
        battery_indicator=BatteryIndicators.HIGHBATTERY
    else :
        battery_indicator=BatteryIndicators.LOWBATTERY
    match battery_status.upper():
        case "CHARGING":
            battery_status_indicator=BatteryIndicators.CHARGING
        case "DISCHARGING":
            battery_status_indicator=BatteryIndicators.DISCHARGING
        case "FULL":
            battery_status_indicator=BatteryIndicators.FULL
        case _:
            battery_status_indicator="⚠️"
    status = "{}🐧 | [{}%]{}{} | {}⬆️ | {}🕙".format(get_linux_version(), battery_percentage, battery_indicator, battery_status_indicator, get_uptime(), get_date())
    # print out to stdout which will be grabbed by swaybar
    print(status)
    

main()
