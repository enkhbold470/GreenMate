//-----------------------------------------------------------------------
// Copyright (c) 2017 Snap Inc.
//-----------------------------------------------------------------------

#ifndef SPHERICAL_HARMONICS_GLSL
#define SPHERICAL_HARMONICS_GLSL

#ifdef ENABLE_SH_INTEGRATION

vec3 sampleRadiance(vec3 R);

const int NumShCoeffs = 9;

void updateShCoeffs(inout vec3 coeffs[NumShCoeffs], vec3 hdr, float domega, float x, float y, float z) {

    /******************************************************************
     Update the coefficients (i.e. compute the next term in the
     integral) based on the lighting value hdr[3], the differential
     solid angle domega and cartesian components of surface normal x,y,z

     Inputs:  hdr = L(x,y,z) [note that x^2+y^2+z^2 = 1]
     i.e. the illumination at position (x,y,z)

     domega = The solid angle at the pixel corresponding to
	    (x,y,z).  For these light probes, this is given by

	    x,y,z  = Cartesian components of surface normal

     Notes:   Of course, there are better numerical methods to do
     integration, but this naive approach is sufficient for our
	    purpose.

     *********************************************************************/

    int col ;
    for (col = 0 ; col < 3 ; col++) {
        float c ; /* A different constant for each coefficient */

        /* L_{00}.  Note that Y_{00} = 0.282095 */
        c = 0.282095 ;
        coeffs[0][col] += hdr[col]*c*domega ;

        /* L_{1m}. -1 <= m <= 1.  The linear terms */
        c = 0.488603 ;
        coeffs[1][col] += hdr[col]*(c*y)*domega ;   /* Y_{1-1} = 0.488603 y  */
        coeffs[2][col] += hdr[col]*(c*z)*domega ;   /* Y_{10}  = 0.488603 z  */
        coeffs[3][col] += hdr[col]*(c*x)*domega ;   /* Y_{11}  = 0.488603 x  */

        /* The Quadratic terms, L_{2m} -2 <= m <= 2 */

        /* First, L_{2-2}, L_{2-1}, L_{21} corresponding to xy,yz,xz */
        c = 1.092548 ;
        coeffs[4][col] += hdr[col]*(c*x*y)*domega ; /* Y_{2-2} = 1.092548 xy */
        coeffs[5][col] += hdr[col]*(c*y*z)*domega ; /* Y_{2-1} = 1.092548 yz */
        coeffs[7][col] += hdr[col]*(c*x*z)*domega ; /* Y_{21}  = 1.092548 xz */

        /* L_{20}.  Note that Y_{20} = 0.315392 (3z^2 - 1) */
        c = 0.315392 ;
        coeffs[6][col] += hdr[col]*(c*(3.0*z*z-1.0))*domega ;

        /* L_{22}.  Note that Y_{22} = 0.546274 (x^2 - y^2) */
        c = 0.546274 ;
        coeffs[8][col] += hdr[col]*(c*(x*x-y*y))*domega ;
    }
}

float sinc(float x) {               /* Supporting sinc function */
    if (abs(x) < 1.0e-4) return 1.0 ;
    else return(sin(x)/x) ;
}

vec3 projectEnvmapToShCoefficient(int coeffIndex, int width) {
    vec3 coeffs[NumShCoeffs];
    for (int i = 0; i < NumShCoeffs; ++i) {
        coeffs[i] = vec3(0, 0, 0);
    }

    for (int i = 0 ; i < width ; i++) {
        for (int j = 0 ; j < width ; j++) {

            /* We now find the cartesian components for the point (i,j) */
            float u,v,r,theta,phi,x,y,z,domega ;

            v = (width/2.0 - i)/(width/2.0);  /* v ranges from -1 to 1 */
            u = (j-width/2.0)/(width/2.0);    /* u ranges from -1 to 1 */
            r = sqrt(u*u+v*v) ;               /* The "radius" */
            if (r > 1.0) continue ;           /* Consider only circle with r<1 */

            theta = PI*r ;                    /* theta parameter of (i,j) */
            phi = atan(v,u) ;                 /* phi parameter */

            x = sin(theta)*cos(phi) ;         /* Cartesian components */
            y = sin(theta)*sin(phi) ;
            z = cos(theta) ;

            /* Computation of the solid angle.  This follows from some
             elementary calculus converting sin(theta) d theta d phi into
             coordinates in terms of r.  This calculation should be redone
             if the form of the input changes */

            domega = (2.0*PI/width)*(2.0*PI/width)*sinc(theta) / PI;  // Don't know why I had to divide by pi here. Did Ramamoorthi miss a factor of pi somewhere, or did I?? I tried using random sampling where the weight should be 4pi/numSamples, and there as well the weight that worked turned out to be 4/numSamples.

            vec3 hdr = sampleRadiance(vec3(x, y, z));

            updateShCoeffs(coeffs, hdr,domega,x,y,z) ; /* Update Integration */
        }
    }

    return coeffs[coeffIndex];
}

#endif  // #ifdef ENABLE_SH_INTEGRATION

vec3 evaluateSh(vec3 L00, vec3 L1_1, vec3 L10, vec3 L11, vec3 L2_2, vec3 L2_1, vec3 L20, vec3 L21, vec3 L22, vec3 n) {
    float x, y, z, x2, y2, z2, xy, yz, xz;

    const float c1 = 0.429043 ;
    const float c2 = 0.511664 ;
    const float c3 = 0.743125 ;
    const float c4 = 0.886227 ;
    const float c5 = 0.247708 ;
    x = n[0] ; y = n[1] ; z = n[2] ;

    x2 = x*x ; y2 = y*y ; z2 = z*z ;
    xy = x*y ; yz = y*z ; xz = x*z ;

    return c1*L22*(x2-y2) + c3*L20*z2 + c4*L00 - c5*L20
    + 2.0*c1*(L2_2*xy + L21*xz + L2_1*yz)
    + 2.0*c2*(L11*x+L1_1*y+L10*z) ;
}

#endif // SPHERICAL_HARMONICS_GLSL
