// -------------------------------------------
// gMini : a minimal OpenGL/GLUT application
// for 3D graphics.
// Copyright (C) 2006-2008 Tamy Boubekeur
// All rights reserved.
// -------------------------------------------

// -------------------------------------------
// Disclaimer: this code is dirty in the
// meaning that there is no attention paid to
// proper class attribute access, memory
// management or optimisation of any kind. It
// is designed for quick-and-dirty testing
// purpose.
// -------------------------------------------

#include "Ray.h"
#include "Camera.h"

using namespace std;

// -------------------------------------------
// Basic Mesh class
// -------------------------------------------

class Mesh {
public:
  vector<Vertex> V;
  vector<Triangle> T;

  void loadOFF (const string & filename);
  void recomputeNormals ();
  void centerAndScaleToUnit ();
  void scaleUnit ();
};

void Mesh::loadOFF (const string & filename) {
  ifstream in (filename.c_str ());
  if (!in) 
    exit (EXIT_FAILURE);
  string offString;
  unsigned int sizeV, sizeT, tmp;
  in >> offString >> sizeV >> sizeT >> tmp;
  V.resize (sizeV);
  T.resize (sizeT);
  for (unsigned int i = 0; i < sizeV; i++)
    in >> V[i].p;
  int s;
  for (unsigned int i = 0; i < sizeT; i++) {
    in >> s;
    for (unsigned int j = 0; j < 3; j++)
      in >> T[i].v[j];
  }
  in.close ();
  centerAndScaleToUnit ();
  recomputeNormals ();
}

void Mesh::recomputeNormals () {
  for (unsigned int i = 0; i < V.size (); i++)
    V[i].n = Vec3Df (0.0, 0.0, 0.0);
  for (unsigned int i = 0; i < T.size (); i++) {
    Vec3Df e01 = V[T[i].v[1]].p -  V[T[i].v[0]].p;
    Vec3Df e02 = V[T[i].v[2]].p -  V[T[i].v[0]].p;
    Vec3Df n = Vec3Df::crossProduct (e01, e02);
    n.normalize ();
    for (unsigned int j = 0; j < 3; j++)
      V[T[i].v[j]].n += n;
  }
  for (unsigned int i = 0; i < V.size (); i++)
    V[i].n.normalize ();
}

void Mesh::centerAndScaleToUnit () {
  Vec3Df c;
  for  (unsigned int i = 0; i < V.size (); i++)
    c += V[i].p;
  c /= V.size ();
  float maxD = Vec3Df::distance (V[0].p, c);
  for (unsigned int i = 0; i < V.size (); i++){
    float m = Vec3Df::distance (V[i].p, c);
    if (m > maxD)
      maxD = m;
  }
  for  (unsigned int i = 0; i < V.size (); i++)
    V[i].p = (V[i].p - c) / maxD;
}

// -------------------------------------------
// OpenGL/GLUT application code.
// -------------------------------------------

static GLint window;
static unsigned int SCREENWIDTH = 640;
static unsigned int SCREENHEIGHT = 480;
static Camera camera;
static bool mouseRotatePressed = false;
static bool mouseMovePressed = false;
static bool mouseZoomPressed = false;
static int lastX=0, lastY=0, lastZoom=0;
static unsigned int FPS = 0;
static bool fullScreen = false;

Mesh mesh;

void printUsage () {
  cerr << endl 
       << "gMini: a minimal OpenGL/GLUT application" << endl
       << "for 3D graphics." << endl 
       << "Author : Tamy Boubekeur (http://www.labri.fr/~boubek)" << endl << endl
       << "Usage : ./gmini [<file.off>]" << endl
       << "Keyboard commands" << endl 
       << "------------------" << endl
       << " ?: Print help" << endl 
       << " w: Toggle Wireframe Mode" << endl 
       << " g: Toggle Gouraud Shading Mode" << endl 
       << " f: Toggle full screen mode" << endl 
       << " <drag>+<left button>: rotate model" << endl 
       << " <drag>+<right button>: move model" << endl
       << " <drag>+<middle button>: zoom" << endl
       << " a: (Disable)/A: (Enable) Light1 " << endl
       << " b: (Disable)/B: (Enable) Light2 " << endl
       << " l: (Disable)/L: (Enable) Lighting " << endl
       << " m: (Disable)/M: (Enable) Material " << endl
       << " n: (Mat 1)/ N: (Mat 2)  " << endl
       << " t: (Disable)/ T: (Enable) Texture  " << endl
       << " o: Call AO function  " << endl
       << " q, <esc>: Quit" << endl << endl; 
}

void usage () {
  printUsage ();
  exit (EXIT_FAILURE);
}

void initLight1 () {
  GLfloat light_position[4] = {22.0f, 16.0f, 50.0f, 0.0f};
  GLfloat direction[3] = {-52.0f,-16.0f,-50.0f};
  GLfloat color[4] = {0.5f, 1.0f, 0.5f, 1.0f};
  GLfloat ambient[4] = {0.3f, 0.3f, 0.3f, 0.5f};
  
  glLightfv (GL_LIGHT1, GL_POSITION, light_position);
  glLightfv (GL_LIGHT1, GL_SPOT_DIRECTION, direction);
  glLightfv (GL_LIGHT1, GL_DIFFUSE, color);
  glLightfv (GL_LIGHT1, GL_SPECULAR, color);
  glLightModelfv (GL_LIGHT_MODEL_AMBIENT, ambient);
  glEnable (GL_LIGHT1);

}

void initLight2 () {
  GLfloat light_position[4] = {22.0f, 16.0f, 50.0f, 0.0f};
  GLfloat direction[3] = {-52.0f,-16.0f,-50.0f};
  GLfloat color[4] = {1.0f, 0.0f, 0.0f, 1.0f};
  GLfloat ambient[4] = {0.3f, 0.3f, 0.3f, 0.5f};
  
  glLightfv (GL_LIGHT2, GL_POSITION, light_position);
  glLightfv (GL_LIGHT2, GL_SPOT_DIRECTION, direction);
  glLightfv (GL_LIGHT2, GL_DIFFUSE, color);
  glLightfv (GL_LIGHT2, GL_SPECULAR, color);
  glLightModelfv (GL_LIGHT_MODEL_AMBIENT, ambient);
  glEnable (GL_LIGHT2);
}


void initLight () {
  initLight1 ();
  initLight2 (); /* [TCS] Exercise: I.a - My second light*/
  glEnable (GL_LIGHTING);
}

void initAO () {
  Vec3Df p;
  float dist;
  float max = Vec3Df::distance(mesh.V[0].p,p);  
  float min = max;
  
  camera.getPos(p);

  glDisable (GL_LIGHTING);

  for (unsigned int i = 1; i < mesh.V.size (); i++){ 
    const Vertex & v = mesh.V[i];
    
    dist = Vec3Df::distance(v.p,p);  

    if(dist > max){
      max = dist;
    }
    else if(min > dist){
      min = dist;
    }
  }
  
  /* II.a Define a color in grayscale based on camera distance*/
  for (unsigned int i = 0; i < mesh.V.size (); i++){ 
    Vertex & v = mesh.V[i];
    v.R = v.G = v.B = (max - (Vec3Df::distance(v.p,p)))/(max - min);
  }
}

void RandomAO () {
  Vec3Df p;
  float dist;
  float max = Vec3Df::distance(mesh.V[0].p,p);  
  float min = max;
  
  vector<Ray> ray; 
  camera.getPos(p);

  glDisable (GL_LIGHTING);

  for (unsigned int i = 1; i < mesh.V.size (); i++){ 
    const Vertex & v = mesh.V[i];
    
    dist = Vec3Df::distance(v.p,p);  

    if(dist > max){
      max = dist;
    }
    else if(min > dist){
      min = dist;
    }
  }
  
  /* II.a Define a color in grayscale based on camera distance*/
  for (unsigned int i = 0; i < mesh.V.size (); i++){ 
    Vertex & v = mesh.V[i];
    v.R = v.G = v.B = (max - (Vec3Df::distance(v.p,p)))/(max - min);
  }
}



void initTexture () {
  GLuint texMap;
  //  GLuint texMapLevel;
  //GLuint texMapWidth;
  //GLuint texMapHeight;
  //GLuint texMapComponents;
  //GLuint texMapFormat;
  //bool texMapGenerated;
  int width=256, height=256;
  FILE * file;
  GLubyte data[width*height*3]; 

  glEnable( GL_TEXTURE_2D );

  // allocate a texture name  
  glGenTextures (1, &texMap);
  
  // select our current texture
  glBindTexture (GL_TEXTURE_2D, texMap);

  // when texture area is large, bilinear filter the original
  glTexParameteri (GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);

  // when texture area is small, bilinear filter the closest mipmap
  glTexParameteri (GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, 
		   GL_LINEAR_MIPMAP_LINEAR);

  // the texture wraps over at the edges (repeat)
  //glTexParameteri (GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
  //  glTexParameteri (GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S,     GL_CLAMP_TO_EDGE);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T,     GL_CLAMP_TO_EDGE);
  
  
  // open and read texture data
  //file = fopen( "../textures/ground_256x256.ppm", "rb" );
  //  file = fopen( "../textures/brick_256x256.ppm", "rb" );
  file = fopen( "../textures/bois_256x256.ppm", "rb" );

  fread( data, width * height * 3, 1, file );
  fclose( file );


  // build our texture mipmaps
  gluBuild2DMipmaps( GL_TEXTURE_2D, 3, width, height,
		     GL_RGB, GL_UNSIGNED_BYTE, data );
}

void matGold(){


  /*    
	Ambient color : Ambient color is the color of an object where it is in shadow. This color is what the object reflects when illuminated by ambient light rather than direct light. ---- cor na sombra sem luz direta 
    
	Diffuse color :Diffuse color is the most instinctive meaning of the color of an object. It is that essential color that the object reveals under pure white light. It is perceived as the color of the object itself rather than a reflection of the light. ---- Reflection para todas as direcoes
    
	Emissive color : This is the self-illumination color an object has. 
    
	Specular color :Specular color is the color of the light of a specular reflection (specular reflection is the type of reflection that is characteristic of light reflected from a shiny surface). ---- Refleccao para uma dada direçao (espelho)
	Fresnel: angulos rasantes
  */

  GLfloat material_ambient[] = { 0.25, 0.20 , 0.075, 1 };
  GLfloat material_diffuse[] = { 0.75, 0.60 , 0.22, 1 };
  GLfloat material_specular[] = { 0.63, 0.55, 0.36, 1 };
  GLfloat material_shininess[] = { 102 };

  glMaterialfv(GL_FRONT, GL_DIFFUSE, material_ambient);
  glMaterialfv(GL_FRONT, GL_DIFFUSE, material_diffuse);
  glMaterialfv(GL_FRONT, GL_SPECULAR, material_specular);
  glMaterialfv(GL_FRONT, GL_SHININESS, material_shininess);

}

void matGrenPlastic(){

  GLfloat material_ambient[] = { 0, 0 , 0, 1 };
  GLfloat material_diffuse[] = { 0.1, 0.35 , 0.1, 1 };
  GLfloat material_specular[] = { 0.45, 0.55, 0.45, 1 };
  GLfloat material_shininess[] = { 32 };

  glMaterialfv(GL_FRONT, GL_DIFFUSE, material_ambient);
  glMaterialfv(GL_FRONT, GL_DIFFUSE, material_diffuse);
  glMaterialfv(GL_FRONT, GL_SPECULAR, material_specular);
  glMaterialfv(GL_FRONT, GL_SHININESS, material_shininess);
}


void init (const char * modelFilename) {
  camera.resize (SCREENWIDTH, SCREENHEIGHT);
  mesh.loadOFF (modelFilename);
  initLight ();
  glCullFace (GL_BACK);
  glEnable (GL_CULL_FACE);
  glDepthFunc (GL_LESS);
  glEnable (GL_DEPTH_TEST);
  glClearColor (0.2f, 0.2f, 0.3f, 1.0f);
}


// ------------------------------------
// Replace the code of this 
// functions for cleaning memory, 
// closing sockets, etc.
// ------------------------------------

void clear () {
  
}

// ------------------------------------
// Replace the code of this 
// functions for alternative rendering.
// ------------------------------------

void draw () {

  Vec3Df lightNorm(-52.0f,-16.0f,-50.0f); 
  Vec3Df faceNorm (  0.0f,  0.0f,  0.0f); 
  
  lightNorm.normalize();
  
  glBegin (GL_TRIANGLES);  
  for (unsigned int i = 0; i < mesh.T.size (); i++){ 
 
    faceNorm = Vec3Df ( 0.0f, 0.0f, 0.0f); 
    
    for (unsigned int j = 0; j < 3; j++) {
      const Vertex & v = mesh.V[mesh.T[i].v[j]];
      faceNorm += v.n;
    }
    
    faceNorm.normalize();

    /*  if (Vec3Df::dotProduct (faceNorm, lightNorm  ) < 0.0) {
	glColor3f (1.0f, 0.0f ,0.0f);
	}
	else {
	glColor3f (0.0f, 0.0f ,1.0f);
	}*/
    
    for (unsigned int j = 0; j < 3; j++) {
      const Vertex & v = mesh.V[mesh.T[i].v[j]];
      glColor3f (v.R,v.G ,v.B);
      glNormal3f (v.n[0], v.n[1], v.n[2]);
      glTexCoord2f (i, j);
      glVertex3f (v.p[0], v.p[1], v.p[2]);
    }
    
  }
 
  glEnd ();
}

void display () {
  glLoadIdentity ();
  glClear (GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
  camera.apply ();
  draw ();
  glFlush ();
  glutSwapBuffers ();
}

void idle () {
  static float lastTime = glutGet ((GLenum)GLUT_ELAPSED_TIME);
  static unsigned int counter = 0;
  counter++;
  float currentTime = glutGet ((GLenum)GLUT_ELAPSED_TIME);
  if (currentTime - lastTime >= 1000.0f) {
    FPS = counter;
    counter = 0;
    static char winTitle [64];
    unsigned int numOfTriangles = mesh.T.size ();
    sprintf (winTitle, "gmini - Num. Of Tri.: %d - FPS: %d", numOfTriangles, FPS);
    glutSetWindowTitle (winTitle);
    lastTime = currentTime;
  }
  glutPostRedisplay ();
}

void key (unsigned char keyPressed, int x, int y) {
  Vec3Df l = Vec3Df (50.0, 0.0, 0.0);
  switch (keyPressed) {
    
  case 'a':
    glDisable (GL_LIGHT1);
    break;  

  case 'A':
    glEnable (GL_LIGHT1);
    break;  

  case 'b':
    glDisable (GL_LIGHT2);
    break;  

  case 'B':
    glEnable (GL_LIGHT2);
    break;  

  case 'f':
    if (fullScreen == true) {
      glutReshapeWindow (SCREENWIDTH, SCREENHEIGHT);
      fullScreen = false;
    } else {
      glutFullScreen ();
      fullScreen = true;
    }      
    break;

  case 'l':
    glDisable (GL_LIGHTING);
    break;  

  case 'L':
    glEnable (GL_LIGHTING);
    break;  

  case 'm':
    glDisable(GL_COLOR_MATERIAL);
    break;  

  case 'M':
    glEnable(GL_COLOR_MATERIAL);
    break;

  case 'n':
    matGrenPlastic();
    break;
  
  case 'N':
    matGold();
    break;

  case 'q':
  case 27:
    clear ();
    exit (0);
    break;
  case 'w':
    glPolygonMode (GL_FRONT_AND_BACK, GL_LINE);
    break;
  case 'g':
    glPolygonMode (GL_FRONT_AND_BACK, GL_FILL);
    break;
  case 't':
    initTexture();
    break;
  case 'T':
    glDisable( GL_TEXTURE_2D );
    break;
  case 'o':
    /* Algoritmo de ambient occlusion*/
    initAO();
    break;
  case 's':

    //vector<float> rad (mesh.V.size (), 0.0);
    for (unsigned int i = 0; i < mesh.V.size (); i++) {
      Vec3Df pl = l - mesh.V[i].p;
      pl.normalize ();
      float rad/*[i]*/ = max (Vec3Df::dotProduct (mesh.V[i].n, pl), 0.0f);
      mesh.V[i].n *= rad/*[i]*/;
    }
    break;
  default:
    printUsage ();
    break;
  }
  idle ();
}


void mouse (int button, int state, int x, int y) {
  if (state == GLUT_UP) {
    mouseMovePressed = false;
    mouseRotatePressed = false;
    mouseZoomPressed = false;
  } else {
    if (button == GLUT_LEFT_BUTTON) {
      camera.beginRotate (x, y);
      mouseMovePressed = false;
      mouseRotatePressed = true;
      mouseZoomPressed = false;
    } else if (button == GLUT_RIGHT_BUTTON) {
      lastX = x;
      lastY = y;
      mouseMovePressed = true;
      mouseRotatePressed = false;
      mouseZoomPressed = false;
    } else if (button == GLUT_MIDDLE_BUTTON) {
      if (mouseZoomPressed == false) {
	lastZoom = y;
	mouseMovePressed = false;
	mouseRotatePressed = false;
	mouseZoomPressed = true;
      }
    }
  }
  idle ();
}

void motion (int x, int y) {
  if (mouseRotatePressed == true) {
    camera.rotate (x, y);
  }
  else if (mouseMovePressed == true) {
    camera.move ((x-lastX)/static_cast<float>(SCREENWIDTH), (lastY-y)/static_cast<float>(SCREENHEIGHT), 0.0);
    lastX = x;
    lastY = y;
  }
  else if (mouseZoomPressed == true) {
    camera.zoom (float (y-lastZoom)/SCREENHEIGHT);
    lastZoom = y;
  }
}


void reshape(int w, int h) {
  camera.resize (w, h);
}


int main (int argc, char ** argv) {
  if (argc > 2) {
    printUsage ();
    exit (EXIT_FAILURE);
  }
  glutInit (&argc, argv);
  glutInitDisplayMode (GLUT_RGBA | GLUT_DEPTH | GLUT_DOUBLE);
  glutInitWindowSize (SCREENWIDTH, SCREENHEIGHT);
  window = glutCreateWindow ("gMini");
  
  init (argc == 2 ? argv[1] : "sphere.off");
    
  glutIdleFunc (idle);
  glutDisplayFunc (display);
  glutKeyboardFunc (key);
  glutReshapeFunc (reshape);
  glutMotionFunc (motion);
  glutMouseFunc (mouse);
  key ('?', 0, 0);   
  glutMainLoop ();
  return EXIT_SUCCESS;
}

