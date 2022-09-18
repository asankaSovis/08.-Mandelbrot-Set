/* MANDELBROT SET ----------------------------------------------------------

In this example, we wil visualize the Mandelbrot set. The Mandelbrot set is
the set of complex numbers C for which the function Fc ( z ) = z ^2 + c
does not diverge to infinity when iterated from z = 0 , i.e., for which
the sequence Fc( 0 ) , Fc ( Fc ( 0 ) ) , etc., remains bounded in absolute
value. The resulting visual pattern is intricate and will remain unchanged
even when you zoom in.
Check out my blog post:
      https://asanka.hashnode.dev/08-mandelbrot-set-the-art-of-complex-numbers
      https://asanka-sovis.blogspot.com/2022/09/08-mandelbrot-set-art-of-complex-numbers.html
Coded by Asanka Akash Sovis

-----------------------------------------------------------------------------*/

// Defining global variables
int maxIter = 100; // Maximum number of iterations
float[] range = {-1.5, 1.5}; // Range to consider

void setup() {
  size(1000, 800); // Defining the size of the canvas
  background(0); // Set the background to black
  colorMode(HSB); // Change the colour mode to HSB
}

void draw() {
  // Mandelbrot set is made up of both real and imaginary values
  // So we must do the calculation for both imaginary and real components
  // separately. So we define a and b to be the real and imaginary numbers
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      // Implementing the Mandelbrot set for each point------------------
      
      // C is the constant we consider in each iteration
      float ca = map(x, 0, height, range[0], range[1]); // Real component of C
      float cb = map(y, 0, height, range[0], range[1]); // Imaginary component of C
      
      // We define a variable n to know how many iterations deep we've gone
      float n = 0;
      
      // In the first iteration, as initial z = 0, z1 = c
      float a = ca; // Real component of z
      float b = cb; // Imaginary component of z
      
      // Now we calculate z over and over again until we reach a 
      // certain maximum iterations
      while (n < maxIter) {
        // We calculate zi = zi-1 = zi^2 + c
        float aa = a * a - b * b; // Real part of zi^2
        float bb = 2 * a * b; // Imaginary part of zi^2
        
        // Adding the c constant to z^2
        a = aa + ca; // New real part of z
        b = bb + cb; // New imaginary part of z
        
        // If the value of z tend towards infinity, we stop
        if (abs(aa + bb) > 64) {
          break;
        }
        
        n++;
      }
      // -------------------------------------------------------------
      
      // Mapping the final iteration count to colours and smoothing
      float bright = map(n, 0, maxIter, 0, 1);
      bright = map(sqrt(bright), 0, 1, 0, 255);
      
      // If we've reached the maximum number of iterations we allow
      // (Empty space within the diagram), we set the brightness
      // back to 0
      if (n == maxIter) {
        bright = 0;
      }
      
      // Drawing the pixels
      fill(bright, 255, bright * 1.5);
      circle(x, y, 10);
    }
  }
  
  saveFrame("Output\\mandelbrot_set.png"); // Saves the current frame. Comment if you don't need
  
  // Stop repeating the loop
  noLoop();
}
