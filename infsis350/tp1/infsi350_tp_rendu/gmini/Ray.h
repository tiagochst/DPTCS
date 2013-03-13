#ifndef RAY_H
#define RAY_H

#include "Triangle.h"
#include "Vec3D.h"
#include "Vertex.h"

class Ray {

public: 
 Ray();
~Ray(){ }

  Vec3Df direction; 
  Vec3Df position; 

/* http://www.cs.virginia.edu/~gfx/Courses/2003/ImageSynthesis/papers/Acceleration/Fast%20MinimumStorage%20RayTriangle%20Intersection.pdf */
/* Should solve intersection between plan and line
   p + t * d = (1-u-v) * p0 + u * p1 + v * p2
   http://www.lighthouse3d.com/tutorials/maths/ray-triangle-intersection/
 */
bool intersectsTriangle(const Vertex& v0,const Vertex& v1,const Vertex& v2);

};
#endif  // RAY_H
