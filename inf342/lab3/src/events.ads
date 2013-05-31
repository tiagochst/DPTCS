with Ada.Real_Time;          use Ada.Real_Time;
with Tasks;                  use Tasks;

package Events is

   type Event_Kind is (K_Produce, K_Consume);
   type Event is record
      Kind        : Event_Kind;
      Name        : Task_Name;
      Activation  : Time;
      Computation : Time_Span;
   end record;

   Event_Table : array (0 .. 31) of Event;
   First_Event : constant Integer := 1;
   Last_Event  : Natural := 0;

   --  Each aperiodic server includes an event table which consists
   --  basically on aperiodic task events (K_Consume) and time
   --  replenishment events (K_Produce). Name provides the aperiodic
   --  task name source of this event. Computation is the amount of
   --  time to consume or produce. Activation is the clock time at
   --  which the event occurs.

   procedure Produce_Event_Table;
   --  Produce from the aperiodic tasks table an events table. This
   --  primitive is used by an aperiodic server to schedule its
   --  activity. It is supposed to handle these events but also to add
   --  its own events (replenishments, ...).

   procedure Append_Event (E : Event);
   procedure Remove_Event (I : Natural);
   --  Remove event of index I from Table and update Last

   function  Less (Op1, Op2 : Natural) return Boolean;
   procedure Move (Op1, Op2 : Natural);
   procedure Sort_Table;

end Events;
