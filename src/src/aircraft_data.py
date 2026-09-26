"""
Aircraft Maintenance Linux Diagnostic System
Aircraft parameter data and threshold definitions.
"""

AIRCRAFT_ID = "A320-TEST-01"

SYSTEM_DATA = {
    "avionics_power": {
        "voltage": {
            "value": 27.8,
            "unit": "V",
            "min": 24.0,
            "max": 32.0
        },
        "current": {
            "value": 31.2,
            "unit": "A",
            "min": 20.0,
            "max": 40.0
        },
        "temperature": {
            "value": 68.4,
            "unit": "C",
            "min": 0.0,
            "max": 60.0
        }
    }
}
