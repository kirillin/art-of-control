#ifndef RAMP_H
#define RAMP_H

class Ramp {

  public:

    Ramp();
    Ramp(float, float, float);
    ~Ramp();


    void reset(float x0, float v0, float a0);
    void eval();


};

#endif /* RAMP_H */