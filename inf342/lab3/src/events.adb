with Aperiodic_Tasks;        use Aperiodic_Tasks;
with GNAT.Heap_Sort_A;       use GNAT.Heap_Sort_A;
with Tasks;                  use Tasks;

package body Events is

   ------------------
   -- Append_Event --
   ------------------

   procedure Append_Event (E : Event) is
   begin
      Last_Event := Last_Event + 1;
      Event_Table (Last_Event) := E;
   end Append_Event;

   ----------
   -- Less --
   ----------

   function Less (Op1, Op2 : Natural) return Boolean is
   begin
      return Event_Table (Op1).Activation < Event_Table (Op2).Activation;
   end Less;

   ----------
   -- Move --
   ----------

   procedure Move (Op1, Op2 : Natural) is
   begin
      Event_Table (Op2) := Event_Table (Op1);
   end Move;

   -------------------------
   -- Produce_Event_Table --
   -------------------------

   procedure Produce_Event_Table
   is
      E : Event;
      T : Task_Info;

   begin
      if not Activation_Done then
         raise Program_Error;
      end if;

      for I in Aperiodic_Tasks.First_Task .. Aperiodic_Tasks.Last_Task loop
         T := Aperiodic_Tasks.Task_Table (I);
         E.Kind        := K_Consume;
         E.Name        := T.Name;
         E.Activation  := Activation_Time + T.Activation;
         E.Computation := T.Computation;
         Append_Event (E);
      end loop;
   end Produce_Event_Table;

   ------------------
   -- Remove_Event --
   ------------------

   procedure Remove_Event (I : Natural) is
   begin
      if I /= Last_Event then
         Event_Table (I .. Last_Event - 1) :=
           Event_Table (I + 1 .. Last_Event);
      end if;
      Last_Event := Last_Event - 1;
   end Remove_Event;

   ----------------
   -- Sort_Table --
   ----------------

   procedure Sort_Table is
   begin
      Sort (Last_Event, Move'Access, Less'Access);
   end Sort_Table;

end Events;
