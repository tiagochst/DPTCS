#include "Triangle.h"

Triangle::Triangle () {
  v[0] = v[1] = v[2] = 0;
}
Triangle::Triangle (const Triangle & t) {
  v[0] = t.v[0];
  v[1] = t.v[1];
  v[2] = t.v[2];
}

Triangle::Triangle (unsigned int v0, unsigned int v1, unsigned int v2) {
  v[0] = v0;
  v[1] = v1;
  v[2] = v2;
}

Triangle& Triangle::operator=(const Triangle & t) {
  v[0] = t.v[0];
  v[1] = t.v[1];
  v[2] = t.v[2];
  return (*this);
}
