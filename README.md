# Controlling a UAV with Sensor Spoofing: More Than A GNSS Problem

## Paper Abstract
Autonomous navigation systems present a unique attack surface:
their sensors. This attack surface allows for sensor spoofing
attacks, where an adversary gains control of a UAV by
manipulating one of its sensors to report incorrect data. Prior
research has shown that many of the sensors being use on
unmanned aerial vehicles (UAVs) are vulnerable to sensor
spoofing attacks. However, most work on UAVs only considers
spoofing the signals from a Global Navigation Satellite
System (GNSS). Concretely, we show that an adversary spoofing
just one of the sensors that is use to attenuate the state
estimate of a UAV can control or crash the UAV, even when
the GNSS is faithful.

## How to install
The modifications made to ArduPilot to embed sensor spoofing
do not alter the ArduPilot install procedure.

[ArduPilot install instructions](https://ardupilot.org/dev/docs/building-the-code.html).

Use this ArduPilot repository instead of the one in the linked instructions.

## Sensor Spoofing Parameters

Each sensor that has sensor spoofing embedded has separate control parameters.

The only common parameter is the CHN or CHAN parameter which is the RC channel that is use to toggle the attacks when raised above 1600.
* If the CHAN parameter is 0, then the corresponding ATK parameter will toggle the attack by itself.
* If the CHAN parameter is 1, then **EITHER** the correspond ATK parameter or the RC Channel will toggle the attack.

For Barometer spoofing:
* BARO_PDLK_ATK  - (0 or 1) Disable or Enable the attack
* BARO_PDLK_TMP  - (Celsius) Temperature to spoof the barometer
* BARO_PDLK_PRES - (Pascal) Pressure to spoof the barometer
* BARO_PDLK_CHAN - (Integer) Sets the RC Channel that will enable or disable the attack

For Rangefinder spoofing (This assumes your rangefinder is the first one, RNGFND1, otherwise use the corresponding one):
* RNGFND1_PDLK_ATK - (0 or 1) Disable or Enable the attack
* RNGFND1_PDLK_DIS - (Centimeters) Distance that is added to rangefinder reading
* RNGFND1_PDLK_ONE - (0 or 1) Immediately add DIS to the rangefinder reading in the next timestep when set to 1. Takes priority over RAT
* RNGFND1_PDLK_RAT - (Centimeters) Distance that is added to rangefinder EACH update, 0 disables this
* RNGFND1_PDLK_CHN - (Integer) Sets the RC Channel that will enable or disable the attack

For Inertial Sensor spoofing:
* INS_PDLK_CHAN - (0, 1, 2, 3) Disables or Enables the attack. 0 is disabled, 1 is the Accelerometer, 2 is the Gyroscope, and 3 is both
* INS_AX_EFF    - (0, 1, 2, 4) Changes how the sensor is spoofed. 0 passes real values through, 1 replaces data with 0, 2 adds Gaussian noise, 4 copies Pitch or Forward data to other axis for Gyroscope and Accelerometer respectively.
* INS_ACC_F/INS_ACC_R/INS_ACC_D - (Centimeters/s/s) Value to spoof on Front/Right/Down axis of accelerometer
* INS_GYR_P/INS_GYR_R/INS_GYR_Y - (Centi-radians/s) Value to spoof on Pitch/Roll/Yaw as read from Gyroscope
* INS_PDLK_CHAN - (Integer) Sets the RC Channel that will enable or disable the attack

For Magnetometer spoofing:
* COMPASS_PDLK_ATK - (0 or 1) Disable or Enable the attack
* COMPASS_ATK_X/COMPASS_ATK_Y/COMPASS_ATK_Z - (Milligauss) Value to spoof on the X/Y/Z axis of the magnetometer
* COMPASS_PDLK_CHAN - (Integer) Sets the RC Channel that will enable or disable the attack

For Optical Flow spoofing:
* FLOW_PDLK_ATK - (0 or 1) Disable or Enable the attack
* FLOW_PDLK_X/FLOW_PDLK_Y - (rad/s) Value to spoof on X/Y axis of optical flow sensor
* FLOW_PDLK_CHAN - (Integer) Sets the RC Channel that will enable or disable the attack

For GPS spoofing:
* GPS_PDLK_ATK - (0 or 1) Disable or Enable the attack
* GPS_PDLK_N - (centimeters) Distance to offset UAV North/South
* GPS_PDLK_E - (centimeters) Distance to offset UAV East/West
* GPS_PDLK_ONE_ATK - (0 or 1) Will immediately apply the offset in the next GPS update
