#include "Ray.h"

Ray::Ray(){

};

bool Ray::intersectsTriangle(const Vertex& v0,const Vertex& v1,const Vertex& v2){
  
  Vec3Df h;
  float a,f,u,v;
  Vec3Df e1 = v1.p - v0.p;
  Vec3Df e2 = v2.p - v0.p;

  h = Vec3Df::crossProduct(direction,e2);
  a = Vec3Df::dotProduct(e1,h);

  /* 0 considering an error */
  if (a > -0.00001 && a < 0.00001)
    return(false);

  f = 1/a;
  Vec3Df s = position - v0.p;// ponto inicial do raio (0,0,0)
  
  u = f * (Vec3Df::dotProduct(s,h));

  if (u < 0.0 || u > 1.0)
    return(false);
  
  Vec3Df q = Vec3Df::crossProduct(s,e1);
  v = f * Vec3Df::dotProduct(direction,q);

  if (v < 0.0 || u + v > 1.0)
    return(false);
  
  // at this stage we can compute t to find out where
  // the intersection point is on the line
  float t = f * Vec3Df::dotProduct(e2,q);
  
  if (t > 0.00001) // ray intersection
    return(true);
  
  else // this means that there is a line intersection
    // but not a ray intersection
    return (false);
  
  return true;
}







