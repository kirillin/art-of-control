#include "pid.h"
#include "ramp.h"

#include <iostream>
#include <vector>

 
int main() {


    float v_max = 1;
    float a_max = 1;
    float d_max = 1;

    float kp = 1;
    float ki = 0;
    float kd = 0;

    Ramp ramp(v_max, a_max, d_max);
    
    PID pid_v(kp, ki, kd);
    pid_v.antiwindup(kt, u_max, u_min);

    ramp.init(x0, v0, a0, v_max, a_max, j_max);

    while (true) {

        pid_v.update(x_des, x);
        

    }

    return 0;
}