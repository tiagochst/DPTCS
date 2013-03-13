#ifndef TRIANGLE_H
#define TRIANGLE_H

class Triangle {

 public:
  Triangle ();
  Triangle (const Triangle & t);
  Triangle (unsigned int v0, unsigned int v1, unsigned int v2);
  ~Triangle (){}
  Triangle & operator= (const Triangle & t);
  unsigned int v[3];
};

#endif
