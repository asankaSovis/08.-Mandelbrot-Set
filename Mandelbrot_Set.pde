/* JULIA SET ----------------------------------------------------------------

In this example, we wil visualize an alternative to Mandelbrot set called the
Julia set. The Julia set is simillar to Mandelbrot set but instead of adding
C in a loop, we first start with z = z^2 + C where C is a range of complex
numbers as usual and in the next iteration we switch to z = z^2 + C' where
C' is a constant pre made. With different values to C', we get much more
elaborate designs.
Check out my blog post:
      https://asanka.hashnode.dev/08-mandelbrot-set-the-art-of-complex-numbers
      https://asanka-sovis.blogspot.com/2022/09/08-mandelbrot-set-art-of-complex-numbers.html
Coded by Asanka Akash Sovis

-----------------------------------------------------------------------------*/

// Defining global variables
int maxIter = 100; // Maximum number of iterations
float[] range = {-1.5, 1.5}; // Range to consider
float[] C = {0.37, 0.1};

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
        a = aa + C[0]; // New real part of z
        b = bb + C[1]; // New imaginary part of z
        
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
  
  saveFrame("Output\\julia_set.png"); // Saves the current frame. Comment if you don't need
  
  // Stop repeating the loop
  noLoop();
}
