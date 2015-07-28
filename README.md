# RL78-G14-iOS-Demo
This app allows you to stream the following from/to RL78/G14:
* Temperature
* Light
* Potentiometer
* Buttons (1, 2, 3)
* Tilt (X,Y,Z)
* Send Beep

All communication is done via http://dweet.io.
This is also a good example of how to "stream" live data from a dweet.

# How to use
In Model.swift change line 12
```
    let thing: String = "cowardly-friction" //REPLACE WITH YOUR "MY-THING"
```
Your MY-THING will display on the LCD of Evaluation Board after succesfully connecting to a network

# Evaluation Board (RL78/G14)
http://am.renesas.com/products/tools/introductory_evaluation_tools/renesas_demo_kits/yrdkrl78g14/index.jsp
