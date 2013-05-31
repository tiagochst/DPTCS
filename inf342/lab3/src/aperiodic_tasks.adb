with GNAT.Heap_Sort_A;   use GNAT.Heap_Sort_A;
with IO;                 use IO;
with Tasks;              use Tasks;
with Ada.Real_Time;      use Ada.Real_Time;

package body Aperiodic_Tasks is

   procedure Sort_Table;
   procedure Move (L, R : Natural);
   function  Less (L, R : Natural) return Boolean;
   --  Function to compare the activation time of two tasks

   ------------
   -- Create --
   ------------

   procedure Create (I : Task_Info) is
   begin
      Last_Task := Last_Task + 1;
      Task_Table (Last_Task) := I;
      Sort_Table;
   end Create;

   --------------
   -- Destroy --
   --------------

   procedure Destroy is
   begin
      null;
   end Destroy;

   ----------
   -- Less --
   ----------

   function Less (L, R : Natural) return Boolean is
   begin
      return Task_Table (L).Activation < Task_Table (R).Activation;
   end Less;

   ----------
   -- Move --
   ----------

   procedure Move (L, R : Natural) is
   begin
      Task_Table (R) := Task_Table (L);
   end Move;

   ----------------
   -- Sort_Table --
   ----------------

   procedure Sort_Table is
   begin
      Sort (Last_Task, Move'Access, Less'Access);
   end Sort_Table;

end Aperiodic_Tasks;
