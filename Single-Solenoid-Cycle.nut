//
// Simple Solenoid class for Esquilo
//
class Solenoid
{
    solenoid_A_Pin = 0;
    solenoid_B_Pin = 0;

    cycleDelay = 0;
    fillDelay = 0;

    constructor (_A_Pin, _B_Pin)
    {
        solenoid_A_Pin = GPIO(A_Pin);
        solenoid_B_Pin = GPIO(A_Pin);

        cycleDelay = 10000;
        fillDelay = 500;

        solenoid_A_Pin.output();
        solenoid_B_Pin.output();
    }
}

function Solenoid::setCycleDelay(cd)
{
    cycleDelay = cd;
}

function Solenoid::setFillDelay(fd)
{
    fillDelay = fd;
}

function Solenoid::resetSolenoid()
{
    print("Resetting solenoids...");
    solenoid_A_Pin.low();
    solenoid_B_Pin.high();
    delay(fillDelay);
    solenoid_B_Pin.low();
    print("done\n");
    local i;
    for (i = 5; i > 0; i--) {
        print("Beginning in " + i + " seconds...\n");
        delay(1000);
    }
}

function Solenoid::fireSolenoid()
{
    print("Firing...");
    solenoid_A_Pin.high();
    delay(fillDelay);  // Hold in-valve open for fillDelay
    solenoid_A_Pin.low();
    delay(fillDelay);  // Hold in-valve closed for fillDelay
    print("done\n");
    delay(cycleDelay);  // Wait cycleDelay
}

function Solenoid::retractSolenoid()
{
    print("Retracting...");
    solenoid_B_Pin.high();
    delay(fillDelay);  // Hold out-valve open for fillDelay
    solenoid_B_Pin.low();
    delay(fillDelay);  // Hold out-valve closed for fillDelay
    print("done\n");
    delay(cycleDelay);  // Wait cycleDelay
}


//
// Simple Solenoid Demo
//

require("GPIO");

local mySolenoid = Solenoid(6, 7);

local x = 5;

local l;

for (l = 0; l < 5; l++) {
   fireSolenoid();
   retractSolenoid();
}

