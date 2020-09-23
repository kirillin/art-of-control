#include "pid.h"


PID::PID() {}

PID::~PID() {}


void PID::clip();
void PID::ramp();

bool PID::setup();

// 1. x_des -> CLIP -> x_des_cliped
// 2. x_des_cliped -> RAMP -> x_des_ramped
// 3. error = x_des_ramped - x
// 4. PID + ?antiwinwup -> u
// 5. u -> CLIP -> u_cliped
double PID::update(double x_des, double x) {

    clip(x_des)



}

bool PID::reset();
