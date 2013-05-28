with PolyORB_HI.Output;
with Computations;
use Computations;

package body Hello is

   -----------------
   -- Hello_Spg_1 --
   -----------------

   procedure Hello_Spg_1 is
      use PolyORB_HI.Output;

   begin
      Put_Line (Normal, "Hello! This is task ONE");

      --  TO BE ADDED: Compute for a duration equal to the maximum
      --  compute execution time.
      Compute_During_N_Times_1ms(400);

      Put_Line (Normal, "Goodbye! This was task ONE");
   end Hello_Spg_1;

   -----------------
   -- Hello_Spg_2 --
   -----------------

   procedure Hello_Spg_2 is
      use PolyORB_HI.Output;

   begin
      Put_Line (Normal, "Hello! This is task TWO");

      --  TO BE ADDED: Compute for a duration equal to the maximum
      --  compute execution time.
      Compute_During_N_Times_1ms (400);

      Put_Line (Normal, "Goodbye! This was task TWO");
   end Hello_Spg_2;

   -----------------
   -- Hello_Spg_3 --
   -----------------

   procedure Hello_Spg_3 is
      use PolyORB_HI.Output;

   begin
      Put_Line (Normal, "Hello! This is task THREE");

      --  TO BE ADDED: Compute for a duration equal to the maximum
      --  compute execution time.
      Compute_During_N_Times_1ms(1200);

      Put_Line (Normal, "Goodbye! This was task THREE");
   end Hello_Spg_3;

end Hello;
