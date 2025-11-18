# Open Margins: Evaluating Limits of PBAD Against Sensor Attacks
## Paper Abstract
Cyber-physical systems have been the center of proactive research in defense against spoofing attacks. Spoofing attacks allow an adversary to gain implicit control of systems actuation by injecting false signals. Software defenses have been a popular approach for defending against sensor spoofing in resource constrained deployments as processing power has become cheaper. A popular approach that continues to see development even to today is physics-based attack detection, a software defense that models a system and checks for anomalous behavior against the model. Although there is frequent improvement in the space of physics-based attack detection, little to none of the work models the defense and extends to abstract systems. Without a statistical analysis the actual guarantees of physics-based attack detection is unknown, potentially seeing real deployments having little impact due to system parameterization. We focus our work on developing a general model of physics-based attack detection and statistically analyzing the model to provide guarantees for the detector. Concretely, we develop a method that determines minimum requirements for a sensor based on detector and attack parameters that will make the system guarantee specified performance.

## How to install
Instructions the same as forked project ["Assessing UAV Sensor Spoofing"](https://github.com/BaileySri/Assessing-UAV-Sensor-Spoofing)

Same procedure as normal ArduPilot install
[ArduPilot install instructions](https://ardupilot.org/dev/docs/building-the-code.html).

Use this ArduPilot repository instead of the one in the linked instructions.

## Autotest Parameters
The primary directory for autotest is located at ["./Tools/autotest/"](Tools/autotest/)

The file containing our specific autotest is ["./Tools/autotest/arducopter.py"](Tools/autotest/arducopter.py), Specifically the function ["attack_rf_idle"](Tools/autotest/arducopter.py#L302)

The ["self.set_parameters"](Tools/autotest/arducopter.py#L314) call can be modified for different simulation noise parameters but all are set to 0 for our evaluation.

The attack parameters are as follows:

#### RNGFND1_XXXX_ONE

  1: Offset the rangefinder by RNGFND1_XXXX_DIS centimeters at the next sensor update, then hold the readings there
  
  2: Offset the rangefinder by RNGFND1_XXXX_RAT meters at each rangefinder reading, never stops offsetting
  
  Other: Advanced subtle attack described in forked project but is unnecessary in this evaluation
  
#### RNGFND1_XXXX_DIS

  Centimeters the rangefinder readings are offset when the attack starts when XXXX_ONE is set to 1
  
#### RNGFND1_XXXX_RAT

  Meters the rangefinder readings are offset at each rangefinder update when XXXX_ONE is set to 2

## Autotest Command
After setting up the ArduPilot install, change to the autotest directory and run

```autotest.py --debug build.Copter test.Copter.attack_rf_idle```

The log files will be stored in the same directory in the "logs" folder. This will often be labeled "00000002.BIN".

Mission Planner software can be used to view and convert the binary file to a log file.
