#ifndef PID_H
#define PID_H

class PID {

  public:
    PID();
    ~PID();

    void saturation();
    void ramp();

    bool setup();
    double update(double x_des, double x);
    bool reset();

};


#endif /* PID_H */